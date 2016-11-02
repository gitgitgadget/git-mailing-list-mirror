Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A3D20193
	for <e@80x24.org>; Wed,  2 Nov 2016 19:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755761AbcKBTqa (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 15:46:30 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34911 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754524AbcKBTqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 15:46:30 -0400
Received: by mail-qk0-f174.google.com with SMTP id n204so21090534qke.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YYkT7Z9zQlmLJr/4r1Y97jm6/dD1m2ani8agDbyxln4=;
        b=WFK6owmhDqhm1Fx9l3FDEYg1XLxBHP3Cxzhxj6inHQjH+te0PRVadLQorK7wufYeFz
         /k9g5lOQC4qXlxpTMwDRnRIqNC3pRjpm3KkV2r7uExWmHUNG4Ypub1hM8zhnpq3R4pwI
         INnyUmX4wz/Q45I0bN7Nlk1jEZjxKvj4hZfa3u3Cz7pPGQagXjtu6/EYzbygAKgdjiux
         vxGxW+8vgu6vjCh3QJAQ3l0kh9pSbX6XT1WXLcnEYTxIbuTxSrW52d9kQR3iir98vMs9
         6dT8A6Pv8IPYtDmUvWMsfZV+qWG9r+haG10fi/N3NDLepro05DyOEl2TRTAuETFLa0Zy
         WlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YYkT7Z9zQlmLJr/4r1Y97jm6/dD1m2ani8agDbyxln4=;
        b=OqyYtu6u/L/9G8MZV++63ivXD1XAE7DEnUdQQaVANvMXCOMUFZrf/g/HnWEEzBjqsp
         uAhnfacLQfW7VtlNtKLWfyuirw4Gh/GY5UcgQ6LVRrlFeISng1z9FUk3069GPb262YYQ
         n8s2FsIZ2BXO25JvsIx+vjzXB5i4+UDagbxqlG1nXU31d9FPwXDVeWyDFXBPVGTvPDj7
         zFjlNHB1feZ5JJEoXvAI3d02udO8JSqtV6rSNxHM2gHdkgz+ciBNvUhRoqq/mbyjfKUv
         JHQIjiWwnX/bOhpWFqUDd0TZZ2iZ3b7EmmS1mc0Ib+8/MwrDNiDL6XhywJ2pRrUDzWI5
         ToJQ==
X-Gm-Message-State: ABUngvfiBHQ/JLjWkFKmsNJAGm6SWlYZCNUEligy/5lDZFaluBYl2GH7zVvTw9XzrCxcjJ2TdA/v7F9eWgaQUA+4
X-Received: by 10.55.64.80 with SMTP id n77mr4887917qka.173.1478115988962;
 Wed, 02 Nov 2016 12:46:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Wed, 2 Nov 2016 12:46:28 -0700 (PDT)
In-Reply-To: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 2 Nov 2016 12:46:28 -0700
Message-ID: <CAGZ79kY195Bff5bUVm44Bx7+XzDDehYbRxgdii4s040pQXRRSQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] disallow symlinks for .gitignore and .gitattributes
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2016 at 6:04 AM, Jeff King <peff@peff.net> wrote:

>
>  attr.c                | 58 ++++++++++++++++++++++++++++++++-------------------

$ git diff --stat origin/master..origin/sb/attr  |grep attr.c
 attr.c                                             |  531 +-

From a cursory read of your series this may result in a merge
conflict, but would be
easily fixable (changed signature of functions that clash).
