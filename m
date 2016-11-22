Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E53D1FF30
	for <e@80x24.org>; Tue, 22 Nov 2016 10:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbcKVKcQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 05:32:16 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33745 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752916AbcKVKcP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 05:32:15 -0500
Received: by mail-yw0-f193.google.com with SMTP id s68so1456165ywg.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DZ2hRt9xVSFimN8UsHFOCzF5u/mumbnrMrunUfheChY=;
        b=bd562f0BI0J8RDIGDPHex5yS5XMITU6GovgvcTfHuDIh5NggsrRPY7nEGOSAHwag4U
         XsRjFJoKu3frqByoJwpKrH/GmAEkVQjOzuJXXyK3guZfsfmayoPyNMn9+Cjc3P548p9W
         b4SfUz2ebDXXgwo1rjT/aIe0Npn9EqtZbLuzkG4sXbLRyC2da8CiaqyF0LQuv7jur+e5
         der00t2d/8c4uPm3Rd22TkXQhAtFGpXmjAtdYDX5xHgMTLm2sX+1J9PRobUpM6YBXobw
         tKjbpsLWFllkTn8+tipiBVQOzDYlZPV+IQ3QJiOzN0BYv7ww9rnZS446FCOhgdrApXZN
         RxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DZ2hRt9xVSFimN8UsHFOCzF5u/mumbnrMrunUfheChY=;
        b=NuNBtcl0SqxjNUzJPvlWcfu6ugp6whaP9/RhPY+qAJ0JVWEfmz4T98Ksw3un96QvE9
         WpQRzRyjVfkDTepR+Gi3e2ysIkg7iERE25VEY0lcV1JathCYc1VmQjttK8eMYzE1nZIV
         gHYShqnskawc2U+94wukOg/+jHjDcEKeGY69TeYhnLXucuSC7O2k4aDhkCijqwQc3ewo
         eLgQk0G9ZHrisjRTGMXDiSQ9pHGmMNTnymvrLoTVk3cPRmc0tF6qK/r0ccvxc60KTth2
         3Hv8yJAbVcT5SlciIX2rRO7yr4XDZIPPomF/9VDlthtJILdTpGKZmD/epeYdXekmoLG9
         lBsg==
X-Gm-Message-State: AKaTC02kWc5JULLEA6tTjvIY/QGrgGaFTtCCDzOfPUdB2GPCJOiiIP5P+foLpN8DHqzHcw8T705vHlFa/dvMKQ==
X-Received: by 10.13.224.3 with SMTP id j3mr20676290ywe.46.1479810734427; Tue,
 22 Nov 2016 02:32:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Tue, 22 Nov 2016 02:31:43 -0800 (PST)
In-Reply-To: <9ef529a4fbb60990a91d7bbfdd49c6d20d49e442.1479737858.git.johannes.schindelin@gmx.de>
References: <cover.1479737858.git.johannes.schindelin@gmx.de> <9ef529a4fbb60990a91d7bbfdd49c6d20d49e442.1479737858.git.johannes.schindelin@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Nov 2016 17:31:43 +0700
Message-ID: <CACsJy8D0uDs8vZgOZ0HkJS7wOuc7TPU9xcB8BTWNsa11At04Ug@mail.gmail.com>
Subject: Re: [PATCH 3/3] rebase -i: handle core.commentChar=auto
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 9:18 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When 84c9dc2 (commit: allow core.commentChar=auto for character auto
> selection, 2014-05-17) extended the core.commentChar functionality to
> allow for the value 'auto', it forgot that rebase -i was already taught to
> handle core.commentChar,

I think this is 180bad3 (rebase -i: respect core.commentchar -
2013-02-11) and a couple followup fixes. My bad.

> and in turn forgot to let rebase -i handle that
> new value gracefully.
>
> Reported by Taufiq Hoven.

Another report in the same area: a merge conflict always writes the
"Conflicts:" section in the commit message with '#' as comment char
when core.commentChar is auto. I've known this for a while, but it has
not bitten me hard enough to do something about it,

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-rebase--interactive.sh    | 13 +++++++++++--
>  t/t3404-rebase-interactive.sh |  2 +-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index ca994c5..6bb740c 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -93,8 +93,17 @@ eval '
>  GIT_CHERRY_PICK_HELP="$resolvemsg"
>  export GIT_CHERRY_PICK_HELP
>
> -comment_char=$(git config --get core.commentchar 2>/dev/null | cut -c1)
> -: ${comment_char:=#}
> +comment_char=$(git config --get core.commentchar 2>/dev/null)
> +case "$comment_char" in
> +''|auto)
> +       comment_char=#

My first thought was "this kinda defeats the purpose of auto, doesn't
it". But 'auto' here is irrelevant because we control the leading
character of all lines in the todo file. 'auto' makes little sense in
this context, falling back to any comment char would do.

So, ack (after you fix the $(comment_char other people have mentioned,
of course).
-- 
Duy
