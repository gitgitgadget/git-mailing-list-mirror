From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t3034: add rename threshold tests
Date: Tue, 23 Feb 2016 19:50:12 -0500
Message-ID: <CAPig+cQ+MF7Nsvp7jASXPtPjNWT_g865ot45Y1Q347Y1iCDeYA@mail.gmail.com>
References: <1456271292-4652-1-git-send-email-felipegassis@gmail.com>
	<1456271292-4652-2-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 01:50:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYNep-0006I0-88
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 01:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbcBXAuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 19:50:16 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36608 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbcBXAuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 19:50:14 -0500
Received: by mail-vk0-f54.google.com with SMTP id c3so2805325vkb.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 16:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=JjiQ69ns5NGyaYAZJ9RANV0vXIOzem/487XIOHbD5I0=;
        b=LrmJy6b8YQ0+/U3gb6OA/uLKccE99xSDbAAvECZiYduLHdUYz4gv1zyzSngnGVYYby
         xT7/wjdHtIBi3fVwQxCfFWeoPnOQ4KNYLqOuw4C1RQG2pP39/qgXUaWKex63SuUx77xg
         w8O/X+AtgENS9u8pRpzIiiK2T2XbJmNw2QgCzDzlJl3wWc4/C8BxJ2188Zhowx70O8nd
         iVcqC6iDiBG3/PDvtix5rn1Sd6kQazKpeWefPQEkJF/EDYNEi20/1U6Rk8hRP7vXctqK
         h95zJJ/P9cc0vyeIZo3e7cNxDc+L5KphG4ywgN9vpprzZ/WtoqrwtoiziKsJC9MiV23J
         NSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JjiQ69ns5NGyaYAZJ9RANV0vXIOzem/487XIOHbD5I0=;
        b=Nh1olaQ8gBjd4D2MB/WBax30paNEFrJLB491zJhxafArgDs2nmOozsuQACkEtn9v+Y
         w98pCmkzl8zWu4I3PMoMRXPvBQjggQ2sV8dy8MfNRbuLj8k7zAj54SyvzFnq0uwP7T9X
         IUtAq+pmj062BBKdY5yF4Y9tKufg8mO4/rPkOQxaYGYuMlVl3K1RPQFKseGQoHyhr1HW
         EZhtoNQSq0MQYunMDd9a++ZR7oZJZrr+2JpNbfOxmVd/l8e8mZ3BhdG0D1N8YEZQ+SIR
         75XaD8ePIkHZ/vGUacL3Tv+rV9gmFHjVRX72XrLIkQgmRHYfZd3csHJXLq410voALKhn
         XDEg==
X-Gm-Message-State: AG10YOQhyd06irHUZuGl2Gx9ahAG8jTxiyLHt29V74OztRRYWxCjJlCpOiKB8QS+qzm38zby2DInEjsMFHOI+Q==
X-Received: by 10.31.146.2 with SMTP id u2mr26564384vkd.19.1456275013149; Tue,
 23 Feb 2016 16:50:13 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 23 Feb 2016 16:50:12 -0800 (PST)
In-Reply-To: <1456271292-4652-2-git-send-email-felipegassis@gmail.com>
X-Google-Sender-Auth: o-PGbk1u93dhmGH-hZMhp56xSs0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287150>

On Tue, Feb 23, 2016 at 6:48 PM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> 10ae752 (merge-recursive: option to specify rename threshold,
> 2010-09-27) introduced this feature but did not include any tests.
>
> The tests use the new option --find-renames, which replaces the then
> introduced and now deprecated option --rename-threshold.
>
> Also update name and description of t3032 for consistency:
> "merge-recursive options" -> "merge-recursive space options"

A few superficial comments below...

> Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
> ---
> diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merg=
e-recursive-rename-options.sh
> @@ -0,0 +1,235 @@
> +test_expect_success 'setup 1/2: basic setup' '

