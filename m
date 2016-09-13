Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4258120985
	for <e@80x24.org>; Tue, 13 Sep 2016 22:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758429AbcIMWMh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:12:37 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37422 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755957AbcIMWMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:12:37 -0400
Received: by mail-wm0-f47.google.com with SMTP id c131so136635195wmh.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jWHICwawD2TJo4POCglIUeUoFepmzvFb5VXBNfqgPF8=;
        b=VwVl6SpAxzMA5QuKHT0jdluwIC2ZmMoB+mm009FFN7IcOW8ujCMYSIZQlhyWQGKnZh
         5u12t/Bzlnv+Ug8O2oB4E+LRu9dgWNYLG8suuJc8bYtlAQ+a8XP6jJruJADpy95v9jlR
         OHcF+cZKRdzHwt9woKoP8fEBS1TeybxwjBMfFCb7+05Jhud6B2yCOFUeLnSRJ/uZ3PK0
         LfCOS6yXIH1J6kpJo60EBZoQ9aEkebVG/U2JKiBdRavqSrRLQux/lD488/E8tdwzH5nV
         D7iKVWoilTbN6v2Ew533CopthLLh3nUAbGLIiTEMfIUrFozQniiz/zpLV/SecekyiPMZ
         Ljmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jWHICwawD2TJo4POCglIUeUoFepmzvFb5VXBNfqgPF8=;
        b=IYMVO2x2M8C6TtAis3qh7/1RR2nvmbTvuRGUVlYiEnvaQtq1P3xeq4si6Dq6HkFWoI
         gJdwrtVE2vc7eVitlWuFSZ2aNADMWRrYshWlf5taR+1LovKcEQViRZMVHVzhhlu131/w
         5uRnOpPDfpbRpcrAYFvRH3CBFPvLY1bml9GJ6nAD/X6E7Rw5pTzChwf0dhJRzVx89Y/l
         2r621W/HpbIM4a9ivQ1f+ELG9iwClQIvQltDfKHhVDLVEnx3SwhMNemg9EdXDYHcbpB8
         CkvGPOS5j10h1UU/b6XE7vrVxxF33DBS0CfDF7JBw/RdmisxxjzRcsgOKQoP7PZiG67+
         HMoA==
X-Gm-Message-State: AE9vXwMd5E4L+RU5waA8Tx3r2LdjhdDwsUJC8MBlDzywWDiYH5ATO90s1ISuWdWSzmNJKA==
X-Received: by 10.28.37.67 with SMTP id l64mr2794614wml.105.1473804755688;
        Tue, 13 Sep 2016 15:12:35 -0700 (PDT)
Received: from [10.32.248.227] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id q139sm7404913wmb.18.2016.09.13.15.12.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Sep 2016 15:12:35 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 04/10] pkt-line: add packet_flush_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqinu0y9v1.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 13 Sep 2016 23:12:33 +0100
Cc:     Git Mailing List <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, tboegi@web.de, jacob.keller@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <B138B703-08A6-45C4-9D54-80F87C75356B@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-5-larsxschneider@gmail.com> <xmqqinu0y9v1.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Sep 2016, at 00:30, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> packet_flush() would die in case of a write error even though for some
>> callers an error would be acceptable. Add packet_flush_gently() which
>> writes a pkt-line flush packet and returns `0` for success and `-1` for
>> failure.
>> ...
>> +int packet_flush_gently(int fd)
>> +{
>> +	packet_trace("0000", 4, 1);
>> +	if (write_in_full(fd, "0000", 4) == 4)
>> +		return 0;
>> +	error("flush packet write failed");
>> +	return -1;
> 
> It is more idiomatic to do
> 
> 	return error(...);
> 
> but more importantly, does the caller even want an error message
> unconditionally printed here?
> 
> I suspect that it is a strong sign that the caller wants to be in
> control of when and what error message is produced; otherwise it
> wouldn't be calling the _gently() variant, no?

Agreed!

Thanks,
Lars
