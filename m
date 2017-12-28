Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C069C1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 14:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbdL1OH6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 09:07:58 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:38227 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdL1OH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 09:07:57 -0500
Received: by mail-wr0-f171.google.com with SMTP id o2so39298023wro.5
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 06:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bxfKg9m1eUiaQsOZpCwHGlijw5Ael0x3NmIbRlfjpig=;
        b=gP+QtpDk6OaZCe/mlbS9Lcvth6Kzvyl+0p0VkzIVve3W6XpWFB3Eb+lNAcj/JGAGdy
         chHWA7vHrG9xtgDEALJxAg/m3lTMPSbz4N74BWjqq62i8A36X+9xGX1IRqOtLYLbMmZY
         1/XZP0vksauswTO52WMmW0egvxQPF9wSmnka4KHBMFjT6erKakCDxSX1d6sAFiD+cNF6
         m7te5GvkLuVNGAMh0A8YNouVnWxltEuds3nk13XJRr5ogRrcXJgTGykaU6JgzTjaII6S
         zZbvYDyaIED1odd4bRSC3wHM+OzLVgnJhkGp/P66/z/sPazLgEr5Xokstbon7PaJrrld
         8PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxfKg9m1eUiaQsOZpCwHGlijw5Ael0x3NmIbRlfjpig=;
        b=CN+GHSdsR4/vNsQH7yjWyuhFMkF7W4vyaYcjhS8BN2tpVXxEvGx9F5Y5doHGgPiFZK
         o6dTG+mTHItWCWYoVNTLDQeQn/ujgxS6zj27l2Nyl1OpOaWB5KEQTwz+1N67RQGM/vF3
         4SppoeUq+aI6VctocXVxP2qez5y03n0Dg4STqJqOVLRj3awWU3PMf+fRbkWID0ZsNZSZ
         PYlAZX1ShhpAjFwI7a9/HbN5x26sg/ZtAplG7t4pheWGIU5tyWdCLuebBryxwiGOgxGo
         206ecSeQZd57pxzMIlKTBmvhvIof3k5VFaqI+KvJf4vxtaXVsku5EsOAxZSVSri2FwRJ
         GPAQ==
X-Gm-Message-State: AKGB3mI+ny6oiL/bDIg/IbayZ2AbdVLY5C3dJlasFK5JRovEuaCN3hsM
        74SJISv5SZk6UKD2xkVPnM/GFcNf
X-Google-Smtp-Source: ACJfBov4y6Eu8vRaZqRqtXxtbi/dpiYBbPBy08uEwonN3gOhPzLsnpJai/EPVypnZsdXCJaooqU24Q==
X-Received: by 10.223.171.15 with SMTP id q15mr30354012wrc.112.1514470075340;
        Thu, 28 Dec 2017 06:07:55 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g54sm33797478wrg.43.2017.12.28.06.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 06:07:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] When DC_SHA1 was made the default we missed a spot
Date:   Thu, 28 Dec 2017 14:07:40 +0000
Message-Id: <20171228140742.26735-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171227233912.GB181628@aiede.mtv.corp.google.com>
References: <20171227233912.GB181628@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27 2017, Jonathan Nieder jotted:

Here's v2, the only changes are to the commit messages.

> Ævar Arnfjörð Bjarmason wrote:
>
>> Stop supplying BLK_SHA1=YesPlease when NO_OPENSSL=UnfortunatelyYes is
>> supplied. This has been done ever since [1], when switching to DC_SHA1
>> by default in [2] this should have been changed as well.
>
> I had trouble parsing this, I think for a few reasons:
>
>  1. Too much 'this', so I end up not being able to keep track of what
>     has been done ever since (1) and (2)
>
>  2. The ',' should be a ';'
>
>  3. Can the commit names go inline in the message instead of being
>     footnotes?  That way, my eye doesn't have to chase so far to
>     find what kind of dates you are talking about.
>
>  4. Why should switching to DC_SHA1 by default have resulted in
>     simply dropping the NO_OPENSSL => BLK_SHA1 behavior?  At first
>     glance it would be more intuitive to change it to
>     NO_OPENSSL => DC_SHA1 instead.
>
> Putting those all together, I end up with
>
>  Use the collision detecting SHA-1 implementation by default even
>  when NO_OPENSSL is set.
>
>  Setting NO_OPENSSL=UnfortunatelyYes has implied BLK_SHA1=1 ever since
>  the former was introduced in dd53c7ab29 (Support for NO_OPENSSL,
>  2005-07-29).  That implication should have been removed when the
>  default SHA-1 implementation changed from OpenSSL to DC_SHA1 in
>  e6b07da278 (Makefile: make DC_SHA1 the default, 2017-03-17).  Finish
>  what that commit started by removing the BLK_SHA1 fallback setting so
>  the default DC_SHA1 implementation can be used.

Thanks. I've used that as-is, and also changed 2/2 to inline the
comment references.

> What happens if I set both OPENSSL_SHA1 and NO_OPENSSL?  Should this
> block set
>
> 	OPENSSL_SHA1 =
>
> so that the latter wins, or should we detect it as an error?

We fail at link-time if you supply both, but that's something that
happens alredy in master.

It's probably not worth the effort to add an $(error ...) for that to
the Makefile (I've added some of these already) since the error should
be fairly obvious, as opposed to some of the subtle "that doesn't work
like that anymore" errorors I've added recently for other topics.

> [...]
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -23,7 +23,6 @@ all::
>>  # it at all).
>>  #
>>  # Define NO_OPENSSL environment variable if you do not have OpenSSL.
>> -# This also implies BLK_SHA1.
>>  #
>>  # Define USE_LIBPCRE if you have and want to use libpcre. Various
>>  # commands such as log and grep offer runtime options to use
>> @@ -1260,7 +1259,6 @@ ifndef NO_OPENSSL
>>  	endif
>>  else
>>  	BASIC_CFLAGS += -DNO_OPENSSL
>> -	BLK_SHA1 = 1
>>  	OPENSSL_LIBSSL =
>>  endif
>>  ifdef NO_OPENSSL
>> diff --git a/configure.ac b/configure.ac
>> index 2f55237e65..7f8415140f 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -241,7 +241,6 @@ AC_MSG_NOTICE([CHECKS for site configuration])
>>  # a bundled SHA1 routine optimized for PowerPC.
>>  #
>>  # Define NO_OPENSSL environment variable if you do not have OpenSSL.
>> -# This also implies BLK_SHA1.
>
> With or without some of those commit message tweaks
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks!

Ævar Arnfjörð Bjarmason (2):
  Makefile: NO_OPENSSL=1 should no longer imply BLK_SHA1=1
  Windows: stop supplying BLK_SHA1=YesPlease by default

 Makefile         | 2 --
 config.mak.uname | 1 -
 configure.ac     | 1 -
 3 files changed, 4 deletions(-)

-- 
2.15.1.424.g9478a66081

