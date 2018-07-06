Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C6F1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 12:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbeGFM7B (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 08:59:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:49853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932870AbeGFM7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 08:59:00 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3zG2-1gRjj62jo2-00rWHd; Fri, 06
 Jul 2018 14:58:50 +0200
Date:   Fri, 6 Jul 2018 14:58:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 6/7] rebase -i: rewrite setup_reflog_action()
 in C
In-Reply-To: <xmqq8t6soy2f.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807061457250.75@tvgsbejvaqbjf.bet>
References: <20180702105717.26386-1-alban.gruin@gmail.com> <20180702105717.26386-7-alban.gruin@gmail.com> <xmqq8t6soy2f.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5bDHAybAO/YvEFEitg6uFqA1wMw24vHvOv508Xgx5kpASPQj8a9
 tKoab/uJyczUDRxJbcaab370hBhzrmpmc1GXKmxlgRu8RCoFTawnK1mi9JA4Z25b9TFsQNt
 25zta0xcdKl9Mg+x+sm0wQES1WpJozyptIh/mPEYQcVUsI2P2l/7rENsEJu+BP263TgUhey
 D+w+Wmv6dlWA8xl6hwuPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mNwJehNNLM4=:5P/dJpNGmWPoYUScNpwdbl
 cNlt5ZrSotjewkS7qn9UBibd5+MeUf9I9a4d5ETb0pR2cSRU2lKjE5uA7KHFdvrtOP+Smi2Dx
 2OfayIJSUGef0fs9O5GoF2hbK7yM0eOaawK7afUbPjHl4hD3B/oZhK8DR0iuW1oR3mepySO7G
 id5It8A40DaGT1MK7KKrsEFPEO/NeS97eA9rR9v1pnewfv1sqZnQfIX4yvmnWrfrfLRBFQJy8
 eGifVXKxSZWtrwlyIEghEzi65Xki/401UY1aKD4H09PyWZI6U9dbAVImovk2Y5UInd17KRKUz
 RmN6QUo+pNA6E1xAlOKyuO1qugeGGC3+Sp9n6nWjR0IVdheIlz1bYjzZxgsj5+dbegURKDone
 6muMEM8qQJLjabbjPSOXCGl1TDGOaj/LDARUBT1CSdrenZVgjI3v1VPPpXo0S70Xm7HZJVQkx
 +hZIsmTqr/A0C2f46Lx5irMIPA3XAhE6WKY7cuqwgrXlZaT4rE8DDdXFrWjEIDTFpWfywK4zn
 H5YaD1LDHfp4+HRtLQEjRMVuzs6X4k0p25cXdcKV1lwRLDSZHULxskldtpPSJ7x+fhc/WV4ag
 1oPsV0vbl3GkmfD09dkoWREoeic6uzJU+ZxDU/wqGTgLsBAC45Erg9PbQWfUSylnRPmx8ecVs
 XCHEwf3o2/dGsM2h+8bJ9zQoySfU5LZIUEVW21HkKU+QJbUoiaSrQYQSnomtrJAePiDO0+v3V
 +lkajmBAHRCkzaxvpU3Sx/B6G4lZlrghoAK1nJUUMq3HzOCQpLNKKY2DUvBahWLW3mHk7a6p0
 qFLBS8J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 3 Jul 2018, Junio C Hamano wrote:

> Alban Gruin <alban.gruin@gmail.com> writes:
> 
> > +static int run_git_checkout(struct replay_opts *opts, const char *commit,
> > +				int verbose, const char *action)
> > +{
> > +	struct child_process cmd = CHILD_PROCESS_INIT;
> > +
> > +	cmd.git_cmd = 1;
> > +
> > +	argv_array_push(&cmd.args, "checkout");
> > +	argv_array_push(&cmd.args, commit);
> > +	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> > +
> > +	if (verbose)
> > +		return run_command(&cmd);
> > +	return run_command_silent_on_success(&cmd);
> 
> I thought we made this into
> 
> 	if verbose
> 		return run_command
> 	else
> 		return run_command_silently
> 
> to help readers in the previous round already.

FWIW we had quite a couple of reviews in the recent years which pointed
out "unnecessary else" after returning or die()ing. Maybe we should make
up our minds, and set a consistent rule to follow.

Ciao,
Dscho
