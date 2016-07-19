Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F316E1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 16:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbcGSQIH (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 12:08:07 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36058 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbcGSQIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 12:08:06 -0400
Received: by mail-it0-f54.google.com with SMTP id f6so95023446ith.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 09:08:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=EB61GWqxoMBXJEaGjwOwRY8DslIKuwV3mMXpnUgADic=;
        b=MzZBjDh7RLOoKj20JcnIW1M16eC9hDJjDKdosbq2aKUY72z8KyKZVG5Rn2ytjtL5/s
         GMULWxdwvXsn12LtroFqyW+15AYWhgyzHS6AeYXRPsY8rLEHLFJqfz989O3zNRVQiJcA
         4RXy6w5UrQ0tIDajGiKXuAAFeJ9oFN7B2MIfTteXAHx3czPJY6md/YR3J8QTbCwN+bET
         wHzy4dWtlS8BuXkFNs9a1N1X2p4RZLRtvckmsTGdlNWDkf5YKecUIInM4jLkjtLZskxR
         5kkprTzwBzvJd2Dr5saRj0ErYVxo5PaEwbAata6/S4UI3KjSSW0reFkVEcB6dCMTCBsB
         zT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=EB61GWqxoMBXJEaGjwOwRY8DslIKuwV3mMXpnUgADic=;
        b=CefKnTI9PpbOzDrxUXrbg8xbG0H1NNFX3K5BIvWKdJMM8nBRsqYIWr02ChFXjaXZPn
         9XNr9iINpTiTA8Oy1ENx6VsCSL04HW6eLIQU68ES+yPelrUZeNc4sdXV+0JQEOomzvjR
         02zrrC63lMlvzQ+ztLEGxmeLD0tYoxLjGcvGhSOuwsQHUwW92ikU/KCdbNeh6Dqxyass
         XdIdqVBjeiEt/5W3Xsh3DVTWk9KJd0/8H2mrV/xou8QA3fSqYNUo9lE3Sf4csU0a1MCP
         Lxz/3TpV7rC9hK1BNFfQufQGmHQ1Q84HeClQnfpCcixiQK2EcLgfOvRAPNBkjqUYBaZ7
         iApg==
X-Gm-Message-State: ALyK8tKEy7/DNPExGgArpFLZ72tp90/J2Tn7XMro1FzIax8nEsLJ8DmSIbaHeDotHIpj8W+zjH/+PUV0FzNSDA==
X-Received: by 10.36.81.15 with SMTP id s15mr4980410ita.57.1468944485251; Tue,
 19 Jul 2016 09:08:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 19 Jul 2016 09:07:35 -0700 (PDT)
In-Reply-To: <CACsJy8AH9Q6rOgvcWGsLGPaP96koGA=k0PYgXP6F3RZ=XAwaSw@mail.gmail.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8AH9Q6rOgvcWGsLGPaP96koGA=k0PYgXP6F3RZ=XAwaSw@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 19 Jul 2016 18:07:35 +0200
Message-ID: <CACsJy8CR_fkYL5UYbV1MqiTSe3gTqWfOrA1NOHTw09vZn7Y-Aw@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 6:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 17, 2016 at 4:21 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> I'm going to end up having to do something similar because of the issue
>> of submodules.  Submodules may still be SHA-1, while the main repo may
>> be a newer hash.
>
> Or even the other way around, main repo is one with sha1 while
> submodule is on sha256. I wonder if we should address this separately
> (and even in parallel with sha256 support), making submodules work
> with an any external VCS system (that supports some basic operations
> we define).

Post-shower thoughts. In a tree object, a submodule entry consists of
perm (S_IFGITLINK), hash (which is the external hash) and path. We
could fill the "hash" part with all zero (invalid, signature of new
submodule hash format), then append "/<hashtype>:<external hash>" to
the "path" part. This way we don't have to update tree object or index
format. And I suspect the "path" part is available everywhere we need
to handle submodules already, so extracting the external hash should
be possible...
-- 
Duy
