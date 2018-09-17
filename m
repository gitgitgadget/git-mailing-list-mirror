Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58F41F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeIRCsf (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 22:48:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34309 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeIRCsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 22:48:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so8015946plo.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z9bxtJ2fYqawlnSm9+p+MLllcERl9QB0VzLxagIgwzw=;
        b=OZJ/MZ/tKniRpNQWiyvCJL82GEGZ5TyV7XFzQgaLat0875eIWvrd0SXttTBwtuKF+v
         CvVGUUl9HKK403nT/h0IAOGGxo3pwtFTRMTPxyRTyNjrXg3wQpCTNboC+QC+74zRKgsP
         woX/uSC51UUHZJCbuZVjZMhmG9knuZz2jEX6zApFYT3Yr7noHgReTdF05pNxlNOsSm1R
         WtMVi2nkKvjoAZcwvytjDr8+3PUHARl1mrcjrVWFWWDkcLw4+C1Pz8Z0pk2waTvmVvUA
         Bocr9UpiZtP7xirutwnu6eo8aqqUdZ01v2Ym5OWM7LEHmpU9NwkOZ+5RaigqiAy+kqsF
         MiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z9bxtJ2fYqawlnSm9+p+MLllcERl9QB0VzLxagIgwzw=;
        b=NoJbmDvDXBtTg9wovqSQkrvWKLt9w/TIJSVuWKSX1IPRimy6XimpMEyRiLsBLCOHFH
         DtKfe4JvXfEp1P7JCrpNB8KTb/wULr0MZXJDC2BacVFtjX/74mdUXIwLDMEh14iirGRC
         acTrreYVaydlVKIW2HE0DywPrw+twHWvPX1QWcBKO68LxWuwDxlbOqXtNnGXqnLHaePJ
         pXl8D4nr1P5Z/OeSbL7/MMNbVbNkBSb9HRHUeJ4vXqHWA1khpXwuVMIxkjwBqO3FJS69
         tPRijyai7zZ5EDXTXEsv1cG5K/ytmCCbwwnzrlGA8mnsStYmM9LbXME580h7DLuK7L+N
         Ji/A==
X-Gm-Message-State: APzg51BoRPykcoAQRA7ogxUwz93pZPQ+Vk0kShT5hX3EPg0suatdJJYo
        PgT+vxchyEt+8i39VaQOL5fDElVM
X-Google-Smtp-Source: ANB0VdaGeGzwi95vICoHzb7HO5wPRCkIl6XUT988wbzEFjkORNFptDCXGOaVBawWuGD8CLsp6fq42Q==
X-Received: by 2002:a17:902:468:: with SMTP id 95-v6mr25702358ple.122.1537219169229;
        Mon, 17 Sep 2018 14:19:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f87-v6sm41123070pfh.168.2018.09.17.14.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 14:19:28 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:19:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5551: compare sorted cookies files
Message-ID: <20180917211926.GI140909@aiede.svl.corp.google.com>
References: <20180917191806.19958-1-t.gummerer@gmail.com>
 <xmqqtvmn6gra.fsf@gitster-ct.c.googlers.com>
 <20180917211026.GA4095@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917211026.GA4095@hank.intra.tgummerer.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer wrote:
> On 09/17, Junio C Hamano wrote:

>>                                                         The other
>> effort implicitly depends on the expected output is kept sorted, but
>> this one is more explicit---I tend to prefer this approach as tools
>> and automation is easier to maintain than having to remember that
>> the source must be sorted.
>
> I'm happy going with either patch, but if we want to go with mine, I'd
> like to make sure Todd is credited appropriately, as he sent a very
> similar patch first.  Not sure what the appropriate way here is
> though?

Thanks for asking.  Credit is a subject that is dear to my heart.

You can for example use
Reported-by: Todd Zullinger <tmz@pobox.com>

to credit him for the patch and analysis that appears to have helped
with reviews (and to signal that this fixes the bug he reported).

[...]
>>> --- a/t/t5551-http-fetch-smart.sh
>>> +++ b/t/t5551-http-fetch-smart.sh
>>> @@ -206,7 +206,7 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
>>>  cat >cookies.txt <<EOF
>>>  127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
>>>  EOF
>>> -cat >expect_cookies.txt <<EOF
>>> +cat <<EOF | sort >expect_cookies.txt

Should this be

	sort >expect_cookies.txt <<\EOF

?  That is simpler since it avoids a pipe and means the reader doesn't
have to look out for shell metacharacters like $ inside the text.

Bonus points if this kind of setup moves to inside the test (using
<<-\EOF), which can make the test script easier to read.

Thanks and hope that helps,
Jonathan
