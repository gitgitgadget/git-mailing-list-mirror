From: vinassa vinassa <vinassa.vinassa@gmail.com>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Sun, 13 Nov 2011 23:14:25 +0100
Message-ID: <CAM6yGmBgpWzC_jgeyKbWCU-_NJ2NCjpOBHWtTtKyZd95P1xU=A@mail.gmail.com>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
	<20111113182757.GA15194@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 23:14:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPiJv-0002Mf-8H
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 23:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab1KMWO1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 17:14:27 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48692 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab1KMWO0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 17:14:26 -0500
Received: by wwi18 with SMTP id 18so4112838wwi.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 14:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=e8S2gHE5pA2jBTCC3MJSk1HzcXyYuo0aAa4IBMAnDkc=;
        b=l87IHJ4BAAOwAuC4tBTAygCVtxThzAd4kBtkw8i41RLxG3qmQQAFQ5wB7Cu7Pn7wUf
         UPa0Q1lKejqCAFenRaJtEoXiICkOctrgPKA10aaFfc738cdHEnsre+85reYzQaP17d+2
         U291GuhbpgDWtq0h+1f8AUP8Ja8rz87IZORiM=
Received: by 10.180.99.225 with SMTP id et1mr22413764wib.14.1321222465785;
 Sun, 13 Nov 2011 14:14:25 -0800 (PST)
Received: by 10.180.99.2 with HTTP; Sun, 13 Nov 2011 14:14:25 -0800 (PST)
In-Reply-To: <20111113182757.GA15194@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185350>

Hi, thanks for the responses, I get the picture. Some comments below st=
ill.

On Sun, Nov 13, 2011 at 7:27 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
> Hi Vinassa,
>
> vinassa vinassa wrote:
>
> > I am wondering about how git behaves currently, if I kinda win the
> > lottery of the universe, and happen to create a commit with a SHA-1
> > that is already the SHA-1 of another commit in the previous history=
=2E
> > However improbable.
>
> That would be great! =A0You could definitely get an academic paper ou=
t
> of it.
>
> > Would that be detected, so that I could just add a newline, and the=
n
> > commit with a different resulting SHA-1,
> > would I just lose one of those commits (hopefully the new one), wou=
ld
> > I end up with a corrupted repository?
>
> I suspect that one of the two commits would "win" the right to be
> shown by commands like "git log". =A0A commit made after one of the
> commits participating in the hash collision might be stored as a delt=
a
> against the wrong one in the pack, producing errors when you try to
> access it (which is good, since it helps you find the hash collision
> and you can get a paper and prizes).

After cashing in the prizes, I would be able then to git reset --soft,
add a newline, make another commit and go on with my work, right? No
screw up big enough to demand restoring from backups.

> Though I haven't tested. =A0It would be nice to have an md5git (or ev=
en
> truncated-sha1-git) program to test this kind of thing with.

Yes, would be nice. I'll try to see if I can wrap my mind around the
test infrastructure.

> Thanks and hope that helps,
> Jonathan

Thank you for your patience, I understand I should not worry about
this, but this has made me even more curious about what would happen..

Vinassa
