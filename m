Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF7E20802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbdFVVHX (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:07:23 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33285 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbdFVVHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:07:22 -0400
Received: by mail-io0-f173.google.com with SMTP id t87so30209018ioe.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Az6ZUULzYz1sO5FDFnCs4jNwXsVGIhHHVCKpxyFtJYY=;
        b=tLANVh+fUaalhLqeoPabCA9NhUSwxl44l8USZMVaeaWT5JEVsICAxqQ66p++9ENx55
         nvJVHIhsctJ/9JlXrTdRdwpBBafFUUp1OyC9+qcAkgc29hRYsJ3Tnm7sCVo0PKeUZKIX
         DZ2m2ZVA5iJQzhDPqZI/ge+mNx7Jv+C/L/pn9nq5uaB5KqpPhd3U/G97kjfj8gKzJykz
         PgagrqA4J3yT8LVe3E6tE9PZlVkhJbd7IrdSXkjE68tjBj3RmByYcF1SuVy+4IIz2w9y
         GKHEraFqcFIbtgjdkzdDqVLD+SK6a2K46wzYKL1To5nD0tpdbEh3NNcl+yk7TEAYTo2d
         0cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Az6ZUULzYz1sO5FDFnCs4jNwXsVGIhHHVCKpxyFtJYY=;
        b=KpxMXhVXWbsFQ1DV53ozB1sMe53hKcCJyqEleSqN+h8mPCX5uE2U6SaS4yltmhKZ9T
         SHIiToe7BaGtFhpru8jo1n3K2YhCOdotcFDqJL8hJkxFx9q7XzQWwINfJLE/o4Cu9fht
         tobEr0SnplLgq1bm0tnkzvT2Pyo6tET2eJDgUz2XiM3pyd1uuIJUvjLbDoulalL4DUX/
         nK0tJC2N4+DUK/M9061rMJXEs5L2vk7j5HboSs2vqZT7mgEru0YiEXWGmSiJ7gzVxjKs
         crdM+bdkM+SRP1kfvifqCogJhtaFI84Gmu12bzAmaAPkfccMddLtVJj9KWTbB54ec5Tz
         VhzA==
X-Gm-Message-State: AKS2vOywXS5j/Msbg5hpEt3LrxYcZsOqQuTGD+L4cq6xj3P/Shqs3+2S
        uGcGhvAQlWmGsUpJ7LiRq3vMwtbQQA==
X-Received: by 10.107.145.86 with SMTP id t83mr4907921iod.129.1498165641505;
 Thu, 22 Jun 2017 14:07:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Thu, 22 Jun 2017 14:07:21 -0700 (PDT)
In-Reply-To: <xmqqh8z7ixcc.fsf@gitster.mtv.corp.google.com>
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
 <20170622190158.13265-3-chriscool@tuxfamily.org> <xmqqzicziyss.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2QwN_8Mn3eFT_FRRbXNfnQFwt53nofh8AUzR0Zhx5EgA@mail.gmail.com> <xmqqh8z7ixcc.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 22 Jun 2017 23:07:21 +0200
Message-ID: <CAP8UFD1dsC6iY-RJBTJ0utF_EG1+_KNHjqvN=MF9qjo2jDipSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] t1700: make sure split-index respects core.sharedrepository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 10:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> We use "git config core.sharedrepository 0666" at the beginning of
>> this test, so it will only apply to the shared index files that are
>> created after that.
>>
>> Do you suggest that we test before setting core.sharedrepository that
>> the existing shared index files all have the default permissions?
>
> I think it would be sensible to see at least two values appear.
> Otherwise we cannot tell if the right value is coming by accident
> (because it was the default) or by design (because the configuration
> is correctly read).

Ok, I think I will use something like this then:

while read -r mode modebits filename; do
    test_expect_success POSIXPERM "split index respects
core.sharedrepository $mode" '
        git config core.sharedrepository "$mode" &&
        : >"$filename" &&
        git update-index --add "$filename" &&
        echo "$modebits" >expect &&
        test_modebits .git/index >actual &&
        test_cmp expect actual &&
        newest_shared_index=$(ls -t .git/sharedindex.* | head -1) &&
        test_modebits "$newest_shared_index" >actual &&
        test_cmp expect actual
    '
done <<\EOF
0666 -rw-rw-rw- seventeen
0642 -rw-r---w- eightteen
EOF
