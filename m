Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDF11F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeFZVr2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:47:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:51497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751616AbeFZVr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:47:27 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtDpH-1gHlJq0mD5-012pl8; Tue, 26
 Jun 2018 23:47:21 +0200
Date:   Tue, 26 Jun 2018 23:47:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 2/2] rebase-interactive: rewrite the edit-todo
 functionality in C
In-Reply-To: <20180626162143.31608-3-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806262346540.21419@tvgsbejvaqbjf.bet>
References: <20180613152211.12580-1-alban.gruin@gmail.com> <20180626162143.31608-1-alban.gruin@gmail.com> <20180626162143.31608-3-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NktzEGAZldrXHexRYLfZl1IBvByO1imGTDfrc7pYVR80O7KGOup
 pSWQVK7xUFnOCKc+bQYvKKbNpBt0By4RG72mmU1hNUl8Xok7QT522q5a3qaCU9bgCSdqRSt
 ZjRRreHfdgq0EEneJAd6r8SZFucd8r76vA4b+1DLehW0YhFOwwPGALTylYPJxJqxJUri8dw
 x+1aJpxAxyg7eEbs/NRKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HMty8mgXYY4=:xlrWTjqGIGg9bU1OcvdA0i
 1+iHAdj8MclOM6cLMvysNZ7Z6PMBdfWoxKV17aIofikKxiVg2zIw2HNmLaBCos8Fu4+vWiX5J
 hio/LjT1+5jM/bhK5KkrFzIwHEPp5e6sptX+Q0JHuL0c3C/fYCSjupjMlRYXEWMZkeIDewrZc
 Ocn5Pt0VMVqmxvvgSy7brg+RmuouIQRDghL/nuT8oAYq3laK7ewoWZLTY2FpgX04qsxuWZWk3
 eayyu8soEtd61h25Y4Wt9bDaM78hNEWFC1El712nRauY34hy7pR8VQYvT6t4+j9MUM+htedDU
 UInYXiAINuEzdsnY6YqeFFNwGOejTkDRGsyp+R6v26gXesHdLN9YJ+qANCeBuexn/DmyAEkuN
 iOWgDVB1Fbfu8wo4k1ojImJP8jyOjUbCOkqiwbnmjS71qR3flWBV02/r69kOr+5F5oah7qO4M
 MLZ5BxxpBBmb69ItLeqJyKxQvJhRKlmhXRcptHOICe3GkfMtVQqPLyfh2eHO4w04LI2h/tP24
 uzA3TQyJF74bBil+nDZrC5bNrfcUlOtaxOT5wycTZr3gM2bFKBS0P+CgAcui7sOQ2N/7h6IN/
 xYg6wCUSF+NnUXF18xJu8oVPfw0lhVi+SaAPi6J8kBooOo5BfOuXaLtyPPQ5AOkPaYnhHdPb+
 TKyv53EKKjLn/sUKxCSovSTKGxSEPooQhB1zvF4iMQ8KKVsG+TEO2JhvAL9lZSwdZaswqSjLk
 dGapBhr3GDbwUPkTBtdHuR05h7QJIv+hTBTJOXXN9HIDuNewAM9Uof9OgW0UX5bcgs6QHvsaM
 ORxV/Au
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 26 Jun 2018, Alban Gruin wrote:

> This rewrites the edit-todo functionality from shell to C.
> 
> To achieve that, a new command mode, `edit-todo`, is added, and the
> `write-edit-todo` flag is removed, as the shell script does not need to
> write the edit todo help message to the todo list anymore.
> 
> The shell version is then stripped in favour of a call to the helper.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>

Both patches are ACKed by me,
Dscho
