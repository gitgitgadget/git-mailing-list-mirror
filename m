Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D4C1F812
	for <e@80x24.org>; Sat, 29 Dec 2018 04:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeL2EjD (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 23:39:03 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:43876 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeL2EjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 23:39:03 -0500
Received: by mail-io1-f53.google.com with SMTP id a2so6286180ios.10
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 20:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jmT5EcoSH3j6NrjuhbCfVtz1qfu+yWzNedpvjUhwuX0=;
        b=ZXzOhIDbsGu0NJ0yp+HkAyDgFgETWG9a0NwNBAosSzCSwFsSCaTyOFFTdZDHy0krHh
         +L/u036wYXH9qWxsNYShBEGfnfIIGjP0/htz3KcyTcvqHRud4gPTAJByvHU8xXviWGx/
         156EiTPTKIs57izV6Cdl0URciJKk7HfdzvDag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jmT5EcoSH3j6NrjuhbCfVtz1qfu+yWzNedpvjUhwuX0=;
        b=mC7GJR8SaLdES7/+kKfRebphp89aPYHW6z2ugw0d+Z8gK7Zz+FOKoekGho+hTYciq+
         DHBAIh9BcCNpngyt3iAENZQuFPGbFiwQ9nEPUQ1sH8NXpLvVV399h1jbOxvYnkYT6wmj
         qiaLY7cIiLA5wy4hynezSJRGe3KoA7msFz4RmpnjgUhHj2KcWJnaFMYVJ0MBHJTr2Pun
         azT+izPIUeEZdy6hMKvkVAgJnQGkPQy1oo7EZjYDyzvT4lBpXkI85C8+XbccbdVgMpKY
         Km3fDrpQ7XnJMoGBbeSOzaZThENKjb9Bk8p8g56nAFTOPvm7lN8ko3NhrJ0znPOultar
         ST0Q==
X-Gm-Message-State: AJcUukdYvajEeBJuVfB/ZZbjkzP7utx1gjfXD1amXDj7z69eddrY8XIG
        q/TSxUKdEtH0wYhxr70rcJWyBaj8HMMgnKVB
X-Google-Smtp-Source: ALg8bN6zCGU64ouxTwktdtmBvyiA67P/A+fG1EjIRMUnSXPhYO0hnxTonk/FCtJFEGzu8iW6D0ZnhQ==
X-Received: by 2002:a5d:930f:: with SMTP id l15mr14044390ion.302.1546058342786;
        Fri, 28 Dec 2018 20:39:02 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id r85sm19141547iod.13.2018.12.28.20.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 20:39:01 -0800 (PST)
Date:   Fri, 28 Dec 2018 23:38:58 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, meta@public-inbox.org
Subject: Re: "IMAP IDLE"-like long-polling "git fetch"
Message-ID: <20181229043858.GA28509@pure.paranoia.local>
Mail-Followup-To: Eric Wong <e@80x24.org>, git@vger.kernel.org,
        meta@public-inbox.org
References: <20181229034342.11543-1-e@80x24.org>
 <20181229035621.cwjpknctq3rjnlhs@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181229035621.cwjpknctq3rjnlhs@dcvr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 29, 2018 at 03:56:21AM +0000, Eric Wong wrote:
> Hey all, I just added this to the TODO file for public-inbox[1] but
> obviously it's intended for git.git (meta@public-inbox cc-ed):
> 
> > +* Contribute something like IMAP IDLE for "git fetch".
> > +  Inboxes (and any git repos) can be kept up-to-date without
> > +  relying on polling.
> 
> I would've thought somebody had done this by now, but I guess
> it's dependent on a bunch of things (TLS layer nowadays, maybe
> HTTP/2), so git-daemon support alone wouldn't cut it...

Polling is not all bad, especially for large repository collections. I'm
not sure you want to "idle" individual repositories when there's
thousands of them. We ended up writing grokmirror for replicating
repo collections using manifest files.

> Anyways, until this is implemented, feel free to continue
> hammering a way on https://public-inbox.org/git/ with frequent
> "git fetch".  I write C10K servers in my sleep -_-

The archive is also mirrored at
https://git.kernel.org/pub/scm/public-inbox/vger.kernel.org/git.git, and
also on kernel.googlesource.com.

-K
