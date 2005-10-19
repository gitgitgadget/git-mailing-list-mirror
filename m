From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git-send-pack segfaulting on DebianPPC (was: Re: cg-clone, tag objects and cg-push/git-push don't play nice)
Date: Wed, 19 Oct 2005 22:02:14 +1300
Message-ID: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 11:03:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES9q7-0005o3-SU
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 11:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVJSJCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 05:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVJSJCP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 05:02:15 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:2000 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932478AbVJSJCP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 05:02:15 -0400
Received: by qproxy.gmail.com with SMTP id v40so37289qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 02:02:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dTkfgYkwy3AxoG+0bIb0kCGecsEQoOPH0946lYJ6yx1REgyiisF8VUJ2WTR9aIvL9JE4wwm0m7w1zGvW2V/oVjPZkeG1kM1v8A23XIIFk7+InXd/r0Q70w2E8AKMYJbc4FVgKMwwrEBhLF/DrJ4P0DrZmOUi2HbaTNrtm1W7tG4=
Received: by 10.65.192.13 with SMTP id u13mr323975qbp;
        Wed, 19 Oct 2005 02:02:14 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 02:02:14 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10278>

On 10/19/05, Junio C Hamano <junkio@cox.net> wrote:
> Although I do not follow Cogito development closely, I seem to
> recall that it fetched tags without making them complete at some
> point in the past; I hope it is now fixed but I am not sure.

Ok -- I can now shed some light on this. This was happening on a
DebianPPC machine, but I didn't have clear evidence of that being a
factor (specially when Linus is widely known to use a PPC, and I
hadn't seen problems in other ppc boxen around). Now I do.

For all my finger-pointing, cg-fetch was trying to fetch the refernces
properly. However, git-fetch-pack is segfaulting on this Debian PPC
(etch). This is true of the current git "master" and 0.99.8.c. I
don'thave strace on the box until tomorrow, so I can't tell you more
about it.

On Debian i386 and Ubuntu i386, the exact same versions work correctly.

I'll post more info as soon as I can get my hands on strace,

cheers,



martin
