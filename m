From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: cg-merge should use git-merge
Date: Thu, 20 Oct 2005 20:04:52 +1300
Message-ID: <46a038f90510200004l67e2d19kf8e9a4c6190f44f@mail.gmail.com>
References: <46a038f90510161644l35119401rdc05c081506ae715@mail.gmail.com>
	 <46a038f90510190421l50b2c12k495db23b62015782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 20 09:05:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESUTw-0007Ys-HA
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 09:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbVJTHEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 03:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbVJTHEy
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 03:04:54 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:12870 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751777AbVJTHEx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 03:04:53 -0400
Received: by qproxy.gmail.com with SMTP id v40so267129qbe
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 00:04:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JFLUPIDSSCXczF04CoSoMJJ9QKqKcTLtT8UHAG1s61juXKaeVySgxcEzEA2kHRp1QfT7CjNqLIAd34Z+f8fYZ7ElndeT8xV6fT+y+yA5/ViNiZoPPhQ+OqJTakWNBmwYVVjLOsInNp64dQ204FD+njK3qExmVUFxnCMmu2hwb3A=
Received: by 10.64.232.15 with SMTP id e15mr1175562qbh;
        Thu, 20 Oct 2005 00:04:52 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Thu, 20 Oct 2005 00:04:52 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <46a038f90510190421l50b2c12k495db23b62015782@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10352>

On 10/20/05, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> After using git-merge a few times by hand to test-drive the new merge
> drivers, I'm sold on the idea, and I 'd like to have cg-merge use
> git-merge directly.

I started drafting a 5-minute proof-of-concept, and then it struck me:
cg users aren't aware of the index. This is really important when you
are merging and have to resolve a conflict over a dirty tree. git
users know that the "clean" part of the merge is in the index, and
they have to resolve a couple of files in their checkout, and update
the index for those only before calling git-write-tree &
git-commit-tree.

Cogito users don't know about this magic at all, which is a bit of a
problem. I can refuse to run cg-merge on a dirty tree to make things
simpler, but that's cheating ;-)

tagging "for later"...

cheers,


martin
