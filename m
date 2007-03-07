From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Tue, 06 Mar 2007 20:15:46 -0500
Message-ID: <45EE1242.8080405@gmail.com>
References: <45ECEB40.4000907@gmail.com> <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOkkx-0002hX-6m
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbXCGBPq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbXCGBPp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:15:45 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:19049 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161089AbXCGBPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:15:44 -0500
Received: by wx-out-0506.google.com with SMTP id h31so77wxd
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 17:15:44 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QptlYLlI/qJMAP7SZ2fLPu57dckYaJgiBIR1NMzc8Fhs/HmI7sTC/HGa1hmoLL/KWqFBuDV+NRr4fV/ETqOqyh3xF3TDsQxK2H1/8SEKAGSiSCl1hejE0zRMiy0UhTnI/RddOk/QhZ4hOt7OyQh2sLdM2ZZNxeljGs/gLxaEsCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kVLlN57ZhnRyhq03df0uhC19GAmzD2pl9iFFuN/WN5mggr4gUN59dif/6zL3PL9zU2WyswGfDGy6rkYwj0d4+obTfKLfUZ9r5J+3UBR6QPi7tM0vvCcptpO+z0axVgrrSKXVISwbslFIzbIuQYWA4Iq/ss87rj6Xl+hd9o1aYY8=
Received: by 10.90.56.14 with SMTP id e14mr6603687aga.1173230144210;
        Tue, 06 Mar 2007 17:15:44 -0800 (PST)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id g3sm12234428wra.2007.03.06.17.15.43;
        Tue, 06 Mar 2007 17:15:43 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41631>

Junio C Hamano wrote:
> The handcrafted built-in rev-list lookalike forgot to mark the trees
> and blobs contained in the boundary commits uninteresting, resulting
> in unnecessary objects in the pack.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>
>   
This works for things like  master~1..master, but fails on git bundle 
create t.bdl  master --since=1.day.ago.
Apparently the boundary commits marked with a date are not being honored 
in creating a pack.

Mark
