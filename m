Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A277203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 21:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbcGXVas (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 17:30:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35128 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbcGXVar (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 17:30:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so14160793wmg.2
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 14:30:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=XJQ3dlj7inkD1e95qaL/PCyX+IuFz+ukVNyXo9BSIPg=;
        b=tAU/yiEQHdc83NI6l98sC96qF6kVmROqoUI8nWfDJVwGpIlx7u2tsQYhX+JcrISw9H
         H9PuFEZYM/cUhd6nxuAFp6b9BpTNMDdV5HXhfHf3k4VdsxZNe7mkTh7AeUKKlgu/f3YA
         LUZz+b1WNbL5Bp7G6fZMffpisasbagWKZkM20Q/CR+2Hz4sahA3Ae6EHmkzuFBFhoGFL
         8K6WLqd2BvVdEVa+8bJaRsgwiFI6aIDbmctc+RWHgs5euG+ZLP4Zf+9rZ5FSoGHmD3tW
         bHpMA73kBQosQ+TtO6wENbWEvK9I3YMkR6yacffzFIcs5GfTILoFjIL2b6C+BK1erP+Z
         WO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=XJQ3dlj7inkD1e95qaL/PCyX+IuFz+ukVNyXo9BSIPg=;
        b=e84yrUkl4xj2BLNn6/FZ7GJbiskL8zgMMpS++KnsXPJK5DV/IQ6l/8N1iqddm022B9
         Q7VYWLBmO5tb2grof8WdaetBR0PTp1L0zvrYCXdcJvZpwwgRqyGgjgHEogeDst5N87vt
         EVBeSVclQIb+SnUBoseevAGI3tuWxuEsiPZCVhOWOuuraelDk+jVnqLqjWNNa9UPTbIG
         NNBddx9kdQVS/yN4toZ4oAx9qdpt1tDywXPvGYdBd8H7+nw6WYWhplZ2FCz/x616AaYk
         tjY8C7IajKyJFliAyqscBVgbEr7bJil1BEFQkUxsArLseW9wECM2+tlHXJWXvMQDz1bV
         RQSA==
X-Gm-Message-State: AEkoouss7rH1mlgAddooOnlKZzyf8dZlJZKAa9KYMoiOOgPrGWlo5I24bMbevyb8EPwvfA==
X-Received: by 10.194.168.197 with SMTP id zy5mr13801858wjb.112.1469395845425;
        Sun, 24 Jul 2016 14:30:45 -0700 (PDT)
Received: from [192.168.1.26] (exa83.neoplus.adsl.tpnet.pl. [83.20.250.83])
        by smtp.googlemail.com with ESMTPSA id xa2sm12397074wjc.0.2016.07.24.14.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 14:30:44 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <5792B622.5040306@gmail.com> <0FB8A921-3465-4081-A36D-D2F19A8ED63D@gmail.com>
 <579521A1.4070501@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <e@80x24.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5795337A.1040701@gmail.com>
Date:	Sun, 24 Jul 2016 23:30:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <579521A1.4070501@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-24 o 22:14, Jakub Narêbski pisze:
> W dniu 2016-07-24 o 20:36, Lars Schneider pisze:

>> I agree that the name is not ideal. "UseProtocol" as it is would be a boolean. 
>> I thought about "persistent" but this name wouldn't convey the scope of the 
>> persistency ("persistent for one Git operation" vs. "persistent for many Git 
>> operations"). What do you think about the protocol as int version idea
>> described in $gmane/300155 ?
>
> You mean the `protocol` as a config variable name (fully name being
> `filter.<driver>.protocol`), being integer-valued, isn't it? Wouldn't
> `protocolVersion` be a more explicit?

Just throwing out further ideas:

Perhaps make `persistent` string-valued variable, with the only value
supported for now, namely "per-process" / "operation"?

Perhaps require for `pidfile` to be present for it to be daemon,
that is persist for possibly many Git operations. Or allow "daemon"
or "server" value for `persistent`, then?

-- 
Jakub Narêbski

