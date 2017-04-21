Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CEF9207BF
	for <e@80x24.org>; Fri, 21 Apr 2017 11:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037685AbdDUL5R (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 07:57:17 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33132 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037365AbdDUL5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 07:57:16 -0400
Received: by mail-lf0-f41.google.com with SMTP id 88so43658996lfr.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aIsnc+NUzo1dekbd5ficC/9s9ZD/P9++au7FGUh0X9Y=;
        b=dU8dpbviDVIsvvaZWjpOhSc0IirvjuRCPHwSH//QHqGlgZ9J9Yq1eWUv8cULs3rlGH
         K4DwDIA2hGAi/BRl0/pOx/DXoUd17Tu0ZLwxtE1Hob+0EH+ccKsIpn48UM+b3ju0Bc/i
         QmoikWhzqj5LMKBggCPub9EPqgDva00y2+PsCRoER4xLgaB/yAWdvunuc3z/nM8oHu17
         CWDlccrY1UKRJwQAtv3kz94q65FHB2PuC6Yj3b70YMFCP4FCqFtZ/GgSdtr0bLdfv+hx
         n+nDtqKjwBqbeYrQj8V2ndZxJTfJEOPxVEkHOSadTgBsM+EqFEDcIeWO380Xhm9nK5qS
         HNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aIsnc+NUzo1dekbd5ficC/9s9ZD/P9++au7FGUh0X9Y=;
        b=OfhBppLpuf3EjNMKYngHjS3nGYmGns9KVgJtQ1/AB4n/ym6ErbQV+6za4syXcZS0x9
         jEp41DIEq33dECBWLk8tz91yV+Bv1DHeu418oRnGWOH9L9jBk+Wo4bqHFPzmGeU/9TKo
         2Zs6MOINOzLIZ/mUjBEfDDy+tArr49tsdoJGGm4iu6Ryh00emBcEIjVedmkQmZ8suvK3
         RvxqEHbvmkXgYgeFrQneiQbpa1QTp2jtKyHgaIJrmaFJZwnsrfNz3bDaS4vWOALix8wf
         cglZGjwKyDaCpukT8twzfPeX2Ta+cwIKDWVGq5IJX6a6xFgPeitkKbk6Wiano6+vTBd/
         o0Eg==
X-Gm-Message-State: AN3rC/5clGgEaP7EkWOSqbFuLnNaTM0ruHfFle3LkZIL4BxTV52mz7LB
        LxrKKB81AlqNSG2Ws5Z984RuKOoZgQ==
X-Received: by 10.25.93.86 with SMTP id p22mr4037937lfj.24.1492775834487; Fri,
 21 Apr 2017 04:57:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.67.78 with HTTP; Fri, 21 Apr 2017 04:57:14 -0700 (PDT)
In-Reply-To: <CAP8UFD2v-X3KfsvFSQrFvgTWRB7P684qN=DowNK2GunJys1i=Q@mail.gmail.com>
References: <20170420205214.GB4989@hank> <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank> <CAP8UFD25tJgQD=bREOG-_q0jCLw-nxhO6pYbOaaYMuAH4VxN3Q@mail.gmail.com>
 <CACsJy8DotVErJjbUBmt9bxu90CSKEsqAT_nYTNXwstEk3YhN2g@mail.gmail.com> <CAP8UFD2v-X3KfsvFSQrFvgTWRB7P684qN=DowNK2GunJys1i=Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Apr 2017 13:57:14 +0200
Message-ID: <CAP8UFD3MJYR6pH2=7pKjBdLY6oUswNdG7eDNp6PdCFz336Y2FQ@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 1:46 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Apr 21, 2017 at 11:53 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Apr 21, 2017 at 2:10 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> On Thu, Apr 20, 2017 at 11:24 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>>> On 04/20, Christian Couder wrote:
>>>>>
>>>>> Could you try with the following patch:
>>>>>
>>>>> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/
>>>>
>>>> Yeah, I tried with and without that patch with the same result.
>>>> Unless I'm screwing something up when testing I don't think this fixes
>>>> the issue unfortunately.
>>>
>>> Ok, I will take a look soon.
>>>
>>> By the way I think that GIT_TEST_SPLIT_INDEX has become redundant now
>>> that there is core.splitIndex.
>>> So perhaps in the long run it will be best to deprecate
>>> GIT_TEST_SPLIT_INDEX and eventually remove it.
>>
>> I think you can't, at least the way I understand this variable. It's a
>> _test_ variable to force exercise split index code path a whole lot
>> more, by running the entire test suite with split index always
>> enabled, instead of just a couple in  t????-split-index.sh. We can't
>> achieve the same with core.splitIndex because that's more about user
>> control and you can't just set core.splitIndex for the entire test
>> suite (can we?).
>
> Yeah, you are right.
> It looks like we have GIT_TEST_OPTS to pass options like --debug,
> --valgrind, --verbose, but we don't have an environment variable to
> set config options.

Or maybe GIT_CONFIG_PARAMETERS works for this purpose?
