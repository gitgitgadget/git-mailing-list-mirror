Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0BC1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 13:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757443AbcIGNjy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 09:39:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32773 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbcIGNjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 09:39:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id j136so1321954wmj.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y94XdPXEhuQXEQJFgLv1SgRJjeXKSjZjdoUWbxmgYhg=;
        b=MqFS2hCkgrLY8OohE6VmDodkMI4UZ1UkCCCkWFsjHy7ZdGYRgJB/iaP7winEkNdgef
         JJi6oyp9QKV59HTG543L1MtfsOusaklsLF8lJIvcQfgi2XyT6Dytr4SeMKMc0D+8qsS5
         VegvCXyWi+aWt9TmOsaw2O4IS7tQTWfpqDjz+yZfbN/thhlwUCRqSpvkcudOuXZ88B+T
         WXSxdoX7bBuR3bT4QXm1cXLWQThpqj9kU4/X47t+8TDZGtewNCZq9m1LdaN2+RAWJa/u
         wxjjEu76uv6Z8mLpflgg2dnnYpkAx3kmO7VZR3kvoAVJzrJfFFZAZ81KV6Yj4JML8a9z
         DNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y94XdPXEhuQXEQJFgLv1SgRJjeXKSjZjdoUWbxmgYhg=;
        b=iXlHnvlQ/5BJ9o9Zfzp31tpI/AgJVpkhqYZQrcKmtaU4+YnNMf7t270AfPViNr+1uw
         n5fpcqdsdu73ZRoIkGHrXS+2WBYJMNwXrT0XJHaoNeerVP/LRITlqjkj2oxPdxCTth6X
         k72ZShgtRlg6hfrXVUuYWkrpCRsotQBqj3quPXmt4qhL2R43X74D2mym7Doy26MIpPxx
         n8rAxLtJRMo5+k5wGgG+JTMxBu+lofaJ2quQCwJ6iU1c3513UF05er2TG+uOQXYf9Ydu
         f9OfUV9FIykPm+xTgkD6WQyTNzqjKQlU2h3euM1tpE87mqK0Ub92KD77imJ3kSkUcpFC
         dPrg==
X-Gm-Message-State: AE9vXwOsDGkvC827jevI9DfmzPOU6VgE6x/dni9Wz1lZTE6OBoaQZsS4P36ehRdqpQlO2A==
X-Received: by 10.194.65.35 with SMTP id u3mr21055580wjs.189.1473255591606;
        Wed, 07 Sep 2016 06:39:51 -0700 (PDT)
Received: from [10.32.250.72] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id e5sm4369259wma.13.2016.09.07.06.39.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 06:39:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 2/2] read-cache: make sure file handles are not inherited by child processes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160906210632.GA28263@starla>
Date:   Wed, 7 Sep 2016 15:39:49 +0200
Cc:     Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
        tboegi@web.de, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <7B903664-0324-4375-A81C-1317020CBE9B@gmail.com>
References: <20160905211111.72956-1-larsxschneider@gmail.com> <20160905211111.72956-3-larsxschneider@gmail.com> <20160906210632.GA28263@starla>
To:     Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Sep 2016, at 23:06, Eric Wong <e@80x24.org> wrote:
> 
> larsxschneider@gmail.com wrote:
>> static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
>> {
>> 	int match = -1;
>> -	int fd = open(ce->name, O_RDONLY);
>> +	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
>> 
>> 	if (fd >= 0) {
>> 		unsigned char sha1[20];
> 
> Also, this needs to check EINVAL when O_CLOEXEC != 0 the same
> way create_tempfile currently does.  Somebody could be building
> with modern headers but running an old kernel that doesn't
> understand O_CLOEXEC.
> 
> There should probably be a open() wrapper for handling this case
> since we're now up to 3 places where open(... O_CLOEXEC) is
> used.

Right! Actually "sha1_file.c:git_open_noatime()" is already a wrapper, no?
Can't we use this here? The O_NOATIME flag shouldn't hurt, right?

Thanks,
Lars

