Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE37220229
	for <e@80x24.org>; Thu, 10 Nov 2016 17:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935481AbcKJRQf (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 12:16:35 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36132 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934541AbcKJRQe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 12:16:34 -0500
Received: by mail-yw0-f196.google.com with SMTP id r204so10293908ywb.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 09:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bKNtcDP3JHJrd4IKSymDHrqRDGIZ4Gs8qgiOIUDZrEc=;
        b=WIzX+tD0HyGu8gqETkkUxcHapxzM40HDjxpWkP9OWyQgnfcNIjyBFOnt584RMGS2Q4
         0N2zJHPnmwI6nMsnT1uwrm4eW1SqO7yNtWSwcn5k32hJn0TRmXIzCJYwCeJ0Kv+o3x+J
         vdq9FdTu5lE2dmkbCVvowF2i5/ujLjnmLLlSBMQ2AnBOf/j8G0iv+saAvQ+GbwS4czos
         wL/E9r1BvaixGFbWkLAWg7tqVu0bbomrxdB5tVdGXkplTuz9zE29r/7tLBdmPDY2OxN2
         PglVDOK3uwy7iz9IclCugsJQOUHJwWi1XH6VALbJExZ21TXrbQwkJkfA85w/6exOcMA9
         EFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bKNtcDP3JHJrd4IKSymDHrqRDGIZ4Gs8qgiOIUDZrEc=;
        b=IFdUOKVwZAIRcSldeFMG0e+Vx1FYsHVplvFB6qzyNh5g/dsKh3VWotHEm7uSQuwdqi
         LWmmdpxePfTGNGtZgur8+atlJXg54Y8jYuPxd39lGI+ignmSGxOZJb+2xk+hTRzR97bt
         g/Oiix3pJApU/7Sp6U6zaYlYirP70lHH6eZUDMUdwWzKLYq+HEF716+gHhfnrUW7eeq3
         cIiL1lKDSq5f6EKmnejL/M1gJ6EA7zEZcyv7dMye71Ovd++l6oizVfuBLe/CSv6Z4Nrn
         UNaaXrQLgIe5/5fdEc3Ekr46QWrcQuPETJOurTZSW4mUMLn2Y68NsSbzUILyd4L1NL/3
         aisQ==
X-Gm-Message-State: ABUngvcTzvlLJ9DuArkCCknJV9qHRGbHG/wuTE+x1WNh8EVggXzVrYjwvwCMjMdlHuTWQ/WiqfgUN/o495M+cw==
X-Received: by 10.129.99.135 with SMTP id x129mr5973127ywb.94.1478798193805;
 Thu, 10 Nov 2016 09:16:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Thu, 10 Nov 2016 09:16:03 -0800 (PST)
In-Reply-To: <CA+P7+xqVAEuc12eQJ7-Et0CtXc12t5zDUg3Qsh3214cTh_brbA@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-3-Karthik.188@gmail.com>
 <CA+P7+xqVAEuc12eQJ7-Et0CtXc12t5zDUg3Qsh3214cTh_brbA@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 10 Nov 2016 22:46:03 +0530
Message-ID: <CAOLa=ZT-RZw1RoKHVXMu9syrTp67iMVCDv1LtyysekJuhJQSpA@mail.gmail.com>
Subject: Re: [PATCH v7 02/17] ref-filter: include reference to 'used_atom'
 within 'atom_value'
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>
>>  /*
>> @@ -370,7 +368,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
>>         push_stack_element(&state->stack);
>>         new = state->stack;
>>         new->at_end = end_align_handler;
>> -       new->at_end_data = &atomv->u.align;
>> +       new->at_end_data = &atomv->atom->u.align;
>
> At first, this confused me. I was like "we dropped the union, why are
> we still referencing it. But I realized that the "used_atom" struct
> actually contains the same union and we were copying it.
>
> Ok, so this looks good.
>

It is confusing if one only looks at the patch without actually going
through ref-filter.c. I'm sure your comment will help
anyone going through these patches.

-- 
Regards,
Karthik Nayak
