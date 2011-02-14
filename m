From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Mon, 14 Feb 2011 08:56:02 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102140854580.4346@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com> <4D58E17C.9090001@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 14:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoyuV-0004Wc-C6
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 14:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab1BNN4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 08:56:10 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56557 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab1BNN4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 08:56:09 -0500
Received: by vws16 with SMTP id 16so3006307vws.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 05:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=vHgwjlb7ll1FbBOoJ6PNX0WW5aqj02P+eDJsFUzO83Y=;
        b=ZS280wNY2wfr7AvjvjkEP6fez1h7raoHZOXQiPi0Wk3asjkUCu/JqrVqPdxxC234rO
         sM41V2QtnATL7GcZDLjTOOW/A+YHYhMGRUJSVagE6ktj2JiucTvaN+dTNhdv3XeyJDx8
         BkQZMjPU6Edt68+LLEEVeXHb4fcaGkCv97glc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=xrZj1GKri/VvlA9qRQFB+MdbN87bi0K//uQvtAx30yrJZLnm2FrlDOve+m5K+CqrvI
         Op1n1siKneSK1cPVzaqg+GtYI7Rl2eT4e5YkcJ4UpEYJVLdHLiZkS6UWSxtCZGkRNFMH
         pzxoaE44Sx0M5i3g0a66AVD0KpWgSq6RLyJK4=
Received: by 10.220.186.9 with SMTP id cq9mr981295vcb.195.1297691768451;
        Mon, 14 Feb 2011 05:56:08 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e18sm1894553vbm.5.2011.02.14.05.56.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 05:56:06 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <4D58E17C.9090001@viscovery.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166711>

On Mon, 14 Feb 2011, Johannes Sixt wrote:

> Am 2/6/2011 19:43, schrieb Martin von Zweigbergk:
> > diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> > new file mode 100644
> > index 0000000..c04ce8a
> > --- /dev/null
> > +++ b/git-rebase--merge.sh
> 
> This should be mode 100755. (Ditto for git-rebase--am.sh in 19/31)

Thanks.
