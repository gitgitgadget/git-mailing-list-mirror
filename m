Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACF1C433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1847061357
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 21:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhKGV2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 16:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbhKGV2J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 16:28:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A56C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 13:25:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v11so52085216edc.9
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycVgQCP/iktoedr+T5KYIh3spON03ubx+ZIAa/JR584=;
        b=L/lJeKFinI+/GD5hd919PZVknd5Nvt0Sg+6ff5NX2lYx+rxzPYm3kbVCCQ3wRCV8BS
         hDMbhLc6AC9CHTV7vMZwm28DOO+AplwJa1EdTpu4lgL1XtqA7d4Q4eJ/CMyvNyXJ1Dkq
         OVICHv/eU8Yib5xZpBE6vEI3nZ9UxWlpHghdvam034XaEL0gFcW6pZpGQMCJJaR88i+X
         AriaGg+1Y0mvkA5EmPXr3Wr1DTeKFjIWyrIGaJKQld0+NkipEoOi6YC5UqjJBHT2Tu8h
         CAKXE/BUKP3KXRpXf570Zu/euzcchjRJX1162Hm/p5cvHoE/+imZMNfGucqXEpB6mG1U
         lMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycVgQCP/iktoedr+T5KYIh3spON03ubx+ZIAa/JR584=;
        b=FAC5BupMNvXbSBiJZiPzIkCURPCEIAJfmMl/2WXatx1lPNmg3iC2bgk9JgU2kAeP9k
         +fGbe/9muctprwkantr4jzkyFnZA8H9UAaWEBrgBsNWRo8+wLblLEag9Rb63ZLEJa4Tx
         Iq/6VCiy6HQ7PwCcZ4K51u5a9iT/rhKPS1cSDYe8WmldMW+eSyxueHTfKHjd3o9sRghd
         mr4PH22DNth7JUDH4a05uNQ/e4ysICrXRip8L5reO2io8D9IoKQSEyOXTKhL4SdxUkjj
         DaCF6VRIc/SCyCLhel3jQ2NzgEOtQukMChATgfaVs9UUkJ8konhRVyhn61yx/g83omMG
         IcDA==
X-Gm-Message-State: AOAM532UdppzLZ/1NWSa+u5DCmXiU6cDXlJfwDSKyJVapxprrSe1JmKP
        VaKrsyVxEWCPGNp4u3dKhrpmjSFEki/XDt6I1E0=
X-Google-Smtp-Source: ABdhPJzi1ZScAkMHT2PhCe6FseLadxCFRU2ky50Bjn8P573pJUZs32O8+UekwC9u9hsCz86E3nFWzOF1DiAWvmqvvXg=
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr101017508edt.280.1636320324004;
 Sun, 07 Nov 2021 13:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20211104160959.183402-1-greenfoo@u92.eu> <20211104160959.183402-3-greenfoo@u92.eu>
In-Reply-To: <20211104160959.183402-3-greenfoo@u92.eu>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 7 Nov 2021 13:24:47 -0800
Message-ID: <CAJDDKr4icrigRO-2S_HVdY7+W0EGJ8XBn5dD=O-qy1tXym4u8w@mail.gmail.com>
Subject: Re: [PATCH 2/3] vimdiff: add tool documentation
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for writing this up. Notes inline below.


