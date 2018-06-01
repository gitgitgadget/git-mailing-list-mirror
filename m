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
	by dcvr.yhbt.net (Postfix) with ESMTP id A93071F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 09:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeFAJuW (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 05:50:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55711 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeFAJuS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 05:50:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id a8-v6so1837468wmg.5
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=G81tBXjIikjmUBrUp0pZYrq2ZiEnocrFk+L+sBf1KFA=;
        b=AhqKOkZTu9w2OQLBxMDqll6eV0XO8lrMEYURAb4RTI9RGqqnR4XQmiL/oAwnXsiR3y
         BbHQZNRGhiLuBNXicui2EHFCXxgDmqzflXLBGsrGjwzWolf81aaETP4MCdfuLoRDYx/z
         HSnyY0XdBUEHwEvBp1a0/AuNSRtgOnDZ1QRXv+ADtiJA5/8OQX738CLVg9D3BW4MRWuW
         4jfSTFCZyCSqE9iAmd6vD8Z2ypsw0rauTSAOaO+gxo6Z4eyNuBZTRbGvnS5WvUTiV0pJ
         C1IaUz6Klafk1j4UGkEMtlEQ6iPzQ1pTHL3WWXt6qCWk1xVAQmUYonb4w9rcvL4fe485
         V8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=G81tBXjIikjmUBrUp0pZYrq2ZiEnocrFk+L+sBf1KFA=;
        b=QQuvE+oZxSvORoFXnbHrrzavAFRz/b2SKKppeNNGDI8wqRc4DmJzNp4xK/+yKBfVqG
         brU9ZH84b/qdzfwKh8lfNfoz/TBCV+K+r+HgADpEcCPRdAOh8LcYdL8K1PGrFdaav1SE
         4TqGsbslBuQNDHS1WnrHIDQSUR7khzJvdGcyqvy7R1My+C7FJ8vXr57xb8Dmsp3cyee6
         r8uOxfUETc2xE/GvyyDBbCOI9Rnn5Yj2LrKOyoaOmMbEg+5ZZKTLGtABHMV6ELzsA9xF
         bfoI70QLMu0MCv099O/9KPunTKqvLRjfK+P47ALMLYLxL00exDuxjDMNSUIRi8GPvkl7
         HdmQ==
X-Gm-Message-State: ALKqPwfUfRF/33WDm1FhsWN9fUuPzklZZ1W/Jwva2bQjCuxY97RJfyLl
        LmY9lGSBAqZa2IWYG7xLF44=
X-Google-Smtp-Source: ADUXVKInenNckKfTy1P4s4DU1ak4f26qSMZ4dr+pGO7Wt70P8bEKC6u0YoQRTIMsESXu3zJW+zQC1A==
X-Received: by 2002:a50:a0e6:: with SMTP id 93-v6mr11917664edo.49.1527846616327;
        Fri, 01 Jun 2018 02:50:16 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x2-v6sm388528edr.24.2018.06.01.02.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 02:50:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 8/9] checkout: add advice for ambiguous "checkout <branch>"
References: <20180531195252.29173-1-avarab@gmail.com> <87a7sg9sjz.fsf@evledraar.gmail.com> <20180531195252.29173-9-avarab@gmail.com> <xmqqin7386tv.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqin7386tv.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 01 Jun 2018 11:50:14 +0200
Message-ID: <8736y6al9l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 01 2018, Junio C Hamano wrote:

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

No:

    $ ./git --exec-path=$PWD checkout -p master
    No changes.
    $ ./git --exec-path=$PWD checkout master
    error: pathspec 'master' did not match any file(s) known to git.
    hint: The argument 'master' matched more than one remote tracking branch.
    [...]

> Somehow checkout_paths(), which is "we were given a tree-ish and
> pathspec and told to grab the matching paths out of it and stuff
> them to the index and the working tree", is a wrong place to be
> doing the "oh, what the caller thought was pathspec may turn out to
> be a rev, so check that too for such a confused caller".  Shouldn't
> the caller be doing all that (which would mean we wan't need to pass
> "remotes-matched" to the function, as the helper has nothing to do
> with deciding which arg is the tree-ish).

I skimmed the rest of this thread and saw there were more specific
suggestions. I'm open to moving this somewhere else. The "what is this
and what do we do" logic in checkout.c is spread over multiple
functions, and this seemed the most straightforward way to add this.
