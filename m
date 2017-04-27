Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF041FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 05:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbdD0FGF (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 01:06:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34898 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdD0FGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 01:06:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id a188so6028690pfa.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 22:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xM9GDEfaUVfhvGPL+DpaYUbJs5jG3WBXAcHT4WNEO4E=;
        b=NU4d28/XhQOD9P5Q4Ulwb/t8eBTLiHGCunFJ6ttS/UB6DhaR6IqkFPCS5VdhiYqq1Z
         r8CnArzvBU8HbLkmnr1nh+ztrn5U9m+WxhbqRWa4/KLeqdwiYaoOX4zBr0UjMTNU24hO
         3/Br0RjCk7/yy8YAIgRSxFYJZV7yfnoS+gffloAmCXlirJSrX51F5SKcEAnQj8bVPUeB
         abICu5SNjEzX1As48zi/JSczgUAvqtWKfcHKHiUV4D3k0ij+XeSrrmO/EHKjW8erDWtR
         B9Sthfw6jjuhqSSwxuzc6kZKj4rGJQ7TSnvsa7VkNws/HS0Bc9DpXfXTPhV1f0+UJJ7X
         npNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xM9GDEfaUVfhvGPL+DpaYUbJs5jG3WBXAcHT4WNEO4E=;
        b=M2MCe5FPni6VMqhG8YO/+yLD8aZBTvRAGeKhUsUbV7diyzwRrDfNpJjUnTC/EyZTuS
         reO01uw5J7YIMKOT7Ioa4mj0ZMn0btgjFOjjlswjqP1ML43Fw/TVl04UqkYxS9KzCV+I
         3HLz/tKIz8CVbzEC8e413SZWxjIfFJOVXlJjb/4KPoc0kNqBWs8hatrY1wAflbK9L9jX
         ba1o1QhlVEcEog0VYkIadjV5GyE6ShZID9g9vS0qNT/QF9pe70Z6VyKUQ/hq6hKUPDd9
         8m/pePfT4iFoabcF3sSgG0g1DDc5tM/7p/oiNYi/LdJVzz74oT6uYvajumAQQ7K5Om6u
         /TIQ==
X-Gm-Message-State: AN3rC/53w+cPhBHhJjEz7lFS/HfzQzhZq4xagiuWEqdj4qrj5PsD66qy
        fqCwzjFqFpQ9iSLtJyrUlA==
X-Received: by 10.84.192.1 with SMTP id b1mr374386pld.9.1493269557692;
        Wed, 26 Apr 2017 22:05:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id d76sm1597301pfj.68.2017.04.26.22.05.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 22:05:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/9] t3404: relax rebase.missingCommitsCheck tests
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <975e7749c2fba9dc263cca1d04879c703c0b3c66.1493207864.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 22:05:56 -0700
In-Reply-To: <975e7749c2fba9dc263cca1d04879c703c0b3c66.1493207864.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 13:59:28 +0200
        (CEST)")
Message-ID: <xmqqmvb2o2x7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> These tests were a bit anal about the *exact* warning/error message
> printed by git rebase. But those messages are intended for the *end
> user*, therefore it does not make sense to test so rigidly for the
> *exact* wording.
>
> In the following, we will reimplement the missing commits check in
> the sequencer, with slightly different words.

Up to this point I thought your strategy was to mimic the original
as closely as possible, and changes to update (and/or improve) the
end user experience (like rewording messages) are left as a separate
step.  Changes to the test can be used to demonstrate the improved
end-user experience that way, and I found it a good way to structure
your series.  Is there a technical reason why you deviate from that
pattern here?  

Just being curious, as I do not particularly mind seeing things done
differently (especially if there is a good reason).

> -cat >expect <<EOF
> -Warning: the command isn't recognized in the following line:
> - - badcmd $(git rev-list --oneline -1 master~1)
> -
> -You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> -Or you can abort the rebase with 'git rebase --abort'.
> -EOF
> -
>  test_expect_success 'static check of bad command' '
>  	rebase_setup_and_clean bad-cmd &&
>  	set_fake_editor &&
>  	test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
>  		git rebase -i --root 2>actual &&
> -	test_i18ncmp expect actual &&
> +	test_i18ngrep "badcmd $(git rev-list --oneline -1 master~1)" actual &&
> +	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
>  	FAKE_LINES="1 2 3 drop 4 5" git rebase --edit-todo &&
>  	git rebase --continue &&
>  	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
> @@ -1277,20 +1270,13 @@ test_expect_success 'tabs and spaces are accepted in the todolist' '
>  	test E = $(git cat-file commit HEAD | sed -ne \$p)
>  '
>  
> -cat >expect <<EOF
> -Warning: the SHA-1 is missing or isn't a commit in the following line:
> - - edit XXXXXXX False commit
> -
> -You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> -Or you can abort the rebase with 'git rebase --abort'.
> -EOF
> -
>  test_expect_success 'static check of bad SHA-1' '
>  	rebase_setup_and_clean bad-sha &&
>  	set_fake_editor &&
>  	test_must_fail env FAKE_LINES="1 2 edit fakesha 3 4 5 #" \
>  		git rebase -i --root 2>actual &&
> -	test_i18ncmp expect actual &&
> +	test_i18ngrep "edit XXXXXXX False commit" actual &&
> +	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
>  	FAKE_LINES="1 2 4 5 6" git rebase --edit-todo &&
>  	git rebase --continue &&
>  	test E = $(git cat-file commit HEAD | sed -ne \$p)
