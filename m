Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9829F1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 21:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389873AbeLTVLy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 16:11:54 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:36183 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbeLTVLy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 16:11:54 -0500
Received: by mail-qk1-f176.google.com with SMTP id o125so1887020qkf.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 13:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gWgJ1ce+mYcT5c0x3p+isWLW6lCeZSephzYtWKnth/g=;
        b=TPaVu5FKqPgJy7LCOHn1KprUGKYRnCHJseW/Ly9NTECmcfmK5SOVWshghjyGCptuEI
         glCl/i+lrGkbK+2PmZPmWwTJpwHHeT5U60sx2OqjelfFcwwz/qU5geyXkYcIqnhpTJiO
         ARABkK6O1Jj4uUj4SwZHdF7x0C+hes79YeMw1bIVnU40XVm+rwGd4NydF55TZpQhBrI1
         ZOJVZzoTWbTETOb3qEY5PQaF5ajZ/S0IneP1OMucnbeYKZ8wRVOiEfnB8YOqbrIUr8XL
         VJYUZmXKlbq0IiwkuglFUIsA61MC5IuoJ0l/Nh9tnfSOnU8L1xDmBHHoOSq1MJ9HtCQ1
         ZOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gWgJ1ce+mYcT5c0x3p+isWLW6lCeZSephzYtWKnth/g=;
        b=bvc97+MZH0w1kkFybdLX9TGhymWvqZ+4T/tUsJVy9SbSbvqXqmZJFoaMiSKrqYGZ5I
         3TkFfsHKuRDS5MKA1bZZA56wa6i6iD21fKAxhsQx3DtK2EWoAT4vdXC7YtERqXFNikux
         ryQkvdMBdOfA7Fa+KsecdtOaBc0UbQ7TpLQGYwX8oeFGMhl1QMm70ALMiihhhupFARZ+
         5X4mkvlKtPT2Lm0iHWE/PZs0EC+nmZRIvTlSEf+d/QsMzIwywgaNKoNJdGRtzXNuBmGB
         uXyJFVdLB/0gMxngPeSotD8pxzY2W1/6Z4zSRny9ZTD6qUUn/T6+ArC5Q0/tb3PMZUaA
         xP2g==
X-Gm-Message-State: AA+aEWYNdUYk4c9aU/fZ4EXEiXZXRAh3gxhgdNESj8pzfxTT+ePqzs/x
        Vb+xSj/+8/VdDBa9LiN8e1B8CnmK
X-Google-Smtp-Source: AFSGD/WtqarTTqvGxPQvhAS2XAPqEKEyXCbK9NuXAqFxeVJiU2lInMubhxlSJ2FFn+VpfIOBgULSsw==
X-Received: by 2002:a37:4f8a:: with SMTP id d132mr25667824qkb.17.1545340312559;
        Thu, 20 Dec 2018 13:11:52 -0800 (PST)
Received: from localhost.localdomain ([187.183.221.211])
        by smtp.gmail.com with ESMTPSA id 3sm3909900qkd.84.2018.12.20.13.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:11:51 -0800 (PST)
Date:   Thu, 20 Dec 2018 19:11:47 -0200
From:   Ricardo Biehl Pasquali <pasqualirb@gmail.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: rebase: Ask before doing anything not undoable
Message-ID: <20181220211147.GA7426@localhost.localdomain>
References: <20181220173348.GA5203@localhost.localdomain>
 <20181220182653.GB4823@alpha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220182653.GB4823@alpha>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ccing the mailing list.

On Thu, Dec 20, 2018 at 07:26:53PM +0100, Kevin Daudt wrote:
> It would be anoying for users to have to constantly confirm when they
> run git rebase --continue. Rather than asking confirmation, it would be
> better to make it easy to go back to the previous state.

I meant confirmation for --committer-date-is-author-date
option.

As Thomas said, it should be possible to undo the action
using reflog, although this seems not as easy as it should
be yet.

	pasquali
