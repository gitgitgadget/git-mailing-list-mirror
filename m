Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5AA9201A4
	for <e@80x24.org>; Tue, 16 May 2017 10:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdEPKXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 06:23:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:51171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751730AbdEPKXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 06:23:06 -0400
Received: from virtualbox ([95.208.59.249]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MV5hN-1dVhxi1Hwr-00YRxw; Tue, 16
 May 2017 12:23:03 +0200
Date:   Tue, 16 May 2017 12:23:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Rannaud <eric.rannaud@gmail.com>
cc:     git@vger.kernel.org, Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
In-Reply-To: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705161220230.3610@virtualbox>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:N8n3uqgnh/LyyKOVMda2qevh9fGvap2IWmj9aexRQzGaSfrlFZ6
 +CxP9WQ8dQHc4NgRIzp5QOuzllifrMHp7SQa7RlLSqfGCpj0Zf2a4IKF22ZxvxDu48MfseG
 j1lSzgU05I02oYIdhQOKTQR0vVcE7jVN3rqoM5Cu4TEqNNUNEg48HlkVxYq+LA6L8xjaeCD
 efYIQG/HC+0cXcPpQxKUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l4louhmyA1U=:e06edu19Hj5sqq3PSIRrsT
 Y7iu+tepsM2zzW24ehX4kVdJlWhCwGmFWtmSVSDh42yoA1RpT+uf3fQpHFbk9aLCoqG1nfdKR
 57sHovQmLTsxhqxp2PKCkToYMgVtqMfDZfe4du1MaBpJqkQ5vbk1W0fL69zE3V2IMOv7WrHR6
 +Tu9vIwI/4NLSSz7F+XMhbHs6v1ppoFLVs6sck+clL9CkUPkWEyT1RmZcye7Zh42eKD0EIWKj
 pbFL+gX+IcKj+7j2N+MWovxbgCuHo5Kgv8wn8RdNlLNwvC9K81yeJbXUJAkA+M0TgbNTj81zP
 n4HIBSPLLicX+i7SW1Mh48TcnAXkcz5haoMYW5sasdVeLQtdiMZ+Fs9DYWmqgmlhqtG7ffhjO
 GHLA0uAC5w41qZmejRNR9zJeG4UaiHpjwThV/GbFykFMFOTbECHA8vrG2qCgZmQJYn0mxdAMT
 Ymn66LDcc+v2k2E6VjTFF03xyoCjeVGjyp5lidWbQWQ/C25jPaS0beMue7MOUgoIQSeLvAZBL
 MuLnj3c+bAggf+RNscH9g8Ze1ysRgHtsZMLj3zs+rwlQl08A0G+6Ru/YSzKVYXi0OIoohEMUK
 f6LuzOipCyaKWr3I6wFCpTIVRGz28eNVuBMJGFzWZ+92OMV4Wg4eTdRP0v/niE0wTuaNHRjEA
 YnYLjfzFcuQ320tJv2+CFwKXpq2ah2WABcM8znBv0paYSWtKYuxs9scgRPvADJ1Nj0QBeNQ/1
 gbgvWVy8YZPtOa/yp390XEnwIm6w3cPFCAP/Eu1ULyAR+1cQkJf3Rk276lWR7HIc+BDNQiGhJ
 wSY+dWs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 15 May 2017, Eric Rannaud wrote:

> It used to be possible to run a sequence like:
> 
>   foo() { echo X; }
>   export -f foo
>   git rebase --exec foo HEAD~10

It would appear to me that you used a side effect of an implementation
detail: that `git rebase -i` was implemented entirely as a shell script.

In my mind, this was a fragile assumption, and that is why...

> commit 18633e1a22a68bbe8e6311a1039d13ebbf6fd041 (refs/bisect/bad)
> Author: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date:   Thu Feb 9 23:23:11 2017 +0100
> 
>     rebase -i: use the rebase--helper builtin

... this commit, which is a long-overdue start of cleaning up our act,
broke your code's assumption.

I am afraid that your code placed too much of a dependency on an
implementation detail that changed.

In short: I think that your fix to your script is correct.

Ciao,
Johannes
