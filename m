Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DD71FD6A
	for <e@80x24.org>; Wed,  8 Feb 2017 06:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbdBHGZG (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 01:25:06 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:35130 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdBHGZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 01:25:06 -0500
Received: by mail-ot0-f171.google.com with SMTP id 65so105672569otq.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 22:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qBMIkBdZaMEZyp3ooed65KyvPkuq/yQum88z6RoaQPA=;
        b=IJVhqOIdNAwGhavbx5bGssVqoD2+/bX7gVeDg4W0BMqOM0mnlILzZWVbc7LNqsvSfu
         qHbKEdUWsd6sywTy6SROFbgKEqTAl0C7HrvgPfIJUcf59F/EriRrfFPtlHcPa07gXbwC
         Dn1JOwkUoknjaYqNPxruRXNGKe+nJoHZwkdG+vpsj7xYy6i4OF3HmWlyAkffn3Im7M2C
         1sqoLudNboZHC6bsVLJJW0bR6YZC+bAgYzF468gTn2+0dFSvI8/ioAJXJOhjBKkQ1t/v
         lFtWW434BX9ofu6wzy4poVgH3rjEQB5jkJFy5RI/d52DK/rMJ9gfzEYKzVtS+A+Zv9Zl
         Jx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qBMIkBdZaMEZyp3ooed65KyvPkuq/yQum88z6RoaQPA=;
        b=aEExn3W8f8FvXr0ti6Y+KHf4zdkPIi3h2+3QcJx9dSkQoCX9dnvt1JsoG/2r9jEYyX
         i+EdVB8pknLEybjXoS+8v3ZQIyorNSv6iNAoZ2u09s9f3ePMclT4rdDZoCAcXh31XOuD
         /WuLxXLtYtUpbe7Y9Ts/IKOXA7t6mpk+gdYHW2ignQpKh5JC1MPF5XuohayFQkKd9YyU
         ptEjokNVWMWeIf3A+kCMDRhC7/c1GDuFvDIFI0sfPHVanmthKmtJvyAP8keBY35/kpZ7
         uRpYz9ObwVlevUndydcEIRplELjHHkEzUoS27xAmfiprm4EMY7yUd8tVrQaSWSTV8Iz5
         sI/A==
X-Gm-Message-State: AIkVDXJdK2R024OFwtJmDfypJdOfXGUEzsXITUI/A6f0bxPLj+qNZFiQr/tOII2urxedr5No7JZshnyuVB919w==
X-Received: by 10.157.46.226 with SMTP id w89mr11066537ota.225.1486535105255;
 Tue, 07 Feb 2017 22:25:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Tue, 7 Feb 2017 22:24:34 -0800 (PST)
In-Reply-To: <CAMh-zaPdSGaDvQSiWx0p7zUmfDAFDWUyHkY4BTs=j85Ue65XnA@mail.gmail.com>
References: <CAMh-zaPdSGaDvQSiWx0p7zUmfDAFDWUyHkY4BTs=j85Ue65XnA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 Feb 2017 13:24:34 +0700
Message-ID: <CACsJy8BmxpTW5pCLNEQa9sm8teU0O+_Xu+td+uh1K0Bn=yu=yw@mail.gmail.com>
Subject: Re: The --name-only option for git log does not play nicely with --graph
To:     Davide Del Vento <ddvento@ucar.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 6:11 AM, Davide Del Vento <ddvento@ucar.edu> wrote:
> `git log --graph  --name-only` works fine, but the name is not
> properly indented as it is for `git log --graph  --name-status`
>
> I tested this in git v1.9.1 the only one I have access at the moment

Confirmed still happens on master. --stat plays nicely with --graph
though, so it's probably just some small fixes somewhere in diff*.c.
-- 
Duy
