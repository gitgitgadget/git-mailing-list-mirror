From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Thu, 2 Mar 2006 10:40:41 +1300
Message-ID: <46a038f90603011340k23327f11s6e3d9d69585a5188@mail.gmail.com>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
	 <4405C6BE.2000706@op5.se>
	 <Pine.LNX.4.64.0603010821590.22647@g5.osdl.org>
	 <200603011814.43573.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0603010935201.22647@g5.osdl.org>
	 <7virqyf094.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 22:41:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEZ3v-0000KD-8o
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 22:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWCAVko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 16:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWCAVko
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 16:40:44 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:15210 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751276AbWCAVkn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 16:40:43 -0500
Received: by wproxy.gmail.com with SMTP id i28so250950wra
        for <git@vger.kernel.org>; Wed, 01 Mar 2006 13:40:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n/9gUYn3t98Slzelc7Wmpxbvb2NX9EALQHdcTAA13vcmWznsX7l1K3+PiySWHx+KbCAyb1Mi0jLCqis15XYs6j4FXzebEBT2fY81MxPDoGIb1p1WmgcAYHlYt1/s5ZyJNFciuh1I494m2+pXYipuq8TX3R2X+6NF3FPe0wPbNHs=
Received: by 10.54.71.13 with SMTP id t13mr164008wra;
        Wed, 01 Mar 2006 13:40:41 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 1 Mar 2006 13:40:41 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7virqyf094.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17017>

On 3/2/06, Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
>
> > But if somebody does the get_sha1() magic, and Junio agrees, then I think
> > it would be a great thing to do.
>
> I am inclined to agree here.

Aren't we doing a lot of work (changes in core git, and corresponding
changes in the porcelain) when simple changes in porcelain would
suffice? Let's imagine that

 - git-commit refuses to commit to a head that has a corresponding
remote (cg-commit does this already with heads that match something in
'branches')
 - git-$SCMimport scripts generate a semi-bogus remotes/headname entry
 - git-pull/push can spot and ignore the semi-bogus remotes/headname entry
 - this means that `touch remotes/foo` is now a cheap way of making
the head readonly
 - depending on the git-$SCMimport script, the remotes/headname file
can perhaps contain useful configuration data for the import, so
git-$SCMimport headname does the right thing.

cheers,


martin
