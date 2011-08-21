From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 21 Aug 2011 20:53:42 +0000
Message-ID: <CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
 <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
 <7vvctvdf5r.fsf@alter.siamese.dyndns.org> <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
 <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com> <CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 22:56:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvF43-0003eJ-K5
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 22:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab1HUUyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 16:54:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56454 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab1HUUyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 16:54:14 -0400
Received: by gwaa12 with SMTP id a12so2620455gwa.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OsgYwCYGBqVqvMnpiglUFHZv/N1puNQVyj5oyAFDYs0=;
        b=L66ZD35lOIel8o41fs4WkvYisHLIJWTFKNdwAbzy6WClffsB4gq7FOHcTEmQeEEQ6L
         HivU6AnAYrnxMrlbx6ZWgukp8UOT8wZ8/B36rGfF8WjosYXDWlPj5p1IaD20c0n/OB8m
         WgtzGJEjYBn4WlpLRmXP8h/PnB/Wl74En1vRk=
Received: by 10.43.44.195 with SMTP id uh3mr1903834icb.196.1313960053175; Sun,
 21 Aug 2011 13:54:13 -0700 (PDT)
Received: by 10.42.174.129 with HTTP; Sun, 21 Aug 2011 13:53:42 -0700 (PDT)
In-Reply-To: <CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179813>

On Sun, Aug 21, 2011 at 13:42 -0700, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> Isn't a branch simply a way to track changes separately?

Well, what does that mean, really? You can certainly use branches to
help you achieve that goal.

In git usage, a `branch' is just a human-readable name for any given
commit object; it points to a commit object, and you can change to
which commit it points. Furthermore, to help you work with commit
lineages, some of the git machinery updates these branches (or
`pointers', if you like) automatically (for instance, when you make a
new commit object with `git commit', then the `current branch' is
updated to point to the newly created commit object).

Of course, 2 different branches may be used to point to the same commit object.

You should really think of your repository as a giant web of commit
objects (or, more technically, as a directed acyclic graph where each
node is a commit object); a commit object can point 'backwards'
towards its parent commit objects. A branch (like `master') just
points to one of these commit objects at any given time (that is, a
branch just gives a nice human-readable label by which to reference
one of these commit objects at any given time).

See here too:

  http://slashdot.org/comments.pl?sid=2350536&cid=36903136