On Thu, Nov 4, 2021 at 9:10 AM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> Running 'git {merge,diff}tool --tool-help' now also prints usage
> information about the vimdiff tool (and its variantes) instead of just
> its name.
>
> Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
> added to the set of functions that each merge tool (ie. scripts found
> inside "mergetools/") can overwrite to provided tool specific
> information.
>
> Right now, only 'mergetools/vimdiff' implements these functions, but
> other tools are encouraged to do so in the future, specially if they
> take configuration options not explained anywhere else (as it is the
> case with the 'vimdiff' tool and the new 'layout' option)
>
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  git-mergetool--lib.sh |  12 ++
>  mergetools/vimdiff    | 272 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 284 insertions(+)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 542a6a75eb..3964cd8f99 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -64,6 +64,10 @@ $(list_tool_variants)"
>                                 fi
>                                 shown_any=yes
>                                 printf "%s%s\n" "$per_line_prefix" "$toolname"
> +                               while IFS= read -r line
> +                               do
> +                                       printf "%s\t%s\n" "$per_line_prefix" "$line"
> +                                done < <(diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname")


If we wanted to shorten this line a bit, would it work to run the pipeline
first and pipe the result?

    (diff_mode && ... || merge_cmd_help ...) |
    while IFS= read -r line
    do
       ...
    done

How come we have to unset IFS here?
We often do:

IFS='
'

so that we have just \n newline as the separator.

I wonder if that would be better along with a save/restore of the IFS value?


>                         fi
>                 done
>
> @@ -162,10 +166,18 @@ setup_tool () {
>                 return 1
>         }
>
> +       diff_cmd_help () {
> +               return 0
> +       }
> +
>         merge_cmd () {
>                 return 1
>         }
>
> +       merge_cmd_help () {
> +               return 0
> +       }
> +
>         hide_resolved_enabled () {
>                 return 0
>         }
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 1f2e88777e..aa8fbc0a19 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -428,6 +428,46 @@ diff_cmd () {
>                 -c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
>  }
>
> +diff_cmd_help() {
> +       case "$1" in
> +       vimdiff)
> +               cat <<-ENDOFMESSAGE
> +                       Opens vim with two vertical windows: LOCAL changes will be placed in the left
> +                       window and REMOTE changes in the right one.
> +               ENDOFMESSAGE


Tiny nit: we call this EOF in the other places
(git-mergetool--helper.sh) where we do the same.

ENDOFMESSAGE is a bit verbose so it might be worth sticking to the
conventional EOF marker.



> +               ;;
> +       vimdiff*)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'vimdiff'
> +               ENDOFMESSAGE
> +               ;;
> +       gvimdiff)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'vimdiff' but opens 'gvim' instead (which uses a graphical toolkit for
> +                       opening its own window)
> +               ENDOFMESSAGE
> +               ;;
> +       gvimdiff*)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'gvimdiff'
> +               ENDOFMESSAGE
> +               ;;
> +       nvimdiff)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'vimdiff' but opens 'neovim' instead (which is a fork of the original
> +                       'vim' 'focused on extensibility and usability' according to their authors)
> +               ENDOFMESSAGE
> +               ;;
> +       nvimdiff*)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'nvimdiff'
> +               ENDOFMESSAGE
> +               ;;
> +       esac
> +
> +       return 0
> +}
> +
>
>  merge_cmd () {
>         layout=$(git config mergetool.$merge_tool.layout)
> @@ -503,6 +543,238 @@ merge_cmd () {
>         return "$ret"
>  }
>
> +merge_cmd_help() {
> +       case "$1" in
> +       vimdiff)
> +               cat <<-ENDOFMESSAGE
> +                       Opens vim with a 4 windows layout distributed in the following way:
> +
> +                           ------------------------------------------
> +                           |             |           |              |
> +                           |   LOCAL     |   BASE    |   REMOTE     |
> +                           |             |           |              |
> +                           ------------------------------------------
> +                           |                                        |
> +                           |                MERGED                  |
> +                           |                                        |
> +                           ------------------------------------------
> +
> +                       "LOCAL", "BASE" and "REMOTE" are read-only buffers showing the contents of the
> +                       conflicting file in a specific git commit ("commit you are merging into",
> +                       "common ancestor commit" and "commit you are merging from" respectively)
> +
> +                       "MERGED" is a writable buffer where you have to resolve the conflicts (using the
> +                       other read-only buffers as a reference). Once you are done, save and exit "vim"
> +                       as usual (":wq") or, if you want to abort, exit using ":cq".
> +
> +                       You can change the windows layout used by vim by setting configuration variable
> +                       "mergetool.vimdiff.layout" which accepts a string where these separators have
> +                       special meaning:
> +
> +                         - ";" is used to "open a new tab"
> +                         - "-" is used to "open a new vertical split"
> +                         - "|" is used to "open a new horizontal split"


This would probably be a good place to mention the "*" current marker as well.

I wonder how good these special symbols are for shell friendliness.

Instead of a "*" suffix I would suggest a "@" prefix eg. "@LOCAL" for
the "use this tab" stuff.



The "|" is a nice choice visually, as is ";" but I wonder if we can
avoid shell metacharacters.

Instead of ";" would "+" or "T" work for "open a new tab". I kinda
like "+", so my examples below will use that.



Instead of "|" would "," (comma) work for a vertical split? Ditto --
the examples below will use "," comma.

Note that I said "vertical", which is the opposite of what is written
above (horizontal split) for "|".

I believe these are called "vertical" splits:

   LOCAL | BASE | REMOTE

because the splits are vertical... that might just be a small
switcheroo in the docs that needs updating.



"-" is nice for horizontal splits. It visually matches what happens,
but in the context of "," and "+" I think "/" would be a better
choice.

"a / b" means "a over b" in some math interpretations, and visually
would make sense for horizontal splits where "a" is on the top and "b"
is on the bottom.


Anyways, just some sugs to try and avoid shell syntax. My examples
below will use "/" for horizontal splits.


> +
> +                       Let's see some examples to undertand how it works:
> +
> +                         * layout = "(LOCAL | BASE | REMOTE) - MERGED"


My sug would be to write this as either: "LOCAL,BASE,REMOTE - MERGED"
or "(LOCAL, BASE, REMOTE) - MERGED".

Are the (parens) necessary, or can we infer grouping because
"LOCAL,BASE,REMOTE" are grouped together in the first example? Maybe
that's too subtle, but it's an idea.


> +
> +                           This is exactly the same as the default layout we have already seen.
> +
> +                         * layout = "LOCAL | MERGED | REMOTE"


My sug would be: "LOCAL, MERGED, REMOTE".

> +
> +                           If, for some reason, we are not interested in the "BASE" buffer.
> +
> +                                  ------------------------------------------
> +                                  |             |           |              |
> +                                  |             |           |              |
> +                                  |   LOCAL     |   MERGED  |   REMOTE     |
> +                                  |             |           |              |
> +                                  |             |           |              |
> +                                  ------------------------------------------
> +
> +                         * layout = "MERGED"
> +
> +                           Only the "MERGED" buffer will be shown. Note, however, that all the other
> +                           ones are still loaded in vim, and you can access them with the "buffers"
> +                           command.
> +
> +                                  ------------------------------------------
> +                                  |                                        |
> +                                  |                                        |
> +                                  |                 MERGED                 |
> +                                  |                                        |
> +                                  |                                        |
> +                                  ------------------------------------------
> +
> +                         * layout = "LOCAL* | REMOTE"
> +
> +                           When "MERGED" is not present in the layout, you must "mark" one of the
> +                           buffers with an asterisk. That will become the buffer you need to edit and
> +                           save after resolving the conflicts.


My sug is that this would be written as: "@LOCAL, REMOTE"


> +
> +                                  ------------------------------------------
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  |     LOCAL         |    REMOTE          |
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  ------------------------------------------
> +
> +                          * layout = "(LOCAL | BASE | REMOTE) - MERGED; BASE | LOCAL; BASE | REMOTE"


If we eschewed parens then this would look like:

    "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE"

With parens it would be:

    "(LOCAL, BASE, REMOTE) / MERGED + BASE, LOCAL + BASE, REMOTE"

I personally like the idea of not needing the parens if we can do without them,
but I haven't looked at the implementation at all yet.

I suspect the more complicated examples below require them, perhaps?

The upside of parens is that it avoids having significant whitespace,
so a grouping syntax might be warranted.


> +
> +                           Three tabs will open: the first one is a copy of the default layout, while
> +                           the other two only show the differences between "BASE" and "LOCAL" and
> +                           "BASE" and "REMOTE" respectively.
> +
> +                                  ------------------------------------------
> +                                  | <TAB #1> |  TAB #2  |  TAB #3  |       |
> +                                  ------------------------------------------
> +                                  |             |           |              |
> +                                  |   LOCAL     |   BASE    |   REMOTE     |
> +                                  |             |           |              |
> +                                  ------------------------------------------
> +                                  |                                        |
> +                                  |                MERGED                  |
> +                                  |                                        |
> +                                  ------------------------------------------
> +
> +                                  ------------------------------------------
> +                                  |  TAB #1  | <TAB #2> |  TAB #3  |       |
> +                                  ------------------------------------------
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  |     BASE          |    LOCAL           |
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  ------------------------------------------
> +
> +                                  ------------------------------------------
> +                                  |  TAB #1  |  TAB #2  | <TAB #3> |       |
> +                                  ------------------------------------------
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  |     BASE          |    REMOTE          |
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  |                   |                    |
> +                                  ------------------------------------------
> +
> +                          * layout = "(LOCAL | BASE | REMOTE) - MERGED; BASE | LOCAL; BASE | REMOTE; (LOCAL - BASE - REMOTE) | MERGED"


This would be:

"(LOCAL, BASE, REMOTE) / MERGED + BASE, LOCAL + BASE, REMOTE + (LOCAL
/ BASE / REMOTE), MERGED"

