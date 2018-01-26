Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 114D51F404
	for <e@80x24.org>; Fri, 26 Jan 2018 16:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeAZQmu (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 11:42:50 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:40528 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbeAZQmt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 11:42:49 -0500
Received: by mail-io0-f181.google.com with SMTP id t22so1035287ioa.7
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M4AmbnFdMKvAj3AEuWavTNdB/j/zXYGii0t/Kkr+i14=;
        b=Bm/35AB0qf9zZ8lY8e7c0OgQ/dS7NalpDlkujCHVfK44nFipRM6MD4932gZs0DX+1a
         LeJSGjLPxNZLmGa8W3PSkeDz/GxaRZH7807vAP+W1BXXsI/AD//bsXgDNWGEedOUxnmn
         u2EK4HReUouVgLU+bT/fKuE1/TfX6iymlZf6kdi+iMR72IIawMH+g/aZHrbxklFLE1lG
         4kCOmQmL6DaeY6FSV4LwOAJ2X9jxn8PDB2UWMfE0+iO/ueo4HjlEgC1CyETZ/coDF8W0
         CrTlGS9+tthLfNH9pfbytwmZlRKNJOZ0/pkE8SbsdDcZTf0pRtzApVaHvNyzmXAciEhL
         JwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M4AmbnFdMKvAj3AEuWavTNdB/j/zXYGii0t/Kkr+i14=;
        b=ql5R22/h01VF9VN43uJ72UPALPuSEtV0+J+hbIoDv33KuczFmoY+Au5f8Tm1/HztTQ
         yNVrNJmc2bvi54V0LjmlTjlGcpGJmASxh9p+LcDwlOCe7J9LCPNDkRLoX7oMJa8ocH1Q
         MUib7LZqq2yWLL7CRZlnchyKTtS/9N9+hACUAHet7vzqcVwByELtsT5beW7FELRcIIPw
         UYeYbvMBaRxmSXVWNe0by/gvHnmxIexXcDjeknpOoXe3eIAmp1yAeX6EO1C+p0339Udd
         RotBkPyN7qRNyinyl6MPFj+EWROGZoLuAZJPqyq8Xio3cIp86d5DQDQjPpnCcul1eY7O
         MhYA==
X-Gm-Message-State: AKwxytdLgBK2YgxlAwtiKMlCzZNWOT7tAkMSbnxaPeSquu0HSL69sMbJ
        bmoYeqvJo5cLZhaKTD2CtWuSas1guczsP1Oq3kI=
X-Google-Smtp-Source: AH8x2272abnT1/729yg3kTKrZ37ZTLxA5uEgJMSLYcX6yZiix9S96fpKLJV3nRi97ySRtweKqTvUHDOvTTiABtoOh3U=
X-Received: by 10.107.200.11 with SMTP id y11mr2805897iof.116.1516984968703;
 Fri, 26 Jan 2018 08:42:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.149.87 with HTTP; Fri, 26 Jan 2018 08:42:48 -0800 (PST)
In-Reply-To: <CAL21Bm=h4o5k2mQ7vob3m-6N-YZ4Rmr5X3_w90ifpR53_+Wnyw@mail.gmail.com>
References: <CAL21BmkTbr9qYK3+bsbwh9aDQ1twqrNkyUdbaFPSAn5y7ov40Q@mail.gmail.com>
 <CAP8UFD14V-3T0kV=VxYLdozGp5yT-Rzio7PiY8sFn_rVUDxnjA@mail.gmail.com> <CAL21Bm=h4o5k2mQ7vob3m-6N-YZ4Rmr5X3_w90ifpR53_+Wnyw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 26 Jan 2018 17:42:48 +0100
Message-ID: <CAP8UFD31oUtoPMN+S_r5YoKrSN4p_QgZQPE6dF20Wdf6o6vdJw@mail.gmail.com>
Subject: Re: Please review my code
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 11:32 AM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> 2018-01-25 23:22 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
>> On Thu, Jan 25, 2018 at 6:20 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=
=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>>> Please look at my code:
>>> https://github.com/telezhnaya/git/commits/catfile
>>> You could send me any ideas here or in Github.
>>
>> I left some comments on GitHub. My main suggestion is to try to get
>> rid of the is_cat global and if possible to remove the "struct
>> expand_data *cat_file_info" global.
>
> Thanks for your comments, I find them very useful. Most of issues are
> fixed except the main one, that you mentioned here :)

Ok, no problem, we will see what happens on the mailing list.

It looks like the for-each-ref documentation has not been changed though.

Otherwise it looks good to me and perhaps you could send your series
to the mailing list even if it's long. For the first version, you may
want to add "RFC" in the subject of the patch emails you send.

Thanks,
