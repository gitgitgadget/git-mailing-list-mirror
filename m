Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063851F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970044AbeCSTOu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:14:50 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:44008 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969771AbeCSTOr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:14:47 -0400
Received: by mail-ot0-f180.google.com with SMTP id m22-v6so18550478otf.10
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TKPiti1hm2fkv+GVFHx9u+0C+zOj/oqwYxP5SWlpUG8=;
        b=k9q1uiK+9/U016mMEB/iQ33eQ4soDtmYHhpiFdiN6/uY2LSDjr+/YDZuHjArHxoqsd
         1W+WikzaJkDrL12hZ7DV18R0JgnrYBWJNXTKiZhUpQqznqVxsFTxpdA+9aJcusKMwQVI
         5NJ/qxbxF/HYWv1PjU5ZRFE2nnSCCiIPCxKgrlmmdkRZMfiCVe7Cd8a1TIVtoUpJU/Vj
         RTB+GneTwAu8ee7Q/8BJKrDE9VXe3viqlfKqmErhNfMpDcn8txzafnV8+UO0o7l8F/K3
         OyZtYELEu02qFnQ+BbUyb3hQ2nKzYDS5QxIn7yK3ynQXhos5sKPQDhDpt3wwhvMwnMU6
         T+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TKPiti1hm2fkv+GVFHx9u+0C+zOj/oqwYxP5SWlpUG8=;
        b=YyQGZeEj9RYrsZWxzRI85DLDNaXGki1ApWhcJBm97QYcP3DkSmLzGvQ0wpdQ2rHTke
         04bleErv7NSX/mHnNhTsa6x98/5UX9rIGD7/riXZNV2YSyTmy3NCTRnr5ADNAVGS6xIM
         d177ws3vwqvh3kPMRELioEDJX7xPdmtivmGeY9EIuvpA0tk22WbrttgtZMVXaEHzRK2y
         RB2rBC/2DXc7I6EJmV9ptck9W8o4xdQFnHu+3vEz7XjrdVrQy4jWn170GhnUdlKLOpI7
         VNVBueee1G4+yJhi7YvLcMsga0JqFoRMHMjTnq6clfv3Fm4QQ7BeMEeAdI/uXfRc40Et
         +npg==
X-Gm-Message-State: AElRT7ElP6f1dm9MxjrFOSQK9aUu8+ALg3a25I/7TYmMA+MKMUz6pGZF
        aVSSxxFi667yg1Rex/bjLvXgREiIYFBff3XKbnvweg5uJpM=
X-Google-Smtp-Source: AG47ELv/aJhVzD6xRCqp7QjvtnoA6+4UI+rYwxSmtQ4su53ZXQuoaGX4ZVA+AnwbqeqwzW1qMX4sHeMuRNx9vBX4sq8=
X-Received: by 2002:a9d:2cc9:: with SMTP id e9-v6mr8210077otd.6.1521486885808;
 Mon, 19 Mar 2018 12:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-3-dnj@google.com>
 <87zi33c22l.fsf@evledraar.gmail.com>
In-Reply-To: <87zi33c22l.fsf@evledraar.gmail.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 19 Mar 2018 19:14:35 +0000
Message-ID: <CAD1RUU_MpCeXfCF9NqvD-CvsWtsJShfMyg9HFAXrN-ULCE67FA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 3:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com>
wrote:

> The merge conflict becomes a tad easier to deal with, also makes sense
> to have gitexecdir after infodir since that's the order we're listing
> these in just a few lines earlier, and this is otherwise (mostly)
> consistent.

Got it, I'll update my patch set to include this in v7, which I'll post
after a little more time for comment on v6. Thanks!
