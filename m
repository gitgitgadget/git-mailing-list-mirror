Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CEC1FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 15:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1948538AbdDYPJR (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 11:09:17 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33840 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948623AbdDYPJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 11:09:14 -0400
Received: by mail-qt0-f196.google.com with SMTP id y33so25442137qta.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8KcnrCbRJR7MsNf6l6/jjxD3sH2/RVGIzOQgs70getY=;
        b=f3Vps7Tr+ufp4929/jadJ5eD8/s+YNeHR6dYI2+OewWLaKj1FlO2KbdFvwO7iUSQeB
         CIL1i4EBNmeqkYppWqmoxcY9r7AcMYzYbb+fCYsr84Xizc2tiLxOpFkcIMPMcZF4lObV
         A8X8/pwHj8c8MVqkZf5udi1GyydfPMF48P9SXH5KbjdrQztbEFtdV/cmbdWKp+168by/
         8lWfBfKvGQt3zPKrvVZV3a18CO4dzchUGCMKCMzfw39fz4L/Ku1ZCO45ag9NQmRewg8B
         4lxcoqgxQTCAH21aecZqw6+N3BNGmlqxyL23BYaYS7ePTV3mx8RN1o5OwZPRMIp1lJpw
         FoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8KcnrCbRJR7MsNf6l6/jjxD3sH2/RVGIzOQgs70getY=;
        b=GsX1irghZ8+sI808rg7vp/X4Tizl0lN764gWLLioDB2WBHpgv8vSRAHQWgQLW4CHoe
         B9nw7oT7b83FZmFM+PCR6w/3GzN8rx5LPVYQn+lz2Orh8qU0SoRQAWK5DP0PDo1iaC7l
         JyfwOv7fR6rigPGJoFw8jQTXwIXcb/8WjWSNP3RDe11NX2zfIFoB4BgpBOm6g6zC4YH2
         XDSrXRkPy53HYWtdIrzod5B8b/IYZiIzp+8rMNBuhUMZ6ZNU4Aiz7d7PM6g6wBrvD4Lj
         uw1j1WBcvT+/gfNuDyT1membtVKx+n5cXN8cRmmoiE+U2RYkY9xeuNC00g9JVMRWCdVM
         RcNg==
X-Gm-Message-State: AN3rC/71ORCy8qjRAOQuj7Ba0u06w29w7QNpdDhF9bKBm0ny9iJPhETR
        UWZm1oDYHjWNZA+gKYU=
X-Received: by 10.237.39.146 with SMTP id a18mr34104450qtd.111.1493132953001;
        Tue, 25 Apr 2017 08:09:13 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id q6sm15191147qtg.39.2017.04.25.08.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 08:09:11 -0700 (PDT)
Subject: Re: [PATCH v6 1/8] pkt-line: add packet_read_line_gently()
To:     Junio C Hamano <gitster@pobox.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
 <20170421172611.12152-2-benpeart@microsoft.com>
 <xmqqy3uqzb90.fsf@gitster.mtv.corp.google.com>
 <d6e8a63b-e95d-4194-5ad0-d68f557be083@gmail.com>
 <xmqqbmrlxm8m.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
From:   Ben Peart <peartben@gmail.com>
Message-ID: <4cadf613-7923-e8bb-c889-34e1bf5eb47c@gmail.com>
Date:   Tue, 25 Apr 2017 11:09:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmrlxm8m.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry if you get this twice, somehow Thunderbird converted my response 
to HTML


On 4/24/2017 10:19 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
>
>> On 4/24/2017 12:21 AM, Junio C Hamano wrote:
>>> Ben Peart <peartben@gmail.com> writes:
>>>
>>> +{ 
>>>> +	int len = packet_read(fd, NULL, NULL,
>>>> +			      packet_buffer, sizeof(packet_buffer),
>>>> +			      PACKET_READ_CHOMP_NEWLINE|PACKET_READ_GENTLE_ON_EOF);
>>>> +	if (dst_len)
>>>> +		*dst_len = len;
>>>> +	if (dst_line)
>>>> +		*dst_line = (len > 0) ? packet_buffer : NULL;
>>> I have the same doubt as above for len == 0 case.
>> packet_read() returns -1 when PACKET_READ_GENTLE_ON_EOF is passed and
>> it hits truncated output from the remote process.
> I know, but that is irrelevant to my question, which is about
> CHOMP_NEWLINE.  I didn't even ask "why a negative len treated
> specially?"  My question is about the case where len == 0.  Your
> patch treats len==0 just like len==-1, i.e. an error, but I do not
> know if that is correct, hence my question.  We both know len < 0
> is an error and you do not need to waste time elaborating on it.
>
>

The packet_read_line() function returns NULL when len == 0 and 
PACKET_READ_CHOMP_NEWLINE is passed so I wrote the similar 
packet_read_line_gently() function to behave the same.

How about I update the comment in the function header to make this more 
clear:

diff --git a/pkt-line.h b/pkt-line.h
index 7c278a158b..b2965869ad 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -78,9 +78,10 @@ char *packet_read_line(int fd, int *size);
   * Convenience wrapper for packet_read that sets the 
PACKET_READ_GENTLE_ON_EOF
   * and CHOMP_NEWLINE options. The return value specifies the number of 
bytes
   * read into the buffer or -1 on truncated input. If the *dst_line 
parameter
- * is not NULL it will return NULL for a flush packet and otherwise 
points to
- * a static buffer (that may be overwritten by subsequent calls). If 
the size
- * parameter is not NULL, the length of the packet is written to it.
+ * is not NULL it will return NULL for a flush packet or when the number of
+ * bytes copied is zero and otherwise points to a static buffer (that 
may be
+ * overwritten by subsequent calls). If the size parameter is not NULL, the
+ * length of the packet is written to it.
   */
  int packet_read_line_gently(int fd, int *size, char **dst_line);

