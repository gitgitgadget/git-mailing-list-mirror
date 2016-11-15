Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87CF2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 21:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933803AbcKOVkm (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 16:40:42 -0500
Received: from mout.gmx.net ([212.227.17.22]:60902 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752308AbcKOVkl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 16:40:41 -0500
Received: from [192.168.178.43] ([88.70.147.72]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0ML6XF-1c6UU42xwP-000J0j; Tue, 15
 Nov 2016 22:40:33 +0100
Subject: Re: [PATCH v15 01/27] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <xmqqvawd7mnr.fsf@gitster.mtv.corp.google.com>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <20ffa616-765d-ef73-4133-977561105eff@gmx.net>
Date:   Tue, 15 Nov 2016 22:40:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqvawd7mnr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:lt/bGUf4l9rbmN74q/1AyDrSgYh4dz/Dv/Hx2TmaCy2D1O6Xy5M
 suByru3ZtJSebHBbjSGqos+xYmrfArg4MhGelQR4JXF8H7KOjQGQJItvmMiUXBOUCug1vKO
 M+fAfbUcg5bgxrlTishq+VL1NxEf+Q2CHpikPS7c7BrOb9wDLDBDzLE+JjB8RVPN96mLkKk
 zHE9ViMS6mUrvWeUZp7dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fEuxJxh5JyY=:QMk7lAXwBmT/c9NAsJj3JU
 Pg78JS61GGu9gSD+XyHTeENwXoRhHAPhcKDPwftZbAUYKRJfPblSg3SfLYreq6G7rBScGa2Ne
 lPSsN69hD0ojiOMKyLVUy8NKk5tzpWkUqkZ/BKPK029dF5fNNjghOFQNTppxUQdvW9WUwkNIR
 oFSTIUGbeQ99qTx2vcvW/EgbZtRBTNEglAp3eEHX8h5PfZiMv1Rd4khQU/oaqnjngeR6OkSNR
 ntFhVdsVst4DDlN3GjtBpp8vgAzRoIdLQcqPXMBMjUzAPBQ6PQtux8zPbpMogSs4jW6aJpbAy
 XWMlB+cj+WSMT3QcMeb/n85QNXPtohMJaXzcPHidfPgOaffhnkM1N18N23Ytx7teH2Y1FTLoC
 mw1WhnBhmaT4S301BFvVXjW98xSngVGrCKneRczL6qvRQeKiO7oI/4h3Lpo0m8HBNM66NW10g
 1Qd9o3TSHnfGiOTr4SnamjmjN9GU85dGUH0D1m32U6L2bKg8EjduI6fygQ5rsO0KSVuRgMKcz
 c25uMpHSyC0Z+xDoQnv8mWqbghMNbOm7QCfBaSZT+zZB0rYB3Ysvm+xkk40dlOPsI+bn5Nz7v
 3BrvR1bg8TzJtJUeLqA/o61ON4AOJlWhw85R/Qq9cB0g5H8HIHTqfeZ4rSIB/rV17gt+4qxxF
 cH9Vg9gFN3iH9JnTrA+7DCa8zGTaLTYFoZuCXowLoTUQtpBcWDOESepLslVwwLHayAnxyMAdY
 ptPWZ8DdB0O9MVP5vdpPZ//9r72tpcs/g5hoEBjquEBxWUAuc7T9UQn4WSXcpQI37cv2M++fp
 uQF8zee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/27/2016 06:59 PM, Junio C Hamano wrote:
> Does any of you (and others on the list) have time and inclination
> to review this series?

Me, currently. ;)
Besides the things I'm mentioning in respective patch e-mails, I wonder
why several bisect--helper commands are prefixed by "bisect"; I'm
talking about:

	git bisect--helper --bisect-clean-state
	git bisect--helper --bisect-reset
	git bisect--helper --bisect-write
	git bisect--helper --bisect-check-and-set-terms
	git bisect--helper --bisect-next-check
	git bisect--helper --bisect-terms
	git bisect--helper --bisect-start
	etc.

instead of

	git bisect--helper --clean-state
	git bisect--helper --reset
	git bisect--helper --write
	git bisect--helper --check-and-set-terms
	git bisect--helper --next-check
	git bisect--helper --terms
	git bisect--helper --start
	etc.

Well, I know *why* they have these names: because the shell function
names are simply reused. But I don't know why these prefixes are kept in
the bisect--helper command options. On the other hand, these command
names are not exposed to the user and may hence not be that important.(?)

~Stephan
