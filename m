Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9D51F461
	for <e@80x24.org>; Tue,  2 Jul 2019 09:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfGBJDQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 05:03:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43809 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGBJDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 05:03:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so7920658pfg.10
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TgWW/3U9QzrwKJKZ7wYC7V7YM245sJ5AYJEGLVuZ+5I=;
        b=qzxxOUOzEgHBZuZFldHb1pjMjnOdQkE+nJdOJ1XcJbNtqjspPSiY8Fg1pGFGJp5ryP
         xzsZVu4ODWH4FapyezFSEdib/vXSebOKyBw4A2kI7tWWvSY3+JisgH6Sp7pPK6zHfxYj
         mGXhVb9cP67Yh5zMlVY+CsqeFcYta6/UtB6YtbksLuW7ib2qhszkQsy9xQn5SWliaNQD
         AF28JfCqctqVD8oauiq7MCkml0sdhswZTWd/0OC3U+1bQxKANZPpeg2JZci1v/HQzgWX
         KuM2jbwZJieLpXiStZHXkxNNe7daEmCnf+NYSbAoIuTpa8wkIMlO114WqQvJJU+pna6x
         kcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TgWW/3U9QzrwKJKZ7wYC7V7YM245sJ5AYJEGLVuZ+5I=;
        b=hUL7RsGxoTiR8MboosQSclpqFHatLGcMN/URoAJ4arFuh2CINWjZVLwl9H/8A7XhCa
         WKj0CLWkpS+1UwU8kvg7ruxGDH+j5d67JFafgZTV7lm6reTU88zY27VoncQGcCmVUsxf
         RUEHkPPjKaD1nZvIRlkHqIeW18SgOG6i8fu9gqDzVI0ToYip3R9pvvdCodsm8NYOiwnw
         gS5WyKxq7KLsNTRbPlzhRGbXVJqm1OUgeWoDA5IZPMguyBAZSfADxnqSTVFx/UzxDdIH
         IsEg6KXrV5R99kaTQNq/hG+KO4dkuHTBufvH6Qi8MUUUnUgS+QxadAiYXQsk3V8gxa1E
         IkDg==
X-Gm-Message-State: APjAAAW7L707hJEKLuq0hSPe0q1kULpdPf+iXrNn9GII1xSz/Bs0ZtqB
        PwzJaWPTlHtTabIdnNRXAE0=
X-Google-Smtp-Source: APXvYqzJdTFviKGtQA2BBgM/pFlNMCm8XovzMCy7fmOGaaicG4X5eAUOaUbihFJsCNXDA97jqFRRrQ==
X-Received: by 2002:a63:205f:: with SMTP id r31mr21072130pgm.159.1562058195221;
        Tue, 02 Jul 2019 02:03:15 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id h6sm5682222pfb.20.2019.07.02.02.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 02:03:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 02 Jul 2019 16:03:09 +0700
Date:   Tue, 2 Jul 2019 16:03:09 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        jacob.keller@gmail.com, martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 07/27] checkout: inform the user when removing branch
 state
Message-ID: <20190702090308.GA27775@ash>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-8-pclouds@gmail.com>
 <20190702080611.GL21574@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190702080611.GL21574@szeder.dev>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 02, 2019 at 10:06:11AM +0200, SZEDER Gábor wrote:
> On Fri, Mar 29, 2019 at 05:38:59PM +0700, Nguyễn Thái Ngọc Duy wrote:
> > After a successful switch, if a merge, cherry-pick or revert is ongoing,
> > it is canceled. This behavior has been with us from the very early
> > beginning, soon after git-merge was created but never actually
> > documented [1]. It may be a good idea to be transparent and tell the
> > user if some operation is canceled.
> 
> After this entered 'next' last week, today it greeted me with 167(!)
> of these warnings...  before I even had my breakfast.
> 
> Now, my script does a lot of repeated cherry-picks and expects that
> rerere is able to deal with most of the conflicts, i.e. it does
> approximately this:
> 
>   if ! git cherry-pick $oid >/dev/null 2>&1
>   then
>       if was_the_conflict_resolved
>       then
>           echo "using previous conflict resolution"
>           git commit --no-edit --cleanup=strip --quiet
>       else
>           die "uh-oh"
>       fi
>   fi
> 
> That 'git commit' in there always prints:
> 
>   warning: cancelling a cherry picking in progress
> 
> I don't understand why committing after a cherry-pick is considered
> "cancelling"...  in my view it's finishing it and there should be no
> warning whatsoever.
> 

I agree, this is not "canceling". I think this series causes conflicts
with pw/clean-sequencer-state-upon-final-commit and the warning is
accidentally enabled (partly my fault since I named the argument
"verbose").

Junio, in this conflict resolution (merging nd/switch-and-restore to
next), we should pass '0' instead of 'verbose' to
sequencer_post_commit_cleanup().

diff --cc builtin/commit.c
index 1921401117,fa5982cc86..145d50caf0
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@@ -1658,7 -1666,8 +1658,7 @@@ int cmd_commit(int argc, const char **a
  		die("%s", err.buf);
  	}
  
- 	sequencer_post_commit_cleanup(the_repository);
 -	unlink(git_path_cherry_pick_head(the_repository));
 -	unlink(git_path_revert_head(the_repository));
++	sequencer_post_commit_cleanup(the_repository, verbose);
  	unlink(git_path_merge_head(the_repository));
  	unlink(git_path_merge_msg(the_repository));
  	unlink(git_path_merge_mode(the_repository));
--
Duy
