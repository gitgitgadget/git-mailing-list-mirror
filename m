Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852DA203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 16:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933750AbcLMQly (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 11:41:54 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33143 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbcLMQkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 11:40:19 -0500
Received: by mail-lf0-f68.google.com with SMTP id y21so4110546lfa.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 08:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e9DWYoLyuWlk4IjjpS+iKfTTwGWpqm3sAL8e5YC3COw=;
        b=zK4IO27j6iJicY6DvwrjWIpSoS8ljYVKrEkkD5A8Uo0tl3Hqv6XMjWvk2w2Dz3q/+l
         TzBWVXgpeu1V3r6COEXH1wei8LcS9luNejNuqEZ7a+GJE+e6QDOtCWPpqgdp1BRNa3iE
         aBRu6BtMh/GIAE3EtgLlCZyHi2etpA23ZgGJzVot0qB0B9ac/DrNO58y7CaCG2831v5a
         9soAkKe4ksEhNsFO7ONmCE3KDPTJm2RCOk8FJhz6lxb3SJkX/Tn9/8i5z2cR4SqiGBnG
         zMxXTE1XRJV2wIr13Qaz6Op9R4qoK1edxR5dhRfPMTrv+sqH0y4Aso0m6ci+u+XJL127
         uedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e9DWYoLyuWlk4IjjpS+iKfTTwGWpqm3sAL8e5YC3COw=;
        b=EA+vve3a27y5aZahOTRV8dy5otMag2RhL94Z54hOIcJi4OHsSahEQJsKY908AmRm53
         H8HQ566aCIBVa5Hk7NKAcqv+55/U8LGXoDrCu+dEHx8l8eZco31gXbbvcYRgQIVckdHq
         UgR0ASLKQ5ugNbO9unEAJvAfRgyBI4JH74tUfbQGrzvcUtU3lnYhI6vzAxtictJYbR8a
         1qYff0AdMpKYVWqUmnneAv0Z31iLxEBYC0quASKZok7r0RLODXRgPAY4lMFTVgqFOsAj
         tZceTs6XEDariKNn9C+UFEM8iHMDKcfHzEUS88+lBIBXFkb22L9dVrixmGsUuljL6zTd
         Z7GQ==
X-Gm-Message-State: AKaTC019CeHjt1imgOANy7t1aFIVot/xUSYXyVuzPD0phKnOvoAGiwGE+JOFsLE/pmQf8N25RwqCciO4LmHtLw==
X-Received: by 10.46.13.9 with SMTP id 9mr23739357ljn.37.1481647217238; Tue,
 13 Dec 2016 08:40:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Tue, 13 Dec 2016 08:40:16 -0800 (PST)
In-Reply-To: <xmqqy400bno3.fsf@gitster.mtv.corp.google.com>
References: <20161130210420.15982-1-chriscool@tuxfamily.org> <xmqqy400bno3.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 13 Dec 2016 17:40:16 +0100
Message-ID: <CAP8UFD1=-xKWaDnGKrtm2mzVxpH7N-Q3iqnOJeOM5QrtNpitrA@mail.gmail.com>
Subject: Re: [RFC/PATCH v3 00/16] Add initial experimental external ODB support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 11:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> For now there should be one odb ref per blob. Each ref name should be
>> refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
>> in the external odb named <odbname>.
>>
>> These odb refs should all point to a blob that should be stored in the
>> Git repository and contain information about the blob stored in the
>> external odb. This information can be specific to the external odb.
>> The repos can then share this information using commands like:
>>
>> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`
>
> Unless this is designed to serve only a handful of blobs, I cannot
> see how this design would scale successfully.  I notice you wrote
> "For now" at the beginning, but what is the envisioned way this will
> evolve in the future?

In general I think that having a lot of refs is really a big problem
right now in Git as many big organizations using Git are facing this
problem in one form or another.
So I think that support for a big number of refs is a separate and
important problem that should and hopefully will be solved.

My preferred way to solve it would be with something like Shawn's
RefTree. I think it would also help regarding other problems like
speeding up git protocol, tracking patch series (see git-series
discussions), tools like https://www.softwareheritage.org/, ...

If the "big number of refs" problem is not solved and many refs in
refs/odbs/<odbname>/ is a problem, it's possible to have just one ref
in refs/odbs/<odbname>/ that points to a blob that contains a list
(maybe a json list with information attached to each item) of the
blobs stored in the external odb. Though I think it would be more
complex to edit/parse this list than to deal with many refs in
refs/odbs/<odbname>/.
