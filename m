Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF371FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 17:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbdF1RPZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 13:15:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33290 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdF1RPY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 13:15:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so9803618pfh.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9Pgo1lm7kARFhC/OtnNpS+E2JBfEhCDxL3jM98xlruo=;
        b=XziK3M/bExvCla9JExgIVNOU35tJ2bLM19OQbOCslB6t3PXmLyJn6Hscr2XvLDFa4d
         45f3ClbnakJFl13QBiKemvzM1UXMx41ZlJCitzaklQWsOcC1chZe00rMkL8BuorpxrEK
         IDGbTm4oswi8F5ds3BfCZgpGSozgVeEFEu9jxBA0jkJeQMRnw2QxMzqvm5g8vJp5VQXX
         B6TyNcGLRwjhTQU0YtB4qZWIZ8EY0W2GyHiUC19Bz8T4EIvNu/hXK8m0BG1PFdIqwaxO
         6ipu9oVPMIQvS/xmARw7D/KRbxs//LfXVcfI7O+VWd1JLH10EbHxY4Al6UdWRRNzgQ/Y
         3t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9Pgo1lm7kARFhC/OtnNpS+E2JBfEhCDxL3jM98xlruo=;
        b=QftfGKXtCGAPXPV5Emx1jJcQm+g4hr9jkZUAAIWXLqG4+bXqXFJWq7+Dc6YwjF8a3z
         w8Rj02GoD9Y8/GDRXFZ96wmBHpfsBiBb5RYjT6d7bVC87VHARfxZbbW2Ugpcvke51y2V
         sRQy6lVmKhPlrqwYIHt3kERbT7H4RGx696mN2TBcMj8X/JwFrmrMh30WvDpI5RraAfC9
         RVlnivRDGgPvzXa6X9Mg0EOq540oNHihVmRUsDc3vh9ZIzc3+P8P4zyJzAwUj4uDuY/g
         To28/mu7JLdCKYIcCY0l3XXSn3aDlqWxg35Xxu/+QPrswAlJOAYXo8W9wR/UQ5Juf1vE
         Hw1Q==
X-Gm-Message-State: AKS2vOzzXxMiAyuE+5xKfPOe/NGf6NIyR7xSIvHbVUIgXmqXF4bpks+R
        kyix0A8mkq9FsA==
X-Received: by 10.99.39.194 with SMTP id n185mr11571722pgn.94.1498670123365;
        Wed, 28 Jun 2017 10:15:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id g10sm6535566pfc.38.2017.06.28.10.15.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 10:15:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Kebe <michael.kebe@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Solaris 11.3 SPARC grep problem with t1450-fsck.sh
References: <CAKKM46uJLu+w-UUFZc1HRar3apAD6Db2KD+GjiNL5v+Q2Ni7hA@mail.gmail.com>
        <xmqqa84t2yaa.fsf@gitster.mtv.corp.google.com>
        <CAKKM46ureAZNB-YjOrmi+H-_tf3hXGS7dA7o=dj8bnHc+8ABng@mail.gmail.com>
Date:   Wed, 28 Jun 2017 10:15:21 -0700
In-Reply-To: <CAKKM46ureAZNB-YjOrmi+H-_tf3hXGS7dA7o=dj8bnHc+8ABng@mail.gmail.com>
        (Michael Kebe's message of "Wed, 28 Jun 2017 08:00:24 +0200")
Message-ID: <xmqqo9t8vxsm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Kebe <michael.kebe@gmail.com> writes:

> 2017-06-27 18:25 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>> Ah, wait, that particular grep may have GNUism.  If you changed it
>> to
>>
>>     egrep "$tree \((refs/heads/master|HEAD)@{[0-9]*}:" out
>>
>> does it make it pass for you?
>
> Yes, this is working.

Thanks.
