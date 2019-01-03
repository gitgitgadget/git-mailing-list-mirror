Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCDB1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfACVg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:36:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55228 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfACVg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 16:36:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so30477272wmh.4
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 13:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f7KHBWs4qZGpClT23xjfRRtGtZHXHM6xvefAEApuOPk=;
        b=QGx5cNKICCNqeTYwzHaPJp4u7rn/nmzu2Dc2F8vs6SqZyy4Vvbz47Lk8AUmfas5V0H
         3OvlaWpQgnUWH5YNNJCdggLnhC4kxUwHw3l7c7MYFIkQl0Kp4HVBQeyBu2gsEILAlDNh
         ncHv2aY35zTqY9vfTSMQeE+DsOYVJuPqxN7W4q3sZH6D5AKAaJDDp4jpfb6nCUWer4Jp
         ckQk/988GG0KgOCQCT9+YouftpfMIoq7t6lhl5l9OORneLpJIGuDMB6/DZbq5OEBpygP
         6RiqmIKctuDKrb7SBV/B1sCz+SfJffJM+doyBrTGIw0hNEQh90s0TvhuGUHRV00qbZqy
         kUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f7KHBWs4qZGpClT23xjfRRtGtZHXHM6xvefAEApuOPk=;
        b=bc8yKORRVo7q4I1KN+GZWbQRaK2AA9mSq1lQ6YWw/jkG2nmsI9NFQytyBRtP8ELD8Q
         ij/uWkajS1tJ4mqLbdKPSwuZC0UcUQCv8KHKNmZGRADWSZTHJqUq5/w+GoQbn65+rbGg
         OPIHYEcAeGZwGGx5fntMOB2PjkoLg2FqOqJWOhbpVTpA/BtO4WApgSJQbm3tLjvdZ4Jj
         dptZTDoVvrhS2JB96kW2Z2YGTgByrpzLEYw/rLnWJ0VG7bYVlJeLFvfslCKaet+ODRCh
         3SVer13eNKCPiugTiUhkDKFLGV4XTU/TPCcXvIJfA5YIr2WP/D/Y4TkPi/Pj+QSuL8YE
         gYSw==
X-Gm-Message-State: AA+aEWaXlbc+23bwWzRyDB97PZfMiGRAjNdiJwnAUezx5KVcBO1Ztzus
        O96KVYAjPYJUYEif7r4KZ1g=
X-Google-Smtp-Source: ALg8bN5ka2/kBD+3LAULSVnwndKC4xyFHkWLYjID97qjW2sFA/INgCyc/ro2Eu8vIR1pnwkJKbRDkQ==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr41815736wmd.143.1546551384290;
        Thu, 03 Jan 2019 13:36:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u10sm36487305wrr.33.2019.01.03.13.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 13:36:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     <randall.s.becker@rogers.com>
Cc:     <git@vger.kernel.org>,
        "'Randall S. Becker'" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 2/4] config.mak.uname: support for modern HPE NonStop config.
References: <20181228200243.19728-1-randall.s.becker@rogers.com>
        <xmqqimz5h6et.fsf@gitster-ct.c.googlers.com>
        <006501d4a39e$b99fe0d0$2cdfa270$@rogers.com>
Date:   Thu, 03 Jan 2019 13:36:23 -0800
In-Reply-To: <006501d4a39e$b99fe0d0$2cdfa270$@rogers.com> (randall s. becker's
        message of "Thu, 3 Jan 2019 14:58:39 -0500")
Message-ID: <xmqq5zv5h19k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<randall.s.becker@rogers.com> writes:

> I will reissue the whole package for you. I think I hacked it badly. Will
> get to it after $DAYJOB is done.

Thanks.
