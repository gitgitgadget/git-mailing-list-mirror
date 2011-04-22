From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: git incorrectly infers rename i.e. (delete file1 + creation of
 new file2) != (file => file2)
Date: Fri, 22 Apr 2011 07:22:24 +0200
Message-ID: <BANLkTimcL2D_FbKnDREQPNLGG2i8wsoLCg@mail.gmail.com>
References: <BANLkTimqk5xP6X7NcGqZ6w05GfYe02iAhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike <xandrani@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 07:22:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD8pI-0006uz-BY
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 07:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006Ab1DVFW1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2011 01:22:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47421 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab1DVFW0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2011 01:22:26 -0400
Received: by iwn34 with SMTP id 34so275108iwn.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7rh7x8sY1O1T4ePUQ7A5S9M3gknBvtEnZ0UmfodWeeU=;
        b=jG2WsGTBjmIRZgK1VxVYSmIa3SRJtFENXaJYvuDB0tveIE3pwtZ3VU4ht2/JqOUsFt
         9IdWppi7e14kGjcVFwjkhqQAbr/yrQn70ba2LyypF3bGT6VJVNKmMoP11vX5IGIsj+vJ
         Xq3gRo7uucCcHJ5xSZpCRxFSng3qvUlr9q2Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bIln1VYBeMv74BEfph4Bz8xZj0i2tMGLcO68qxb5uun3DwpU0eZEXB9/fB7d6LR4ft
         i5o1yd81RiP9FXxRTg3zpkdkm5UbXc7iMvVY2R04WK6Fa7MQ9APZWRUK4DiLCUoGfF5B
         nFnv+E/Wl+B85uBLi+zZCX5yFL4wWbfpLaGOg=
Received: by 10.43.60.205 with SMTP id wt13mr860333icb.253.1303449744122; Thu,
 21 Apr 2011 22:22:24 -0700 (PDT)
Received: by 10.43.61.4 with HTTP; Thu, 21 Apr 2011 22:22:24 -0700 (PDT)
In-Reply-To: <BANLkTimqk5xP6X7NcGqZ6w05GfYe02iAhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171932>

On Fri, Apr 22, 2011 at 02:31, Mike <xandrani@gmail.com> wrote:
> Hi
>
> I deleted a file called 'class.NumberOfResultsCache.php' and created =
a
> completely different file called
> 'cgi-bin/___php/class.NumberOfResults.php'.

"completely different" in what they mean to you, or in their actual con=
tent?
Please be more specific.

> I deleted the file using
> rm followed by 'git rm'.
>
> When I do a 'git status' I now get told:
>
> =C2=A0 renamed: =C2=A0 =C2=A0cgi-bin/___php/class.NumberOfResultsCach=
e.php ->
> cgi-bin/___php/class.NumberOfResults.php
>
> However I want to commit 'class.NumberOfResultsCache.php' as having
> been deleted, and I want to commit 'class.NumberOfResults.php' as a
> brand new file.

Git doesn't care about individual files or renames, it tracks whole tre=
es.
What it shows as a rename is just its best guess based on the contents
of the two files.

> How do I get git to do this? Apologies for a 'noob' question. Only
> been using the superb git for a couple of weeks!

You could commit the deletion and the add separately, but before doing
that, why is it important to you that git not show this change as a
potential rename?

// Ben

> Thanks :)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
