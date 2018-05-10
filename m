Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7361F406
	for <e@80x24.org>; Thu, 10 May 2018 23:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeEJXck (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 19:32:40 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:43637 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEJXci (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 19:32:38 -0400
Received: by mail-pf0-f172.google.com with SMTP id j20-v6so1791081pff.10
        for <git@vger.kernel.org>; Thu, 10 May 2018 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PQwGpZehaO4BfOEmFWOmpEmfHortrquPOZpScN+txB4=;
        b=MWa149TLEfRNjWqcoDCGOmsMLsQ1pceDCOu7hwYGdyPi0HlzXiTeMkNVDZPFGIDrDQ
         BPWnPMyBW0L9ZReNqJ3RWpbxHetAwgytB5PMYTf/0xh1skvSv/EqwzuJboNdpUO7Zgbk
         06zBzvBj/bOTci1zhFFEMYDaWFF5Ovqg5gsJoMWujaZSjbSZ926WkbKeTWFCC7cS+XLM
         uB9f4WsJWmkQKO/R8tkx8YMnZEwpTwEPpeYKAocQxrxHOmpLfJjPfkkOo/0txBnEKOYa
         mH4JN/T/YnCUb4MXdY1xXFV6VPJOY2jXzJEDeanZc3iZHpH73z5p/v68iS3OtaNfvZvX
         irDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PQwGpZehaO4BfOEmFWOmpEmfHortrquPOZpScN+txB4=;
        b=sC6DjBbP2fUw38EZs1Vt9vZ70+fYs0zT67+o9VJ6OvdHxnSTV2hBPGNZUcNwliErb2
         9RDMY6rNP87PpNI3TyGpDCKC+qmHeiXtFpycIBwCNAaL/eYKEKDScojSzz79Qb+v+2qI
         QVz5s1KoiXxojwRHXAyHLaBswg241I2ueE7Kc6Rb2gYbllRKEo1sbSg2wvxEG0gvf1N+
         qYyz0RP0Lb1N3fZyUpb/rXGJMkYxI+Z92WTIqqsEyXfYG6OVq5d21TdRfVCFMA/1rNiu
         FiYr1iiXUAC8+fJdYbGndXs+LDCUj73qTjzsziauGo08mMZbLD04qawe4B3vitNyFJRl
         h/Gg==
X-Gm-Message-State: ALKqPwePE9mRY2+QPSOJE+4DloS5ZbguZsoam10U9kzpMOQonRCSDd4o
        IJ053jmbQCeWstlkVk/cb+o=
X-Google-Smtp-Source: AB8JxZquo80PwsInpEN6zXbUd7esGHKG8ETt/bbtoa6yuy5KIsX3U2Jw4ZCwL9I/EIlLqV26BjiHDg==
X-Received: by 2002:a62:ac14:: with SMTP id v20-v6mr3192911pfe.101.1525995157236;
        Thu, 10 May 2018 16:32:37 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a10-v6sm3140139pfo.55.2018.05.10.16.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 16:32:36 -0700 (PDT)
Date:   Thu, 10 May 2018 16:32:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     jens persson <jens@persson.cx>, git <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Ken Cunningham <ken.cunningham.webuse@gmail.com>
Subject: Re: [PATCH] sha1dc: fix for compiling on AIX using IBM XLC compiler
Message-ID: <20180510233226.GA125677@aiede.svl.corp.google.com>
References: <CAEoyyNJPZXUKi3W=Gs=3v8i4YnTL47G9oaHDoV5pvCLx78jUVQ@mail.gmail.com>
 <87603xxc3k.fsf@evledraar.gmail.com>
 <20180509183008.GL10348@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180509183008.GL10348@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing Marc Stevens for real this time. Sorry for the noise)
Ævar Arnfjörð Bjarmason wrote:
> On Wed, May 09 2018, jens persson wrote:

>> Hello, first patch. I'm having trouble compiling on AIX using IBMs
>> compiler, leading to
>> unusable binaries. The following patch solved the problem for 2.17.0.
>> The patch below is cut&pasted via gmail to allow for firewalls, but
>> exists in an unmolested form on github:
>> https://github.com/MrShark/git/commit/44bfcaca6637e24548ec06f46fb6035a846b14af
>>
>> Best regards
>> /jp

Thanks for the patch.

>> Building on AIX using XLC every checkout gives an error:
>> fatal: pack is corrupted (SHA1 mismatch)
>> fatal: index-pack failed
>>
>> Back tracking it was introduced in 2.13.2, most likely in [1]
>>
>> Add a #ifdef guard based on macros defined at [2] and [3].
>>
>> Should perhaps __xlc__ should should be changed to or combined with _AIX
>> based on the behavour of GCC on AIX or XL C on Linux.
>>
>> 1. https://github.com/git/git/commit/6b851e536b05e0c8c61f77b9e4c3e7cedea39ff8
>> 2. https://www.ibm.com/support/knowledgecenter/SSGH2K_13.1.3/com.ibm.xlc1313.aix.doc/compiler_ref/macros_platform.html
>> 3. https://www.ibm.com/support/knowledgecenter/SSGH2K_13.1.3/com.ibm.xlc1313.aix.doc/compiler_ref/xlmacros.html
>>
>> Signed-off-by: jens persson <jens@persson.cx>
>> ---
>>  sha1dc/sha1.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>> index 25eded139..68a8a0180 100644
>> --- a/sha1dc/sha1.c
>> +++ b/sha1dc/sha1.c
>> @@ -84,7 +84,7 @@
>>  /* Not under GCC-alike or glibc or *BSD or newlib */
>>  #elif (defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
>>         defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
>> -       defined(__sparc))
>> +       defined(__sparc) || (defined(__powerpc) && defined(__xlc__)))

I wonder if there's a simpler way to detect this.

__powerpc seems orthogonal to the goal, since there are little-endian
powerpc machines.

It appears that XLC defines _BIG_ENDIAN on big-endian machines.  I
wonder if we should do

 #elif defined(_BYTE_ORDER) && defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN)
  ... as today ...
 #elif !defined(_BYTE_ORDER) && defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
 # define SHA1DC_BIGENDIAN
 #elif !defined(_BYTE_ORDER) && !defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN)
  /* little endian. */
 #else
  ...

It also seems to me that Git should enable the #error in the
fallthrough case.  The test suite would catch this kind of problem but
it does not seem that everyone runs the test suite, so a compiler
error is more robust.  Is there a #define we can set to enable that?

>>  /*
>>   * Should define Big Endian for a whitelist of known processors. See
>>   * https://sourceforge.net/p/predef/wiki/Endianness/ and
>
> This patch looks sane to me, but we don't manage this software but
> instead try to pull it as-is from upstream at
> https://github.com/cr-marcstevens/sha1collisiondetection
>
> Which we could apply this, it would be much better if you could submit a
> pull request with this to upstream, and then we can update our copy as I
> did in e.g. 9936c1b52a ("sha1dc: update from upstream", 2017-07-01).

Thanks,
Jonathan
