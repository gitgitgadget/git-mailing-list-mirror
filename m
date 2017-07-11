Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9342035B
	for <e@80x24.org>; Tue, 11 Jul 2017 20:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933298AbdGKUW6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 16:22:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35833 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933261AbdGKUW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 16:22:57 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so333375pgc.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=23oU/h6bg5jXSnL/XTPQeODTiI/IvY5JWXXnY+d1ZAQ=;
        b=iSITPWmWvDatrgnnlfVwEtcVHlco6tMxpSoiGNmrFB6neKKKamQwKV32OD3UbWuxQq
         Y0dtAXIrEZGOEfpdmftSWmrNuu4jZZJSWu80oxNc0s3rU238wPGcLomsaEgD03G/t42a
         ZYLt1prqD/KFRXMVwUg9bgzKnmXQRNPw9DcLPMr6T3SOjGkaKxyIUvmzPFw11llBjNG8
         Fw581Qe7EVvhOk10l749EeDh54o6NfH61kDfN75fWHijsYmnU6ddFxynrTQt0OT6p8N7
         v1D7khDjahngNCsXDPc7oOz/QBAjH2O2K8xs+tkzBkXDKeA+X803zlu7vki+brNzO1ml
         3wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=23oU/h6bg5jXSnL/XTPQeODTiI/IvY5JWXXnY+d1ZAQ=;
        b=HDUu6xRPLaRBd/LCoqSOOILuzItjwdDbzbI6L8bIxS5HY9yKaS2lbE9HIzo7nbWFXR
         xmC1zCmbzO5yVdNddwL7lnP47EYrhg5S8SqB3qfDH2fCvHv7hceW9PqiW9rMAdhNB0uz
         w9O7uRoerP6VXZEs35Igdmf/WrGjAW9puc/9pADPCuKpC844SolIVV6iktEZX1m0PB9g
         WTf/+GDEXVfoFcGOPeTVb3oDSfepCgoUmWHgMsZZnonj49SIu3o9AS+75imYrUrlNz4L
         g0WIT70wUbu3oyomXnfWCfLZy5oblVJL23HeohTPHnbBlVz8WXX3VUVlxTrr2yqsUidW
         A7rA==
X-Gm-Message-State: AIVw1130ZXvNO8TC9oZVlFCU//nvzcC1r7IMYQLptIzH/JudnfgTmXAP
        6xI0X/V6CCAywQ==
X-Received: by 10.101.90.75 with SMTP id z11mr220872pgs.58.1499804576091;
        Tue, 11 Jul 2017 13:22:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id x65sm327219pfa.107.2017.07.11.13.22.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 13:22:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, me@ikke.info
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
        <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
Date:   Tue, 11 Jul 2017 13:22:54 -0700
In-Reply-To: <20170711141254.7747-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 11 Jul 2017 19:42:54 +0530")
Message-ID: <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> In the context of "git merge" the meaning of an "empty message"
> is one that contains no line of text. This is not in line with
> "git commit" where an "empty message" is one that contains only
> whitespaces and/or signed-off-by lines. This could cause surprises
> to users who are accustomed to the meaning of an "empty message"
> of "git commit".
>
> Prevent such surprises by ensuring the meaning of an empty 'merge
> message' to be in line with that of an empty 'commit message'. This
> is done by separating the empty message validator from 'commit' and
> making it stand-alone.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  I have made an attempt to solve the issue by separating the concerned
>  function as I found no reason against it.
>
>  I've tried to name them with what felt appropriate and concise to me.
>  Let me know if it's alright.

I probably would have avoided a pair of new files just to house a
single function.  I anticipate that the last helper function in
commit.c at the top-level would become relevant to this topic, and
because of that, I would have added this function at the end of the
file if I were doing this patch.

> @@ -772,7 +773,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>  	}
>  	read_merge_msg(&msg);
>  	strbuf_stripspace(&msg, 0 < option_edit);
> -	if (!msg.len)
> +	if (!msg.len || message_is_empty(&msg, 0))

I do not see much point in checking !msg.len here.  The function
immediately returns by hitting the termination condition of the
outermost loop and this is not a performance-critical codepath.

I think the "validation" done with the rest_is_empty() is somewhat
bogus.  Why should we reject a commit without a message and a
trailer block with only signed-off-by lines, while accepting a
commit without a message and a trailer block as long as the trailer
block has something equally meaningless by itself, like
"Helped-by:"?  I think we should inspect the proposed commit log
message taken from the editor, find its tail ignoring the trailing
comment using ignore_non_trailer, and further separate the result
into (<message>, <trailers>, <junk at the tail>) using the same
logic used by the interpret-trailers tool, and then complain when
<message> turns out to be empty, to be truly useful and consistent.

And for that eventual future, merging the logic used in commit and
merge might be a good first step.

Having said all that, I am not sure "Prevent such surprises" is a
problem that is realistic to begin with.  When a user sees the
editor buffer in "git merge", it is pre-populated with at least a
single line of message "Merge branch 'foo'", possibly followed by
the summary of the side branch being merged, so unless the user
deliberately removes everything and then add a sign-off line
(because we do not usually add one), there is no room for "such
surprises" in the first place.  It does not _hurt_ to diagnose such
a crazy case, but it feels a bit lower priority.

So from the point of "let's improve what merge does", this change
looks to me a borderline "Meh"; but to improve the "why sign-off is
so special and behave differently from helped-by when deciding if
there is any log?" situation, having a separate helper function that
is shared across multiple codepaths that accept edited result may be
a good idea.