Without parents it would be:

"LOCAL,BASE,REMOTE / MERGED + BASE, LOCAL + BASE, REMOTE +
LOCAL/BASE/REMOTE, MERGED"


That does seem a bit subtle... it could work, but maybe we should
avoid making whitespace have special meaning and just go with parens
(or [] or {}) for grouping.

I'd like to hear some opinions on that.


> +
> +                           Same as the previous example, but adds a fourth tab with the same
> +                           information as the first tab, with a different layout.
> +
> +                                  ---------------------------------------------
> +                                  |  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
> +                                  ---------------------------------------------
> +                                  |       LOCAL         |                     |
> +                                  |---------------------|                     |
> +                                  |       BASE          |        MERGED       |
> +                                  |---------------------|                     |
> +                                  |       REMOTE        |                     |
> +                                  ---------------------------------------------
> +
> +               ENDOFMESSAGE
> +               ;;


This example really shows off how nice and flexible this approach is.
This is really cool, by the way.

My only other sug is that maybe this documentation can be in the
Documentation/ area and these messages can be reduced to something
along the lines of:

    Please see the "vimdiff" section in "git help mergetool" or "git
help difftool" for more details.


Not sure. It is kinda nice that the help message is maximally helpful as-is,
but it probably should be in Documentation/ so that we don't have to duplicate
the information in multiple places.



