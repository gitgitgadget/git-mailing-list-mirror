Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E371FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 20:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756175AbdCGUZm (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 15:25:42 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36789 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933023AbdCGUZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 15:25:41 -0500
Received: by mail-wr0-f181.google.com with SMTP id u108so9602659wrb.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 12:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZUDC/ufYOutx0H0mL3Ob4VWp4MeicJsVkBravVmUgZ8=;
        b=IN29NmOn/plO77HZokXboZKYHk0y/mZtg+eO1AQEnzcbx2gaLMrRr3NZSac7av+vi0
         ChrRsdAYk4u9tYj4FMN5HhFkhlcv36Uxwq9CnJuR8Bdshq8SL/iYAx7wCNYZglRyr0DD
         CKwKRXgjhiulSIBvblh3LaanTeKGgcBYklunvvhA8ltvIAv8j/6uTDGekYq6/Msey4wm
         CMd3N04t6rPaJA1HpgM8USmmqhf7el3VjIiBbRjVuivZD285/eP+6kCMoRUS3ABN9L63
         aVGUsTwxi9N7rSBHcJ8KMGilntKiv5ixko6Fg5OSW/E0zL7pS5xqnJ0IObHhJ4X8zJ48
         0VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZUDC/ufYOutx0H0mL3Ob4VWp4MeicJsVkBravVmUgZ8=;
        b=VnVGnQtQE4cboIXb27CjRMfOH6HyixKr5hWa6VlafNmwqct2pVLBdNoE95BDyuXdu9
         9H5SRoNhSm0J86sqB8vVPhCLaOLfBKPqEO4GteHExOnRlkhvw/hA1VZsrfAtPIhZjGNK
         Cy/JbiF6FVpxZKtB+W7lCAo7ujDwrcY14z86A0xdQCdYwqfBgu7FCr8EjtWDBjm/Di8s
         jYrw8p3Y2NnHtVlgH0TeoR1lmxTj6a7QcAOO+5fFMOpjMpjKlVmzu7o7nbwUCNSmWvXn
         UuTFIi51XuyaC3rbctT3dIhA4s5M+Up7cwXb+sBnebWYOqC0PS+/YS5aw+5SBJMuXaoF
         iELw==
X-Gm-Message-State: AMke39nYmxjSPwQcMeCIA6dYD80lJqYBqAKAhIISnz8dBey5BRftEOk6VJ+WDQUxfFx7GsjZ5oXlPa8cjIX0Og==
X-Received: by 10.223.177.148 with SMTP id q20mr1646572wra.154.1488912056102;
 Tue, 07 Mar 2017 10:40:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.126.201 with HTTP; Tue, 7 Mar 2017 10:40:55 -0800 (PST)
In-Reply-To: <CAGZ79ka_5QogUEwF6SPCwyqSrCNSrtAsqzqJQdXsJkZEAyzDNA@mail.gmail.com>
References: <000001529cbe5436-285f0113-5761-49d8-8961-5a9df0180ed7-000000@eu-west-1.amazonses.com>
 <0102015aa974d7a6-46afa73b-4378-4b01-9db4-723fb9e41d65-000000@eu-west-1.amazonses.com>
 <CAGZ79ka_5QogUEwF6SPCwyqSrCNSrtAsqzqJQdXsJkZEAyzDNA@mail.gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Tue, 7 Mar 2017 19:40:55 +0100
Message-ID: <CAHGBnuNgHbDmFj2y=4gLTeKQL+JSBazNrQSZwfN=gN3eTggz9Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] git-gui--askpass: generalize the window title
To:     Stefan Beller <sbeller@google.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 7:30 PM, Stefan Beller <sbeller@google.com> wrote:

> Although the following are included in git.git repository, they have their
> own authoritative repository and maintainers:

Thanks. I continuously get confused by this fact.

-- 
Sebastian Schuberth
