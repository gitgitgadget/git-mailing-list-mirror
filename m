Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A941201A0
	for <e@80x24.org>; Fri, 12 May 2017 01:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757293AbdELBBP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 21:01:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35811 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756954AbdELBBO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 21:01:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so5059410pfd.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 18:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2znKcz/kLqop69XtGGXM3HgAxfEEi9b0tQnyOR3lMDI=;
        b=oicOU84u/6BEO6YBRnxew3LlhSuZW9rR3vjBNEJ7DElcJ4Y6ZNBWEvCoF89lTRRnPM
         GLGfeefBhQB1px8z0l7e8shLaExgH3SiTrADZIfHkwLivdCoaENf3AVv85Z/TLmP2Bih
         Rrdee9N3Hg+jk+FBECAj4eVKmRyZ9AqMBDxjsqyBXWvDkvoufo55S+5w6FWTbgCuKUke
         BTwW7zE0AxZf+rO6V356RY2v09aZeNbY6bI7umJDS9ADRrI2TEFfuyPMGc9wQCU56Wlt
         ZmN9Yrl6DSa8FNoMtAkFTaddcDrCNdHddC2+dZfu12WZUikFfpo66ANPMr/E32dVsLgA
         98Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2znKcz/kLqop69XtGGXM3HgAxfEEi9b0tQnyOR3lMDI=;
        b=lg5kBQo6/txSqjXHwtmnf+FD4MKvetOtsIXGxMLzLf1yzuhPYbgwljtPcOVxK7gqpE
         ndujxgrNHhRx6etvsc1O+iFlmYfpQ/d+OAADkXOl/Oav2l8uHMZ2qa8gtcA7EqJvm0bF
         Fe1eN2RKWPPDrgVciPKLMyu6rOd+5cFQSqjy1CjV+Oot7iAt4Uwe/jJVpSlTYECEMTux
         8jsdX65Wmih70fVOD47ybX60QhdTN6sA5x3jgn/gd0DGg+EAABoAV0mWK68774vjEaDS
         A9Gpd3hsnCajPYTp4tOy6VH/MngvrSPSgMSJpPa033x/LxHPIimUhYSTr5QEwu6NcR7I
         Jc9w==
X-Gm-Message-State: AODbwcCYaHzAWzF43F+DO9s8jqHt3f7ka6G/CPhOt2MD74ySktEheVHw
        2JhPCtritnMR1A==
X-Received: by 10.99.232.69 with SMTP id a5mr1467962pgk.167.1494550873177;
        Thu, 11 May 2017 18:01:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id o74sm2117183pfa.14.2017.05.11.18.01.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 18:01:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
        <ac2f1563-735e-9a07-e762-5dda0630304e@xiplink.com>
        <20170511233805.mkus2g3nu4ffbh2w@sigill.intra.peff.net>
Date:   Fri, 12 May 2017 10:01:11 +0900
In-Reply-To: <20170511233805.mkus2g3nu4ffbh2w@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 11 May 2017 19:38:05 -0400")
Message-ID: <xmqqo9uy99d4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 11, 2017 at 05:31:45PM -0400, Marc Branchaud wrote:
>
>> > * mb/diff-default-to-indent-heuristics (2017-05-09) 4 commits
>> [...]
>> >  Kicked out of next; it seems it is still getting review suggestions?
>> 
>> I believe v4 of this one is ready to cook.
>
> Yeah, I think it's ready, too (and I agree with you on the text for the
> release notes).

Yeah, what is on 'pu' is v4 and I think everybody on the list
discussion was happy with it.  Thanks.
