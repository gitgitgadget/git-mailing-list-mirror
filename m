Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A921F404
	for <e@80x24.org>; Tue, 27 Mar 2018 15:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeC0P1U (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 11:27:20 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36451 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeC0P1T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 11:27:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so33925445lff.3
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wDJ6FW3DJj1cQnUcZRyRjxU67wNxgbR2wPV7tTU3oWo=;
        b=kGk1eZvN8cbDf5zxfKaT0xCzya6ZnaPh6mL8kJbMSeyQ2SvLVzVQmP1ZKOafDiu7WK
         iJ3WW5QoOYeP15aT3/rOAY9A+D0ZMnihqZWw8bJh6ZlkesO1b5rPjhO+rc6sCsToKhKU
         TPYnYX6MX9qlWWW+HLs9m37pdPdXIPF8phXYOss51EhnFA0RLrUkjNoocpjdNkY6kcAV
         g2Wsoq9vvqpxE5qdWsL1rylzWhRBADDXvGeEP+S+rwgLS39v/H/VPEQQcfjG27mh2/G0
         PqA7k14rv8TNePPrnHHS+1A085wNgf6nyhw6OTUMQA9IwAfpUcDKoRD2nldJHgfmZW7c
         jwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wDJ6FW3DJj1cQnUcZRyRjxU67wNxgbR2wPV7tTU3oWo=;
        b=rldU+oDbfadT8Gu/SEP5h9ZbD3JxRosk0lenwWdHhKxmqePHXW3+Rab7KsG5t8Mlno
         xOA3HhsJ8eLWYYi6ctqpbvmBv88AhOOlmjlS9VUrrFJ8sYSS9Tm3TeUdvhfl3EweAmP5
         xuiIZl4s3ezroM+xMuMGAoIcWhXnrZM9t5GIoqY/UxnGzJW9nDybak0O87UXttdkfkjl
         zMQQzcpSOmEyc9kJCsekimL1/EJ828Q6JM97PTMkTrzU1psY5R2eCVvblD6dJxWUoYLS
         I6UBykZfZVuBZkgtOrA3P6Jz0cqrk9cl9DO9OeTj8UPpRE6Ja+SOOJoXmDV1PkTyL47N
         4deA==
X-Gm-Message-State: AElRT7Hjxtad7n90W+IIew6Fy9VW5eZl5lFdAWXZZayQT4iOsSeg7oDZ
        wHweF6zZbcbWYAbdXUAq4s8=
X-Google-Smtp-Source: AG47ELuZlRrDIHi/YCNmJBvK5rJVJ/UgM9dRl0FVOteOV/fLEezEySlMbjy/cWAE19KukBEpjgiufw==
X-Received: by 2002:a19:5c4b:: with SMTP id q72-v6mr31413248lfb.126.1522164437847;
        Tue, 27 Mar 2018 08:27:17 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 93-v6sm288670lfy.5.2018.03.27.08.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 08:27:16 -0700 (PDT)
Date:   Tue, 27 Mar 2018 17:27:14 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 07/35] connect: convert get_remote_heads to use struct
 packet_reader
Message-ID: <20180327152714.GA27050@duynguyen.home>
References: <20180314183213.223440-1-bmwill@google.com>
 <20180315173142.176023-1-bmwill@google.com>
 <20180315173142.176023-8-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315173142.176023-8-bmwill@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 10:31:14AM -0700, Brandon Williams wrote:
> In order to allow for better control flow when protocol_v2 is introduced
> +static enum protocol_version discover_version(struct packet_reader *reader)
> +{
> +	enum protocol_version version = protocol_unknown_version;
> +
> +	/*
> +	 * Peek the first line of the server's response to
> +	 * determine the protocol version the server is speaking.
> +	 */
> +	switch (packet_reader_peek(reader)) {
> +	case PACKET_READ_EOF:
> +		die_initial_contact(0);
> +	case PACKET_READ_FLUSH:

gcc is dumb. When -Werror and -Wimplicit-fallthrough are enabled (on
at least gcc 7.x), it fails to realize that this die_initial_contact()
will not fall through (even though we do tell it about die() not
returning, but I guess that involves more flow analysis to realize
die_initial_contact is in the same boat).

Since -Wimplicit-fallthrough may be useful to spot bugs elsewhere and
there are only two places in this series that tick it off, is it
possible to squash in something like this? On the off chance that we
fail horribly to die, "break;" would stop the wrong code from
executing even more.

This covers another patch too, but you get the idea.

diff --git a/connect.c b/connect.c
index 54971166ac..847bf2f7d6 100644
--- a/connect.c
+++ b/connect.c
@@ -124,6 +124,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
 	switch (packet_reader_peek(reader)) {
 	case PACKET_READ_EOF:
 		die_initial_contact(0);
+		break;
 	case PACKET_READ_FLUSH:
 	case PACKET_READ_DELIM:
 		version = protocol_v0;
@@ -303,6 +304,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 		switch (packet_reader_read(reader)) {
 		case PACKET_READ_EOF:
 			die_initial_contact(1);
+			break;
 		case PACKET_READ_NORMAL:
 			len = reader->pktlen;
 			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))

--
Duy
