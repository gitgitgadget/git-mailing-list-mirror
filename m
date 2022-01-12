Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB817C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356249AbiALSe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:34:28 -0500
Received: from mout.web.de ([212.227.15.4]:51267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343979AbiALSeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642012456;
        bh=XjV4DE0XkcXxZD97WbaTyxVPsfsIUzW60IUHTLdwA2w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SucPol8ON3tnF2AnwAwukgVzYxJUyJHD3WReQczSVmZBGOA4O5rjFNpxyyhCvm+1E
         A75BmsgBm6X8D5mLoTgIhh2zpkKNUTZg5A3oIvmfPAUeSO/NOzXQXReZDkbavfb8vS
         yy/CdLo87paLF2gjbEwhuvzE43pphf+8tNJ1SZGM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d3k-1mNkem1jHU-012FWz; Wed, 12
 Jan 2022 19:34:16 +0100
Message-ID: <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
Date:   Wed, 12 Jan 2022 19:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: git bisect bad @
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramkumar Ramachandra <r@artagnon.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g>
 <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
 <3dade45b-494f-663b-264b-06a51ea1cf56@web.de> <xmqq35lsyhbf.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq35lsyhbf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:64lDOukjYobBX2tmKvWoHisgmBaGqgDBvsECEXSSZy6HjYhYOUv
 zWCvPI3mQiSVupOcrfHwTuCkBGUM+2uJfq5zO7raHD4BEkgccN36tlgOPaH5JfHr8b0K9+F
 79b0y9GBX/Om+mtHZKN2A3kc7Lxv/PxoxeQU1qgel1cXLrVnZo3Kko0ZxBz6mVbJvotI+Eb
 lmbWlJeuN/dlipJZnSZ1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wT8QpngBqpQ=:DFnOg3oTJPDs66HE9SaSi9
 mfu+TLV0YDKSvpCp5zSswHFVf4odOvadooHM+uMxJ4pp7S98gf+AqywFF3265SMUr0+NcuJkJ
 1vgfFoO//37ByrRap3eeHWK5KA3L143n7mRacB3WHTaAx5xVjJa2Zctu85kRDaYe7UYk8yrIX
 2oFB/B/+YOcmccnOOr/RdifWt/5ANYrgny9Y3YE+c7UFxd2PM0ebl3J7PQpd+ObduS8oM6c+P
 dy5iv+Gjh3QWN667G0Gzxorqbb2pLSEMck/UdSJiml3UX5S5+uYF8FIkGy0O8u8vxJ5LGOe9p
 Nr+utEKYajUDP11Zazx3PfOrhFg3UbqoXrylpy9rSCrHWKzBQAF78BhEqdSKYlZBW122YAzb7
 L9Em9NfbpoeTOLHZGmBS6BMT7nVY3h2Q1kTBfTc2C20NGR4epA/zX92SUmO2KnA30zX2PhoQB
 vaW9FngI3eMyz+yj4sw6fqxIbbO5VNTe+tSaOn1mZEqyrzRBNoancIStFuHsH+4TGigxpSKrd
 jkCwr2HPLFJyfnIwyRyqFiItDk4TcunjcApahroMa2MfY1LqkCsqYCybvrNmtjUwGVOAcqj4t
 oV91rkr/RGJLhOqMzIfN4dv48R31csQ/hmchH2u07JwBMynujSP56PXEitzlZB8vEWvu/kHLj
 0tsdZaHdQwOK30xvFZucDeZw5R2uWvDQoZcJ9BUsbLZFvlLdOtVelNJNLmATggmY27Ps9ARZR
 /5iisnEybkvUMqie4+JsixELm53gmyVahyTYn1eg5ksaODAVoFW3yn2VNwqqkgxuDtIJHj89U
 2dfHqnGNCsvrJAKG/GOkoVW0FdmWRf3FKUmr3Au2R3VHF2HArTCCYd8c96h6BZgbY4qaevwpP
 eIBoV2UhsWOxQ+4rxoqIvbpZ7uY3IYqEknFSaZNV8hncwvZfClnr7XNK/OE0mToARM/IMSej7
 MvEgFMquD62s/Rug27eTphvW/uGiDCeT9T4j8bY8Au95gPTFrIBi2VWnVzdtg5GunAAvf79xy
 SAg5f+hrDM0vy8tnkuxsyOJH5yumNFT0URODWbS9cf3MjH7LHL965h4wfq7pxCDffDbSY3n3A
 oYy85EXG/wnmmg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 12.01.22 um 18:50 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> It would be nice if we could determine if the command was not found by
>> the shell and halt the bisection.  This is actually indicated by the
>> shell using error code 127.  However, the script itself could also exit
>> with that code (e.g. if one of its commands was not found).  Currently
>> this is interpreted as a bad revision and bisection continues, as
>> documented in the man page of git bisect.
>>
>> If we'd make error code 127 (and 126) special by stopping the bisection
>> (like we do for 128 and higher) then scripts that relied on that code
>> indicating a bad revision would require a manual "git bisect bad" at
>> each affected step.  Annoying, but not dangerous.  Such a script would
>> have to be modified to convert codes 126 and 127 to e.g. 1.
>>
>> Seems like a reasonable trade-off to me.  Thoughts?
>
> Probably.  It is safer than the current "all revisions including the
> bottom one and the top one are bad" which leads to the "merge-base
> says your good and bad are nonsense" error for the "command not
> found" case, but what if the one that reports an error with 127 (or
> 126) is coming from something other than shell (i.e. the 'bisect
> run' command was fed is not a script at all)?  Is it a no-no for a
> random binary that is not an implementation of shell to exit with
> these error status?

The man page of exit(3) mentions the implementation-defined constants
EXIT_SUCCESS and EXIT_FAILURE from C99.  It also says: "Cooperating
processes may use other values".

sysexits(3) on BSD mentions a few others, all below 100
(https://man.openbsd.org/sysexits.3).  Its BUGS section says:
"The choice of an appropriate exit value is often ambiguous.".

So exit code values are only very vaguely standardized.  It's very
possible that there are programs that use 126 or 127 to signal
something other than "can't execute" or "cannot find command".  Under
the new rules the bisect run script would have to translate them to
some lower value.

Ren=C3=A9
