Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF761F597
	for <e@80x24.org>; Sun, 22 Jul 2018 15:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeGVQ2j (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 12:28:39 -0400
Received: from ober.noekeon.org ([91.134.133.203]:37859 "EHLO ober.noekeon.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbeGVQ2j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 12:28:39 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jul 2018 12:28:37 EDT
Received: from 192.168.1.3 (78-1-22-249.adsl.net.t-com.hr [78.1.22.249])
        by ober.noekeon.org (Postfix) with ESMTPSA id 45C6E2229E;
        Sun, 22 Jul 2018 17:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=noekeon.org; s=mail;
        t=1532272993; bh=t+5TTRRdCOaXH1XgVbMEtD4F1o37iEkJSah5JAxG2rk=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
        b=NnpbYdWCdGu/PbW8sw89rnYaFNkv6+BPXH4xnAQ7XQVK4+4wc8HxCZQtX1SaXJDFI
         16GomX7dSSgByvC69hcBqSe2uqzIeVNTytGTSJRc3U7oyCf6TBUVSr1vpStQgNhX9p
         Yc7cggfAEjQlVQXtAQoBmnmB9aLny3izODJK4EHU=
Subject: Re: Hash algorithm analysis
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net>
From:   Joan Daemen <jda@noekeon.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jda@noekeon.org; prefer-encrypt=mutual; keydata=
 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
Cc:     Keccak Team <all@keccak.team>
Message-ID: <f5bb91e8-5189-7f61-e018-91447c42845e@noekeon.org>
Date:   Sun, 22 Jul 2018 17:23:01 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180721235941.GG18502@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

I wanted to react to some statements I read in this discussion. But
first let me introduce myself. I'm Joan Daemen and I'm working in
symmetric cryptography since 1988. Vincent Rijmen and I designed
Rijndael that was selected to become AES and Guido Bertoni, Michael
Peeters and Gilles Van Assche and I (the Keccak team, later extended
with Ronny Van Keer) designed Keccak that was selected to become SHA3.
Of course as a member of the Keccak team I'm biased in this discussion
but I'll try to keep it factual.

Adam Langley says:

  I think this group can safely assume that SHA-256, SHA-512, BLAKE2, K12=
, etc are all secure to the extent that I don't believe that making
  comparisons between them on that axis is meaningful.

If never any cryptographic algorithms would be broken, this would be
true. Actually, one can manage the risk by going for cryptographic
algorithms with higher security assurance. In symmetric crypto one
compares security assurance of cryptographic algorithms by the amount of
third-party cryptanalysis, and a good indication of that is the number
of peer-reviewed papers published.

People tend to believe that the SHA2 functions have received more
third-party cryptanalysis than Keccak, but this is not supported by the
facts. We recently did a count of number of cryptanalysis papers for
different hash functions and found the following:

- Keccak: 35 third-party cryptanalysis papers dealing with the
permutation underlying Keccak, most of them at venues with peer review
(see https://keccak.team/third_party.html) This cryptanalysis carries
over to K12 as it is a tree hashing mode built on top of a reduced-round
Keccak variant.

- SHA-256 and SHA-512 together: we found 21 third-party cryptanalysis
papers dealing with the compression functions of SHA-256 or SHA-512.

- BLAKE2: the BLAKE2 webpage blake2.net lists 4 third-party
cryptanalysis papers. There are also a handful of cryptanalysis papers
on its predecessor BLAKE, but these results do not necessarily carry
over as the two compression functions in the different BLAKE2 variants
are different from the two compression functions in the different BLAKE
variants.

I was not surprised by the relatively low number of SHA-2 cryptanalysis
papers we found as during the SHA-3 competition all cryptanalysts were
focusing on SHA-3 candidates and after the competition attention shifted
to authenticated encryption.

Anyway, these numbers support the opinion that the safety margins taken
in K12 are better understood than those in SHA-256, SHA-512 and BLAKE2.

Adam Langley continues:

	Thus I think the question is primarily concerned with performance and im=
plementation availability


Table 2 in our ACNS paper on K12 (available at
https://eprint.iacr.org/2016/770) shows that performance of K12 is quite
competitive. Moreover, there is a lot of code available under CC0
license in the Keccak Code Package on github
https://github.com/gvanas/KeccakCodePackage. If there is shortage of
code for some platforms in the short term, we will be happy to work on th=
at.

In the long term, it is likely that the relative advantage of K12 will
increase as it has more potential for hardware acceleration, e.g., by
instruction set extension. This is thanks to the fact that it does not
use addition, as opposed to so-called addition-xor-rotation (ARX)
designs such as the SHA-2 and BLAKE2 families. This is already
illustrated in our Table 2 I referred to above, in the transition from
Skylake to SkylakeX.

Maybe also interesting for this discussion are the two notes we (Keccak
team) wrote on our choice to not go for ARX and the one on "open source
crypto" at https://keccak.team/2017/not_arx.html and
https://keccak.team/2017/open_source_crypto.html respectively.

Kind regards,

Joan Daemen



On 22/07/2018 01:59, brian m. carlson wrote:
> On Sun, Jul 22, 2018 at 12:38:41AM +0200, Johannes Schindelin wrote:
>> Do you really want to value contributors' opinion more than
>> cryptographers'? I mean, that's exactly what got us into this hard-cod=
ed
>> SHA-1 mess in the first place.
> I agree (believe me, of all people, I agree) that hard-coding SHA-1 was=

> a bad choice in retrospect.  But I've solicited contributors' opinions
> because the Git Project needs to make a decision *for this project*
> about the algorithm we're going to use going forward.
>
>> And to set the record straight: I do not have a strong preference of t=
he
>> hash algorithm. But cryprographers I have the incredible luck to have
>> access to, by virtue of being a colleague, did mention their preferenc=
e.
> I don't know your colleagues, and they haven't commented here.  One
> person that has commented here is Adam Langley.  It is my impression
> (and anyone is free to correct me if I'm incorrect) that he is indeed a=

> cryptographer.  To quote him[0]:
>
>   I think this group can safely assume that SHA-256, SHA-512, BLAKE2,
>   K12, etc are all secure to the extent that I don't believe that makin=
g
>   comparisons between them on that axis is meaningful. Thus I think the=

>   question is primarily concerned with performance and implementation
>   availability.
>
>   [=E2=80=A6]
>
>   So, overall, none of these choices should obviously be excluded. The
>   considerations at this point are not cryptographic and the tradeoff
>   between implementation ease and performance is one that the git
>   community would have to make.
>
> I'm aware that cryptographers tend to prefer algorithms that have been
> studied longer over ones that have been studied less.  They also prefer=

> algorithms built in the open to ones developed behind closed doors.
>
> SHA-256 has the benefit that it has been studied for a long time, but i=
t
> was also designed in secret by the NSA.  SHA3-256 was created with
> significant study in the open, but is not as mature.  BLAKE2b has been
> incorporated into standards like Argon2, but has been weakened slightly=

> for performance.
>
> I'm not sure that there's a really obvious choice here.
>
> I'm at the point where to continue the work that I'm doing, I need to
> make a decision.  I'm happy to follow the consensus if there is one, bu=
t
> it does not appear that there is.
>
> I will admit that I don't love making this decision by myself, because
> right now, whatever I pick, somebody is going to be unhappy.  I want to=

> state, unambiguously, that I'm trying to make a decision that is in the=

> interests of the Git Project, the community, and our users.
>
> I'm happy to wait a few more days to see if a consensus develops; if so=
,
> I'll follow it.  If we haven't come to one by, say, Wednesday, I'll mak=
e
> a decision and write my patches accordingly.  The community is free, as=

> always, to reject my patches if taking them is not in the interest of
> the project.
>
> [0] https://public-inbox.org/git/CAL9PXLzhPyE+geUdcLmd=3DpidT5P8eFEBbSg=
X_dS88knz2q_LSw@mail.gmail.com/


