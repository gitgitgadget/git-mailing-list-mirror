Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9B21F859
	for <e@80x24.org>; Fri,  2 Sep 2016 07:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbcIBHOC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 03:14:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:53193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbcIBHOB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 03:14:01 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LzKyn-1b22L32oDJ-014WTN; Fri, 02 Sep 2016 09:13:52
 +0200
Date:   Fri, 2 Sep 2016 09:13:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/34] sequencer (rebase -i): add support for the 'fixup'
 and 'squash' commands
In-Reply-To: <1472746749.4680.33.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609012009070.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>   <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de>  <1472718808.4680.19.camel@kaarsemaker.net>  <alpine.DEB.2.20.1609011658300.129229@virtualbox>
 <1472746749.4680.33.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:V/ln7U6viy9SsE+96l/gXkk54Wl419PfdCuEzy5L0uBC7KkhMnC
 wVsPQu17HuXoapFBuX8xWb6vxOGpxDQmaXIJNZpfjMqRZKNsU31tAf7lYiEiLXs9OesgQvL
 TQPCRjRECq9oOBqyw4LFkUNW8DpAjJnAj2RKeZbH7eCr3vgl9E7z3QIXFh7gsiK+Yi/VWfS
 v4ZteSEPojKMCy0/keMeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8StozAlYsAY=:JMAYwcZv1AeL8QE+e5mLHr
 ZyUDImC6rqGDUaMy/XafwS9SNbciVHzkjAojVlPR83lNQhfzDpB3Rg5WVaIKYuF8aKqX28bUO
 XmaRIVDP1erYmTUNaoQd7gqqY/GDWpWYISZOmioBpt2G1tXnBnULoxVkSeswKvFIeu4Dv0frt
 yopz9keBImPyZttZtRu6tsFpJple4zzeAFII/rh/K9ntRRzx6ejREXXRqPQrTn3J38WAuTaIA
 XE1DIHqJjQD2IsKyS87CQJFOzmRK4/lD9e2vQQPetS2M0le7L6LaHaNsP1pCoLhGxPV1ArCNC
 xcvZP25Zixvf/+JcWE3Oa/8CIPm7avwF8S7shhbC+eT/RPRtX1l1MzAtzeRYL5g+Jm6dnTDoZ
 znv3GI70uAPAIhS/6kQlOU9VBZd+YTiMpRJavTTg//cAPfLLmgRTz3DaF6lpwZnyl66nW/IMV
 RgInIELwmx8yYEfB6PCmwdXTsiVCgp6zX9wUKxVJAXPewl6TFZQmvvmWTTbj+CS08Fjp5R3Yc
 tRcURyIss8SUxru+EN95cJVOKuPXCvdlohpxJUfwbZ0la0S0iXQjul36AEte7jTED3fttnDU7
 Np9g55J+Pm5/bXugrjel76dsSrrWwheSbZ6RSnEgIjKHXhLL+Rtt7W0w6A+pAu4urF8/4JJg8
 54gdZ3UuMBX/WrARsiQhpf11Px7BO1lyM3f+8eLwojDNCQSZobYfTg2FseeJFgEINsfLchx13
 riAm/2IPSJGtHXwSUdF3wjxJ05qm+F1fy6S3BCOk42kK1ocmr2mdebj/WaOP857tQiDuLktpk
 uME3qo2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Thu, 1 Sep 2016, Dennis Kaarsemaker wrote:

> On do, 2016-09-01 at 17:17 +0200, Johannes Schindelin wrote:
>
> > And I see that the beautiful ordinal computation was given up in favor
> > of a lousy "#1", "#2", "#3", etc (it used to be "1st", "2nd", "3rd"
> > etc).
> > 
> > In any case, translation is not my main concern until v2.10.0, so I'll
> > take care of this after that release.
> 
> Hmm, not sure if I agree with that. I'd see it as a regression to lose
> the i18n there.

As Git for Windows does not ship with translations (for multiple reasons),
it would not be a regression.

Having said that, I see that having a different text than the current
rebase -i can be seen as a regression, so I changed that.

Thanks for the review!
Dscho
