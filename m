Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B891F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 18:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443165AbfJRSwa (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 14:52:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39377 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfJRSwa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 14:52:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so4418486pff.6
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9lnztSXpOmG9OZP92IS6snzGRcC43iBLaQBr1x1NWfQ=;
        b=JTogFgGsVcKtANOhA0VToMRUYM2S+ah5pVssQKwiCXIVdhSKhj0iVFx4VHwsz3B3lp
         Fakzw7Uruq23TPWMQQkQ2mg7zsV4zsgdk4LodmeKY1pJozXjFKu0hpgUv92uwsdWy5aS
         OVTUJ+RcluHSnRu7CYczxvsAv/UkqO8Dp6rMzGjGTgM8kR8woqyJAaHPZcSxFIaVjcF5
         JqpbuU6qkUSLD2PiHCzl9+rh8Ozg7Iw5P7+41x596DgwzQApa534+TG9J34OwRAgtFLQ
         HlfSTJ99srIpYit3GEhJqDtaMdZw98/9pAgr3HHAp9BFKVur/GjD2SrR6Amqee0JoN8m
         vTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9lnztSXpOmG9OZP92IS6snzGRcC43iBLaQBr1x1NWfQ=;
        b=TOpkug4hIx4PeMBFXc4B1oRgHQzJmfxLjnoB+59f63/XImhINqhzHfOkqiHrKPRvUF
         5GnvCwr1Op6LfbFb9RQJ8TnTnK3HUMxTZVV6/VtDau302OziI4Z6SmxEpBZk80kZHPCB
         T9/nTOOO6e0iEqGCbuxCzUk3r1lpYlUpgDiOgyWAN+9Ee8FcZ5HiuBJy2mA9Ru4FHy6a
         wu0PUY6NsA68aZdvU5mjESDU6YPH6pKEpVrMwbvZXk1mPWzY6lIVyjfqvlR/ACM09FXb
         H4e7uFCjMZkCfS8Yuyk7OWIzDsNlT9AWO1zWd3Pql2FuzQx1RqjD3f9a08cDzfqEXJiw
         sycg==
X-Gm-Message-State: APjAAAX5tchvgl7CReLOb54IQWKGg8LyRwjC03d3q08xV06rb66DuYlC
        kyx0VQXzOHnVzQEwd5TsNiRSwTN+
X-Google-Smtp-Source: APXvYqwFuXEgjxjNnpXUk3WNSxAmlSiXnYwcqv70lZR+VBNP9EpERhKVcedjgg13N5i7QaWZ9FfHBg==
X-Received: by 2002:a62:b504:: with SMTP id y4mr8486229pfe.40.1571424749392;
        Fri, 18 Oct 2019 11:52:29 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 37sm5917969pgv.32.2019.10.18.11.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 11:52:28 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:52:27 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 08/12] t5520: use test_cmp_rev where possible
Message-ID: <20191018185227.GA74877@generichostname>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <ff05a0a8f7dc91d988e290b7d606e8a64f5daf54.1571354136.git.liu.denton@gmail.com>
 <CAPig+cRF0taNhmZVu0z+P+Oe3em11Jz33GY8eBZRTGkx3z=TOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRF0taNhmZVu0z+P+Oe3em11Jz33GY8eBZRTGkx3z=TOw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Thanks for the reviews. I have no idea how you always get to my patches
so quickly but I appreciate the prompt reviews whenever I send a
test-related patchset in.

I've fixed up the other concerns you had and I'll send a v2 later but I
wanted to address this one.

On Thu, Oct 17, 2019 at 07:41:44PM -0400, Eric Sunshine wrote:
> On Thu, Oct 17, 2019 at 7:17 PM Denton Liu <liu.denton@gmail.com> wrote:
> > In case an invocation of `git rev-list` fails within the subshell, the
> > failure will be masked. Remove the subshell and use test_cmp_rev() so
> > that failures can be discovered.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> > @@ -597,10 +597,10 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
> >         test_must_fail git pull &&
> > -       test "$COPY" = "$(git rev-parse --verify me/copy)" &&
> > +       test_cmp_rev "$COPY" me/copy &&
> 
> This transformation doesn't look correct. COPY already holds the
> result of a git-rev-parse invocation:
> 
>     COPY="$(git rev-parse --verify me/copy)" &&
> 
> so passing it to test_cmp_rev() -- which applies its own git-rev-parse
> invocation -- doesn't make sense.

I'll annotate the entire test case with my comments:

	# so we'll be testing that pull --rebase dies early
	test_expect_success 'pull --rebase dies early with dirty working directory' '
		git checkout to-rebase &&
		git update-ref refs/remotes/me/copy copy^ &&
		COPY="$(git rev-parse --verify me/copy)" &&
		git rebase --onto $COPY copy &&

		# according to git log --graph, we have this currently:
		#
		# $ git log --pretty=oneline --graph to-rebase copy me/copy
		# * 9366795adb50ef6eb482b610b37cb1fb6edbd3d0 (HEAD -> to-rebase) to-rebase
		# * b3dcf50eea47c4ad85faabb0fb74eded71cc829f file3
		# * faf459539411b4557cf735232a3746be073177a9 new file
		# | * f340b1b8932f7b1e016c06867cbdc3f637eeea2d (copy) conflict
		# |/  
		# * 5e86d50a28977ebee5ea378f81591ea558149272 (me/second, me/copy, second) modified
		# * d25cf184567afad1dc1e018b2b7d793bc1bd2dc1 original

		test_config branch.to-rebase.remote me &&
		test_config branch.to-rebase.merge refs/heads/copy &&
		test_config branch.to-rebase.rebase true &&

		# we make the tree dirty here
		echo dirty >>file &&
		git add file &&

		# and over here, the pull should fail
		test_must_fail git pull &&

		# but since we're testing that it dies early, we want to
		# make sure that the remote ref doesn't change, which is
		# why it should still be equal
		test_cmp_rev "$COPY" me/copy &&

		git checkout HEAD -- file &&

		# but over here, the pull succeeds...
		git pull &&

		# so as a result, the remote ref should now be updated
		test_cmp_rev ! "$COPY" me/copy
	'

So after grokking the test case, it seems like the the transformation is
indeed correct. Maybe we can replace the last line with

	test_cmp_rev copy me/copy

but I think I'll leave it unless you have any strong opinions.

Thanks,

Denton
