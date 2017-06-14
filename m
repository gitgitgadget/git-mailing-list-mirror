Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F4BA20401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbdFNKU5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:20:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:57171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdFNKU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:20:56 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbyUS-1e4Lmh1ChI-00jHAh; Wed, 14
 Jun 2017 12:20:43 +0200
Date:   Wed, 14 Jun 2017 12:20:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 6/6] Use the early config machinery to expand
 aliases
In-Reply-To: <xmqqk24f97ud.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706141219260.171564@virtualbox>
References: <cover.1497355444.git.johannes.schindelin@gmx.de> <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de> <xmqqk24f97ud.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JDNgkP2UOJd/PR2i+1XTW6tZ7IAnK3crNrXgpNEEBa2UUih9GMG
 igEZ29AnYv68ZqBvFRfeUxke/d2gW3bgNse80IgWA+aqfJ/29Miw+dHVhdqE+oIeeIIwWCd
 LZ9MDZn1WPxxsJnArr4avRrOGQAfuX532RI6t+6eHbsAHULViv1q5Xv1wPhwp5KFGdw37xd
 4w5n1kZGfC4cA8cNmgp9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hW4Ko123S9Y=:vsS+m1Zyx2x89ZCQJeS6rU
 uyqfJxjJ5pod86yo+u0H/Zu5jSH/JzR2j/cNyXr9yjbUTJEnUXpvxRo6CkScIwBI0DOipcGqi
 Ke/BlkxG6/ZgSBUv3zP3fVJXSLz0LSlHCT6aURRWRRkzR6w2TJlgiP+4TM92H8rmm/fbn8BrG
 YWubWV5lJquwVE9E/05lJ9W6mN+44uFTw871Tnfq1z14S5UTNr5+yXeBrVBetUKav7XtFYPTP
 6Fh2ODpx9ak1pU858Oi4itW1m9RJpHn6w2GniIEhBAFat/M+e1+NmjPsk+mi1erLXFqSUu1I1
 vFlJ9F5VzCa5wDKoVO6LzJ4C1DB558bIXhKtZU2K8PMaMvN4CPdO707saxNzze7ABsQ1L1ZGG
 /cpGYoik6uT5EEskxOF0biXt5gNSDldwUEMC+5+g2W+d86rr1lgdErXUdqSyHBTjCR6o1mGKs
 C88+/EWnpngbuDg7DB/h3Ene4dVd6ttQts/WdELRqdWwrDZgvaeFM1vWCgRqFXjsLDHLsgXBG
 T7SBB4Q+/ljwed9++/DdhqE9ya4wbjj3kTctIwQKAqEAA0jxG+Raojq6TIddYDkwpnAvqo1Wd
 +4eH6QPYXFKSLGzcuE7gX6xQNAE3PV+PYlpVzi85Ez1M+WuOwOQPDBBAZFCBlGrzB+FZnshdP
 qYMfIhu975/Dy3OrGwfiP+AjEB3z+EuRk65hDHUXJa3Tl+WI4l6JDn0MjAC+d4biB5PPGMpt6
 oifSS1rEd3yQAf3QPBJ2E8KBF4xKmTGNysBUbd5JczbpWLJ7j5+Ux3fXawT22BQqVf1HUqBDu
 qutWI/M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Jun 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Instead of discovering the .git/ directory, read the config and then
> > trying to painstakingly reset all the global state if we did not find a
> > matching alias, let's use the early config machinery instead.
> 
> s/read/&ing/, I think.  My reading hiccupped while trying to figure
> out what two alternative approaches are being compared.

Whoa. Brainfart on my side. Sorry.

> > Also, one might be tempted to streamline the code in alias_lookup() to
> > *not* use a strbuf for the key. However, if the config reports an error,
> > it is far superior to tell the user that the `alias.xyz` key had a
> > problem than to claim that it was the `xyz` key.
> 
> The mention of "streamline" is puzzling to me.  When we are trying
> "git xyz", "alias.xyz" is the key we would look up, not "xyz"; it is
> not clear to anybody who didn't read the discussion on v2 (which
> includes the readers of "git log" in a few months) what kind of flawed
> streamlining could look up "xyz" and result in a bad configuration
> reported on it.

As I changed it (thanks for pointing out my mistake to assume that
skip_prefix() has to change the pointer passed as first parameter), this
paragraph is now gone anyway.

> >  alias.c          | 31 ++++++++++++++++++++++++-------
> >  git.c            | 55 ++++---------------------------------------------------
> >  t/t7006-pager.sh |  2 +-
> >  3 files changed, 29 insertions(+), 59 deletions(-)
> 
> Happy to see the deletion of all the save/restore-env stuff.

Yep.

Ciao,
Dscho
