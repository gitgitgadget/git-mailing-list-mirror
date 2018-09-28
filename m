Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EFA41F453
	for <e@80x24.org>; Fri, 28 Sep 2018 07:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeI1ODQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 10:03:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44708 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeI1ODQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 10:03:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id g24-v6so4219750lfb.11
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 00:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SpDUaHlhJbhhC3NXqf4/7rrKmpIRuDRnYl0kOp7shwc=;
        b=Eb8c98GcxX9koopJ3kDovofnrtZXUGvcGTQZPdFoIjT/l3swOv+l6XoqOVUukSoKwG
         HWN3ibcr2jRcFmtPyYOsMYkDxN0mhe+DSc/OdkoyUWSuGBl1mEKdzbuJGNdRI53K6hG2
         YK0PJF9XNd9qJ2MH9KOWB+4gRa+XkJL+12PaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SpDUaHlhJbhhC3NXqf4/7rrKmpIRuDRnYl0kOp7shwc=;
        b=sJner3f49le3hCYGASCipgc6ZCH/sOZTIT24GNE0Ha2/A1m3ggURBh1bntyCGjKtQS
         rZSwPAbgx9Na8htjMERSFKETQrcjZQnjVsooqz4o+QBV29UIo+zjlcLWPWJc710c/eau
         xnvwom0idDB9xIvqEPD6c9M9fab3MW2TDihyRIVPDf0eUsQABo8/nyps4yv944xt/gRT
         fuPE94HaeB2wTV10IGNGhfPV3Uuukx1WFohO2+COq4yV5Dm1i6CvVoTZD49NOKc6jql6
         ecNidRDXvKIml0oTiSnAPi2i3pJg/RnE/Xp/HUAibnHaC96CDHSb7QmrJLaNokPNeNBb
         amaQ==
X-Gm-Message-State: ABuFfojmDyLxuh475qUf+IX7fmt4Q0W6573T0c7387ltAFnsVYWtDuDo
        T1MIufZJpAGqv4IwnBlef3UjkH+Lx2oltejL
X-Google-Smtp-Source: ACcGV632wM3ROElHeucW8QQxMha6TmqfY5HkVLygC4b7YavSTmrReIALg1XlcPdAP4nrc0Jqb3AMAQ==
X-Received: by 2002:a19:910c:: with SMTP id t12-v6mr7439196lfd.98.1538120447992;
        Fri, 28 Sep 2018 00:40:47 -0700 (PDT)
Received: from [192.168.43.23] (77.241.135.131.mobile.3.dk. [77.241.135.131])
        by smtp.gmail.com with ESMTPSA id n16-v6sm867059lji.28.2018.09.28.00.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 00:40:47 -0700 (PDT)
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <fb221514-4749-affa-c657-0e36dd28fb13@rasmusvillemoes.dk>
Date:   Fri, 28 Sep 2018 09:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-26 17:16, Junio C Hamano wrote:
> Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:
> 
>> +		/*
>> +		 * We use split_cmdline() to get the first word of the
>> +		 * alias, to ensure that we use the same rules as when
>> +		 * the alias is actually used. split_cmdline()
>> +		 * modifies alias in-place.
>> +		 */
>> +		count = split_cmdline(alias, &argv);
>> +		if (count < 0)
>> +			die("Bad alias.%s string: %s", cmd,
>> +			    split_cmdline_strerror(count));
>> +
>> +		if (follow_alias > 0) {
>> +			fprintf_ln(stderr,
>> +				   _("Continuing to help for %s in %0.1f seconds."),
>> +				   alias, follow_alias/10.0);
>> +			sleep_millisec(follow_alias * 100);
>> +		}
>> +		return alias;
> 
> If you have "[alias] cp = cherry-pick -n", split_cmdline discards
> "-n" and the follow-alias prompt does not even tell you that it did
> so,

That's not really true, as I deliberately did the split_cmdline after
printing the "is an alias for", but before "continuing to help for", so
this would precisely tell you

  cp is an alias for 'cherry-pick -n'
  continuing to help for 'cherry-pick' in 1.5 seconds

> and you get "git help cherry-pick".  This code somehow expects
> you to know to jump to the section that describes the "--no-commit"
> option.  I do not think that is a reasonable expectation.

No, in that case I would not expect git cp --help to jump to that
section anymore than I would expect "git cherry-pick -n --help" to
magically do that (and that would be impossible in general, if more
options are bundled in the alias).

> When you have "[alias] cp = cherry-pick -n", "git cp --help" should
> not do "git help cherry-pick".  Only a single word that exactly
> matches a git command should get this treatment.

I considered that, and could certainly live with that. But it seems the
discussion took a different turn in another part of the thread, so I'll
continue there.

Rasmus
