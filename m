From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Add passed and estimated seconds to the filter-branch on demand
 via --progress-eta flag
Date: Sun, 30 Aug 2015 17:55:59 -0400
Message-ID: <CAPig+cS3rWfN_y73Tn_ryJpMzS8UvCs_ZaWAfYeJ82wJDp_ALw@mail.gmail.com>
References: <CANy2qHcz2Kk2_S29hyPf-yMe0AgjRZkd1=R33cY10sc6v91ixA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, mfwitten@gmail.com
To: Gabor Bernat <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 23:56:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWAa6-0005Lc-ML
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 23:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbbH3V4B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2015 17:56:01 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34662 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbH3V4A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2015 17:56:00 -0400
Received: by ykfw127 with SMTP id w127so10476248ykf.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=s2Uhcxq8m33xXd+DTIV3QrFfOssnRMYbm3W0c3L4miw=;
        b=VePRAyJOWrH15K5DeNL+54z90TR61DNsZI54bCn4kwIeiuKlVG5qYQTN+QcOmj2tVK
         jII/zO0yb0o/BG6edjsfJEWha2KM70bmQk0w0aATflRS79/BtMWUEWFjwctVeZCsCe5N
         NvicP8xEHB+Ck9EAwwJGuodeIay7P8zQ4rmNzJOzZeBBz32qvEMvwS6g+LuLrQj8thYO
         tF9GsE2N6rKXJe33en54gGcC/xHktldz+v14bOC9wBePSfHfsF/QI7Xbv/ZD4OdyOCyt
         s9fO1IJqkS28zTmVuTJvssFZsJ5Q1kQ2L30axs6uXyMTssKWfwtpn2A6Ep/pcpBbvhgC
         lozA==
X-Received: by 10.129.92.8 with SMTP id q8mr17853556ywb.163.1440971759855;
 Sun, 30 Aug 2015 14:55:59 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 30 Aug 2015 14:55:59 -0700 (PDT)
In-Reply-To: <CANy2qHcz2Kk2_S29hyPf-yMe0AgjRZkd1=R33cY10sc6v91ixA@mail.gmail.com>
X-Google-Sender-Auth: FXKwuf9ccichD2ouGr0dkNmp79Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276839>

On Sun, Aug 30, 2015 at 7:45 AM, Gabor Bernat <bernat@primeranks.net> w=
rote:
> I've submitted this first to this list as a feature request, however
> in the meantime with the help of Jeff King <peff@peff.net>, Junio C
> Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
> and Mikael Magnusson <mikachu@gmail.com> came up with solution, so no=
w
> I submit it as a patch. Here follows a patch, I really hope I got
> right the format:

Thanks for the patch. Since the actual implementation is still under
discussion[1], I'll just comment on the properties of the patch
itself...

In order to allow "git-am --scissors" to extract the patch
automatically from your email, you'd want to separate the above
commentary from the below patch with a scissor line "-- >8 --".
Alternately (and more commonly), you can make git-am happy by placing
the commentary (such as the above text) below the "---" line just
under your sign-off and before the diffstat.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/276531

> From 620e69d10a1bfcfcace347cbb95991d75fd23a1d Mon Sep 17 00:00:00 200=
1
> From: Gabor Bernat <gabor.bernat@gravityrd.com>
> Date: Thu, 27 Aug 2015 00:46:52 +0200

When including a patch in a mail message like this (separated by a "--
>8--" line), you'd normally drop these headers. "From" isn't
meaningful outside your own repository, and "From:" (with colon) and
"Date:" are normally inferred from the email itself. In this case,
however, use of "From:" (with a colon) is appropriate since it differs
from the email address of your message.

An alternative is to use git-send-email to take care of the mail
header situation for you automatically.

> Subject: [PATCH] Add to the git filter-branch a --progress-eta flag w=
hich when
>  enabled will print with the progress also the number of seconds pass=
ed since
>  started plus the number of seconds predicted until the operation fin=
ishes.

A commit message should consist a one-line brief explanation of the
change (shorter than 72 characters), followed by a blank line,
followed by one or more paragraphs explaining the change. The first
line should also be prefixed by the area the patch is touching, is
typically not capitalized, and lacks a full-stop (period). For
example:

    filter-branch: add --progress-eta option to estimate completion tim=
e

    In addition to reporting how many commits have been processed and
    how many remain, when --progress-eta is enabled, also report how
    much time has elapsed and an estimate of how much remains.

> Signed-off-by: Gabor Bernat <gabor.bernat@gravityrd.com>
> ---

This is where you'd place commentary such as that which is currently
at the top of this email (as well as the small comment at the very
bottom), particularly if you are using git-send-email to send the
patch.

Unfortunately, this patch is severely whitespace damaged, as if it had
been pasted into the message via Gmail's user-interface. Using
git-send-email can help avoid such damage.

>  Documentation/git-filter-branch.txt |  6 ++++++
>  git-filter-branch.sh                | 29 +++++++++++++++++++++++++++=
+-
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-filter-branch.txt
> b/Documentation/git-filter-branch.txt
> index 73fd9e8..6ca9d6e 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -194,6 +194,12 @@ to other tags will be rewritten to point to the
> underlying commit.
>   directory or when there are already refs starting with
>   'refs/original/', unless forced.
>
> +--progress-eta::
> + If specified will print the number of seconds elapsed and the predi=
cted
> + count of seconds remaining until the operation is expected to finis=
h. Note
> + that for calculating the eta the global speed up to the current poi=
nt is
> + used.
> +
>  <rev-list options>...::
>   Arguments for 'git rev-list'.  All positive refs included by
>   these options are rewritten.  You may also specify options
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 5b3f63d..7b565fb 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -105,6 +105,7 @@ filter_subdir=3D
>  orig_namespace=3Drefs/original/
>  force=3D
>  prune_empty=3D
> +progress_eta=3D
>  remap_to_ancestor=3D
>  while :
>  do
> @@ -129,6 +130,11 @@ do
>   prune_empty=3Dt
>   continue
>   ;;
> + --progress-eta)
> + shift
> + progress_eta=3Dt
> + continue
> + ;;
>   -*)
>   ;;
>   *)
> @@ -277,9 +283,30 @@ test $commits -eq 0 && die "Found nothing to rew=
rite"
>  # Rewrite the commits
>
>  git_filter_branch__commit_count=3D0
> +
> +case "$progress_eta" in
> + t)
> + start=3D$(PATH=3D`getconf PATH` awk 'BEGIN{srand();print srand()}')
> + ;;
> + '')
> + ;;
> +esac
> +
>  while read commit parents; do
>   git_filter_branch__commit_count=3D$(($git_filter_branch__commit_cou=
nt+1))
> - printf "\rRewrite $commit ($git_filter_branch__commit_count/$commit=
s)"
> +
> + case "$progress_eta" in
> + t)
> + now=3D$(PATH=3D`getconf PATH` awk 'BEGIN{srand();print srand()}')
> + elapsed=3D$(($now - $start))
> + remaining_second=3D$(( ($commits - $git_filter_branch__commit_count=
) *
> $elapsed / $git_filter_branch__commit_count ))
> + progress=3D" ($elapsed seconds passed, remaining $remaining_second =
predicted)"
> + ;;
> + '')
> + progress=3D""
> + esac
> +
> + printf "\rRewrite $commit
> ($git_filter_branch__commit_count/$commits)$progress"
>
>   case "$filter_subdir" in
>   "")
> --
> 2.5.1.408.g14905ed.dirty
>
> Let me know if this works for adding it to the main repository,
>
> Thanks a lot,
>
>
> Bern=C3=A1t G=C3=81BOR