If someone ever adds a third setup test, it's likely that that person
will forget to update this title to say "1/3" (ditto regarding "setup
2/2" below). Perhaps just call this "setup repo" and 2/2 "setup
thresholds" or something.

> +       cat <<-\EOF >3-old &&
> +       33a
> +       33b
> +       33c
> +       33d
> +       EOF
> +       sed s/33/22/ <3-old >2-old &&
> +       sed s/33/11/ <3-old >1-old &&
> +       sed s/33/00/ <3-old >0-old &&
> +       git add [0-3]-old &&
> +       git commit -m base &&
> +       git rm [0-3]-old &&
> +       git commit -m delete &&
> +       git checkout -b rename HEAD^ &&
> +       cp 3-old 3-new &&
> +       sed 1,1s/./x/ <2-old >2-new &&
> +       sed 1,2s/./x/ <1-old >1-new &&
> +       sed 1,3s/./x/ <0-old >0-new &&
> +       git add [0-3]-new &&
> +       git rm [0-3]-old &&
> +       git commit -m rename &&
> +       get_expected_stages 0 &&
> +       get_expected_stages 1 &&
> +       get_expected_stages 2 &&
> +       get_expected_stages 3 &&
> +       check_50=3D"false" &&

Why isn't this assignment done in setup 2/2 where all the other
assignments to 'check_50' are done?

> +       tail=3D"HEAD^ -- HEAD master"
> +'
> +
> +test_expect_success 'setup 2/2: threshold array' '
> +       git diff --name-status -M01 HEAD^ HEAD >diff-output &&
> +       test_debug "cat diff-output" &&
> +       test_line_count =3D 4 diff-output &&
> +       grep "R[0-9]\{3\}       \([0-3]\)-old   \1-new" diff-output \
> +               >grep-output &&

I'd be slightly concerned about the use of \{3\} with older grep's
such as on Solaris, and would just code it as "[0-9][0-9][0-9]" and be
done with it, but perhaps it's not worth worrying about until someone
complains.

> +       test_cmp diff-output grep-output &&

So, this is asserting that you only see "renames" and nothing else. Oka=
y.

> +       th0=3D$(sed -n "s/R\(...\)        0-old   0-new/\1/p" <diff-o=
utput) &&
> +       th1=3D$(sed -n "s/R\(...\)        1-old   1-new/\1/p" <diff-o=
utput) &&
> +       th2=3D$(sed -n "s/R\(...\)        2-old   2-new/\1/p" <diff-o=
utput) &&
> +       th3=3D$(sed -n "s/R\(...\)        3-old   3-new/\1/p" <diff-o=
utput) &&
> +       test "$th0" -lt "$th1" &&
> +       test "$th1" -lt "$th2" &&
> +       test "$th2" -lt "$th3" &&
> +       test "$th3" =3D 100 &&

It's very slightly odd to see '=3D' rather than '-eq' among all these
other algebraic operators ('-lt', '-le'), but not so odd that I'd
mention it (unless I just did), and not necessarily worth changing.

> +       if [ 50 -le "$th0" ]; then
> +               check_50=3Dcheck_threshold_0
> +       elif [ 50 -le "$th1" ]; then
> +               check_50=3Dcheck_threshold_1
> +       elif [ 50 -le "$th2" ]; then
> +               check_50=3Dcheck_threshold_2
> +       fi &&
> +       th0=3D"$th0%" &&
> +       th1=3D"$th1%" &&
> +       th2=3D"$th2%" &&
> +       th3=3D"$th3%"
> +'
> +
> +test_expect_success 'assumption for tests: rename detection with dif=
f' '
> +       git diff --name-status -M$th0 --diff-filter=3DR HEAD^ HEAD \
> +               >diff-output-0 &&
> +       git diff --name-status -M$th1 --diff-filter=3DR HEAD^ HEAD \
> +               >diff-output-1 &&
> +       git diff --name-status -M$th2 --diff-filter=3DR HEAD^ HEAD \
> +               >diff-output-2 &&
> +       git diff --name-status -M100% --diff-filter=3DR HEAD^ HEAD \
> +               >diff-output-3 &&
> +       test_line_count =3D 4 diff-output-0 &&
> +       test_line_count =3D 3 diff-output-1 &&
> +       test_line_count =3D 2 diff-output-2 &&
> +       test_line_count =3D 1 diff-output-3
> +'
> +
> +test_expect_success 'default similarity threshold is 50%' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive $tail &&
> +       $check_50
