From: Chris Rorvick <chris@rorvick.com>
Subject: Re: Feature Request - Hide ignored files before checkout
Date: Sat, 8 Dec 2012 23:54:11 -0600
Message-ID: <CAEUsAPaqSQVSNaiJUO3Sfms3Rt2vzsciczXK0impHnXQ52u7mA@mail.gmail.com>
References: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com>
	<CAEUsAPaHJ+N0EnxGuVkRqcmY0fUy+4myMiWtd1_vu1vRL763JQ@mail.gmail.com>
	<000001cdd5a0$fd23adf0$f76b09d0$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthew Ciancio <matthew.ciancio16@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 06:54:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThZqW-00063Z-AW
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 06:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522Ab2LIFyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 00:54:14 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:46954 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756503Ab2LIFyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 00:54:13 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so536501wib.1
        for <git@vger.kernel.org>; Sat, 08 Dec 2012 21:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=HggiTChPi1wAFFLqRSk/gfM40Jtk9qzHJzlCE/fuWVo=;
        b=H9Shd4Irau8K5kN/EjUYmSr2tmkMnFrd5HcrVB8n7yA+DfaSCTO9cZNLNVnm7z52/w
         rGoGCS7/guDwxCa4kvHaTnXzSfdFja85uLCgDNQ0zPuxA0QF9BA+xxRridLUFqMjNPid
         eCgBzsjN5+hSDVfGu+vIoDYcl31wMvh5Vp3m8+Dr205GjUDqGv2VYToqvj3+AnmUAti8
         kPTC8EJTuJ0ok5/1rKMu/cW2uUv2neKOgd/w8cQDgx+a/1/uu/fcqWsjGnpYr3q5T0yQ
         HcyO6qN+Nuz28qg6wQ+845Ap3j9sMlzuwueRHi4GbTEFkgo0a3gna+DManSEmFHuOcul
         X+Pg==
Received: by 10.216.73.195 with SMTP id v45mr3447986wed.161.1355032451767;
 Sat, 08 Dec 2012 21:54:11 -0800 (PST)
Received: by 10.217.52.4 with HTTP; Sat, 8 Dec 2012 21:54:11 -0800 (PST)
In-Reply-To: <000001cdd5a0$fd23adf0$f76b09d0$@gmail.com>
X-Google-Sender-Auth: OyGQSNX0ZB6i5aaAYCsZFFtzT2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211226>

On Sat, Dec 8, 2012 at 6:06 PM, Matthew Ciancio
<matthew.ciancio16@gmail.com> wrote:
> Hi Chris,
>
> Yes, I don't think I have explained myself well enough.
>
> When I say "disappear" I do not mean "get deleted", I mean: go out of view
> just like foo.txt does, as it is committed to branchB and not merged into
> branchA.
>
> So I am saying that I think .gitignored files should behave partly like
> committed and un-merged files, in the sense that they disappear when
> checking out to a different branch.
> I don't want to commit these files (which would give me the behaviour I
> want), because they are binary/OS specific and really do not belong in the
> repository, BUT I need them to run/build certain committed files.
>
> To be concrete: I want ignore.txt to be ignored in branchB and hence
> disappear (in the same way that foo.txt will), when checking out to branchA.
> When I checkout back to branchB I want ignore.txt to reappear (in the same
> way that foo.txt will).
>
> I understand why this behaviour is not happening (because my .gitignore
> files are different between the branches), but I am saying that I would like
> to have the option to keep my .gitignore'd files local to the branch they
> are in.
>
> E.g. I currently have a branch with all these binary files that are required
> to run an application on my OS, but when I checkout to another branch I do
> not need or want those binary files anymore (at least not until I checkout
> back into the branch I just came from).
>
> Please tell me if that still doesn't make sense.

Hi Matthew,

Cc'ing the list to benefit from the review of others.

Not wanting the files in the repository seems to be in conflict with
the desire to have them under its control (i.e., disappear/reappear
behavior.)  I understand not wanting to commit dependencies, but why
do you need them to disappear?  Why not just put them somewhere where
they can be used when needed and left alone when not?

If you do want this behavior, it seems like you should just commit the
files on the respective branch.  Maybe someone else will have a better
idea, though.

Chris
