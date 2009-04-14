From: Johan Herland <johan@herland.net>
Subject: Re: git init permissions?
Date: Tue, 14 Apr 2009 20:47:21 +0200
Message-ID: <200904142047.21810.johan@herland.net>
References: <49E4D16E.9050500@pelagic.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 20:49:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltngu-0001MT-RK
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 20:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767AbZDNSr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 14:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756351AbZDNSr0
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 14:47:26 -0400
Received: from mx.getmail.no ([84.208.15.66]:60485 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755827AbZDNSrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 14:47:25 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KI300LTVTIZNO40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 14 Apr 2009 20:47:23 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KI3008L8TIY1B60@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 14 Apr 2009 20:47:23 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.4.14.183727
User-Agent: KMail/1.11.2 (Linux/2.6.29-ARCH; KDE/4.2.2; x86_64; ; )
In-reply-to: <49E4D16E.9050500@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116555>

On Tuesday 14 April 2009, Ferry Huberts (Pelagic) wrote:
> I'm looking at the git init --shared=group result and see:
>
> drwxrwsr-x 7 ferry ferry  111 2009-04-14 19:51 .
> drwxrwxr-x 3 ferry ferry   17 2009-04-14 19:51 ..
> drwxrwxr-x 2 ferry ferry    6 2009-04-14 19:51 branches
> -rw-rw-r-- 1 ferry ferry  127 2009-04-14 19:51 config
> -rw-rw-r-- 1 ferry ferry   58 2009-04-14 19:51 description
> -rw-rw-r-- 1 ferry ferry   23 2009-04-14 19:51 HEAD
> drwxrwxr-x 2 ferry ferry 4.0K 2009-04-14 19:51 hooks
> drwxrwxr-x 2 ferry ferry   20 2009-04-14 19:51 info
> drwxrwsr-x 4 ferry ferry   28 2009-04-14 19:51 objects
> drwxrwsr-x 4 ferry ferry   29 2009-04-14 19:51 refs
>
> Is there some kind of reason that the branches directory is
> not created with +s permissions?
>
> I can understand it for the hooks and info directories since
> you can not push into those. You _can_ however push into
> branches and I would expect it to have +s too, like objects
> and refs.
>
> Bug or my misunderstanding?
>
> git version 1.6.0.6

This was caused by the template files not getting adjusted permissions set 
correctly when copied into a new repository (by git init).

This has been fixed (along with other --shared issues) in v1.6.2.3. Please 
upgrade, if possible.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
