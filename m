Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEADE1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 17:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeCNRbl (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 13:31:41 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:44290 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeCNRbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 13:31:40 -0400
Received: by mail-wr0-f176.google.com with SMTP id v65so5542839wrc.11
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/4yQIuBvxvzJrL2MfmaAV1HnvXswvOL7UtWJLtK+9ec=;
        b=MTTSS360RWj2aunpxvJTTT7byfiW2elH+7UwQfwWAerA3XLjMjhVtiFPT52gAUAcjt
         AuO8Fl1YU4P4aFtwYMfriiyUXAeiI7eC44WX00dMxRSoEbJiyUlQPg5rGY9WqwnZVZBZ
         WmCfHaa9rhypMV+ycch62fvgPwCF8+TgY5em9jiLrldk4nBozTxe+aW+kAeiCMrEYHTi
         MSLj0N+bQjwz2hXkFiEWVvRh17v9bvKmsGL1zN63xLhchpqhDD0L19aN3Od5+BFmpA4Q
         aA0uss9ZX4DGIOCoKhrbNkNfYEpTHNIJaYP44UTPdD5iFD6wE1zGtUo1NZPtQb+ttpQ5
         o6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/4yQIuBvxvzJrL2MfmaAV1HnvXswvOL7UtWJLtK+9ec=;
        b=fWl8T0CWY25xR3uqOlWu79ozrJnegE+97T319481d/UOfXA4ks+xr8VsCXiA3agc0S
         O6tOTe6mIM57XEiBOIaxz+XziF3PY3fWcGISsGuY3fyvi7ktE2opo8XXBWzmn056BPgD
         Wec3oR6At9EIhMP7EuF+bTMy8AeeeFOdcp//6FcQd689G8zMb+t0Od0BIT0Qg55FT/WN
         Zv5KOAklYb7IRX6J6rBsxi/YS+rF0TciOcsIen+MExDu9RYEN8woYkhFKqCg5AjxeIYK
         Inlxz/J6FT/Z6g2Ca9nBSuQl+NVfypPERDfc24OIQNBFkvDYndN+CKE4wPxK+Eokjwoj
         EHuw==
X-Gm-Message-State: AElRT7HKdHcIx5DF0YoaVXKUsHee7hqpx09u6peuQ2JOLhGj8VIbxST3
        /Rtag8P7upnbDILflJBp3Bo=
X-Google-Smtp-Source: AG47ELtLDdNudupBGo+iFECrpM5oReRLpYrQsHmlUip62t6VmFIgNqfZHlkwJWShk1HJjEvnri0XDQ==
X-Received: by 10.223.138.172 with SMTP id y41mr3769786wry.98.1521048699220;
        Wed, 14 Mar 2018 10:31:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 55sm4106209wrz.6.2018.03.14.10.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 10:31:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/36] object_id part 12
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
Date:   Wed, 14 Mar 2018 10:31:37 -0700
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 12 Mar 2018 02:27:20 +0000")
Message-ID: <xmqqlgeuzhqe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>     -+		buf += the_hash_algo->rawsz;
>     -+		size -= the_hash_algo->rawsz;
>     ++		memcpy(it->oid.hash, (const unsigned char*)buf, rawsz);
>     ++		buf += rawsz;
>     ++		size -= rawsz;
>       	}

Using memcpy() to stuff the hash[] field of oid structure with a
bare byte array of rawsz bytes appears twice as a pattern in these
patches.  I wonder if this is something we want to abstract behind
the API, e.g.

	size_t oidstuff_(struct object_id *oid, const unsigned char *buf)
	{
		size_t rawsz = the_hash_algo->rawsz;
		memcpy(oid->hash, buf, rawsz);
                return rawsz;
	}

It just felt a bit uneven to be using a bare-metal memcpy() when
oidcpy() abstraction releaves the callers from having to be aware of
the rawsz all the time.

