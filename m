Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C511F404
	for <e@80x24.org>; Thu, 15 Feb 2018 20:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166091AbeBOUms (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 15:42:48 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38378 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161186AbeBOUmp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 15:42:45 -0500
Received: by mail-wm0-f46.google.com with SMTP id 141so3211541wme.3
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 12:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/N8Pc8YgXeNPJDUw/HAuq9KVdRBvz7rtN1xEhgW1onk=;
        b=eUZq16iaR+s6FKPI4V70TQxhdhst82UJZz2bkzvjoKB9U0pL2+aVtia2Z4wo92JKa7
         WQ9RmN4nw0AG333ChUFCoJc76niv2ecyJEnZVTlQLrx2C4tBvr1uSS03ru0vECdfQF36
         36cAAPyLXOhWeV6od8F0LRA0sXbZEHLMuqFTkkkW6liLZZ9b+OJpa7Vqutkpqrb3ip+h
         ms7adbWM7oAEqpNpjLByskTkEV6eVOZimnvuUQ1vINKh7LkEpfqCHoHstot9oGLTNIO2
         /8TvqaAMy/c471UWoe02UhgBAQF1nEeEx1REogNnsliNHwhg///wUsjQ3NvPAyi4fLsG
         L4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/N8Pc8YgXeNPJDUw/HAuq9KVdRBvz7rtN1xEhgW1onk=;
        b=iYX9qT7Hir3VLKel7VUMhy/tVGNGlpt+E4NwHLccTeW1AJrxHgt5A6b9SVN6sbMk/O
         4y/+G4aahKKZq8rtgjnlcTVdOeXCPM9fa+KWaBYm/UQ4x/SrmwU6QppKadHhz4y4dIfQ
         GeOH7Ho2kuCcXhAoC0IuOqPvpSproYB9LwLb1naftvWGdh3l5MB+UkAQN+oR4d24VedH
         9QxYzffhJ4IBrOl+n/rR95sPW/XSUuNT/1YaDTjjoTI1DyMe/VDDnhGIRDespFrM960I
         /6R9PmBASQ4Qd/ACAU4DLxqpDdOj8XGhQZxYtemYLodRaUqGb7uZNYsUep97KmF0o+/Y
         vm2g==
X-Gm-Message-State: APf1xPDBsi4mQKMLtAUcUGSjT15N5o+G4xrfGk6+4wpS2HchJUhyJzx+
        52Pnvf+HZP8I5yLY4wc+L5ht6HRz
X-Google-Smtp-Source: AH8x225mswxhWxES5WvLnLVIYdj/HkubYwuKpWkCJ/wEhXn+tF8IdOc6bIGQXe1KxN04dIkLwY7dGA==
X-Received: by 10.28.93.83 with SMTP id r80mr3315244wmb.154.1518727362437;
        Thu, 15 Feb 2018 12:42:42 -0800 (PST)
Received: from evledraar (static-2-73-24-46.ipcom.comunitel.net. [46.24.73.2])
        by smtp.gmail.com with ESMTPSA id p1sm16092180wra.90.2018.02.15.12.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 12:42:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 8/8] perl: hard-depend on the File::{Temp,Spec} modules
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-9-avarab@gmail.com> <20180214235404.GH136185@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180214235404.GH136185@aiede.svl.corp.google.com>
Date:   Thu, 15 Feb 2018 21:42:39 +0100
Message-ID: <87r2pmf0hs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 14 2018, Jonathan Nieder jotted:

> Ævar Arnfjörð Bjarmason wrote:
>
>> --- a/perl/Git.pm
>> +++ b/perl/Git.pm
>> @@ -1324,8 +1324,9 @@ sub _temp_cache {
>>  }
>>
>>  sub _verify_require {
>> -	eval { require File::Temp; require File::Spec; };
>> -	$@ and throw Error::Simple($@);
>> +	require File::Temp;
>> +	require File::Spec;
>> +	return;
>
> Same question as in the other patches: any reason not to simplify by
> using 'use' at the top of the file instead?

I was just going for the minimal change, but yeah, that makes
sense. Will do that in v2.
