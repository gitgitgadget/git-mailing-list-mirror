From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 1/9] Fix git patch header processing in git-apply.
Date: Tue, 30 Aug 2005 19:36:00 +1200
Message-ID: <46a038f905083000362ae0d9fc@mail.gmail.com>
References: <11252426672473-git-send-email-robfitz@273k.net>
	 <7vslwtein3.fsf@assigned-by-dhcp.cox.net>
	 <20050829235823.GA19351@localhost>
	 <Pine.LNX.4.58.0508291744400.3243@g5.osdl.org>
	 <7vacj06xi6.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0508291821010.3243@g5.osdl.org>
	 <7vbr3g5hsb.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0508291856080.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 09:38:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EA0g9-00018S-1V
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 09:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVH3HgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 03:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVH3HgE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 03:36:04 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:59723 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751199AbVH3HgD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 03:36:03 -0400
Received: by rproxy.gmail.com with SMTP id i8so1103876rne
        for <git@vger.kernel.org>; Tue, 30 Aug 2005 00:36:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H/Fu+dDqx1Bgr3j+kj18NxQ30biuj9mE5GyZT5qTGhj9zeSjeNhrfifpax54b4JelY3Xp7fzbbvGCNeszRKpAWwxdrt4LtRzbiJGPQujxiZwx8lI3IZfj0UEqOBoN/TRwdQpuTlomu/VrWD7AYVGuQkAJrOzHBto0FLdon09d8s=
Received: by 10.39.3.45 with SMTP id f45mr185935rni;
        Tue, 30 Aug 2005 00:36:00 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 30 Aug 2005 00:36:00 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508291856080.3243@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7949>

On 8/30/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Actually, an import should preferably never use patches at all, since that
> never really works for binary data. This is why the CVS importer actually
> checks out full files and imports them that way. The patch-based ones will
> fundamentally always have problems.

<AOL>. Patches can be useful during the process, but you should (a)
prefer more solid manifestations of the file/tree if possible, and (b)
be extremely strict with them. Any hint that they don't match means
that something is borked.

However, if you're importing from patch-oriented SCMs that tend to
'replay' patch sequences from one branch to the other, asking git to
skip applied patches *could* be a shortcut. Not 100% correctness
guarantee, but if the resulting history makes sense, it can be useful.

The other alternative is to do what I'll start to do soon on the
archimport script: keep a tally of what was merged where according to
the records that the source SCM has.

cheers,


martin
