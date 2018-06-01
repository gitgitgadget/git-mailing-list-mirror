Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8231F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 09:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeFAJyg (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 05:54:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55517 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeFAJye (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 05:54:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id a8-v6so1860281wmg.5
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5X/pd/+BxZs4njYsC5b6mUbgAATz4EGTTZp91izgkk0=;
        b=U6JeDprTq/sphpSyOS9h6KooYCH240/5C0ImOeWo1UkHVc5qX+xtxIOwkyFys57ye5
         RtK9uT98QamlFcwHl5oqzXLsaipG32Qr4AXaMPYjxiffNLEkkoh8bsAuBayt4kJmcIhP
         7BbO8F9HLS3UBIn/KFCAIxKD2LxKUgUZJVTsXXJURIcgfaSazABd3GOU8hxo7fXSeONa
         9pR4cl8/8icUqru9N3LMJaEK8pZCT8GKYX9NihSQhFMwyhX1CxWqqE4o/T7ckg+oKfMF
         A8Gfh6bKI+/xUe9FH3925wMkz2569RG5PpkgeZWSBFnQkK8wpLfPQ0s3ESNJ2rzGpEqb
         KHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5X/pd/+BxZs4njYsC5b6mUbgAATz4EGTTZp91izgkk0=;
        b=AWMbxJORGxUd2HktiH+86pt/o+XfIZhY7HpA+zgo+ytK8Gml1OmRFPOAcke6zNuu7n
         g/qdPzakOjI6WsG16tDVM6Pt9phoSSYlp2maooFPGYN9AGznSt4/7nZoaP0tdu9is0dT
         Cp84C8k1PExdV50fNMe4deC9bpHJ2XlklKGcX6Tm+nvaIF8tVgB2lAN0Qf04H0vcrhn/
         uAZDXIqAe3OS0mMM1rMAT48CpMtjlbMypX3zmBMQiu+GpXp3mQgUV9y8vtHZAkklovmq
         R3xoCuqrFVzrpeNLU4n6mOUX2yWqVL3sAFUJU7Efe5uFllwEWbaSThWEsrZscMO/Lhmb
         60OQ==
X-Gm-Message-State: ALKqPwcwB+q4kt39QJhgRqvCx405rbQQFvtbBQ6Yq4U89vv3EW5d93d+
        WpCcblAeV7KT/wGLFYVhdd4=
X-Google-Smtp-Source: ADUXVKIzRTJcyb+gI5bm0RJJumBiLMlIZKwrBs/dJ39Xnu39aS2rJaU4nsEBV+k+oikQZkZw3Mz4hw==
X-Received: by 2002:a50:b122:: with SMTP id k31-v6mr12034759edd.217.1527846873222;
        Fri, 01 Jun 2018 02:54:33 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x15-v6sm660648edd.90.2018.06.01.02.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 02:54:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 8/9] checkout: add advice for ambiguous "checkout <branch>"
References: <20180531195252.29173-1-avarab@gmail.com>
        <87a7sg9sjz.fsf@evledraar.gmail.com>
        <20180531195252.29173-9-avarab@gmail.com>
        <xmqqin7386tv.fsf@gitster-ct.c.googlers.com>
        <xmqqefhr850j.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqefhr850j.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 01 Jun 2018 11:54:31 +0200
Message-ID: <871sdqal2g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 01 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> @@ -1269,6 +1270,16 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>>>  	if (opts.patch_mode || opts.pathspec.nr) {
>>>  		int ret = checkout_paths(&opts, new_branch_info.name,
>>>  					 &dwim_remotes_matched);
>>> +		if (ret && dwim_remotes_matched > 1 &&
>>> +		    advice_checkout_ambiguous_remote_branch_name)
>>> +			advise(_("The argument '%s' matched more than one remote tracking branch.\n"
>>> +				 "We found %d remotes with a reference that matched. So we fell back\n"
>>> +				 "on trying to resolve the argument as a path, but failed there too!\n"
>>> +				 "\n"
>>> +				 "Perhaps you meant fully qualify the branch name? E.g. origin/<name>\n"
>>> +				 "instead of <name>?"),
>>> +			       argv[0],
>>> +			       dwim_remotes_matched);
>>>  		return ret;
>>
>> Do we give "checkout -p no-such-file" the above wall of text?
>>
>> Somehow checkout_paths(), which is "we were given a tree-ish and
>> pathspec and told to grab the matching paths out of it and stuff
>> them to the index and the working tree", is a wrong place to be
>> doing the "oh, what the caller thought was pathspec may turn out to
>> be a rev, so check that too for such a confused caller".  Shouldn't
>> the caller be doing all that (which would mean we wan't need to pass
>> "remotes-matched" to the function, as the helper has nothing to do
>> with deciding which arg is the tree-ish).
>
> Well, upon closer inspection adding *dwim_remotes_matched parameter
> to checkout_paths() done in an earlier step seems to be totally
> bogus and only serves the purpose of confusing reviewers.  The
> function does not touch the pointer in any way---it does not use the
> pointer to return its findings, and it does not use an earlier
> findings to affect its behaviour by dereferencing it.

Yes, sorry. I'll fix that. This was a relic from an earlier version of
this that never escaped into the wild where I first tried printing out
this error printing it out near the report_path_error() codepath called
from checkout_paths().

I.e. I was trying to avoid printing out the "error: pathspec 'master'
did not match any file(s) known to git." error altogether. That's still
arguably a good direction, since we *know* "master" would have otherwise
matched a remote branch, so that's probably a more informative message
than falling back to checking out pathspecs and failing, and complaining
about there being no such pathspec.

But it was a pain to handle the various edge cases, e.g.:

    $ ./git --exec-path=$PWD checkout x y z
    error: pathspec 'x' did not match any file(s) known to git.
    error: pathspec 'y' did not match any file(s) known to git.
    error: pathspec 'z' did not match any file(s) known to git.

So I decided just to let checkout_paths() to its thing and then print
out an error about dwim branches if applicable if it failed.

> The dwim_remotes_matched is set by an earlier call to
> parse_branchname_arg(), which does gain an int* parameter in this
> series.  And that addition _does_ make sense.  That codepath is
> where the "do we have many remotes that could match, or none, or
> unique?" determination is made.

*nod*
