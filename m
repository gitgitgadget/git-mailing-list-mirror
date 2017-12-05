Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9FC020A40
	for <e@80x24.org>; Tue,  5 Dec 2017 15:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbdLEPms (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 10:42:48 -0500
Received: from mail-yb0-f178.google.com ([209.85.213.178]:33332 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbdLEPmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 10:42:47 -0500
Received: by mail-yb0-f178.google.com with SMTP id i15so288719ybk.0
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 07:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zXqbKdIEAG07a3UBwsUuIkdIKxNdVfAuahn3GmJnjWI=;
        b=EKu9w0CIFJUjBNrlXbWIvEk7yN299cEnrRmSLQk9OiYmgzPlqGziC/pbJyIEJQ7DDI
         AuwJ9fJOPQp6B81zfj/WvUMm/HwR/O7fdXM6A9HCZCyfpJJk7fZEQPtzreNpKz1+Eo0e
         Coe0H4pje3AkD+Mf1A4gOaMh1Sz39hpWqD1wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zXqbKdIEAG07a3UBwsUuIkdIKxNdVfAuahn3GmJnjWI=;
        b=KU41o3Gfaot+z9X9pL3hPzJRcFqnddooQlqv71c/uDU2Hv/plBf7xPSstRGS9jQtM1
         30gkqSbAerZeEGx78uCX0AKihvm3DwuenR6dwnxcboUYkStTGwpFdF86rZ3V2U+SfcNy
         nOoglqow7xJzb5ECX/PkWcpChimagam3I/gbc/jdGMFYH0kwjpwexpmxrRBJvQyKGqx+
         H21NhBHNlhItBPcjB7BP1BHRn/rYmJ3W9etGpatD94KXmXnXg1U9J2p2OwLlNdaYuZ1I
         U3UW2sDmxerjUIuW3MDe5rbHXdf5f1Hco03nS3xE2cSWgvuqWMbu8s3CySDoyb4coVPS
         fT6A==
X-Gm-Message-State: AJaThX5mNbUIkDJxBC7Xs9yQhJoFIyg+GQWgSj01Q+r996rqpr9WfAht
        OaXoYNCqKH6cFOq6zm10CMr4+ILIjA8=
X-Google-Smtp-Source: AGs4zMaZ6eN32T4KwH1C++jbGAZDJCBU7fXa7JjELh/v96QlEmFsj2PgmnjL5DiASrUE5ncgLAeAIA==
X-Received: by 10.37.46.12 with SMTP id u12mr13053225ybu.112.1512488566948;
        Tue, 05 Dec 2017 07:42:46 -0800 (PST)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id b140sm206913ywa.26.2017.12.05.07.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 07:42:46 -0800 (PST)
Date:   Tue, 5 Dec 2017 10:42:44 -0500
From:   Ben Boeckel <ben.boeckel@kitware.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, brad.king@kitware.com
Subject: Re: gitattributes not read for diff-tree anymore in 2.15?
Message-ID: <20171205154244.GA16581@megas.kitware.com>
Reply-To: ben.boeckel@kitware.com
References: <20171204212255.GA19059@megas.kitware.com>
 <20171204230355.GA52452@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171204230355.GA52452@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 04, 2017 at 15:03:55 -0800, Brandon Williams wrote:
> Reading the attributes files should be done regardless if the gitmodules
> file is read.  The gitmodules file should only come into play if you are
> dealing with submodules.

Yeah, it doesn't seem to make sense why this commit breaks us, but there
it is *shrug*.

> Do you mind providing a reproduction recipe with expected outcome vs
> actual outcome and I can take a closer look.

I'll work on one. It isn't as simple as I thought it was :) . The setup
we do before running the checks is apparently involved as running it
from the command line is not exhibiting the difference.

--Ben
