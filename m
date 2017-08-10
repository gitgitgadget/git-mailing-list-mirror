Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1BA20899
	for <e@80x24.org>; Thu, 10 Aug 2017 10:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbdHJKEs (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 06:04:48 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:46052 "EHLO
        homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751373AbdHJKEr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Aug 2017 06:04:47 -0400
X-Greylist: delayed 3810 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Aug 2017 06:04:47 EDT
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id D2F9B3C001C17;
        Thu, 10 Aug 2017 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=jupiterrise.com; bh=J
        70r+5KIWEKWR9pO9vhdYM3uNQA=; b=rBFZad8l59GOU8xtr7n28aOcE5gK82LQ7
        kQtgnXHeUpltKEF0PIqQyvHNm3aMd4uz5GA2MPAvz65Dwfzb6vvPF/EP6qxI2UF2
        b7yilUI/LpCFhRZaznrW9ojLjv1h/zyUdMcuZOXT+6rtAj4CFxyBRgW4pHcnwQc5
        l645zVF8+o=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id 9B34A3C001C15;
        Thu, 10 Aug 2017 03:04:46 -0700 (PDT)
Received: from [172.18.95.11] (nat.statsbiblioteket.dk [130.225.26.33])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id BAC9C605EE;
        Thu, 10 Aug 2017 12:04:43 +0200 (CEST)
Subject: Re: Dropping support for older perl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Tor Arntsen <tor@spacetec.no>,
        "Randal L. Schwartz" <merlyn@stonehenge.com>,
        Jakub Narebski <jnareb@gmail.com>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <87zib8g8ub.fsf@gmail.com>
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Message-ID: <69dba5a3-b9e5-15b2-ca7c-8720da6c3b62@jupiterrise.com>
Date:   Thu, 10 Aug 2017 12:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <87zib8g8ub.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: da
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/17 15:38, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> RHEL/CentOS 5.x has perl 5.8.8, but it also has curl 7.15.5[1] which is
> obseleted by these curl patches. Maybe we'd want to be more conservativ=
e
> with perl for whatever reason, but I'd like to at least bump our
> requirenment of 5.8.0 to 5.8.8. Those releases are 4 years apart, and a
> lot of bugs were fixed[2], and some constructs / modules have newer API=
s
> we could use.
>=20
> But if we do the thing corresponding to these curl patches we should
> bump the dependency to 5.10.1, that was released in August 2009 (and th=
e
> curl version JK is bumping us to in March 2009), and 5.10.1 is shipped
> with RHEL/CentOS 6.
>=20

I agree with your thoughts.
Though I'm a bit biased since I only really care about RHEL/CentOS in=20
the context of being able to use vendor provided versions of curl and per=
l.

> The bump to 5.10.1 may be a bad idea, I know AIX/HPUX/Solaris and some
> others have historically been more conservative about upgrading perl
> than stuff like libcurl since it's in the base system.
>=20

AFAIK it used to be common to build updated versions at least on Solaris.
I provide perl 5.16.x and a recent curl for Solaris 2.6-9 as part of=20
tgcware(1) and Solaris 10/11 users can use OpenCSW which seems to have=20
5.10.1 available.

-tgc

1) https://jupiterrise.com/tgcware/
