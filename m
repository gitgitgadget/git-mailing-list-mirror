From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] merge-recursive: test more consistent interface
Date: Sun, 21 Feb 2016 13:40:26 -0500
Message-ID: <CAPig+cSAWjqD7weNLyk4MrAU1Q7+R6z16GndKkByHo2Uc4yWqg@mail.gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-6-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 19:40:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYvn-0004dM-PZ
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 19:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbcBUSk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 13:40:28 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36356 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbcBUSk1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 13:40:27 -0500
Received: by mail-vk0-f47.google.com with SMTP id c3so112626282vkb.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 10:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=075YDg5yJP6px+v3WCl0b/BidGO1b99Y2pizc25K5VY=;
        b=qVdPop57DzQ6AFYUxNpyRS1vCir32nn+P4AsiC7/M4Afo+svMta2Diqq49SjdpdMpH
         xP6b3xYmDVAJKmGm0jTZlLxWiJlb/9WsPH5dblGoLUQhIQPI7cYiB1K5XZP3LbcwsvQI
         knhtpuKG5HcHgTP28bBe25vscsDKZcz8jWEf4VcvS10xKJd8penTuhpy4mGOana+SUiS
         0gNsITuFGFEuyhdxZlDbRP+nJkjj19XnRUsQkXjP5b0LVKkEj0H7RrUA41tCYRvBnaxq
         hnE8dW23FEgnuknQ4GjnHSj3uHtRZM+W0KT9CKYDRlPewJmRfG1mNYM2bBB9aTa26pQu
         kUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=075YDg5yJP6px+v3WCl0b/BidGO1b99Y2pizc25K5VY=;
        b=HwuH9u2WadlkB9ox+Ys2X8m04A/o7qCK3LfaE/WBQ2XM+ryNkoI+xmKV9djxKH8XBZ
         4sfIyGSq+AVI3OpRYeXQpanUAmMDbCLyptIjsPV9ygqpJqcRSJOQZec+NEvCkdO4PtEJ
         K6MsMRovoadobXqF76vYNGJLdXC0AK1i97tBpHqpdhcNqGOMqNG3qnXsVrs+k/xQECs9
         QzhACKC5pDwSQT37YZh4WP/fZ2qqe6zKkrciLdzh8SNOfoyNx5bGmti/ZHXNyfcwwk/n
         7z2eWBgElMgjH8BmmCFZZa/Wi81u+c+f0NiN6ah9i/3i7gcDGjn3+jA0YRQCgPO5526H
         4WvA==
X-Gm-Message-State: AG10YOTkB/R0CniYFT1Te55wudkIIZ4fs3f91xCVO8wJ3iVJlcCtjytdRIMY6xv4uVJk6Yx7XUMg5J9cq93OpQ==
X-Received: by 10.31.8.142 with SMTP id 136mr63407vki.14.1456080026179; Sun,
 21 Feb 2016 10:40:26 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 10:40:26 -0800 (PST)
In-Reply-To: <1456067358-19781-6-git-send-email-felipegassis@gmail.com>
X-Google-Sender-Auth: r4G9_bBhbgEHwrC-N_yNIbWh-5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286823>

On Sun, Feb 21, 2016 at 10:09 AM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> merge-recursive: test more consistent interface

The real meat of this patch (it seems) is that you're adding tests to
verify that --find-renames=3D and --rename-threshold=3D are aliases, so=
 it
might make sense for the summary line to state that.

    t3034: test that --find-renames=3D and --rename-threshold=3D are al=
iases

> Update basic tests to use the new option find-renames instead of
> rename-threshold. Add tests to verify that rename-threshold=3D<n> beh=
aves
> as a synonym for find-renames=3D<n>. Test that find-renames resets
> threshold.

Likewise, the order of these sentences seems wrong. The important bit
should be mentioned first, which is that the one is an alias for the
other.

(In fact, if you take advice given below in the actual patch content,
then this paragraph can probably be dropped altogether since the other
two bits don't really belong in this patch.)

> Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
> ---
> diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merg=
e-recursive-rename-options.sh
> @@ -115,25 +115,25 @@ test_expect_success 'the default similarity ind=
ex is 50%' '
>
>  test_expect_success 'low rename threshold' '
>         git read-tree --reset -u HEAD &&
> -       test_must_fail git merge-recursive --rename-threshold=3D25 HE=
AD^ -- HEAD master &&
> +       test_must_fail git merge-recursive --find-renames=3D25 HEAD^ =
-- HEAD master &&

Since you're building this series atop 10ae752 (merge-recursive:
option to specify rename threshold, 2010-09-27) in 'next', the
--find-renames=3D option already exists, so these tests, which were
added in 3/5, can instead use --find-renames=3D from the start, thus
making this patch (5/5) much less noisy since this change and several
below will disappear altogether.

