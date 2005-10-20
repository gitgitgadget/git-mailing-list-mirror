From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cg-fetch will now retrieve commits related to tags if missing.
Date: Thu, 20 Oct 2005 17:18:51 +1300
Message-ID: <46a038f90510192118s31c52fe7m73d88a9779653f4c@mail.gmail.com>
References: <1129769745158-git-send-email-martin@catalyst.net.nz>
	 <7voe5lvv1q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 06:19:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESRtH-0001Kc-Jc
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 06:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbVJTESw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 00:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbVJTESw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 00:18:52 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:4129 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751733AbVJTESv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 00:18:51 -0400
Received: by qproxy.gmail.com with SMTP id v40so249474qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 21:18:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=npMu4V5ADGOOqygS+XVsnOjH8qJUnO92E0V03LnzuV4TuegKLjxrIDyOvT5JWZbAd9WnWXg7OtkE0gulQ3gWo42NQOskrzSI0CVwWjjgfHWt+uo0CpTlk8q1a0OzeJmdKU/uilOGXmeE7HT+hOfvuF+JoLE8INstovF3UTJaY98=
Received: by 10.64.213.8 with SMTP id l8mr1171080qbg;
        Wed, 19 Oct 2005 21:18:51 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 21:18:51 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe5lvv1q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10343>

On 10/20/05, Junio C Hamano <junkio@cox.net> wrote:

> You are saying:
>         if "$tagid" is already commit then continue;
>         if "$tagid" dereferences to a commit and if you have it
>         then continue
>
> If that is the case, then this might be more efficient.
>
>         GIT_DIR=../.. git-rev-parse --verify "$tagid^0" >/dev/null 2>&1 && continue

Note however that git-rev-parse is lazy and won't check that the
commit is there. I have to call git-cat-file and check whether it
succeeds to know if we have the object.

cheers,


martin
