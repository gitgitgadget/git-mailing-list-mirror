Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E008B20281
	for <e@80x24.org>; Thu, 14 Sep 2017 10:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdINKO3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 06:14:29 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:47342 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdINKO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 06:14:28 -0400
Received: by mail-it0-f41.google.com with SMTP id o200so137466itg.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aHFEU13PQAsFA2K//c91gzOzLbOdJdww04+B4KEqLKA=;
        b=hKEA9IUL9PTGmwBMaP1tvWsWg8SbiLTfZx3p9lPbLmaA8gdU9RjpGe0LiXHGu/VrTw
         clMB2VTRRro6ZhS8zrAwOv/yb8lUmcbYsVym9/pAgDwAzfvJUQbTTyB1/5ON9xX4dnEw
         FByxaXxC5k2yehJ4cZApIhBF19D9yybWVf5Gd2ykaVFNrd/gdr83A+YKWnYB8DlzPMld
         5c2bJwzOHxXNnqckJI/YOSUoXx+KdexTnpPK6RuODi5VcGhb2lMXZP0oxceN9mU30QqQ
         MXa3xlGVxYCJi5Ofjx/+/Lxqr2A91S6FNClxQNgv0zYWfCa0ULxrkaA3vdSF8WulGuyo
         Sedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aHFEU13PQAsFA2K//c91gzOzLbOdJdww04+B4KEqLKA=;
        b=dgZobGemaqH0Acza10pzVF6ibNrUn7v6b3c9uWt6mcXXE7eG4TSN6qmtsmxHYxhK0S
         SLr7OSneRK4beVySBozwDIS9+fTtejK7BQgoPwL7zigtXrMW7/+IW7nTcpi5RzenCd9y
         Tavi3DgGQY2+oskwBDyybbrvGbo6sTn6K/5L1zYyhTfsfMPA4HQiERUX5nkqQEcRHbWl
         Owr3m5VMjjSYVIqYV5dUi6zVLTIfCHGHEzbjPCzE7Zzr6z497rUA7bvEihJzwC0UGDGA
         ABSA8opSLsdexoaXj0upEC9q7OdsETtkHhTzyuVf2hLi/ojAnB0KorRp1IHm4mmctBp1
         CkHA==
X-Gm-Message-State: AHPjjUiOZOGqMH5PoAt9SSstZffD0xg/y+y6QVL1y3nA4ikTof0RSoWB
        jTCdQfp0wfUIX31QjOkf6Gg69jnBhU9tdbuvveY=
X-Google-Smtp-Source: AOwi7QD0ZYTZsbBdQtglQMAAxlzqolcfHcabwZs4VrwiaLf4+21JVCEUDbWjOt4EGJOdW3tsAv9dgZ8zIDEcOKq4GeQ=
X-Received: by 10.36.185.12 with SMTP id w12mr1867807ite.67.1505384068210;
 Thu, 14 Sep 2017 03:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Thu, 14 Sep 2017 03:14:27 -0700 (PDT)
In-Reply-To: <xmqqfud8xx6m.fsf@gitster.mtv.corp.google.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-11-chriscool@tuxfamily.org> <xmqqfud8xx6m.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Sep 2017 12:14:27 +0200
Message-ID: <CAP8UFD2F65Y+eTDO1=WFsrAMmO=8Wykes9bmGBUS5smULvAOtQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/40] Add initial external odb support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 9:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> diff --git a/external-odb.h b/external-odb.h
>> new file mode 100644
>> index 0000000000..9989490c9e
>> --- /dev/null
>> +++ b/external-odb.h
>> @@ -0,0 +1,8 @@
>> +#ifndef EXTERNAL_ODB_H
>> +#define EXTERNAL_ODB_H
>> +
>> +const char *external_odb_root(void);
>> +int external_odb_has_object(const unsigned char *sha1);
>> +int external_odb_get_object(const unsigned char *sha1);
>
> Even though ancient codebase of ours deliberately omitted them, I
> think our recent trend is to explicitly spell "extern " in headers.
>
>> diff --git a/odb-helper.h b/odb-helper.h
>> new file mode 100644
>> index 0000000000..5800661704
>> --- /dev/null
>> +++ b/odb-helper.h
>
> Likewise.

Ok, I am adding "extern " to the headers.
