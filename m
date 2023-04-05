Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EA5C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 04:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbjDEEar (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 00:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjDEEao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 00:30:44 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD9A10DD
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 21:30:43 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id d3so13280677ybu.1
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 21:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680669042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iC2MFCve6QsJhVKs4VaLeLs+UyoHguTrvMAcXLvshI=;
        b=qweJGkDcH0bfUSmfEGw4x8og5xRL2LrI2lHfcQzr3my7Hj/Xxf8Qo8kPo5UiTOq4SQ
         HZSvKPgr1t9PuZQBY34MNuibs+CoKw2/+1jYZyKwa6mW9WpgAWDtuzO7/cp+HA3aCgMQ
         BfHSa6+cCYVpr45pGR3qzrfNqj2OJQz1Z6/T9B27+y0pqJoCCIrURmL09LIEqsZHjVAR
         oXAloptMOwBFrVuu1ry8NbOu0Q81fIIehNyPP8wB5pGC3WA0VQRiZAp73rJ9urdzCBRq
         wUcZAaS2kyahF2S8x6xDFe0emuFEAe8PQy0sFiXOuwY0PIcoPgijjwJ6rMNYYUSNsxch
         e6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680669042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iC2MFCve6QsJhVKs4VaLeLs+UyoHguTrvMAcXLvshI=;
        b=oni/Xc1dmn+atgAgAzYnENwGmodcqDWAOBEyGJEb4nXf1KqrBAdwbYIVUvPn6seI/a
         oc4gruPtg+6mlbUvlJ1Fkqjqoj9rzehtoC7qOd3KTcCw+mIYyvbXe4kHvrJPIkkFN1rf
         mk8+AlbeWgvDUheuAWL82LOtR25AsZw/Vbsm3e1Dpi2SLOVYAzqorvVLiNBAuVG0eEeL
         +7KqE9JLtrQayWpKLdlk9eYhIu08Ck0zRld7r/OYqcemxt2g5oaSJf/fYSkgh5l3QVYT
         dJ7bAUlinYDfItfZZngRRFKwP+1GvfKMhORXL5k31UAQUS3bw9jGsbHZLsPT943jYuZR
         dtaQ==
X-Gm-Message-State: AAQBX9d2IWd7U27XLcIt83fWJODv+TDDpLvtCs9/FPCDaz7uZ9kIe+rO
        Zrs02n5ZPyu9lmO1Yq3WYHE+pJznHAsDoQytJdGcCSoEAKc=
X-Google-Smtp-Source: AKy350YRYhwJytwPm4NpyokAc2z1ir1JXh6Ag5kQV1wEskZnSaI+Xic090rco9u59GxHglw6HPtLVTxgJjsu/pG1L+U=
X-Received: by 2002:a25:d981:0:b0:b21:a3b8:45cd with SMTP id
 q123-20020a25d981000000b00b21a3b845cdmr3383139ybg.0.1680669042229; Tue, 04
 Apr 2023 21:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1510.git.1680661709616.gitgitgadget@gmail.com>
In-Reply-To: <pull.1510.git.1680661709616.gitgitgadget@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 4 Apr 2023 23:30:30 -0500
Message-ID: <CAMP44s15E0xJwXv8qGp8FqQvB_KaxS2TXenNZNH_VzvXpXv4Hw@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: render literal *
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Emily Shaffer [ ]" <emilyshaffer@google.com>,
        Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 9:56=E2=80=AFPM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> The HTML version of MyFirstContribution [1] does not render the
> asterisks (*) meant to be typed in as glob patterns by the user, because
> they are being interpreted as bold text delimiters.

Yes, they should be between backticks in order to be interpreted as literal=
s.

Acked-by: Felipe Contreras <felipe.contreras@gmail.com>

>  Documentation/MyFirstContribution.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirs=
tContribution.txt
> index ccfd0cb5f3e..9c64bf58757 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1164,7 +1164,7 @@ After you run this command, `format-patch` will out=
put the patches to the `psuh/
>  directory, alongside the v1 patches. Using a single directory makes it e=
asy to
>  refer to the old v1 patches while proofreading the v2 patches, but you w=
ill need
>  to be careful to send out only the v2 patches. We will use a pattern lik=
e
> -"psuh/v2-*.patch" (not "psuh/*.patch", which would match v1 and v2 patch=
es).
> +`psuh/v2-*.patch` (not `psuh/*.patch`, which would match v1 and v2 patch=
es).

Small nit: with this change we would lose the quotes, which are
helpful, I would rather do "`foo`".

And for what it's worth I would revamp the whole section, something like th=
is:

--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1136,18 +1136,18 @@ information on how to handle comments from reviewer=
s.
 We'll reuse our `psuh` topic branch for v2. Before we make any changes, we=
'll
 mark the tip of our v1 branch for easy reference:

-----
+....
 $ git checkout psuh
 $ git branch psuh-v1
-----
+....

 Refine your patch series by using `git rebase -i` to adjust commits based =
upon
 reviewer comments. Once the patch series is ready for submission, generate=
 your
 patches again, but with some new flags:

-----
+....
 $ git format-patch -v2 --cover-letter -o psuh/ --range-diff
master..psuh-v1 master..
-----
+....

 The `--range-diff master..psuh-v1` parameter tells `format-patch` to inclu=
de a
 range-diff between `psuh-v1` and `psuh` in the cover letter (see
@@ -1157,53 +1157,53 @@ between your v1 and v2 patches.
 The `-v2` parameter tells `format-patch` to output your patches
 as version "2". For instance, you may notice that your v2 patches are
 all named like `v2-000n-my-commit-subject.patch`. `-v2` will also format
-your patches by prefixing them with "[PATCH v2]" instead of "[PATCH]",
-and your range-diff will be prefaced with "Range-diff against v1".
+your patches by prefixing them with "`[PATCH v2]`" instead of "`[PATCH]`",
+and your range-diff will be prefaced with "`Range-diff against v1`".

 After you run this command, `format-patch` will output the patches to
the `psuh/`
 directory, alongside the v1 patches. Using a single directory makes it eas=
y to
 refer to the old v1 patches while proofreading the v2 patches, but
you will need
 to be careful to send out only the v2 patches. We will use a pattern like
-"psuh/v2-*.patch" (not "psuh/*.patch", which would match v1 and v2 patches=
).
+"`psuh/v2-*.patch`" (not "`psuh/*.patch`", which would match v1 and
v2 patches).

 Edit your cover letter again. Now is a good time to mention what's differe=
nt
 between your last version and now, if it's something significant. You do n=
ot
 need the exact same body in your second cover letter; focus on explaining =
to
 reviewers the changes you've made that may not be as visible.

-You will also need to go and find the Message-Id of your previous cover le=
tter.
+You will also need to go and find the `Message-ID` of your previous
cover letter.
 You can either note it when you send the first series, from the output of =
`git
 send-email`, or you can look it up on the
 https://lore.kernel.org/git[mailing list]. Find your cover letter in the
-archives, click on it, then click "permalink" or "raw" to reveal the Messa=
ge-Id
+archives, click on it, then click "permalink" or "raw" to reveal the
`Message-ID`
 header. It should match:

-----
-Message-Id: <foo.12345.author@example.com>
-----
+....
+Message-ID: <foo.12345.author@example.com>
+....

-Your Message-Id is `<foo.12345.author@example.com>`. This example will be =
used
-below as well; make sure to replace it with the correct Message-Id for you=
r
-**previous cover letter** - that is, if you're sending v2, use the Message=
-Id
-from v1; if you're sending v3, use the Message-Id from v2.
+Your `Message-ID` is `<foo.12345.author@example.com>`. This example
will be used
+below as well; make sure to replace it with the correct `Message-ID` for y=
our
+**previous cover letter** - that is, if you're sending v2, use the `Messag=
e-ID`
+from v1; if you're sending v3, use the `Message-ID` from v2.

 While you're looking at the email, you should also note who is CC'd, as it=
's
 common practice in the mailing list to keep all CCs on a thread. You can a=
dd
 these CC lines directly to your cover letter with a line like so in the he=
ader
 (before the Subject line):

-----
+....
 CC: author@example.com, Othe R <other@example.com>
-----
+....

 Now send the emails again, paying close attention to which messages you pa=
ss in
 to the command:

-----
+....
 $ git send-email --to=3Dtarget@example.com
  --in-reply-to=3D"<foo.12345.author@example.com>"
  psuh/v2-*.patch
-----
+....

 [[single-patch]]
 =3D=3D=3D Bonus Chapter: One-Patch Changes


--=20
Felipe Contreras
