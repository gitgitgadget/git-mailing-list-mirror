Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D43E120A40
	for <e@80x24.org>; Mon,  4 Dec 2017 07:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbdLDH7O (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 02:59:14 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40110 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbdLDH7N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 02:59:13 -0500
Received: by mail-it0-f68.google.com with SMTP id f190so4507575ita.5
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 23:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uYUI4wuSUrkHGCk4B0haAsDn5YWKKwhi00edMGyRf9U=;
        b=FBrwvn1ESIci+GAfD7PA8uTNEU0R2gptKCMca8stRv+WtIHyGnsRQK/soOucyxhcJC
         tj+ri4p99ArpJTQr35118DPSm7Q3SdJkVq2h5SmLeSi7tDPVXcKuSIBIBpeZ3y1F8e42
         uTWB/p4mT9Z/Gy8oNktOL/1xca2Cy9J2zgMYf3EV403WBZ2YvGuLE1MM0if5ANV5Fej9
         UODUoKefORnKrk/y+uwezpvp2paUh3SvyDqf1O+76IbwfMwHqd3g4ldXa+q05Ejxg99R
         OYI9u9GV4LgS/RCLhlOPNzKkkL8gzUdROZeP6hUXkngjFvotSwlvub7Au1tY9VmL1sos
         3n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uYUI4wuSUrkHGCk4B0haAsDn5YWKKwhi00edMGyRf9U=;
        b=IZ4dCoplow1krv3QZZDFkG7ekao/TJ95XLVk4KCCKT7wDjwBP0B4lRmuhZ6yOnvAjk
         38ulkSewUHWGk/x7V10WLpVzx1RceD2eJ2CtOBybiM+txF6hYB5/iqOyk2zoFldD8qzk
         OF/nOuDwkfomDMItAviHSclVHlCGdc6aOBLi8UPKKuA0XLxYIGPDUrkQ3Xlty8E+fOKZ
         aKQIT1NDB/b2tmzeCz1esK7dArhUzffvXpUTWvXa+VFBG4El8J4IebVcx36CoEwamjA4
         YHa2kSMg/eaPVDjX5rb+UuNjEKSlNfbSRpT8iCyoAm/0Lqq+QKMor2gpIdXtyl0uPHry
         rZGA==
X-Gm-Message-State: AKGB3mLj06Nns6VrdbMRvcJXnh08KfJdSk0VclRxt5IHs5izskMhH9PO
        xdQ+QkceR8ki4Kn8ZYpe1PfCBKSuXqhxfVaANT0=
X-Google-Smtp-Source: AGs4zMZsYjWGQZDfg/vjNJ5F57FtvYvodEeSZUTKRtMTVR8O8VSozGjt+UcZn+OSMy391dbGYZctkw0zPqZ0EOEihUg=
X-Received: by 10.36.228.68 with SMTP id o65mr12694302ith.128.1512374353070;
 Sun, 03 Dec 2017 23:59:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 3 Dec 2017 23:59:12 -0800 (PST)
In-Reply-To: <xmqqfu8rig10.fsf@gitster.mtv.corp.google.com>
References: <20171203170415.15939-1-chriscool@tuxfamily.org>
 <xmqqk1y3ira9.fsf@gitster.mtv.corp.google.com> <CAP8UFD2OSsqzhyAL-QG1TOowB-xgbf=kC9wHre+FLc+0J1Xy+Q@mail.gmail.com>
 <xmqqfu8rig10.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 4 Dec 2017 08:59:12 +0100
Message-ID: <CAP8UFD0UH62fyLLAx8QP37L22if9zGjX=7f_c23asOFiKEEB7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] git-compat-util: introduce skip_to_opt_val()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 3, 2017 at 11:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Anyway there is a design choice to be made. Adding a "const char
>> *default" argument makes the function more generic,...
>
> I didn't suggest anything of that sort, and I do not understand why
> you are repeatedly talking about "default" that you considered and
> rejected, as if it were an alternative viable option.  I agree that
> "default" is not yet a good idea and it is a solution to a problem
> that is not yet shown to exist.
>
> On the other hand, just assigning NULL to *arg when you did not see
> a delimiting '=', on the other hand, is an alternative option that
> is viable.

What I am saying is that I'd rather have a lot of code like:

        if (skip_to_optional_val(arg, "--key", &arg, "") /* the last
argument is the default value */
                do_something(arg);

than a lot of code like this:

        if (skip_to_optional_val(arg, "--key", &arg) /* no default can
be passed, NULL is the default */
                do_something(arg ? arg : "");

because in the former case the `arg ? arg : ""` pattern is captured
inside the function, so the code is simpler.

In the few cases where do_something() accepts NULL and does something
different with it, the former can be changed to:

        if (skip_to_optional_val(arg, "--key", &arg, NULL) /* the last
argument is the default value */
                do_something(arg);

So yeah I rejected it, but my preference is not strong and I never
said or thought that it was not viable. I just think that there are
few cases that might benefit. So the benefits are not big and it might
be better for consistency and simplicity of the UI to nudge people to
make "--key" and "--key=" behave the same. That's why having "" as the
default and no default argument is a little better in my opinion.

>> .... I think setting
>> "arg" to NULL increases the risk of crashes and makes it too easy to
>> make "--key" and "--key=" behave differently which I think is not
>> consistent and not intuitive.
>
> So now this is very specific to the need of command line argument
> parsing and is not a generic thing?  You cannot have your cake and
> eat it too, though.

I think that even when we are not parsing options, it is probably good
in general for UI consistency and simplicity that "key" and "key=" are
interpreted in the same way.
