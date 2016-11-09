Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411D42021E
	for <e@80x24.org>; Wed,  9 Nov 2016 18:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbcKISIr (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 13:08:47 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36032 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbcKISIq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 13:08:46 -0500
Received: by mail-qk0-f171.google.com with SMTP id n21so155039063qka.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pd2VJSTJ6vkWKwVcJ6XYs1nqm2S8EtQmUIi+dhDcMnA=;
        b=Wf1W7QxDIDJ0po0PQYn40l8ISZ9q5IChC68nU27ZICq+nSaappZjJlhBqtgdNhc9qi
         hynaYL+axCH5BRvovR6TyRWTvWh5vr0jPcu1syfD9ztsZueZbeVMxe7fs2hBu8pGf0lX
         aCMvhhfXuAXYma6cP6AqG4cE11yQWI0piLvurZtKUCooqgaJUmWCHuPN8p2AYOGemttF
         19PoM4sTmQAuKfiGW/G3dFxaDm2rtBp/KD0RXQY2ZXvfGHnfm2A24Byai/BxN9R186d/
         p8o5BQ+92P3y6oD0SFnl5sOLPP+Uy+6Lm1cbr9XgKwfxmkorS7VL9I2iF5Hj7lqVBgmW
         ElOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pd2VJSTJ6vkWKwVcJ6XYs1nqm2S8EtQmUIi+dhDcMnA=;
        b=av4DeeimaNkUGZ7tYR46ge5+Mtn+1GVSoWXf2Czwvoth1fOaxG+GSMTlBl3u0DVohu
         bTH7eAXq3dCfseB+enljsvbmQQ4GVkyunP4zC43XocJnAkZ9xbSg8gWegGDhfQbbADZO
         iprVF5G8nb23yfq1+mp2ZPkPvp6yylrx6/2gTKETBCEt+WJUV1sb1owOW2I/ZVTUxQdD
         EIRzseOEBc8C2Rz4VL+1w/1yJ0YtzPnvem438x5CZ9r22MpbemD6aBIjlgW6diEAMQgk
         jsW9vYeRdGHliMXw8s9IjU0VyHmZKbvj/zJrbbB4SuBF4dM+VPC7N7rs74VVr77dYqtq
         8pSw==
X-Gm-Message-State: ABUngveBCGf9iRsHUzB8kqt7/1F7gmsEOVoDujQPyqAqT5vUmdUbnDMo3EQLLjk/mWSjsjymJ6T6fK/YZat4m3ln
X-Received: by 10.55.186.3 with SMTP id k3mr1114644qkf.47.1478714925519; Wed,
 09 Nov 2016 10:08:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Wed, 9 Nov 2016 10:08:45 -0800 (PST)
In-Reply-To: <CACsJy8C2MLg4ncLBXXJGf+=mPF_rRoKs2vN6=+chZeNeXWZsbg@mail.gmail.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-33-sbeller@google.com>
 <xmqqzilp63yh.fsf@gitster.mtv.corp.google.com> <CACsJy8C2MLg4ncLBXXJGf+=mPF_rRoKs2vN6=+chZeNeXWZsbg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Nov 2016 10:08:45 -0800
Message-ID: <CAGZ79kZ=9QeZLKKrH27U2iE9x3WxgVe4RvCZpbdzZriMArV6Sg@mail.gmail.com>
Subject: Re: [PATCH 32/36] pathspec: allow querying for attributes
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 1:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Oct 28, 2016 at 1:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The reason why I am bringing this up in this discussion thread on
>> this patch is because I wonder if we would benefit by a similar
>> "let's not do too involved things and be cheap by erring on the safe
>> and lazy side" strategy in the call to ce_path_match() call made in
>> this function to avoid making calls to the attr subsystem.
>>
>> In other words, would it help the system by either simplifying the
>> processing done or reducing the cycle spent in preload_thread() if
>> we could tell ce_path_match() "A pathspec we are checking may
>> require not just the pattern to match but also attributes given to
>> the path to satisfy the criteria, but for the purpose of preloading,
>> pretend that the attribute satisfies the match criteria" (or
>> "pretend that it does not match"), thereby not having to make any
>> call into the attribute subsystem at all from this codepath?
>>
>> The strategy this round takes to make it unnecessary to punt
>> preloading (i.e. dropping "pathspec: disable preload-index when
>> attribute pathspec magic is in use" patch the old series had) is to
>> make the attribute subsystem thread-safe.  But that thread-safety in
>> the initial round is based on a single Big Attribute Lock, so it may
>> turn out that the end result performs better for this codepath if we
>> did not to make any call into the attribute subsystem.
>
> It does sound good and I want to say "yes please do this", but is it
> making pathspec api a bit more complex (to express "assume all
> attr-related criteria match")? I guess we can have an api to simply
> filter out attr-related magic (basically set attr_match_nr back to
> zero) then pass a safe (but more relaxing) pathspec to the threaded
> code. That would not add big maintenance burden.
>

So with the current implementation, we already have the shortcut as:

     if (item->attr_match_nr && !match_attrs(name, namelen, item))

i.e. if attr_match_nr is zero, we do not even look at the mutexes and such,
so I am not sure what you intend to say in this email?
