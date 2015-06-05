From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] git-bisect.sh : create a file if the bisection is in
 old/new mode, named "BISECT_OLDNEWMODE", so it can easily be seen outside the
 program without having to read BISECT_TERMS. This will have to be changed in
 further versions if new terms are introduced.
Date: Fri, 5 Jun 2015 16:03:15 -0400
Message-ID: <CAPig+cQnrKEx_=WHw5gjA9SVtDObXWOJ3augZbhvNUuD8o19aA@mail.gmail.com>
References: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	j_franck7@msn.com, valentinduperray@gmail.com,
	thomasxnguy@gmail.com, lucienkong@hotmail.com,
	Christian Couder <chriscool@tuxfamily.org>
To: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xpp-0004I5-1V
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 22:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbbFEUDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 16:03:17 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34153 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbFEUDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 16:03:16 -0400
Received: by iebmu5 with SMTP id mu5so30021567ieb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oNrWaPe05rmrOeAsQxmJr1aQ7G+FVkMgQFJoP2I62QU=;
        b=jSQ8BZo9wolRSyQhbfD0akNc+vF2AkvPTG2r+Hh4trY9MClH4OdFQcP4pb4+oxkNff
         hQUGwLAeuHOQm2pjoxvRE23lps8AxNfOfif6vIemAZr95fjvpE/J3/jXCZ2UmN8UD5kf
         5HP6cQHBUA1xcToUykki+emvnu9yW0ZazIYCGH5dNKC8d6Qo510BYDsM0VH++ZyswjtU
         Zm34GJBIBov+dbCrz4tutyT4C4xHyuCy0++XKetKrCYa42ho2M5Y79bfg/3CkQqpqgm4
         t0NK8lu8exNVuu57tw3IabkVRG4FgIoreMYLlFvJqeeosb2ex0v1k/u1jMvGXNDf1Da9
         ezvA==
X-Received: by 10.42.166.200 with SMTP id p8mr6864725icy.25.1433534595462;
 Fri, 05 Jun 2015 13:03:15 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 5 Jun 2015 13:03:15 -0700 (PDT)
In-Reply-To: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: D5pcFBAcLmmFHKQgwyJm_CLVuAk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270886>

On Fri, Jun 5, 2015 at 12:34 PM, Louis Stuber
<stuberl@ensimag.grenoble-inp.fr> wrote:
> git-bisect.sh : create a file if the bisection is in old/new mode,
> named "BISECT_OLDNEWMODE", so it can easily be seen outside the
> program without having to read BISECT_TERMS. This will have to be
> changed in further versions if new terms are introduced.

Documentation/SubmittingPatches contains instructions for how to write
a good commit message. The first line should be a very brief
high-level overview of the change, followed by a blank line, followed
by one or more paragraphs justifying and explaining the change. Also,
wrap the commit message to 70-72 columns.

This commit message doesn't do a very good job of explaining the
problem this change is trying to solve or justifying why this solution
is preferable. Justification is particularly important considering the
ominous-sounding final sentence of the commit message (which itself
seems to imply that this is not a very good change).

> Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
> Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
> ---
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 109bd65..d3d19cb 100644
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -183,6 +183,10 @@ bisect_start() {
>         then
>                 echo "$BISECT_BAD" >"$GIT_DIR/BISECT_TERMS" &&
>                 echo "$BISECT_GOOD" >>"$GIT_DIR/BISECT_TERMS"
> +               if test "$BISECT_BAD" = "new"

Nit: Unnecessary quotes around "new" make the code a bit more noisy,
thus slightly more difficult to read.

> +               then
> +                       echo "" > "$GIT_DIR/BISECT_OLDNEWMODE"

Style: Drop space after redirection operator.

If only the file's existence is important, but not its content, then
you could phrase this more concisely without the 'echo'. Just use the
redirection operator without any command in front of it: >"$somefile"

Same comments apply below.

> +               fi
>         fi &&
>         echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
>         #
> @@ -416,6 +420,7 @@ bisect_clean_state() {
>         rm -f "$GIT_DIR/BISECT_NAMES" &&
>         rm -f "$GIT_DIR/BISECT_RUN" &&
>         rm -f "$GIT_DIR/BISECT_TERMS" &&
> +       rm -f "$GIT_DIR/BISECT_OLDNEWMODE" &&
>         # Cleanup head-name if it got left by an old version of git-bisect
>         rm -f "$GIT_DIR/head-name" &&
>         git update-ref -d --no-deref BISECT_HEAD &&
> @@ -544,7 +549,8 @@ check_and_set_terms () {
>                         if test ! -s "$GIT_DIR/BISECT_TERMS"
>                         then
>                                 echo "new" >"$GIT_DIR/BISECT_TERMS" &&
> -                               echo "old" >>"$GIT_DIR/BISECT_TERMS"
> +                               echo "old" >>"$GIT_DIR/BISECT_TERMS" &&
> +                               echo "" > "$GIT_DIR/BISECT_OLDNEWMODE"
>                         fi
>                         BISECT_BAD="new"
>                         BISECT_GOOD="old" ;;
> --
> 1.7.1
