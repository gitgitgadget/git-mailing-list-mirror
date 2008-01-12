From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 17:29:39 -0500
Message-ID: <47893F53.2070908@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 12 23:30:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDorq-0003b8-0o
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 23:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758195AbYALW3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 17:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758164AbYALW3t
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 17:29:49 -0500
Received: from ag-out-0708.google.com ([72.14.246.240]:29328 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758045AbYALW3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 17:29:48 -0500
Received: by ag-out-0708.google.com with SMTP id 23so1111702agd.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 14:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=kS63qy4ksXF/XJO5p+5M8GdDLbwyb4cFfdS4+GezFbg=;
        b=PyiedW5TfKKz/dZ0GlD7b8TzWeQm2Xj22vYDODnNOlYP4EJXRseJqTMzKRSC3M37ssxC/g7qQ6EDEcBG1pHdIsMd/Ywx2TIhQW+WWZiAkx5tiHL25RH2ucaNj4qyEPrSIFxrvtwMco0H+0CpgI9FY8cV6AWtPfFsCzLgQVt7d0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iGanu1hd+oNX3mJLSd2xXafvVNKSPV4nP3kL0zDi8gP0ndprFPkhpnwwvhCyp33bof9ku2EHHYbhqygN/qdfBcfjh0sN1ozKrj4m7yN0sVvDbKWPUX7KLT8644udbr6ECD9dQC3fH2UUj35gxLv/nirlqZ0jeUDXPx9dxJngJ7Y=
Received: by 10.70.23.2 with SMTP id 2mr3180411wxw.11.1200176983663;
        Sat, 12 Jan 2008 14:29:43 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id h36sm16492525wxd.29.2008.01.12.14.29.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jan 2008 14:29:40 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70361>

Johannes Schindelin wrote:
> Why is your patch then not about git-submodule?
>
> And I still fail to see -- even for submodules -- how you begin to tackle 
> that lookup problem.
>
> Ciao,
> Dscho
>
>   
Because git-submodule is a wrapper around git-fetch and git-clone and 
git-remote, and those lacked the mechanism to honor the fact that when I 
said

       git clone -o  frotz frontz.foo.bar/foo.git

I *defined* the upstream's nickname as "frotz", not "origin", and origin 
is *not* defined so don't try to use it. As sub-modules are git 
projects, fixing this in a sub-module necessarily fixes it in any git 
project.

Mark
