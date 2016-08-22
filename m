Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9BE2018E
	for <e@80x24.org>; Mon, 22 Aug 2016 12:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbcHVMsd (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 08:48:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:63233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbcHVMsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 08:48:32 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MWPOI-1bdM7p0T4E-00XYi4; Mon, 22 Aug 2016 14:47:11
 +0200
Date:   Mon, 22 Aug 2016 14:47:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Ben Wijen <ben@wijen.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not inherited
 by child processes
In-Reply-To: <xmqqbn0o4uq2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608221443170.4924@virtualbox>
References: <cover.1471437637.git.johannes.schindelin@gmx.de> <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de> <20160818173555.GA29253@starla> <xmqqshu14udc.fsf@gitster.mtv.corp.google.com> <20160818224814.GA10341@whir>
 <xmqqbn0o4uq2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yZqsuiFlwGivgJObHdKNwca0fVfQoyNier2QWGtaAQmnZGsT7na
 cyPPw6HDrcU3/uPq4dwlKq0M/eh2ODXOTk/OHiozeOBocJ27vW0Tx1kNRLXKuvHzn6vCRiJ
 btKCalI4dMGQqIm1k5WyJ5Vd3agu2dbJFNKRI1nXAVtHExLXownsFouzwvTIRBulgt05Rr8
 Ghe4h6+gzE75WJ6nljYqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dbogRLvcCQM=:uKI7gEROFdSf9eF6O36jwk
 ds44uoYUX2EQC0ZOZJSZ0lBS9M0E6di7CRugtTBYFNoMM1bWjUFX4QsNRjx2FrKdvMhRjpxBz
 Qy1p/SCtFzPF3OkIZteEO3ezyg0kuRrAbSTCCqouwk+lyE9O/Fg/Wb2mIgBsJvShjVel4rI8L
 Fbxi3r7zoOhdz+sTljgzXl5LsSbJU1YuXO3uaXALRJt6Gr4beUpis6Y8qv52X/+t5uTGseHEf
 7Ui+1ATjjz/9dBtqiIm7h+Pxc36WRkggsfxGSsxwqp89Le8t9IXdfInhz2nfHoJqZai5ju/IY
 nhjeaogVqa2hHRjPO41SMvMuERy/XxNMrZ5gyrF7T47SvgiRSiPYqO7pmEaguQSL9ybQrGRHu
 1OXy9ip5HUQg/YAfxPaGhiM2PdV38ZDsR8Hf2JQBlletRDH8EqcrvqO+5l5xHriuD5w5wql1h
 Bl/dQ2udjCxkaugWN7U5m/dME60WjFEudXPgvrjzskiZ9bbHEECFxFA7+eHLMuveZu0w6MS50
 PiB4u6960xc3YPBY5m7KQXutzWCtWDoLgmezbUJz9cRmggmlFcjiX3FPyCg7NNcftfmR1qE8q
 BM4HJqHjBILc8vpRyQHF7EA7vDHyLuGILzK2+93B8D1tQP4/zRGDMQSsCnSKOqw4drDq4eSFK
 dsleg2+zsxPhxg0K8YckUUEzkDgd9jTyY3YrHNJRFfncFQwPBXbg8KHnGONiN1qBrWJT3tKCd
 LpLVKO1RBcnbRNb4anks68nYW4Gu+JrQCaOE4tLpPxbh5z7nz2xahC5Rx+zDTd4bw39rlifKt
 9NBAONe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 19 Aug 2016, Junio C Hamano wrote:

> Eric Wong <e@80x24.org> writes:
> 
> > I'd be more comfortable keeping the EINVAL check that got
> > snipped in your reply.  O_CLOEXEC can be defined to non-zero in
> > new userspace headers, but an older kernel chokes on it with
> > EINVAL.
> 
> Good point.  Thanks.

I tried to accomodate both of your suggestions by defining O_CLOEXEC
in git-compat-util.h unless defined earlier, and by handling EINVAL via
dropping O_CLOEXEC in a second call to open(). Please inspect the
interdiff of the upcoming iteration.

Ciao,
Dscho
