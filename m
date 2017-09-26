Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC622047F
	for <e@80x24.org>; Tue, 26 Sep 2017 11:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030398AbdIZLWv (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 07:22:51 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:52811 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030395AbdIZLWs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 07:22:48 -0400
Received: by mail-vk0-f45.google.com with SMTP id 126so5171523vkj.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 04:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yPUGHJXmni2BVddE094gjWzMIGzwH66Lxi/zcyY0cJM=;
        b=JCJqKlJ64dJUlZ2lAhI1K6EZ5VOJUSy0MCtGIItUI2fwzYaUGNQlG5do3RAOofWP1K
         0SyOgpdcY5ki3yc5UzKT1e79fJPhWqEuwxdr9f955QzMpxw8S+jL0xx4uKnHzXDWPxaq
         anjE/6/xxGFZ9VrtFc/9e0WbVmrP6BI1h9XIkNDy5viu2q1mvQXoYdqb3Qgn31n26Qdn
         GPROPHXFMZVKGBoPoZ978o5XL2VitHqsEFS2SMEH70Kh+imMe5yYiMyQSpeWEm5eaIcS
         dKNNgECSuOsn47DwnUvDaAGyDN/h4g6t1Qd9/zXNLV6ck9JMZZfTCxiVMBqwtuD5Ycm9
         jBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yPUGHJXmni2BVddE094gjWzMIGzwH66Lxi/zcyY0cJM=;
        b=J0ut636VkHzQO7Dl6PYX9RC2Uk80c7rz6GDO/YXNHUdIaW1+XBf6uIDmfpScTo56s2
         oarW5WkQ0MPblmE0wlejpp4Dfh15/u3dPFYiXMargYf+lHIezkoFIhV2vbye7cIdQnqs
         3HuEFufYTk1Qvw9VVWuP/aW6KopDyp9Fd37zhYfIpRx917I/3QVUISk3xrRGDDd+b8IP
         33mF6mraBdK0UUVhROodSDohO0LR0V0TUa3aaCd9D2ebuqw7oPf35yrklYGyRkXcrCDp
         sQpvrvyrlR0rG0MZNDdBlYKFm6a/lhSwG9yEjkM+gLIjiPDge53p3q58pu3zC/M8D88r
         s3Zw==
X-Gm-Message-State: AHPjjUjtgmbnJWqNv7nJ5J/AbQyQkgtntYI8lAQo5XhxNk5tPz4tQY5Z
        3YTelWsW98X9o2MuTloutxKIX23IyIGKUaElPc2NdQ==
X-Google-Smtp-Source: AOwi7QAUfFD3NeL8AJpWRKqrT8ugqrcntA3HYOiK5Rz6GoUnZdZHDtfUxryop6HMWGliwvCobWR5Pmf6WOoiz2hQMag=
X-Received: by 10.31.48.151 with SMTP id w145mr8091789vkw.174.1506424967583;
 Tue, 26 Sep 2017 04:22:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.3.93 with HTTP; Tue, 26 Sep 2017 04:22:26 -0700 (PDT)
In-Reply-To: <xmqqefquavam.fsf@gitster.mtv.corp.google.com>
References: <20170925155927.32328-1-hanwen@google.com> <20170925155927.32328-5-hanwen@google.com>
 <xmqqing6aw0w.fsf@gitster.mtv.corp.google.com> <xmqqefquavam.fsf@gitster.mtv.corp.google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 26 Sep 2017 13:22:26 +0200
Message-ID: <CAFQ2z_PhSus5yBvG0FV+8DRHbR+OAzFB74sodfEN7YvPjhb3XQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] Move documentation of string_list into string-list.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2017 at 7:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>
>> Thanks.  I am not sure if you can safely reorder the contents of the
>> header files in general, but I trust that you made sure that this
>> does not introduce problems (e.g. referrals before definition).
>
> Alas, this time it seems my trust was grossly misplaced.  Discarding
> this patch and redoing the integration cycle for the day.

Oops, my bad.

I resent the remaining patches. They do compile now :)

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
