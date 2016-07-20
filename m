Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298CF202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 14:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbcGTO60 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 10:58:26 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35344 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539AbcGTO6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 10:58:21 -0400
Received: by mail-io0-f173.google.com with SMTP id m101so49773120ioi.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 07:58:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QfTF8ewUCRGbolDFYcFe4xam5kyWH6xc8B26shxSUQk=;
        b=sX65cJXmIaEijsdB0w6TV34D0HMq5aMU8q/I4thSSwT9SnNR+6o7ocjAiXrfjB3Onu
         Y+IbqUwbpDf5BYYi7ivA4Gxu5FbBXxC1rI8NhXFvmEwmXHtanFGM+E5R7MkTLE2QVBkA
         /GPTW9yZcOLfVuXnmBxK5/D6ur7ce7o6EAMVIhYhZp9qdwLyTilyihiXHHz1lfbfvb+F
         KLOwJXoa16kj3HKFfM1+wlfuulcwAaTjZPNDGWhT9osmIVcp03cJuU8AvevSV0bxETUW
         7YHelvsqS8ewtEKNVyaZ4jne+ycq0/rnF0Ssuw3H3sHyqKOP4LLrXWkZwm/q7guAJJ4O
         DFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QfTF8ewUCRGbolDFYcFe4xam5kyWH6xc8B26shxSUQk=;
        b=MuDIySK//9BWx7l1FlsectZN5e36JKi56KkX5id8A1rn83+tn763vFzxSzZr9m5AKX
         qVMWYDWMB3F49DotyYlhmlDzqaHUjEoF9rDVgWurVQAVqNhAeR55iScMRKW6NJ1Zr3kN
         owQcFhat7o5rFwcwQBc5ddQ33KtCs2tcDfPYin9Nsz4ELS8EQIGfJziegaJP9K4+5WsM
         762HlQc+IrtKN++C0lnqLlH25roPGLK5dyHJuSf7Q/dqNPVPwN8I0ChBgaTlr66fGOEY
         mT/gYjaT9ztWGvESicA79dAzYjMswmjspFcsS5RjXUFE2SlNGRPZlzPbSja1RwgdEfjX
         byOA==
X-Gm-Message-State: ALyK8tKOjiSDcl8o4J54/CviSpfj9kvbsr/6lBVI/G6bj+MQAi3jPjhAQO5cR/hIRZYvJRY7F6tbJZBwjHM4dQ==
X-Received: by 10.107.159.147 with SMTP id i141mr16254602ioe.29.1469026700450;
 Wed, 20 Jul 2016 07:58:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 20 Jul 2016 07:57:51 -0700 (PDT)
In-Reply-To: <20160720030226.GA7112@whir>
References: <20160718223038.GA66056@plume> <20160718225424.GA813@plume>
 <CACsJy8CRHsyT8YLPYoHZnxCuMvF1W=S5iayy2eoHZhbSe_qmDg@mail.gmail.com> <20160720030226.GA7112@whir>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 20 Jul 2016 16:57:51 +0200
Message-ID: <CACsJy8CVT8Y2DBGUfABGJfyOqPrm9LHt5Kx8RxoKZ=7XvF0grg@mail.gmail.com>
Subject: Re: t7063 failure on FreeBSD 10.3 i386/amd64
To:	Eric Wong <e@80x24.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	David Turner <novalis@novalis.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 5:02 AM, Eric Wong <e@80x24.org> wrote:
> Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Jul 19, 2016 at 12:54 AM, Eric Wong <e@80x24.org> wrote:
>> > Oops, forgot to Cc some folks who worked on this :x
>> >
>> > Filesystem is ufs and it fails regardless of whether
>> > soft-updates is enabled or not.
>>
>> Nothing stands out to my eyes, so I'm going to install freebsd this
>> weekend. I hope ufs does not have any nasty surprise for me. Stay
>> tuned.
>
> Thanks, this problem might be ufs-specific, tmpfs is fine.
> Tested tmpfs with:
>
>         kldload tmpfs
>         mkdir /tmp/tmpfs
>         mount -t tmpfs tmpfs /tmp/tmpfs
>
> (Documenting all this since much of this is new to me)

If you can, try with some other "real" filesystems, not virtual ones
like tmpfs, e.g. zfs or ext2 (not sure if it's supported on fbsd).
This is just to make sure I didn't hit a bug specific to fbsd. Don't
worry if you don't have time to do it. I'll get to it eventually.

> I noticed FreeBSD now provides ready-to-run VM images along with
> normal installation stuff, including qcow2 ones for QEMU users,
> so that saves some time.
>
> http://ftp.freebsd.org/pub/FreeBSD/releases/VM-IMAGES/10.3-RELEASE/amd64/Latest/FreeBSD-10.3-RELEASE-amd64.qcow2.xz

Yeah that's what I'm going to do, but not right now..
-- 
Duy
