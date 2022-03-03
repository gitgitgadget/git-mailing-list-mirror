Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C22C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 05:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiCCFKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 00:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCCFKk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 00:10:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CBD15470D
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 21:09:56 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id r13so8210817ejd.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 21:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4CG8yHDtcl+g8tViSTP5d8C08xrhixMYJDQLU7xeNTI=;
        b=BUZ6A5EXVf+bWZPCV8/BJw5o1oDVBQk5Ifinqa569GtsOehxX296zfVY+Q5r3hMzJP
         Nq4COyBqjy6Dkr+4yQ8w/E9KSjcbpNJfc+oeYbJy94mlemdoguJAKVp4empiF5tOoLl1
         5ZgCsX/rDJVBjzBSiIBnWhb2cbL0nJrX7nTj/jojRF+L4LC6uYOqrPEnVpe4pqIe1dfm
         ZOBuqYvlOUKz9gC52kcFFEE8fdYwZvnxDnnzaM2d/h7IkgIckUCJUkg7pvdwhdezgw5F
         H+38xA//e3+iXt7hAbNcReJfbIcHfycKdtbzlJI9efqHDU2poeVcj25tTOSGzmKA0YCV
         XkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4CG8yHDtcl+g8tViSTP5d8C08xrhixMYJDQLU7xeNTI=;
        b=cEWH4fTSSvhp9CYKMmd30z3cvPznnnjxAL83BIgCWUNTGfYSXjwDBV/ioPVDbuPcyk
         U9CltalvDEtcchhTMiPr3eW+LaIV7QZcDY9uyUviDPibowLs6+MGtzkBZyOafZ4b4Qty
         KWefg0VzwCgj1qvyIr4bO44yNvvAhqVrbp8HMXq6t831ssawzBY8hJVx4d4RAM/T4nDS
         9tmglklAPBhLYkVHUA5ISlG2pl+buuV7xhqUEBVs2UgK7T4/cQZdC7G6d3HkaIrExLXz
         ll4wQo/8Zk2K7A3WnwwdQX6padziIEdppvk3nlH0b78L6B+AZ+KJroBPG9OyXAenXW25
         0dtw==
X-Gm-Message-State: AOAM530l9TN4Xzrzm4H3yt/kc7YhuW4/29ll3yEX2tdxACPdXJ9F+U7k
        KhIBDnGRGAbKMN499H30Y6UIxbc/3JxaMvJ0ZHQ=
X-Google-Smtp-Source: ABdhPJxtRf99xwcbdVbQdRRHUwifGNwoLIZ8pwfm+q+m7HTBaid2C6f2/Y3hux8OtbKd+k6vD/RHT3yWwxL4OQFByYo=
X-Received: by 2002:a17:907:334c:b0:6cd:76b7:3948 with SMTP id
 yr12-20020a170907334c00b006cd76b73948mr27697218ejb.55.1646284194678; Wed, 02
 Mar 2022 21:09:54 -0800 (PST)
MIME-Version: 1.0
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Thu, 3 Mar 2022 10:39:42 +0530
Message-ID: <CAC316V7jcHTVs7f_p5zMRqpvTZBPCa6X7=L_MUEy0Zx0PJZZ_A@mail.gmail.com>
Subject: Re: [PATCH 00/15] tests: don't ignore "git" exit codes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks =C3=86var for CCing me. Your patch is insightful for me.

> This series is not made by string-replacing things in our test suite,
> if it was it would be much larger. These are all tests I've seen real
> hide real failures under SANITIZE=3Dleak, either on current "master", or
> in combination with various local leak fixes I've got unsubmitted.

Can you please tell me what "SANITIZE=3Dleak" do?

Thanks,
Shubham
