Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1041F406
	for <e@80x24.org>; Fri, 15 Dec 2017 10:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756221AbdLOKgh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 05:36:37 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:62536 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754533AbdLOKg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 05:36:27 -0500
Received: from [130.75.46.4] ([130.75.46.4]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LtRci-1f8mi733vY-010wvX; Fri, 15 Dec 2017 11:35:39 +0100
Subject: Re: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make
 rules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
        'Jeff King' <peff@peff.net>, 'Dan Jacques' <dnj@google.com>,
        'Alex Riesen' <alexander.riesen@cetitec.com>,
        'Jonathan Nieder' <jrnieder@gmail.com>,
        'Brandon Casey' <drafnel@gmail.com>,
        'Petr Baudis' <pasky@ucw.cz>, 'Gerrit Pape' <pape@smarden.org>,
        "'martin f . krafft'" <madduck@madduck.net>,
        'Eric Wong' <e@80x24.org>,
        'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        Bill Honaker <bhonaker@xid.com>
References: <20171129195430.10069-1-avarab@gmail.com>
 <20171210211333.9820-1-avarab@gmail.com>
 <003f01d37390$ed0e0440$c72a0cc0$@nexbridge.com>
 <87a7ynd1ml.fsf@evledraar.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <b8b4534f-1eda-ee52-faed-ec5188c2ad35@grubix.eu>
Date:   Fri, 15 Dec 2017 11:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <87a7ynd1ml.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:OhUrr11OuUsG5c4GXPHFk1eKlU+c2JeY/Ebdf2zKwjMduvv4sve
 0sgi3eRz/ot5k48P40CpC4+wgk9DRv7Kk2XnxM6zk6wT+tOCb2DtzPomtdwSyq19DIajWHV
 XJgd6uTrVXejQaieah673NqJ54D+2jKDntYlligAeS4+rEMKI+HiIDnQK82tSGHErzas8qn
 C8tyifExZKbyvYvbk42rQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BaTpxQ0sRWQ=:gJRiiMNsSeRMUGdp3ZAn0K
 PDClsATg3ymzolfMUDpLoKDqkGhff0J/IeGVjS0XupVqUKLgYCoLe1l/y9ab3pYxTANe3t7my
 OHI/58Li04PWNw5YrV35QIRba2M2GO7yFAy+q689orft51Hwfu7wzi7Vr01PI0FVX3PI4nQar
 wZjYwI+CXCyMK7kjDrN99Hpl2Gt1rKm1etA87+b4ETJigCDftkcrlusa8nytQZgR3JkqOBeXR
 suoE0wPZR9LcsSQBhRJUPpIS8QKBNZ/3soIRaoGM8eIlNxOpXSNIdmRyCNjbTFaUgzNlnXT0I
 LZyD2BNS76rWgtLSbCfZ4O1udTThhW0eOUMwkJowYF1zMvT2LIm475apOvZNEadi0OngT3ZHX
 lr6lBi3JwJNfFLNKnSyAKX03Ikr76G90UlyterP0ZCRdGfp1H3uJnZqmK5IyuFil7sfURNLsJ
 n73vFYFnyKQu2D4CFv6FxJC1jYGIwjXlxoOvDDnkODxHnbULZVe57Otzxy/KMKioVaq8KTcCp
 lUEPeML0L4KV4l8UrIjBQE9Fr6lE6uJARoug3U1bRl3jrD/qsdhM1t77t1MgiPr1J882CCB0o
 GI+MIWeQ2JUA3V4c/SKYnw/8hBkdjTtFapLivEkOnyGxPPYU3cnKfuOndHtGlPjnUcZ650V28
 fhFIAZP6ksW2XneyOOU3iAYox6U5aRzvuexvN0DjYlVRzqTTVdPZw//U8uyXXIihcBArrtxRd
 IKhGRLaYjevmWJYzfUy7uL40oN9dLMOUyBwMETE5V1TfoxewFJnLKlY5LSc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason venit, vidit, dixit 12.12.2017 23:26:
> 
> On Tue, Dec 12 2017, Randall S. Becker jotted:
> 
>> -----Original Message-----
>> On December 10, 2017 4:14 PM, Ævar Arnfjörð Bjarmason wrote:
>> Subject: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make rules
>>
>>> Replace the perl/Makefile.PL and the fallback perl/Makefile used under NO_PERL_MAKEMAKER=NoThanks with a much simpler implementation heavily inspired by how the i18n infrastructure's build process works[1].
>>> The reason for having the Makefile.PL in the first place is that it was initially[2] building a perl C binding to interface with libgit, this functionality, that was removed[3] before Git.pm ever made it to the master branch.
>> <big snip>
>>
>> I would like to request that the we be careful that the git builds do not introduce arbitrary dependencies to CPAN. Some platforms (I can think of one off the top, being NonStop) does not provide for arbitrary additions to the supplied perl implementation as of yet. The assumption about being able to add CPAN modules may apply on some platforms but is not a general capability. I am humbly requesting that caution be used when adding dependencies. Being non-$DAYJOB responsible for the git port for NonStop, this scares me a bit, but I and my group can help validate the available modules used for builds.
>>
>> Note: we do not yet have CPAN's SCM so can't and don't use perl for access to git anyway - much that I've tried to change that.
>>
>> Please keep build dependencies to a minimum.
>>
>> Thanks for my and my whole team.
> 
> I think you should be happy with this patch then, and it doesn't add any
> more CPAN dependency than before, and sets up a framework (as discussed
> in [1]) where we can use more CPAN modules while not requiring packagers
> such as yourself to package CPAN modules.
> 
> However, it doesn't sound believable to me that even on NonStop you
> can't install any CPAN modules whatsoever.
> 
> That would also mean that this patch doesn't work for you, because it
> means that you either don't have anything resembling a hierarchical
> filesystem on which git can be installed in the first place (in which
> case it wouldn't work), or perl doesn't have an @INC to search through
> perl libs on on NonStop. What does:
> 
>     perl -V
> 
> Return for you on that system?
> 
> If this patch works, and if at the bottom of `perl -V` you see some
> directories which you could write a package to drop some static *.pm
> files, then you can grab a *.tar.gz from CPAN such as the one for
> Error.pm[2] and arrange for the *.pm files contained within its lib/
> directory to be dropped into one of those @INC directories.
> 
> It may be that some aspect of the CPAN toolchain is broken for you, or
> even ExtUtils::MakeMaker, but you typically don't need that to package
> non-XS perl modules, certainly not any of the ones we've discussed
> possibly bundling up in git.git on-list recently. As a (very occasional)
> contributor to perl.git I'd be interested to know if that's what you
> mean is broken, and if so see if it could be fixed for you.
> 
> 1. <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com>
>    -- https://public-inbox.org/git/CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com/
> 
> 2. https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/Error-0.17025.tar.gz
> 

This patch (currently in origin/next) makes a ton of tests from our test
suite fail for me on pretty standard systems (Fedora 27, CentOS 7.4.1708).

Is there anything I'm supposed to do differently now to make our test
suite run? If yes then a clear and short hint in the patch description
would me more than approriate.

Michael

Test Summary Report
-------------------
t0090-cache-tree.sh                              (Wstat: 256 Tests: 21
Failed: 1)
  Failed test:  10
  Non-zero exit status: 1
t2016-checkout-patch.sh                          (Wstat: 256 Tests: 14
Failed: 12)
  Failed tests:  2-13
  Non-zero exit status: 1
t3701-add-interactive.sh                         (Wstat: 256 Tests: 44
Failed: 25)
  Failed tests:  2, 4-5, 7, 9-10, 13, 16, 18, 21-25, 29
                31, 33, 35, 37, 39-44
  Non-zero exit status: 1
t3904-stash-patch.sh                             (Wstat: 256 Tests: 8
Failed: 4)
  Failed tests:  3-6
  Non-zero exit status: 1
t7105-reset-patch.sh                             (Wstat: 256 Tests: 8
Failed: 6)
  Failed tests:  2-7
  Non-zero exit status: 1
t7106-reset-unborn-branch.sh                     (Wstat: 256 Tests: 7
Failed: 1)
  Failed test:  5
  Non-zero exit status: 1
t7501-commit.sh                                  (Wstat: 256 Tests: 66
Failed: 2)
  Failed tests:  7, 39
  Non-zero exit status: 1
t7514-commit-patch.sh                            (Wstat: 256 Tests: 3
Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t9001-send-email.sh                              (Wstat: 256 Tests: 151
Failed: 111)
  Failed tests:  4-7, 9-10, 12-13, 15, 17, 19-26, 29-31
                33-39, 41-43, 45, 47, 49, 51, 53, 55, 57
                59, 61-68, 71-94, 97, 99-101, 104, 106-108
                110, 112, 114, 117, 119-133, 135-145, 150-151
  Non-zero exit status: 1