> +       vimdiff1)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'vimdiff' using this layout: "LOCAL* | REMOTE"
> +
> +                       This will probably be deprecated in the future. Please use "vimdiff" and
> +                       manually set the "mergetool.vimdiff.layout" configuration variable instead.
> +               ENDOFMESSAGE
> +               ;;
> +       vimdiff2)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'vimdiff' using this layout: "LOCAL | MERGED | REMOTE"
> +
> +                       This will probably be deprecated in the future. Please use "vimdiff" and
> +                       manually set the "mergetool.vimdiff.layout" configuration variable instead.
> +               ENDOFMESSAGE
> +               ;;
> +       vimdiff3)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'vimdiff' using this layout: "MERGED"
> +
> +                       This will probably be deprecated in the future. Please use "vimdiff" and
> +                       manually set the "mergetool.vimdiff.layout" configuration variable instead.
> +               ENDOFMESSAGE
> +               ;;
> +       gvimdiff)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'vimdiff' but opens 'gvim' instead (which uses a graphical toolkit for
> +                       opening its own window).
> +                       The desired layout can be set with configuration variable
> +                       "mergetool.gvimdiff.layout"
> +               ENDOFMESSAGE
> +               ;;
> +       gvimdiff1)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'gvimdiff' using this layout: "LOCAL* | REMOTE"
> +
> +                       This will probably be deprecated in the future. Please use "gvimdiff" and
> +                       manually set the "mergetool.gvimdiff.layout" configuration variable instead.
> +               ENDOFMESSAGE
> +               ;;
> +       gvimdiff2)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'gvimdiff' using this layout: "LOCAL | MERGED | REMOTE"
> +
> +                       This will probably be deprecated in the future. Please use "gvimdiff" and
> +                       manually set the "mergetool.gvimdiff.layout" configuration variable instead.
> +               ENDOFMESSAGE
> +               ;;
> +       gvimdiff3)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'gvimdiff' using this layout: "MERGED"
> +
> +                       This will probably be deprecated in the future. Please use "gvimdiff" and
> +                       manually set the "mergetool.gvimdiff.layout" configuration variable instead.
> +               ENDOFMESSAGE
> +               ;;
> +       nvimdiff)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'vimdiff' but opens 'neovim' instead (which is a fork of the original
> +                       'vim' 'focused on extensibility and usability' according to their authors)
> +                       The desired layout can be set with configuration variable
> +                       "mergetool.nvimdiff.layout"
> +               ENDOFMESSAGE
> +               ;;
> +       nvimdiff1)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'nvimdiff' using this layout: "LOCAL* | REMOTE"
> +
> +                       This will probably be deprecated in the future. Please use "nvimdiff" and
> +                       manually set the "mergetool.nvimdiff.layout" configuration variable instead.
> +               ENDOFMESSAGE
> +               ;;
> +       nvimdiff2)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'nvimdiff' using this layout: "LOCAL | MERGED | REMOTE"
> +
> +                       This will probably be deprecated in the future. Please use "nvimdiff" and
> +                       manually set the "mergetool.nvimdiff.layout" configuration variable instead.
> +               ENDOFMESSAGE
> +               ;;
> +       nvimdiff3)
> +               cat <<-ENDOFMESSAGE
> +                       Same as 'nvimdiff' using this layout: "MERGED"
> +
> +                       This will probably be deprecated in the future. Please use "nvimdiff" and
> +                       manually set the "mergetool.nvimdiff.layout" configuration variable instead.
> +               ENDOFMESSAGE
> +               ;;
> +       esac
> +
> +       return 0
> +}
> +
>
>  translate_merge_tool_path() {
>         case "$1" in
> --
> 2.33.1
>

Thanks for taking it this far! I personally like the direction this is
going, but I'd very much appreciate hearing others' opinions.
-- 
David
