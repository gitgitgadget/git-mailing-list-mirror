Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F2A1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 11:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeCFLpQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 06:45:16 -0500
Received: from mail.javad.com ([54.86.164.124]:51418 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFLpP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 06:45:15 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id EBFC43E939;
        Tue,  6 Mar 2018 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520336714;
        bh=W5iNxSQULK7QyNc9g1WY8L86Htl0Av+c+Ey8qj0RG4o=; l=1586;
        h=Received:From:To:Subject;
        b=Ldh5F1p4OwN021Y6CeuiziQx2KRxpZmSZY5q/fHae2drA4vRoGaybkUbYjX2wCj4v
         IUfGF/pu16Nve1vpoqIM9QJBLLJLOSrLb5az+FOMX/k8QomI7buYLkiBZkHn7QW4KA
         cDzcMTMYztcWgSvxwmVb5v6Vg4a3DzGK4iv7Hs14=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520336714;
        bh=W5iNxSQULK7QyNc9g1WY8L86Htl0Av+c+Ey8qj0RG4o=; l=1586;
        h=Received:From:To:Subject;
        b=Ldh5F1p4OwN021Y6CeuiziQx2KRxpZmSZY5q/fHae2drA4vRoGaybkUbYjX2wCj4v
         IUfGF/pu16Nve1vpoqIM9QJBLLJLOSrLb5az+FOMX/k8QomI7buYLkiBZkHn7QW4KA
         cDzcMTMYztcWgSvxwmVb5v6Vg4a3DzGK4iv7Hs14=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520336714;
        bh=W5iNxSQULK7QyNc9g1WY8L86Htl0Av+c+Ey8qj0RG4o=; l=1586;
        h=Received:From:To:Subject;
        b=Ldh5F1p4OwN021Y6CeuiziQx2KRxpZmSZY5q/fHae2drA4vRoGaybkUbYjX2wCj4v
         IUfGF/pu16Nve1vpoqIM9QJBLLJLOSrLb5az+FOMX/k8QomI7buYLkiBZkHn7QW4KA
         cDzcMTMYztcWgSvxwmVb5v6Vg4a3DzGK4iv7Hs14=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520336714;
        bh=W5iNxSQULK7QyNc9g1WY8L86Htl0Av+c+Ey8qj0RG4o=; l=1586;
        h=Received:From:To:Subject;
        b=Ldh5F1p4OwN021Y6CeuiziQx2KRxpZmSZY5q/fHae2drA4vRoGaybkUbYjX2wCj4v
         IUfGF/pu16Nve1vpoqIM9QJBLLJLOSrLb5az+FOMX/k8QomI7buYLkiBZkHn7QW4KA
         cDzcMTMYztcWgSvxwmVb5v6Vg4a3DzGK4iv7Hs14=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520336714;
        bh=W5iNxSQULK7QyNc9g1WY8L86Htl0Av+c+Ey8qj0RG4o=; l=1586;
        h=Received:From:To:Subject;
        b=Ldh5F1p4OwN021Y6CeuiziQx2KRxpZmSZY5q/fHae2drA4vRoGaybkUbYjX2wCj4v
         IUfGF/pu16Nve1vpoqIM9QJBLLJLOSrLb5az+FOMX/k8QomI7buYLkiBZkHn7QW4KA
         cDzcMTMYztcWgSvxwmVb5v6Vg4a3DzGK4iv7Hs14=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520336714;
        bh=W5iNxSQULK7QyNc9g1WY8L86Htl0Av+c+Ey8qj0RG4o=; l=1586;
        h=Received:From:To:Subject;
        b=Ldh5F1p4OwN021Y6CeuiziQx2KRxpZmSZY5q/fHae2drA4vRoGaybkUbYjX2wCj4v
         IUfGF/pu16Nve1vpoqIM9QJBLLJLOSrLb5az+FOMX/k8QomI7buYLkiBZkHn7QW4KA
         cDzcMTMYztcWgSvxwmVb5v6Vg4a3DzGK4iv7Hs14=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520336714;
        bh=W5iNxSQULK7QyNc9g1WY8L86Htl0Av+c+Ey8qj0RG4o=; l=1586;
        h=Received:From:To:Subject;
        b=Ldh5F1p4OwN021Y6CeuiziQx2KRxpZmSZY5q/fHae2drA4vRoGaybkUbYjX2wCj4v
         IUfGF/pu16Nve1vpoqIM9QJBLLJLOSrLb5az+FOMX/k8QomI7buYLkiBZkHn7QW4KA
         cDzcMTMYztcWgSvxwmVb5v6Vg4a3DzGK4iv7Hs14=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520336714;
        bh=W5iNxSQULK7QyNc9g1WY8L86Htl0Av+c+Ey8qj0RG4o=; l=1586;
        h=Received:From:To:Subject;
        b=Ldh5F1p4OwN021Y6CeuiziQx2KRxpZmSZY5q/fHae2drA4vRoGaybkUbYjX2wCj4v
         IUfGF/pu16Nve1vpoqIM9QJBLLJLOSrLb5az+FOMX/k8QomI7buYLkiBZkHn7QW4KA
         cDzcMTMYztcWgSvxwmVb5v6Vg4a3DzGK4iv7Hs14=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1etB1r-0007dT-JS; Tue, 06 Mar 2018 14:45:11 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
        <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
        <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
Date:   Tue, 06 Mar 2018 14:45:11 +0300
In-Reply-To: <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net> (Phillip
        Wood's message of "Tue, 6 Mar 2018 10:45:27 +0000")
Message-ID: <87r2oxfmwo.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 03/03/18 00:29, Igor Djordjevic wrote:
>> Hi Phillip,

[...]

>> 
>> The only thing I wonder of here is how would we check if the 
>> "rebased" merge M' was "clean", or should we stop for user amendment? 
>> With that other approach Sergey described, we have U1'==U2' to test with.
>
> I think (though I haven't rigorously proved to myself) that in the
> absence of conflicts this scheme has well defined semantics (the merges
> can be commuted), so the result should be predicable from the users
> point of view so maybe it could just offer an option to stop.

Yes, hopefully it's predictable, but is it the intended one? We don't
know, so there is still some level of uncertainty.

When in doubt, I try to find similar cases. There are two I'm aware of:

1. "git merge" just commits the result when there are no conflicts.
However, it supposedly has been run by the user just now, and thus user
can amend what he gets. That's effectively a stop for amendment from our
POV.

2. When rebasing, "rerere", when fires, stages the changes, and rebasing
stops for amendment. For me "rerere" behavior is rather annoying (I've
never in fact amended what it prepared), but I always assumed there are
good reasons it behaves this way.

Overall, to be consistent, it seems we do need to stop at U1' != U2', at
least by default. Additional options could be supported then to specify
user intentions, both on the command level and in the todo list,
provided it proves to be useful.

-- Sergey
