From: Johan Herland <johan@herland.net>
Subject: Re: notes metadata?
Date: Sun, 07 Feb 2010 23:57:24 +0100
Message-ID: <201002072357.24021.johan@herland.net>
References: <cb7bb73a1002070350j750287abl43de4d936a47acef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 23:57:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeG4U-0002Jn-SJ
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 23:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab0BGW5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 17:57:37 -0500
Received: from smtp.getmail.no ([84.208.15.66]:47895 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755970Ab0BGW5g (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 17:57:36 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXH009FKUFZ0930@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 07 Feb 2010 23:57:35 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXH00AOSUFOKZ30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 07 Feb 2010 23:57:35 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.7.224233
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <cb7bb73a1002070350j750287abl43de4d936a47acef@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139263>

On Sunday 07 February 2010, Giuseppe Bilotta wrote:
> Hello all,
> 
> ok, this may sound a little odd especially with the 'notes vs
> metadata' thread going on, but I was wondering: do we store _any_ kind
> of metadata _about_ the notes themselves? If I'm reading the code
> correctly, we have neither author nor date information about the notes
> themselves, so we don't know who added them or when. Is it too late to
> suggest that this kind of metadata be added to notes? Making them
> full-blown commit-style objects is probalby overengineered and wrong
> under many points of view (not to mention probably incompatible with
> current storage), but maybe we can set up a convention that notes
> SHOULD be in pseudo-mbox format? This would mean that when a note is
> created, the template starts with a 'From ' line including the user's
> name &  email and note creation date; when editing, the note is again
> augmented with the new author name email and date. Of course the users
> are then free do expunge the From lines if they don't want it (just
> commenting it would be enough, of course). How does the idea sound?

NAK

Notes are stored in a notes tree that is changed by making commits on the 
notes ref (see commit_notes() in builtin-notes.c in 'pu'). The commits on 
the notes ref are regular commits with the usual commit metadata (author, 
date, etc.), so if you're interested in who/when a given note was written, 
you can simply point 'git (gui) blame' at the notes tree.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
