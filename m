Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4BF1F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 02:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbdFJCXg (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 22:23:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33244 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdFJCXf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 22:23:35 -0400
Received: by mail-pg0-f66.google.com with SMTP id a70so9114242pge.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 19:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/z5qmO0aG+DMR6mc3lBSFgZ3ICiXLaxY3TKWW7cPEew=;
        b=C1+MNRMsbPQDpNODLnhqEDYIck8uKkO2pNsRb6lg3nJp+jsayiRO3EaiYI8CX+jZTx
         NDalUyrwSl5Hv3wlvstUFSRlf9y4uRlW3/550OWDqyQzlPaayHxc9DY09WOI/48paFD5
         LE2CJ1gfFqs8mr1AuJqCZ9BVzXzzBBZgyYdA5rel4eryh1Qn9+bMn9DTkkIj+dEp/hJW
         g7jJI2RoZF4MDBHnpnQByx5wlh+jvq9aEGPMRwwAglH4sR1+kamoxnblmCowMfF01g//
         g4rSA4xBl1idxyzz6Eo3m60sftSFMPdZZ+PRGTMAgqqiJJjn5+9QlmZjvsPHFNu6+8e4
         2QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/z5qmO0aG+DMR6mc3lBSFgZ3ICiXLaxY3TKWW7cPEew=;
        b=cwDdflbEcBppo4MCYbNrtrvDNPEsR+t4rj7CLPjj9csocn5bnG2E6WtWM+K++TcHbP
         qgXZIt/fxW7/nNaGlfpk9Ay4+b71JDRk0T1M/vMeLWZDYFzKg483yi9Mn2Gve7RVV9q0
         m2YgiflYR/mJvZ5NjMtfOpsQweKv3iEE0ELLUOrQxaowbl5FbasNELJyhJNjZLhZTmSv
         V3XwZrcMwXxoehULBrwMhq3RoybqR50C1EHd5jmhoe3f/3nl9WHr+rICwvJ6YizIsQwC
         NuSkviiIdKjvXhVn7umxy+PsQaLAWm11fvYsNzYQQZdxlhHe/Ov7H89gPgwz55lAowSi
         WGxA==
X-Gm-Message-State: AODbwcBNEpBFaP4ZYLYwz1+B36TWr4hLf5ML2GhZrxqPUe/AjTYMvrlx
        uroLvFcAMhm/Fg==
X-Received: by 10.84.198.35 with SMTP id o32mr17210348pld.194.1497061414880;
        Fri, 09 Jun 2017 19:23:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id w26sm7021789pgc.13.2017.06.09.19.23.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 19:23:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a parent-less branch
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
Date:   Sat, 10 Jun 2017 11:23:33 +0900
In-Reply-To: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Sat, 10 Jun 2017 07:22:36 +0530")
Message-ID: <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

>Subject: Re: [PATCH] wt-status.c: Modified status message shown for a parent-less branch

$ git shortlog -20 --no-merges

may help learning the preferred style of writing the title.  We do
not say "[I] did this".  Instead we phrase things in imperative
mood, giving an order to the codebase to "become like so".  E.g.

    Subject: wt-status.c: rephrase "Initial commit" in "git status" output

or something like that.

> The status message shown for a paren-less branch wasn't so
> descriptive and was a little confusing.

s/paren/parent/; It was descritive enough, but the problem lied
elsewhere. It assumed that the user knows that "git status" message
is relative to the next commit the user creates from the state.

And it wasn't just "a little" confusing.

	"git status" indicated "Initial commit" when HEAD points at
	an unborn branch.  This message is shared with the commit
	log template "git commit" prepares for the user when
	creating a commit (i.e. "You are about to create the initial
	commit"), and is OK as long as the reader is aware of the
	nature of the message (i.e. it guides the user working
	toward the next commit), but was confusing to new users,
	especially the ones who do "git commit -m message" without
	having a chance to pay attention to the commit log template.

> The message has been changed to be more descriptive to users in
> such a way that it clearly shows the state of the branch / repository.

Again, not "This commit did X".

	Rephrase the message so that it is more clear that the state
	of the current branch (not the whole repository) is being
	described to remove this confusion.

> This allows the users to be reminded that they are about to make
> their initial commit which the previous message didn't seem to do
> communicate well.

And this paragraph becomes unnecessary.

> A few alternatives were,

s/were/considered were/;

>
> * No commit yet
> * Your current branch does not have any commits
> * Current branch waiting for initial commit
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---

Does this break "git commit", or is the update limited to "git
status"?

>  wt-status.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 0375484..7bfdde4 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1576,7 +1576,7 @@ static void wt_longstatus_print(struct wt_status *s)
>  
>  	if (s->is_initial) {
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
> -		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
> +		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Waiting for initial commit"));
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
>  	}
>  
> @@ -1746,7 +1746,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>  #define LABEL(string) (s->no_gettext ? (string) : _(string))
>  
>  	if (s->is_initial)
> -		color_fprintf(s->fp, header_color, LABEL(N_("Initial commit on ")));
> +		color_fprintf(s->fp, header_color, LABEL(N_("Waiting for initial commit on ")));
>  
>  	if (!strcmp(s->branch, "HEAD")) {
>  		color_fprintf(s->fp, color(WT_STATUS_NOBRANCH, s), "%s",
