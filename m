Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350E5207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 12:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1038855AbdDUM0E (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 08:26:04 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36766 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1038167AbdDUM0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 08:26:03 -0400
Received: by mail-oi0-f42.google.com with SMTP id s131so6222239oia.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3idy4oBYzwRXrc23yLhLJXT59YQ60Utj/Dplj9EiUlQ=;
        b=OeNGA8adXfU9shyQcZP+0airEZkwQnxAmV5kYc2tIHnJ2Ttglbg7AtMaTKBKKtPkhm
         6rJSJboG+xqNE/WTjpVC8kVk5nrLhcm3uu7PQNb+vq4EhGJH+L26ga6/RZrChlSy9iJm
         trm2OuATWqNv/aGJKNaKRRshl830cGTWiFqErR3dIXxe2mDN1AbllECdRL8JvwmmLK+d
         XPZP2SCddL++mH9th23kvBOxAUpzZnbfjzoqODPg2MpynVaCAsX54BSh+ynsQmi8s6QY
         2ViOUeZ/oi7DsMQUqMsYO7PDsdb/NjGSf1OfJqGfgnieksGzlonsYy44/hmGitfiCDlg
         yUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3idy4oBYzwRXrc23yLhLJXT59YQ60Utj/Dplj9EiUlQ=;
        b=iLPsJSw7Nd2JyLExIX2Y63VF6W445ZOzLMYH8Df6CUv6NUWzt+m8TWZvuzmW4NlzcV
         mDwNOKiTlffmv8vlC81M5Cq81SeK3eJbfTRuu4hI22LLUh/KnQzWn+QyRjiWMagM0aa1
         iZ4hTv7vRatO4S0sz0i3gFIXf0UGIP2DDAzD+sDnnr8d4b6ZLvuKHjVX2jylqA201xYr
         CqPTyYTr6izGY/27gK0b3iapvyRt3PYavFLJjcDhcDbhJLfEGYSBEtc1vdFj41xTbWel
         NDFnFEvZEPsDFlS/pxkU5P4VUXj7fczRB6BRUwy2fNPAYFWvGWYp4P1KZOWo/Wfcu/qs
         AsXA==
X-Gm-Message-State: AN3rC/6MlDFiRLh2n0PbTM5pNuI9lVIjmyedtd5DtKP5YYf0xKlSx3hh
        nYtyv13Zcz42Yrqoch6Eh2DxTNDSlA==
X-Received: by 10.157.46.246 with SMTP id w109mr8008316ota.225.1492777552285;
 Fri, 21 Apr 2017 05:25:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 21 Apr 2017 05:25:21 -0700 (PDT)
In-Reply-To: <CAP8UFD3MJYR6pH2=7pKjBdLY6oUswNdG7eDNp6PdCFz336Y2FQ@mail.gmail.com>
References: <20170420205214.GB4989@hank> <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank> <CAP8UFD25tJgQD=bREOG-_q0jCLw-nxhO6pYbOaaYMuAH4VxN3Q@mail.gmail.com>
 <CACsJy8DotVErJjbUBmt9bxu90CSKEsqAT_nYTNXwstEk3YhN2g@mail.gmail.com>
 <CAP8UFD2v-X3KfsvFSQrFvgTWRB7P684qN=DowNK2GunJys1i=Q@mail.gmail.com> <CAP8UFD3MJYR6pH2=7pKjBdLY6oUswNdG7eDNp6PdCFz336Y2FQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Apr 2017 19:25:21 +0700
Message-ID: <CACsJy8ATvRgOZPpy9_SznvFXm5imJNbcqMSAYSw4H633rqRjEw@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 6:57 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Apr 21, 2017 at 1:46 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Fri, Apr 21, 2017 at 11:53 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Fri, Apr 21, 2017 at 2:10 PM, Christian Couder
>>> <christian.couder@gmail.com> wrote:
>>>> On Thu, Apr 20, 2017 at 11:24 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>>>> On 04/20, Christian Couder wrote:
>>>>>>
>>>>>> Could you try with the following patch:
>>>>>>
>>>>>> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/
>>>>>
>>>>> Yeah, I tried with and without that patch with the same result.
>>>>> Unless I'm screwing something up when testing I don't think this fixes
>>>>> the issue unfortunately.
>>>>
>>>> Ok, I will take a look soon.
>>>>
>>>> By the way I think that GIT_TEST_SPLIT_INDEX has become redundant now
>>>> that there is core.splitIndex.
>>>> So perhaps in the long run it will be best to deprecate
>>>> GIT_TEST_SPLIT_INDEX and eventually remove it.
>>>
>>> I think you can't, at least the way I understand this variable. It's a
>>> _test_ variable to force exercise split index code path a whole lot
>>> more, by running the entire test suite with split index always
>>> enabled, instead of just a couple in  t????-split-index.sh. We can't
>>> achieve the same with core.splitIndex because that's more about user
>>> control and you can't just set core.splitIndex for the entire test
>>> suite (can we?).
>>
>> Yeah, you are right.
>> It looks like we have GIT_TEST_OPTS to pass options like --debug,
>> --valgrind, --verbose, but we don't have an environment variable to
>> set config options.
>
> Or maybe GIT_CONFIG_PARAMETERS works for this purpose?

It has to be set inside test-lib.sh, not from outside because
environment variables from outside are filtered if I remember
correctly and only a few specials plus those GIT_TEST_ can survive.
Some tests override GIT_CONFIG_PARAMETERS themselves to pass config
vars to certain command (I know because I just did a couple days ago
;).which loses core.splitIndex.
-- 
Duy
