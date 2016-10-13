Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929D01F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 10:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbcJMK5V (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 06:57:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:56049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752940AbcJMK5T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 06:57:19 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MTBLi-1bSTmh2JwU-00S3XY; Thu, 13 Oct 2016 12:50:17
 +0200
Date:   Thu, 13 Oct 2016 12:50:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 13/25] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <xmqq60ox5wxb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610131242100.197091@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <9b2782e64f678ab2d261042b63fafc3e4a519295.1476120229.git.johannes.schindelin@gmx.de> <xmqqwphe8zl2.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610121356510.3492@virtualbox> <xmqq60ox5wxb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aYWg6VAZBGXMdnR7HW3hAjO9FchmfGIJCvE6XAt+fmrgLxxZrB6
 kULNok55YTnPWSm1p9tKwbdsUew7pNAaznEKRSvF/DZd9iLN0kr5wRsn42pySYDKppwgRzi
 FuQvbolQ/KmamjbQd8ulLKfQF6Q/T9xqm7EeLMZZPAQULYXJZx6PA/ACKOoDJKRxnfsQmUa
 0habsGOiYJpNtxIHRQeNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aa/qviEsGRE=:PUjID0GyKpeT+koUbOpcxz
 oqqD1hw99Q77Spt9hzXGqT/tREJBGiRYdsjfznB6PbVidVHEM1uQpCZKiLnzln7DI3lzx56W0
 OQWbnWUR80qTRLQySifo968FH/F5HRTRBDTjRlj/oJcNmzhLdO/OHXJkyTF9I5cF50crf3BhV
 RgsqgPlDxsi8AM0hjEgKqCsp8kXVS5+bvxE0XlujW5HpOirguRt0y1+2/JZgpMavNTSvrysXU
 4zKx/quhwCX+oCud/x/HgoB3Oc5ObpPaEoHykc51T3DVXpeWkiwmQtnhFGkP8n1+iBG8MKm4S
 Z/cWj2qRuPy5XXIHrylXhGDlk7Wvzfm9OK6fyVR1/oHeP8Mrh62ZXPJ/rwwdN0gNIIYPg0FWJ
 ddrZvbGJcceADsnfbcc4Y0KHSy+d1gorGk2/bM1mWI9mjdcQA9crPBytTKoaJC4jwgw5+F6OD
 kn4RI8filqR+5VV0fkRb16VjEPZddq2nvNR/Q0gtLE78aaZkKwshj/DQy47HIGFQbnhu/r8LR
 ElxiA5A54QgUordW7HTwcdIYw7Gbs/VygAU4Ne9QyX/PNX6VOybhVoJb+XL8F6eAoxbMVTyNQ
 rFXi870/CnvD/48+RIvkSEs3mqeUb6x0n+06zcnOADct7/2XpRugdSNPgC2BXL6psiDsnt8QP
 5KtC3KNFu095ge2lrDLA5PA3Si01IUA4nbgkK3D3yjcd777Y0rC9HOdg7hFF3YWV1RbcSAvcT
 dK/j6qY0Tx8YWo0idaIWr+PAd1IIAu+RJ+TS42Wqr7hCiGStL/hi8sK81ylH/FdaeU4owL+jg
 UsBItd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 12 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Hmph, didn't we recently add parse_key_value_squoted() to build
> >> read_author_script() in builtin/am.c on top of it, so that this
> >> piece of code can also take advantage of and share the parser?
> >
> > I already pointed out that the author-script file may *not* be quoted.
> 
> I think my puzzlement comes from here.  What makes it OK for "am" to
> expect the contents of author-script file to be quoted but it is not
> OK to expect the same here?  What makes it not quoted for _this_
> reader, in other words?

The `git am` command is inherently *not* interactive, while the
interactive rebase, well, is.

As such, we must assume that enterprisey users did come up with scripts
that edit, or create, author-script files, and exploited the fact that the
interactive rebase previously sourced them.

Come to think of it, there is a bigger problem here, as users might have
abused the author-script to execute commands in rebase -i's own context.
Not sure we can do anything about that.

But the point stands, if anybody used unquoted, or differently quoted,
values in author-script, we should at least attempt within reason to
support that.

> I am not sure what you meant by "nominally related", but the purpose
> of the author-script in these two codepaths is the same, isn't it?

The purpose is, but the means aren't. As I pointed out above, the
interactive rebase is inherently much more interactive, and needs to be
much more forgiving in its input, than `git am`.

> Somebody leaves the author information from the source (either from
> an e-mailed patch or an existing commit), so that a later step can
> use that pieces of information left in the file when (re)creating a
> commit to record the tree made by using pieces of information from
> the source.
> 
> Are our use in the author-script in these two codepaths _already_
> inconsistent?  IOW, "am" never writes malformed unquoted values,
> while the sequencer writes out in a way that is randomly quoted or
> not quoted, iow, if you fed such an author-file to "am", it wouldn't
> understand it?

We heed Postel's Law: what the sequencer writes is in a very strict
format, but what the sequencer accepts need not be.

> I fully support your position to use different codepaths, if the
> file that has the same name and that is used for the same purpose
> uses different format in these two separate codepaths and the users
> already expect them to be different.  We obviously need to have two
> separate parsers.

Well, traditionally we *do* have separate parsers. I do not say that we
need to keep that, but given what I said above, it might not be a bad idea
to keep the lenient parser required by `git rebase -i` separate from the
one used by `git am` so that the latter can be faster (by making
assumptions the other parser cannot).

> But if that is not the case, IOW, if "am"'s author-script shares the
> same issue (i.e. "'am' initially writes the file properly quoted,
> but this or that can happen to change its quoting and we need to
> read from such a file"), then perhaps sharing needs to happen the
> other way around?  This patch may prepare "rebase -i" side for the
> "this or that" (I still do not know what they are) to allow the
> resulting file read correctly, but the same "this or that" can break
> what "am" has used and is in use there if that is the case, no?
> 
> What makes it OK for "am" to expect the contents of author-script
> file to be quoted but it is not OK to expect the same here?  What
> makes it not quoted for _this_ reader, and doesn't "am" share the
> same issue?

The fact that `git am` is *non-interactive*.

Ciao,
Dscho
