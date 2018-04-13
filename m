Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33521F424
	for <e@80x24.org>; Fri, 13 Apr 2018 09:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeDMJx2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 05:53:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47015 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeDMJx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 05:53:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id d1so7690712wrj.13
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=k3FMrVhdhRkgtZlWLD3mj+WMKwSQ+I1EWy7WtqD8eIQ=;
        b=WIU43fDyO5yQ5EwgWbGNGx7NEr0IM2Dnsg0i/LDrtbK/DGGO+pM3h5Vg9Z//bipqG0
         NJtE+t/cBHV0F348VA3uHOlteM9MdD88jIFDJPwYl8Bn/AlZxZFs5tZe/58Var9ndFuo
         AVCC2Rl61U5ax+pqXs9gr1SrgRnJTedidSliwD2qsrULOGJi/NwCHb2WiD4+yvbsdv3B
         eJdG19slsj2YXOA3GeRZ96o+pY/b0ve+3t9nyCKr7+eBBvW6MlFl7UIUfzhulk2z6Gkw
         f2Z1vv1/iZCMCz+PZN5BP9zUnsn6zsIOG5n68OIbLOZfla3xBTFsmCm/LqNEdDCr97k6
         p5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=k3FMrVhdhRkgtZlWLD3mj+WMKwSQ+I1EWy7WtqD8eIQ=;
        b=bok53TLp51RBnCkMNG/kQAKpRXRwug4Oui+NOxfrlPf+c/mAn/LFLIWM/OMLjQEE97
         uor0SzaDFX8oY5UmXJsX7hAR1csAp0+KrBxU6NKWtcOHiUAJKCAqzMOcd/bu7kqjIr8c
         U3r+dTchdDKVUceQXAe1O/CPSmju2UdH0Kdwns+vH1Vm0QdaCe6AYyKdHExNOGzESGxD
         MrjLKKgR/LdnWMiWXsif7lbm3daxcgklbdYpbijXY3O6u4pnVCwbTvyHLFQOUnSSWkaE
         YXcyC1Z6MkSNA3ZG2JJDgHSokf7d1jgvH8g2/YRhQPCSlbf91r6BrNdJj2TsHum7DIt4
         6+6g==
X-Gm-Message-State: ALQs6tDXMUFKUaGP4jFX/SYAMMB1s59WeitwhaLCxECvdrHR5l3yyzdq
        9lM5COdZ3fdYDripm6u7CAA=
X-Google-Smtp-Source: AIpwx4+3oS5cn+DwSpg2HgRp7S7zbn5rbBMOrxVCTmSGUzg5Za0JYtqDlMj2/Fb7dTYWdXh1GyQdFQ==
X-Received: by 10.223.198.71 with SMTP id u7mr3389431wrg.270.1523613206100;
        Fri, 13 Apr 2018 02:53:26 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrf152.neoplus.adsl.tpnet.pl. [83.8.99.152])
        by smtp.gmail.com with ESMTPSA id c130sm1452692wmh.33.2018.04.13.02.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 02:53:24 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 07/10] commit-graph.txt: update future work
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180409164131.37312-1-dstolee@microsoft.com>
        <20180409164131.37312-8-dstolee@microsoft.com>
        <xmqqfu403i0p.fsf@gitster-ct.c.googlers.com>
        <f557058d-7836-4b66-8fda-7fdfc7484219@gmail.com>
Date:   Fri, 13 Apr 2018 11:53:21 +0200
In-Reply-To: <f557058d-7836-4b66-8fda-7fdfc7484219@gmail.com> (Derrick
        Stolee's message of "Thu, 12 Apr 2018 07:35:36 -0400")
Message-ID: <86a7u7mnzi.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/12/2018 5:12 AM, Junio C Hamano wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>>> +Here is a diagram to visualize the shape of the full commit graph, and
>>> +how different generation numbers relate:
>>> +
>>> +    +-----------------------------------------+
>>> +    | GENERATION_NUMBER_INFINITY =3D 0xFFFFFFFF |
>>> +    +-----------------------------------------+
>>> +	    |            |      ^
>>> +	    |            |      |
>>> +	    |            +------+
>>> +	    |         [gen(A) =3D gen(B)]
>>> +	    V
>>> +    +-------------------------------------+
>>> +    | 0 < commit->generation < 0x40000000 |
>>> +    +-------------------------------------+
>>> +	    |            |      ^
>>> +	    |            |      |
>>> +	    |            +------+
>>> +	    |        [gen(A) > gen(B)]
>>> +	    V
>>> +    +-------------------------------------+
>>> +    | GENERATION_NUMBER_ZERO =3D 0          |
>>> +    +-------------------------------------+
>>> +			 |      ^
>>> +			 |      |
>>> +			 +------+
>>> +		     [gen(A) =3D gen(B)]
>>
>> It may be just me but all I can read out of the above is that

It's not just you.

>> commit->generation may store 0xFFFFFFFF, a value between 0 and
>> 0x40000000, or 0.  I cannot quite tell what the notation [gen(A)
>> <cmp> gen(B)] is trying to say.  I am guessing "Two generation
>> numbers within the 'valid' range can be compared" is what the second
>> one is trying to say, but it is much less interesting to know that
>> two infinities compare equal than how generation numbers from
>> different classes compare, which cannot be depicted in the above
>> notation, I am afraid.  For example, don't we want to say that a
>> commit with INF can never be reached by a commit with a valid
>> generation number, or something like that?
>
> My intention with the arrows was to demonstrate where parent
> relationships can go, and the generation-number relation between a
> commit A with parent B. Clearly, this diagram is less than helpful.

Perhaps the following table would make the information clearer (perhaps
in addition to the above graph, but without "gen(A) {cmp} gen(B)"
arrows).

I assume that it is possible to have both GENERATION_NUMBER_ZERO and non
zero generation numbers in one repo, perhaps via alternates.  I also
assume that A !=3D B, and that generation numbers (both set, and 0s) are
transitivelu closed under reachability.

gen(A) \   commit B ->   |                     gen(B)
        \-----\          |
commit A       \         | 0xFFFFFFFF | larger   | smaller | 0x00000000
----------------\--------+------------+----------+---------+------------
0xFFFFFFFF               | =3D            >          >         >
0 < larger  < 0x40000000 | < N          =3D n        >         >
0 < smaller < 0x40000000 | < N          < N        =3D n       >
0x00000000               | < N          < N        < N       =3D

The "<", "=3D", ">" denotes result of comparison between gen(A) and gen(B).

Generation numbers create a negative-cut filter: "N" and "n" denote
situation where we know from gen(A) and gen(B) that B is not reachable
from A.

As can be seen if we use gen(A) < gen(B) as cutoff, we don't need to
treat "infinity" and "zero" in a special way.


Best,
--=20
Jakub Nar=C4=99bski
