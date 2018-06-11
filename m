Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319621F403
	for <e@80x24.org>; Mon, 11 Jun 2018 20:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbeFKUEd (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 16:04:33 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:39315 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932139AbeFKUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 16:04:32 -0400
Received: by mail-vk0-f41.google.com with SMTP id r83-v6so7738392vkf.6
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VlFXF3gbnJkEn0z6FafwdDq+cSntvBj9wjwjTQPXEVI=;
        b=Yq8B9pbfXpCr3QjulIOLI1NNAm5SVHF9NOebUCOO13qi6tsD1otRtfiOaZfho6MnyM
         kZrnWvingbin8rj5FBWTYoHIy/LRpwwkxy7fEs2KS+AnHqhvCCi4QgaZuJVs0rLXqeTG
         sdlrAJSVUXCfkvZKfTu5MLso+UZR/ZX5SJGguZl7xeS0s3dMoIWy8Tp5peCZj2Z9fgIZ
         3kbSIboqqJdRghYg7nzjaQsyiKBmbuHYkSgzM7ZFGeD/X0SoeaQBnEsNm7dMUCIyL8b8
         TrVIJdQ7RrXYaD1+y4hCsZaD0Rv9iCav/nETw5Pf9S+s9Cw6Zazvf6CDD+4BFQFO7bcm
         DZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VlFXF3gbnJkEn0z6FafwdDq+cSntvBj9wjwjTQPXEVI=;
        b=KRctT71D4Y/tA6IhThT8yM7irykIUPylQB/6/0A1EjL+k+rPx4LOCItKNKrt6atkod
         dbFeqG+Pu2ubD7GcLyO8becntkE+tK3xT80MFL+CeBD02Nl+ay2rS2/HepvtqPXeASUe
         +adDb6LtI/gSfj9gIYWAY2s+MkwOHagRmlvP+UMpiMbeLDo/KSzyH10bzZQzMQNW8UQl
         Qgih28nxl2ZhlMz/EzZSoyiAj3zTgwyw3kDN5ulgcFC4kxx4ZwaZK+y1YFuH52fzy2iQ
         0cbD/iAi9jjW6tedCYpPVwJ3lbeFqR1Bzp+wAVufguXJsEq1IniXfQt19P52LOjxJvoI
         Rxug==
X-Gm-Message-State: APt69E2wIbtmlketKvgTOC/uLq0tHVxLMiKP2wABnTgZmEtTj0CL91r6
        b2iik6CZ71PCJ0JRXP3YDNSKwA==
X-Google-Smtp-Source: ADUXVKJgOZpDA8BZFqthjw7D5dGRYcFIUEfCEJltDNY+LWDFZ4LLZIydfYH9uJ7aTq83l/EPpvixRA==
X-Received: by 2002:a1f:31b:: with SMTP id 27-v6mr376653vkd.114.1528747470972;
        Mon, 11 Jun 2018 13:04:30 -0700 (PDT)
Received: from localhost (net-216-37-85-226.in-addr.worldspice.net. [216.37.85.226])
        by smtp.gmail.com with ESMTPSA id w5-v6sm15010095uaw.7.2018.06.11.13.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 13:04:29 -0700 (PDT)
Date:   Mon, 11 Jun 2018 15:04:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2018, #04; Wed, 30)
Message-ID: <20180611200429.GA38947@syl.local>
References: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com>
 <20180530160908.GA8340@D-10-19-29-76.dhcp4.washington.edu>
 <20180530161210.GA9211@D-10-19-29-76.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530161210.GA9211@D-10-19-29-76.dhcp4.washington.edu>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 09:12:10AM -0700, Taylor Blau wrote:
> On Wed, May 30, 2018 at 09:09:08AM -0700, Taylor Blau wrote:
> > [...]
> >
> > I have these patches mostly updated on my copy (available at
> > https://github.com/ttaylorr/git/compare/tb/grep-column) but am out of
> > the office for the next week, so I will polish and send these on June
> > 8th.
>
> Ack, that link is broken. It should be:
> https://github.com/ttaylorr/git/compare/tb/grep-colno.

Since it's past the date that I said I would re-roll this, I wanted to
provide a quick update. I am back in the office, and have discovered a
new wrinkle that `--invert --not -e ...` prints a column offset of 1,
when it should recover the pattern and display the offset of the pattern
match, treating the double negation as a no-op.

I am going to continue to polish this until I can figure out a clean way
to work around this issue. Sorry for the delay.


Thanks,
Taylor