Taking the above and review comments from earlier patches into
account, it might make sense to re-order the series as follows:

1/5: add --find-renames & --find-renames=3D tests (including "last wins=
")
2/5: add --find-renames=3D / --rename-threshold=3D aliases tests
3/5: add --no-renames tests (including "last wins")
4/5: fix --find-renames to reset threshold to default (including test)
5/5: fix merge-strategies.txt typo

The position of the typo fix patch isn't significant; I just
arbitrarily plopped it at the end. Also, the order of patches 2 & 3 is
arbitrary.

More below...

>         check_find_renames_25
>  '
>
>  test_expect_success 'high rename threshold' '
>         git read-tree --reset -u HEAD &&
> -       test_must_fail git merge-recursive --rename-threshold=3D75 HE=
AD^ -- HEAD master &&
> +       test_must_fail git merge-recursive --find-renames=3D75 HEAD^ =
-- HEAD master &&
>         check_find_renames_75
>  '
>
>  test_expect_success 'exact renames only' '
>         git read-tree --reset -u HEAD &&
> -       test_must_fail git merge-recursive --rename-threshold=3D100% =
HEAD^ -- HEAD master &&
> +       test_must_fail git merge-recursive --find-renames=3D100% HEAD=
^ -- HEAD master &&
>         check_find_renames_100
>  '
>
>  test_expect_success 'rename threshold is truncated' '
>         git read-tree --reset -u HEAD &&
> -       test_must_fail git merge-recursive --rename-threshold=3D200% =
HEAD^ -- HEAD master &&
> +       test_must_fail git merge-recursive --find-renames=3D200% HEAD=
^ -- HEAD master &&
>         check_find_renames_100
>  '
>
> @@ -143,12 +143,36 @@ test_expect_success 'disabled rename detection'=
 '
>         check_no_renames
>  '
>
> -test_expect_success 'last wins in --rename-threshold=3D<m> --rename-=
threshold=3D<n>' '
> +test_expect_success 'last wins in --find-renames=3D<m> --find-rename=
s=3D<n>' '
>         git read-tree --reset -u HEAD &&
> -       test_must_fail git merge-recursive --rename-threshold=3D25 --=
rename-threshold=3D75 HEAD^ -- HEAD master &&
> +       test_must_fail git merge-recursive --find-renames=3D25 --find=
-renames=3D75 HEAD^ -- HEAD master &&
>         check_find_renames_75
>  '
>
> +test_expect_success '--find-renames resets threshold' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive --find-renames=3D25 --find=
-renames HEAD^ -- HEAD master &&
> +       check_find_renames_50
> +'

As mentioned in my review of patch 1/5, this test really ought to be
bundled with that patch.

> +test_expect_success 'last wins in --no-renames --find-renames' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive --no-renames --find-rename=
s HEAD^ -- HEAD master &&
> +       check_find_renames_50
> +'
> +
> +test_expect_success 'last wins in --find-renames --no-renames' '
> +       git read-tree --reset -u HEAD &&
> +       git merge-recursive --find-renames --no-renames HEAD^ -- HEAD=
 master &&
> +       check_no_renames
> +'
> +
> +test_expect_success 'rename-threshold=3D<n> is a synonym for find-re=
names=3D<n>' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive --rename-threshold=3D25 HE=
AD^ -- HEAD master &&
> +       check_find_renames_25
> +'

I rather expected to see this test come first, as all the others are
rather subordinate to it.

>  test_expect_success 'last wins in --no-renames --rename-threshold=3D=
<n>' '
>         git read-tree --reset -u HEAD &&
>         test_must_fail git merge-recursive --no-renames --rename-thre=
shold=3D25 HEAD^ -- HEAD master &&
> @@ -161,4 +185,16 @@ test_expect_success 'last wins in --rename-thres=
hold=3D<n> --no-renames' '
>         check_no_renames
>  '
>
> +test_expect_success 'last wins in --rename-threshold=3D<n> --find-re=
names' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive --rename-threshold=3D25 --=
find-renames HEAD^ -- HEAD master &&
> +       check_find_renames_50
> +'
> +
> +test_expect_success 'last wins in --find-renames --rename-threshold=3D=
<n>' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive --find-renames --rename-th=
reshold=3D25 HEAD^ -- HEAD master &&
> +       check_find_renames_25
> +'
> +
>  test_done
