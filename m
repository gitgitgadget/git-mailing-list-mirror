Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74701F404
	for <e@80x24.org>; Fri,  2 Feb 2018 18:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeBBSgz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 13:36:55 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:37017 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeBBSgx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 13:36:53 -0500
Received: by mail-yw0-f179.google.com with SMTP id v139so13892253ywg.4
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 10:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NzbcglO2uSSlWqra3Q0tUtIuGoDQ/2RsHMxa0AmnvXQ=;
        b=dsD3/t34V1xy+q+CKwcHxAl52LLU0Be+wrV5zZ6SrtLhqaghDKMyj2hPiL0qxjrjwm
         9onw3FVnPPVi8tQ36q2ApsgAosckYvJWWNkMcUfb4AKBUk737Xr8RfgKRzIxqeOvOFpV
         H/fU+5ZMGHoWL9dO58lYADJRfIX+ukhROwBR2TP1bjzxqU9Izyz7DD4KvMZX50V9eHAZ
         ZhwoSsasrUc5w/Mg9C+Cf+pbbcidy8sdp1NCBDeZjDPCvF6j4MaFAJfroI7I2WyqW6yY
         2rylRDav/3Va7yGWo8Tg++OpZ1mFa338TpOY2mEaF1rqrhjPePhmv9YPwI7l4B215LI6
         UwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NzbcglO2uSSlWqra3Q0tUtIuGoDQ/2RsHMxa0AmnvXQ=;
        b=m64t7Z15rFSh936HH1qN23VKd0elrZTT0d9YgTIOswhUUWX5hvb1zPkh+q2OvalDPF
         dRZPUpXJsya5jTtQ4+F1euWJ5eo/rUBEeQWFHzUsZw24veeWODA5kBQogqJtGznfbjgA
         9yPWCnNv4Me9GRY0VQEuy5buIKw7m1yYhTnq/D3ZRGuVpHMlNE9UFFc2tWk2QyDxrSg1
         lQXVIxQNzF+o+3M7MpEYkaFz5ZL/kADeXhWrTJzVUHN5HIelbFODRpHaMNxFMTCEFjJm
         01a770D7c22CMxanRKdbZtmprjmZhuWhP56PS8J+uZilCbmaHMawRrucBsB+KdAfW8lo
         KIbQ==
X-Gm-Message-State: AKwxytdhr0OsEKZkXTtwBeIUmwsI+/NKGrcqZbqN3hicBI+IXZas6mS4
        Gq/WwowLYbTuOvIFbBfat4dZQ3w18yRGeMNGhJG28A==
X-Google-Smtp-Source: AH8x224CMwcXvcynOs0BtbSllToWKP4tx1OcsFcUbh+c2eNpPDgWVS4prVH93x8UziszcMZFGRGDzNr1JpGfD+rKFo8=
X-Received: by 10.129.122.73 with SMTP id v70mr27471865ywc.156.1517596612003;
 Fri, 02 Feb 2018 10:36:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 10:36:51 -0800 (PST)
In-Reply-To: <20180201153349.c94fe3de6b632e2fd8f843cf@google.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-6-git-send-email-dstolee@microsoft.com> <20180201153349.c94fe3de6b632e2fd8f843cf@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 10:36:51 -0800
Message-ID: <CAGZ79kb8kHAb6HYrxY_oMq5v3p1+AHX_ad40nwUEwiDKe=i+Ng@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 3:33 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 30 Jan 2018 16:39:34 -0500
> Derrick Stolee <stolee@gmail.com> wrote:
>
>> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>> index c8ea548dfb..3f3790d9a8 100644
>> --- a/Documentation/git-commit-graph.txt
>> +++ b/Documentation/git-commit-graph.txt
>> @@ -5,3 +5,21 @@ NAME
>>  ----
>>  git-commit-graph - Write and verify Git commit graphs (.graph files)
>>
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git commit-graph' --write <options> [--pack-dir <pack_dir>]
>
> Subcommands (like those in git submodule) generally don't take "--", as
> far as I know.

Then you know only the ugly side of Git. ;)

It is true for git-submodule and a few others (the minority of commands IIRC)
git-tag for example takes subcommands such as --list or --verify.
https://public-inbox.org/git/xmqqiomodkt9.fsf@gitster.dls.corp.google.com/
