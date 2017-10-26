Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2BA202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 15:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbdJZPL3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 11:11:29 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:48058 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932246AbdJZPL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 11:11:28 -0400
Received: by mail-io0-f181.google.com with SMTP id h70so6107154ioi.4
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/VEC/0p/L09d1MM8jqR8I6W7yDAL4F1iO3pLHIrIwHo=;
        b=Pjmgc5XBItUhKha6cewEeiZyXMUvKNC7NbiKllTZgtZ/RpggEAcRSKMkgxl2kPgwS4
         7aSCyodJ+IIermgo/ZixeXgjhb+GPhsT+DYkqIvwizOicsyQFrTW0mrWAkHTfFlJAW56
         Ls5erxil5pzz+zjzj+B2Tt3UJ0w36imAgSiMuDDsT9jiEOVR1/afI+uS6MF95f4VwmHG
         xwRwztVZZJ/hsnmJ30TnqAhmg/+O9gpxrTd3pDotRXB9/5ZGzZdZX67e3OiZw8lAkS48
         qIUSniHvvxY91kP+piO6TQOvy07qBSg3mGLJ3hAJDckE4pzHAOOYzS8KZ9OdefFJZoB9
         7TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/VEC/0p/L09d1MM8jqR8I6W7yDAL4F1iO3pLHIrIwHo=;
        b=fcgCR9l+rJ+grWi89GA3WWc92Me4+I6tLzrjQ4/z1YNil65saZnNuY3acEQ3MD0MCU
         Ovea+vqBaOOEu8qp08ZqQSL9TWUN9x9dfOoIv/gbb+yoU7DXmZ04ErFtKHBShCzTag2t
         dHezXnVMNZDrttSj8HMAkG8hkS0iwazsq2EiNYKV3VlZj1SiVge0G4g8oP5SViekQ569
         KVvTxEUvt0FksKmMqykqrc7ujVh3uK6+45mxDyqg8d7dpHlfgccYEIctQAr3uAra481a
         LWFuKESey+f+6wE0kJXsJKmx48n2k6EuGQZeqCY5HqNy9F2E1/iYTaf6GwdDXpLxGCYh
         lhIA==
X-Gm-Message-State: AMCzsaX/LfD+AJsn82+MkhP1xbr4QRTmUVDoqommXBF3lDHUgzLjwQ2P
        CvGjxaHWUW1CsGJMgmVPOcDpo4hcnSfhxqyj+rYkAg==
X-Google-Smtp-Source: ABhQp+Qg+fb3hUkqciB60p19TvQ5ZzE44KW64zxxB3809T/29UTsjofyvCb5PKdGh989HwKqasZuqMR+5lym/h3wdik=
X-Received: by 10.36.43.13 with SMTP id h13mr3092448ita.8.1509030687795; Thu,
 26 Oct 2017 08:11:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.151.137 with HTTP; Thu, 26 Oct 2017 08:11:07 -0700 (PDT)
In-Reply-To: <1509030170.10651.59.camel@perches.com>
References: <1509030170.10651.59.camel@perches.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 26 Oct 2017 17:11:07 +0200
Message-ID: <CAFQ2z_P9bpw+Pc2DhJTCB8dxj-5JAKLE=nyvToGuiRA8wV66Wg@mail.gmail.com>
Subject: Re: grep vs git grep performance?
To:     Joe Perches <joe@perches.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 5:02 PM, Joe Perches <joe@perches.com> wrote:
> Comparing a cache warm git grep vs command line grep
> shows significant differences in cpu & wall clock.
>
> Any ideas how to improve this?

Is git-grep multithreaded? IIRC, grep -r uses multiple threads. (Do
you have a 4-core machine?)

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
