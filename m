Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC981F404
	for <e@80x24.org>; Sun, 25 Mar 2018 03:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbeCYDln (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 23:41:43 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41288 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbeCYDlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 23:41:42 -0400
Received: by mail-pl0-f67.google.com with SMTP id b7-v6so9822578plr.8
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 20:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=j5AY7eWS2Ttvg+lz3gZxHzFmS7EsoOTMlvNVXaRr7Gc=;
        b=V84aFNlVQwKEyWiRqlAhwCwdU2mJJlEL3O/8VuuaON0tDcCrbppSjW4Nk0V/0v9vwD
         W2NmmqQBhh3739N12SMTkN+rpE65eadezvP8J5Yg8TlqvyRN3wsc2EOy0NCUAIqMCtAe
         1SbNvui/MRdqm2EqC1t3Uz9Xw7ilcm7k50DoQsCtkvAHIsBUxPV6u9N12xT51hVoqlQS
         zajNfqJJNhZdNXOUtqZz97Qktg2MEhz0ptvH1dqNlPZDcBJrfS8HHz99zhGm2ghNJKZc
         9+IDKTS1RbhOdl8yBJ26XXipt/8pLVqJkpjWPplZlT4HQ+eC8YnqSBWqTylVBXv44ryD
         IpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=j5AY7eWS2Ttvg+lz3gZxHzFmS7EsoOTMlvNVXaRr7Gc=;
        b=YHAke8EeMMNGQa5ZGZ7cKZIs0bhLcj7RbxyypzhtDLov8anlTyFhcLrjxti3GLS33Y
         T6UPGIYSnmWVRObmYkx6nrsBEDfbLCBfA2JycmzbfBtS5r7NlR0aatmPk06+ByNIfbCc
         Izalg/vj5AYG3nLoMUVepaSB1MSgHhtZGPdXSjT6YKSeOKxjZDY5Lapl4wPxRCbE3r1d
         LP72HmWjg8aAC+wSLmxiABwBpNDBwXsguyBHWT4hkq6w5u8I6v8JdpSLsVyPdy45WURq
         ibAFOAIeE5bgFKz8uHvhV9dxqeuTulxNa7dsl0TK0OQHX9wWfQ9mLETHhmFTZkFPCFcz
         Ovjg==
X-Gm-Message-State: AElRT7EKw/UCpEvp3BYUrbTGgSqEOoMj86mL3B+HsiT/C3mUiPMTERDl
        AhrLIBDBHxxIAI31rOYO93eaJGfR
X-Google-Smtp-Source: AG47ELssyNL5fZDGmXPB2G2Mi9Hhvi+/4higFgP+q+a5i9eLkaSk4ULTsVeVyOdMVzKy6WqTbA7xSg==
X-Received: by 2002:a17:902:b786:: with SMTP id e6-v6mr36157909pls.58.1521949301730;
        Sat, 24 Mar 2018 20:41:41 -0700 (PDT)
Received: from [192.168.206.100] ([117.246.78.52])
        by smtp.gmail.com with ESMTPSA id y1sm22913791pgs.80.2018.03.24.20.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 20:41:40 -0700 (PDT)
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
Date:   Sun, 25 Mar 2018 09:11:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qh6hGVYqolNURlZY5dqTk08hXC0YNFsqG"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qh6hGVYqolNURlZY5dqTk08hXC0YNFsqG
Content-Type: multipart/mixed; boundary="nICPfPS5JQsc4dkYMotntyrS1RGgiGbbY";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
In-Reply-To: <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>

--nICPfPS5JQsc4dkYMotntyrS1RGgiGbbY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Sunday 25 March 2018 07:04 AM, Eric Sunshine wrote:
> On Sat, Mar 24, 2018 at 2:38 PM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> When rebasing interacitvely (rebase -i), "git branch -l" prints a line=

>=20
> The "git branch -l" threw me since "-l" is short for --create-reflog.
> I'm guessing you meant "git branch --list".
>=20

That's surprising, I just tried "git branch -l" on a repository and I
did get a list of branch names. Is this a consequence of some option
parsing weirdness ?!

To be honest, I actually assumed "-l" to be a shorthand for "--list" and
didn't check with it in the documentation; which I should have. Sorry,
for that. I still wonder why "git branch -l" prints a list of branch
names when it is not a shorthand for "--list" ? (BTW, I'm also surprised
by the fact that "-l" is not act shorthand for "--list"!)

Regardless, I'll update the commit message to use "--list" in place of "-=
l".


>> indicating the current branch being rebased. This works well when the
>> interactive rebase was intiated when a local branch is checked out.
>>
>> This doesn't play well when the rebase was initiated on a remote
>> branch or an arbitrary commit that is not pointed to by a local
>> branch.
>=20
> A shorter way of saying "arbitrary commit ... not pointed at by local
> branch" would be "detached HEAD".
>=20

Thanks. I was actually searching for this word. It didn't strike when I
wrote the commit message, yesterday.


> You could collapse the whole thing back down to:
>=20
>     strbuf_addf(&desc, _("(no branch, rebasing %s)"),
>         state.branch ? state.branch : state.detached_from);
>=20
> which means you don't need the 'rebasing' variable or the braces.
>=20

Nice point.


> Can we have a couple new tests: one checking "git branch --list" for
> the typical case (when rebasing off a named branch) and one checking
> when rebasing from a detached HEAD?
>=20

Sure, but I guess it would take some time for me to add the tests. I'll
send a v2 with the suggested changes.


--=20
Kaartic


--nICPfPS5JQsc4dkYMotntyrS1RGgiGbbY--

--qh6hGVYqolNURlZY5dqTk08hXC0YNFsqG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlq3Gm8bHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlp1XQP/ig0IMuDeq8YgvryJtbi
D4UcaRmJWI+VnwX13pvbWHu3Z2Cz6LL71nYlfenngsUD390ymJrZsNyTl0g7m97x
RdTvMhRR2Jjg7P9PPJpxScd/of0tTgStpQn1qvjkkDLV824VJH0x2kgjD+STPgFB
oknoh6hMFa6VChSrroaDOWKRrDRYvOtrtI3MIckG8yTw5Q8h1ctX2YUCJoi5kQ4/
Yo3+PAXOfBn5lG5RDpJipgl2f1LUijrpaJ/o0js3+XTW/lpqnNfVDelAdJoVlipH
O3dsGOBEiQMtGWbZrwcrt5/bI9C6ksW8dYChE/87Ge1nG+5mtFzStp4doZ5MpZx5
QffKm+/hdVfNAE3T3ESKn07n1JStmRrcYuSJEuKuhFVoff/bgCYfXkfuDESqeY0F
0EqJfw/kFS7ou7DtlhNtjMeEuZ2+0Tx25DSvO7qDCjLqajypN6RcUFOVzltuD8d3
465dCwA1q1lh4lvSnEGps+gZC21BmvqPi5kAEjWaTtbsTmu1DvcsDgQf5lqqRwDp
m9KbdAj4ph25bJNXPtTfb2n/MH8SeUlmchpYoBfm0OlySDaRM0ibqM/EpRf8thiB
lFYjLNr0n+3QkxWXkvOCJU8qIfyQPzaUx+L1dQZhAOCVI+BFCieaRWT73PeW9O2C
nwOazOh0lbcxkEnIF2Yd0dx4
=0vRK
-----END PGP SIGNATURE-----

--qh6hGVYqolNURlZY5dqTk08hXC0YNFsqG--
