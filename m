Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C224FC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD3D20829
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rRQfabWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHLQXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:23:08 -0400
Received: from mout.web.de ([212.227.17.12]:60767 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgHLQXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 12:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597249382;
        bh=hUQHNrzXSKstXAO92bv6Hm6kOcQBx7t1PCqBz9C7cqE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rRQfabWgTlkl7c2sj/xHP1fhGuaoS8vpIVJ7aY0kK19Q3Zg2yv6Tqws3gtYQaMjgT
         j57aaCUCTUWmLVBpG1brLM84L5cU+kd3eW53c/yKCDHrrtfqS2O+UuwHjQvQvPcPRP
         6Qs5F3SlGvrjDRnorZh+26tywb2jvU+6pQVacH38=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2uWg-1kwLDs0jTC-00shaC; Wed, 12
 Aug 2020 18:23:02 +0200
Subject: Re: [PATCH 0/11] renaming argv_array
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
 <20200812150611.GA33189@coredump.intra.peff.net>
 <20200812151038.GB33189@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <045ea49b-7165-0f45-e670-a24bf648f880@web.de>
Date:   Wed, 12 Aug 2020 18:23:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812151038.GB33189@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GphvW58+S+VCLAWfHmkNwWy2FutM1ppIc6nT0wR8z3qem/kexNC
 zoi4zlXmBUDq2itA0E5jwAoz7USsLtJC2pBKZFCToZp03LI+m596LQchHlB1iztdGgHcB/g
 52fEArNPdrC2X0q1q8a81vAe/I7UL/T+HSt8VZHLaWXgVn6MMLBh726DXw/YlMlh8RkPlQ4
 dVZegFUuxBbNiEPjfOl9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tjmOrK3MYp0=:sndws8zE4BWQ1x0nAGTdAw
 TLrlUV0BIR5GEoVlyrsmUxF5CNnvv/y+vp95y4uOnP7F4beAP/mfFSi+3JN85e3LN4uwbxKc4
 ClUPtHAbhXxo4FKgwoPpZ49/bKipiMwHZqiLzqtYFffJe4t0rf/DlVVXnH1d1gpE2P3uHurbA
 b8V7caoWJaopiY3HY64mrZTUN61wM9kyrPDoUuUMfGg43QQabF20TamlL/dXGTwGIROerTKhw
 EV1pPBeSBkSE6j+EeIkkJTIJ4EUQoR6U+2SEwgoFRIcsXtye6wcrszn2D5nJwtxxTo748PBdc
 PCecRSIjFwajufzM1smMztPNNdsVAa7CpY2/4dvEFZy2qj0uSqbmk1tFPlKgYPoPT0K8tMLa4
 g/mWBsklzywABbGNckiXcyA4XsTolIGhoqEPKjTNOQAl+CS9A0TGjtJe0OlypKcD1GzQWejQ2
 JMHCnwCNo1/THiREzVH74W269iMCZBY24TfKKQFnm54EFOzXKzbxOhghAE5u7vlaNV/Geb/CC
 /79pOOCaS526E+ucdGrdt9XlW6mrqkMlLKu7wxDVmNeX9QEy4p5/FRmAZ5rRW1DqHLt16q3+P
 3no0RqpRjIl4dEeV8CbQktNkuDZf1bpzIulvDk6aLVk5oHUidagNwkz8PT4z0tSIYng8RDztL
 RoqYHL6rTQSh1HHFTXLfbP+9E/QOofezB+R2P15MMKYrx1XJwMFoJWgrfW2fRJxIyoCTfvsnf
 WazIXqRsIHNnyZv0cP38PTIZ5wUoiyz+QKjsfFRmQx8Bt93S/BLS2Zau+/qqAAXnYrisCdch6
 znrlGnuAtwy7o3MOont0FiKSdicspWtEmI4ZwAlxuEWIfY+thQnrPr26IDvEPGhLi2aRTGHhJ
 3KovtgrTO72KVoT7qLZw8KjpY3cNf+Ll1euYXpMuuPP5PbUe601s5rl86Nx3lRa2gRdyxSKaO
 NVq4G34v9QkJ8ul2jlRM1KuZyU7qRcjwARNWA+7bVsuyxJZWA7BgBeTq3gyfcKaLB5jnsAM83
 GqZTXN0gze0a3zYN5WbgqX4G3JOC1j5xYys5fEIVmXbwG5SZA0tALvIo2gISJmeFpyDAA9s8J
 L56B5APx3+YITlF+tqn2QhivBxmRoetCjuwi+xyBWZZhUviJDXKye60xmh61yXayZYkzvDi7X
 miIr5ju2lGZ4qInOOYAnohxekwD88Zgp5QekESu/HKs75yCPgnevS37P0LuccXGS1gmViyteF
 RLVcA8oLH9IAHlRRn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.08.20 um 17:10 schrieb Jeff King:
> On Wed, Aug 12, 2020 at 11:06:11AM -0400, Jeff King wrote:
>
>> Debian unstable now ships coccinelle 1.0.8, and it's unbelievably slow
>> compared to 1.0.4. Running "make coccicheck" is currently at 80 minutes
>> of CPU time running each script in parallel, with none of them down.
>> They're also all consuming 6GB of RAM each, so I'm killing them all.
>
> This seems to be related to setting SPATCH_BATCH_SIZE to "0". It used to=
 make
> things go much faster (if you had enough memory), but now seems to just
> consume tons of CPU. Setting it to "1" finishes the whole thing in ~13
> minutes of CPU (~2m wall-clock).

This bit me as well, and I settled with SPATCH_BATCH_SIZE =3D 10.  With
MAKEFLAGS +=3D -j3 I get these number, which are quite similar to yours
(except I don't dare use more cores due to cooling issues..):

  real	4m12,393s
  user	12m15,447s
  sys	0m10,418s

> So that's at least a path forward, but in general I have been frustrated
> with operational aspects of coccinelle like this.

And I was a bit shocked when Coccinelle's testing package became
unmaintained for a while and I had to compile it from source.

And yes, coccicheck is quite heavy.  When I merge all .cocci files into
one I get:

  real	2m7,164s
  user	2m5,389s
  sys	0m1,572s

Nice.  With spatch -j3 I get basically the same numbers, though.  Hmm.

Ren=C3=A9
