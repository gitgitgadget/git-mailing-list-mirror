Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0EAA20D0A
	for <e@80x24.org>; Wed, 31 May 2017 08:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbdEaIuq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 04:50:46 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36313 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdEaIup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 04:50:45 -0400
Received: by mail-vk0-f68.google.com with SMTP id p85so515839vkd.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 01:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rvDzp0k5ByX+fvFHEEsf5gWwf1K2TqYnb+fQIkvsGZg=;
        b=u1Il6NvvEimCoL6yXg9ZtKeIpIJfHm7ofGv5pSAoKNrZpJ4E3672cWL7ATMGzd/glu
         tIauq7Kq0jRM7gxvq6sj0/BJFDJnxn43qxfYpRj/oPwU5FgPETy+3DdYmtLE0ySgLrCW
         79ohq7gsE5R/41GbV6PGUCp2H/QgxVAG6A1kbWqNIhdGAkJPiEC06gtDP4cubFhsNTSI
         eqFezHFwJNOO3at39/GpgpeniGLuI7y/dbywrGR/NTX1/BUrED7CLA404ueYGFXgHucl
         xnHsZ9WhleHwo+6Fr4085LimXS6C3yTZamSpzpKn/mQu71mDhmgh1SsJsZymgkKF/gDq
         3BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rvDzp0k5ByX+fvFHEEsf5gWwf1K2TqYnb+fQIkvsGZg=;
        b=buwusgj+9nBaspjZDWdGYz1RW7aVwgSJeZbaiUNoCBNbnprIsplR/wTkKKbbrNwAux
         7oN/RW+1qVr2Jt/LErR4FM3EXHgUybBNEPotvtb/86q8YVquLgsYjPkGj6xa+NqaJEnZ
         VTyUNlBhm9NOG+Lj968riHtGjTTock1x5Bh+Gbp5HgWDlCfKpB8Y8s1VAHxj8+0nn2ED
         FYRX+kV+7BVQf7P8bZl8+QIpwEmtRgYyyUKJpjC/V0S4IgCUkXmynNpxHYW/bCe3MlM2
         AUPzs+HtKpQkgFj+NlZrnpTNkjSysMxl+qjV1pizp7lPDCMlZ9bkgxkKHDU97AFguOK5
         Vd+g==
X-Gm-Message-State: AODbwcD4VgKiItAFnPkd98ShD/L9Lrgz39eF6eFZbEeA7XGXysuomnjx
        7TdDwF8MSiypKNXcQFrmDWW8Ozn/nA==
X-Received: by 10.31.76.132 with SMTP id z126mr9840300vka.137.1496220644190;
 Wed, 31 May 2017 01:50:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.82.57 with HTTP; Wed, 31 May 2017 01:50:43 -0700 (PDT)
In-Reply-To: <CACBZZX740rcQKnfkRXgn0+fmeUDaWL-Kz5WzKeyUvBhXWPwPhg@mail.gmail.com>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com> <20170530071244.32257-2-szeder.dev@gmail.com>
 <CACBZZX740rcQKnfkRXgn0+fmeUDaWL-Kz5WzKeyUvBhXWPwPhg@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 31 May 2017 10:50:43 +0200
Message-ID: <CAM0VKjmz7MpVt3oPBuwHiXNoLkZmdmrZ66ggk+aY5-4oVkE35A@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] Documentation/clone: document ignored configuration variables
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 11:01 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, May 30, 2017 at 9:12 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com>=
 wrote:

>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> index ec41d3d69..4f1e7d4ba 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -186,6 +186,10 @@ objects from the source repository into a pack in t=
he cloned repository.
>>         values are given for the same key, each value will be written to
>>         the config file. This makes it safe, for example, to add
>>         additional fetch refspecs to the origin remote.
>> +       Note that due to limitations of the current implementation some
>> +       configuration variables don't take effect during the initial
>> +       fetch and checkout.  Configuration variables known to not take
>> +       effect are: `remote.<name>.mirror` and `remote.<name>.tagOpt`.
>
> We should add to that: "Instead supply the --mirror and --no-tags
> options, respectively".

I don't think we can do that in this patch right now.  This topic
branches off from c3808ca69 (preparing for 2.10.3, 2016-12-05), I
assume because, as a bugfix, it will be included in maintenance
releases for older releases, and those won't have the '--no-tags'
option.  Perhaps as a follow-up, only on master.
