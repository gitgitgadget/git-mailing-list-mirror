Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717CF1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 05:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbeFAFMA (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 01:12:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52444 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeFAFL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 01:11:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id 18-v6so542761wml.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 22:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iQSbRNXdD++yCHJW6EG/wy3vvrPXMXC2ybsfc3dW8M8=;
        b=pCpeyv1103Ea161Gqk7psHBH5X+MXs9cZTzbxjsqO3svhg52frcWbpdMDc3Ns1HtCg
         pJCSTgWI49VYJtZI6VZWwD34crlC4c76BmEPALZ1afLRGesiC7EzC5g1yWLenDu8NPxJ
         hZoec0mBPi6IIuGDxwjNqJbb/l1zldp8HaVrFylY5jrBQ4tb6g7+czQi+adh5k/W0XLL
         pd7ghz1cGLEM1V6qE1zqMqR+rK01r4gOzfJpeqR0Km9wAVDVYToieQ0cHyPJEVIF2jzZ
         zj3+Ny4R7+B22lsgs/nP9XBmhsKcW7oN3+XnkJXVUQ+9RVv/8bL0jyr4rNG9UREfIbxD
         1ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iQSbRNXdD++yCHJW6EG/wy3vvrPXMXC2ybsfc3dW8M8=;
        b=pEfN/jPqeSs/d03L/OB8E/LYDinsp7QhLbWTJS9Sv30U667NU5bqVH5PH7Flye5xHR
         ghgcw8ODGdLLowdEvdbTWx/LZ8XCWsDr8cOwjU0oXEdMeu2a6n3rjObI1j5pCCTIGrgK
         YR8KG0og4eIXiGd/KS7GrSjH4kNiEBZ7nSuxeUPUh+xJQTy9LoLm367GxP4t/ESn6mDv
         PGDqViaLDw7TkipVY9Tqt6AcZFzVa5pyDjz4A0+NimmVrOHhGyb35knqxYO8/l5YRCAA
         YsxV0mtCcT7ITlm59y+ah0axlqqW7H8hSf0Vp5MO4EXZjiqxpdvIEMCXPEUTY1zVeZiD
         LxnA==
X-Gm-Message-State: APt69E26fRVDmIXjGwV8oQeNrH97R6SghhuPsu4De+E2n4gevJ/16GWn
        mnyXfkDkL92wvOH5n6FI8Rg=
X-Google-Smtp-Source: ADUXVKIu63umrFW5UWRBwQPYaySjRNEU62c+zjRdoPYOcwnhRQHXHXckRhq7nxpig9U8IjOa37NkdA==
X-Received: by 2002:a1c:e5c5:: with SMTP id c188-v6mr1626647wmh.86.1527829917762;
        Thu, 31 May 2018 22:11:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z7-v6sm47601301wrg.56.2018.05.31.22.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 22:11:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
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
Date:   Fri, 01 Jun 2018 14:11:56 +0900
In-Reply-To: <xmqqin7386tv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 01 Jun 2018 13:32:44 +0900")
Message-ID: <xmqqefhr850j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> @@ -1269,6 +1270,16 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>>  	if (opts.patch_mode || opts.pathspec.nr) {
>>  		int ret = checkout_paths(&opts, new_branch_info.name,
>>  					 &dwim_remotes_matched);
>> +		if (ret && dwim_remotes_matched > 1 &&
>> +		    advice_checkout_ambiguous_remote_branch_name)
>> +			advise(_("The argument '%s' matched more than one remote tracking branch.\n"
>> +				 "We found %d remotes with a reference that matched. So we fell back\n"
>> +				 "on trying to resolve the argument as a path, but failed there too!\n"
>> +				 "\n"
>> +				 "Perhaps you meant fully qualify the branch name? E.g. origin/<name>\n"
>> +				 "instead of <name>?"),
>> +			       argv[0],
>> +			       dwim_remotes_matched);
>>  		return ret;
>
> Do we give "checkout -p no-such-file" the above wall of text?
>
> Somehow checkout_paths(), which is "we were given a tree-ish and
> pathspec and told to grab the matching paths out of it and stuff
> them to the index and the working tree", is a wrong place to be
> doing the "oh, what the caller thought was pathspec may turn out to
> be a rev, so check that too for such a confused caller".  Shouldn't
> the caller be doing all that (which would mean we wan't need to pass
> "remotes-matched" to the function, as the helper has nothing to do
> with deciding which arg is the tree-ish).

Well, upon closer inspection adding *dwim_remotes_matched parameter
to checkout_paths() done in an earlier step seems to be totally
bogus and only serves the purpose of confusing reviewers.  The
function does not touch the pointer in any way---it does not use the
pointer to return its findings, and it does not use an earlier
findings to affect its behaviour by dereferencing it.

The dwim_remotes_matched is set by an earlier call to
parse_branchname_arg(), which does gain an int* parameter in this
series.  And that addition _does_ make sense.  That codepath is
where the "do we have many remotes that could match, or none, or
unique?" determination is made.

