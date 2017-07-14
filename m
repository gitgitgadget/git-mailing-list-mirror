Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912032027C
	for <e@80x24.org>; Fri, 14 Jul 2017 02:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbdGNCck (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 22:32:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34027 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdGNCck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 22:32:40 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so8894677pge.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 19:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/xCG5vcNlUT4WKdcrnYpqvwU9J+DqK/vMu+1DqUuidM=;
        b=Ep6KZjsI52Ot3jSnBF2blZklvLYFQXnOpyNkTcc/tHhdLDdgM570unLEY+wRRXtYJF
         3NSwtR2RVmc/LcYB1O9uyJhnxAPsM7A6YFZTzYBAWYRiQUIXtu8jhCwWg9/CV8oQ0FU/
         rFw+5eG6f5g2/bSMeuNw18+I8939y0UhCZ8Lw418ih8hD7VZW9gme75sEym+JOBZqlHv
         0OWXanQPt0TFUcLqLUQR0HIXiq3WWUhJgjufjkStJzrqo6jiqb9iJPqoab/RiI3zkgKo
         BT429eW6IylaHRSCBeghgxWkEetA+hklR9uZ0dads5s+DV334Khf8IUuVL0A1mX3oJ63
         16vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/xCG5vcNlUT4WKdcrnYpqvwU9J+DqK/vMu+1DqUuidM=;
        b=fiK3aTgh/F/QEugq7c7CjxmVZagijUkZVe6yS5A/GUxagjCEpRSUlYgHiBzj9AGdQP
         X9nytXnvGy+p1W4vCMfQgroviwukSXSGXSzlKIMMSs7ioKlUSmAJZ+Ixhj8imVaDtxH1
         Ou96BjxIHjv3Ev6nqquJq5mfhwXBq8R92a4slTkHQiuBmfyaur5bLmqk/GSJ9mU4ODsy
         kfrbV6fNd0kGjv1zG7foPuoM8jn7B01BnWfe/8CDFOOn+Bazg+ghRBVzHJoWjEiXpHwd
         amVwq2gu1URIZIiY3KXM3BUp4Vd4mCZ0AdM92hZQoo/14LulNz7mSVI62BeJv/YFiBrh
         OXWQ==
X-Gm-Message-State: AIVw113/p4ZW2EowHQjYeXRlV6m1DtWafeC+OtZDKajCmsl5PKwdKw/Y
        wnUVh1BGT5HgEw==
X-Received: by 10.84.211.137 with SMTP id c9mr13312615pli.96.1499999558990;
        Thu, 13 Jul 2017 19:32:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id s11sm12741592pgr.53.2017.07.13.19.32.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 19:32:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
        <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
Date:   Thu, 13 Jul 2017 19:32:37 -0700
In-Reply-To: <20170714002754.jyck5qmykbmuado7@LykOS.localdomain> (Santiago
        Torres's message of "Thu, 13 Jul 2017 20:27:55 -0400")
Message-ID: <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

>> Here are the topics that have been cooking.  
>
> I sent (a patch almost a week ago) that would probably[1] be labeled
> as "uninteresting" (as per the notes from the maintainer), but I wanted
> to make sure it wasn't lost in the noise -- I see that theres a lot of
> active development lately. I checked the latest iterations of "what's
> cooking" to see if it was going to be discarded or so, but I see no
> mention of it.

I postponed it when I saw it the first time to see if anybody
comments on it, and then it turns out nobody was interested, and it
remained uninteresting to the list to this day.  

Now, after looking at the message again, from the patch description,
I would believe you that you experienced _some_ trouble when the
gpg-agent that is auto-spawned by gpg gets left behind (as I do not
see any hits from "git grep gpg-agent t/", we are not deliberately
using the agent).  However, I could not convince myself that the
solution is credible.  Here is an excerpt from the patch:

> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index ec2aa8f68..22ef2fa87 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -31,6 +31,7 @@ then
>  		chmod 0700 ./gpghome &&
>  		GNUPGHOME="$(pwd)/gpghome" &&
>  		export GNUPGHOME &&
> +		gpgconf --kill gpg-agent &&
>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
>  			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
> -- 

but the current directory of this part is the $TRASH_DIRECTORY,
which is always created anew from the beginning in a test.  What
agent process could possibly be running there immedately after
creating ./gpghome (which happens with "mkdir gpghome &&" without
"-p" just before the context of this hunk---if the agent was running
already, the directory would have been there, and mkdir would have
failed, which would have caused "test_set_prereq GPG" at the end of
the "&&" cascade to be skipped.  In other words, it is unclear to
me, and your log message does not sufficiently explain, why this is
the right solution (or what the exact cause of the symptom is, for
that matter).

Or perhaps the gpg-agent socket is created somewhere outside the
GNUPGHOME and stays behind even after a previous run of the same
test finishes and $TRASH_DIRECTORY gets cleared (I am guessing the
"what the exact cause is" part, as the log message did not explain
it)?  If that is the case, it makes me wonder if either of the two
alternative may be a more robust solution: (1) running gpg tests
telling gpg never to use agent, or (2) telling gpg and gpg-agent to
use a socket inside GNUPGHOME.

After all, "kill"ing agent blindly like the above patch would mean
you do not know what other party is relying on the proper operation
of the thing you are killing.  That sounds more like a workaround
that a solution (unless it is explained with a solid reason why that
is the right way to run more than one instances of GPG).

Perhaps everybody else is running these gpg tests without having to
worry about gpg-agent already because their environment is more
vanilla, but you have some configuration or environment that cause
gpg to use agent, and that is the reason why nobody is interested
(because they have never seen the symptom)?  It is possible that the
part of t/test-lib.sh that tries to cleanse environment variables
and other "external influence" to give us a predictable and
repeatable test is unaware of such a knob that only some developers
(including you) have and the rest of us were merely lucky.  Perhaps
we need to throw GPG_AGENT_INFO SSH_AUTH_SOCK etc. into the list of
envirionment variables to nuke there?

Combined with the unknown-ness of the root cause of the issue, I can
only say that the patch may be raising an issue worth addressing,
but it is too sketchy to tell if it is a right solution or what the
exact problem being solved is.
