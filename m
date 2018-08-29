Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09DBE1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 19:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeH2XKw (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 19:10:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35174 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2XKw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 19:10:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9-v6so2719676plr.2
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 12:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d8u/4szb67mp2fVJ/ijesZLIxDq88FD3oK7Flb3i070=;
        b=BR+ZkQgEaBJ9AMlqUuLBWGOrS9SloaVcJ6A3POuhFKwE+esfF7ZGGDXZ0MCTHYpMrF
         YTqpZDm9W/g1SatDNdqbcbXkk5D+racpkAzWRu3qjgelH7zPZEyZiOZx6RxlgIshBaxh
         b4fg9u+RDOkJu9iOltDiGqon6+U3jPp5/+xc7qoi41gD7Rro1HgxrNWSWItFYO1DDB6z
         atP6XNfhhTFj87qowf8BbgQtbhh8cdSKkRsgXMDfvy0ODnG2etk3iyTzebY7NMT8O9dP
         9g3WBXP1oEutJzKLLZvf1h/LJAsgzwmXzMDJ/Ur9NvIGsb2V4vvIxbOCoXdqMhulT+zO
         7HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d8u/4szb67mp2fVJ/ijesZLIxDq88FD3oK7Flb3i070=;
        b=UiJsb2GavrhDnKQkxoHSHo+WPAFkHEVilJU7xFDgoupHwcmyYQiIQVJPaMn4q+xClq
         wPKyOwVg/F6uAW2U2/TnkyG2RXpLL7vnIwfTWwONviLLYlRuc75bIXXLS0bstHmDyIyS
         40j3nbFoi8tSQ2si8D7dtGZgFLnUHuNDsYl7SqrH2iIYLkWA3QCmFp2sBnmJA+O8xvOZ
         vnRsCBcyWM7Lw7itpPoRkW6Ud04yaxmhl2QDKIu+qPJYhSmlPTUfGAa0VRVzEXTNR9On
         0I1B29AVii4fG2ZHbPuh0UE52sduR8zAW6bnsZLC8KoNonnfpMgFXu833s8LC3ohv3lT
         tKhg==
X-Gm-Message-State: APzg51BwhVTnDxVgJsXxTCA2P3f2RbDSuT+7oNf/zCvgHJxbuPmYpgF+
        DXtkRZvl0hC+IFSGGbGvPnE=
X-Google-Smtp-Source: ANB0VdZ12IxEhKPEzmZXWSJs5s1StDbwwMmrDTVkJg0+oMAD+9iYaypI9+wemHkh5EO9SyQTHZQHsg==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5-v6mr7175350plk.338.1535569954577;
        Wed, 29 Aug 2018 12:12:34 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b64-v6sm6944231pfg.66.2018.08.29.12.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 12:12:33 -0700 (PDT)
Date:   Wed, 29 Aug 2018 12:12:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: How is the ^{sha256} peel syntax supposed to work?
Message-ID: <20180829191232.GC7547@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <877ek9edsa.fsf@evledraar.gmail.com>
 <CAGZ79kaGb_TL7SiR4CFGFzrfy2Lotioy76o6sUK4=vZK5qwqNA@mail.gmail.com>
 <20180829175950.GB7547@aiede.svl.corp.google.com>
 <87zhx5c8wo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhx5c8wo.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:
> On Wed, Aug 29 2018, Jonathan Nieder wrote:

>> what objects would you expect the following to refer to?
>>
>>   abcdabcd^{sha1}
>>   abcdabcd^{sha256}
>>   ef01ef01^{sha1}
>>   ef01ef01^{sha256}
>
> I still can't really make any sense of why anyone would even want #2 as
> described above, but for this third case I think we should do this:
>
>     abcdabcd^{sha1}   = abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd
>     abcdabcd^{sha256} = ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
>     ef01ef01^{sha1}   = ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
>     ef01ef01^{sha256} = abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd...
>
> I.e. a really useful thing about this peel syntax is that it's
> forgiving, and will try to optimistically look up what you want.

Sorry, I'm still not understanding.

I am not attached to any particular syntax, but what I really want is
the following:

	Someone who only uses SHA-256 sent me the commit id
	abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd... out of band.
	Show me that commit.

	I don't care what object id you show me when you show that
	commit.  If I pass --output-format=sha1, then that means I
	care, and show me the SHA-1.

In other words, I want the input format and output format completely
decoupled.  If I pass ^{sha1}, I am indicating the input format.  To
specify the output format, I'd use --output-format instead.

That lets me mix both hash functions in my input:

	git --output-format=sha256 diff abcdabcd^{sha1} abcdabcd^{sha256}

I learned about these two commits out of band from different users,
one who only uses SHA-1 and the other who only uses SHA-256.

In other words:

[...]
> Similarly, I think it would be very useful if we just make this work:
>
>     git rev-parse $some_hash^{sha256}^{commit}
>
> And not care whether $some_hash is SHA-1 or SHA-256, if it's the former
> we'd consult the SHA-1 <-> SHA-256 lookup table and go from there, and
> always return a useful value.

The opposite of this. :)

Thanks,
Jonathan
