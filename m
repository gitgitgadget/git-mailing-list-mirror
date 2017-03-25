Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2D9F20958
	for <e@80x24.org>; Sat, 25 Mar 2017 11:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdCYL7f (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 07:59:35 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35127 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdCYL7e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 07:59:34 -0400
Received: by mail-ot0-f179.google.com with SMTP id y88so7535102ota.2
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ksx7pP5jIF1Ij7s4XDaRA8lX0Uxl3bUu6YgaKlaiKuo=;
        b=IAD9aVlshKXNfpeIQH6/ECj+eGUGuHWdyhAo2SPPXN8RVwkGA5TRLuXWpeBW7HJkin
         eaMJ/ku+pjHCiSbT2R4WfnSG2+OY3Gq8B4VT5iwPXnDQIMu0+FTMa7XfkY8yVrQhLNo9
         Dri0uaOswZgIzX2oSveXGqXmUJ+vaxk15T2/HW++Ir+3diBGTcONbPcnItDgAVqniOZC
         e0yUFbwmK/5M3G4Dc3kEPCHfaWQxKoO5imhiE44DgPhGP8Q2PIR+m2+QcCMdWgp8nbkb
         4SoFBIC6ZcdenoiSkxHM3vNv2NIc1yDnyqToRw7WDwKp8B8Cl18VJj7SoOw++Uu7ls8Z
         5q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ksx7pP5jIF1Ij7s4XDaRA8lX0Uxl3bUu6YgaKlaiKuo=;
        b=ft6vP7L855RPTmT6Y0poQW10U97xfpQKFZY1xTkn8SLreWm2oxfwGC9zn6PtpIUsFo
         nLvV4OkHmPazLcHlkYeJ0w8G3m/TLYG0P/IIBtXC6VXxJND7iy9LZTCc1n+uxc//frFR
         sGVKoaKf1H3rGhi++rZadFNH+As/dLOITf4g1GlVTNs8JH1YrZHK5sZx9Hy6ekt6UfMB
         aJY31qnnIaam6qaFrm9kb1RbOfXVwKUb6Y3m1b1aDXceHaDewCxBoP+BHPsb7k+MY9vM
         D+b+DVUovunSA41LPOz6d2XIEFYl77RPsvUwDeqleyEwsqQphMsoJXQoHIMk2SXUcKRC
         xpxQ==
X-Gm-Message-State: AFeK/H0uzI8UYbJvTPBWgLrvW++GZw3Zizg3Y2r8M21fZkfsoJK4AM0ldnZNsLfgcyNImkMZu1Xybn64AebsHw==
X-Received: by 10.157.46.145 with SMTP id w17mr2561011ota.225.1490443172950;
 Sat, 25 Mar 2017 04:59:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Mar 2017 04:59:02 -0700 (PDT)
In-Reply-To: <20170322165220.5660-1-benpeart@microsoft.com>
References: <20170322165220.5660-1-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 Mar 2017 18:59:02 +0700
Message-ID: <CACsJy8DyqxUCXievDON7=D9gNv=mWm=0HZ_t4yj6=xddUp5CaA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add support for downloading blobs on demand
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, benpeart@microsoft.com,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 11:52 PM, Ben Peart <peartben@gmail.com> wrote:
> We have a couple of patch series we=E2=80=99re working on (ObjectDB/Read-=
Object,
> Watchman integration)

Oops, sorry. I should be reworking the index-helper series for
watchman support, but I haven't time for it. Yes I'm also eyeing Lars
code as the communication channel for any external helper (which in
turn can talk to watchman or whatever). I guess I'll let you do it
then.
--=20
Duy
