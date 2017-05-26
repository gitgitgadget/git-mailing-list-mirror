Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02AD1FA14
	for <e@80x24.org>; Sat, 27 May 2017 01:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756631AbdE0BLw (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 21:11:52 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33714 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948773AbdEZWDW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 18:03:22 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so22459215pfh.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 15:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2YXL0jHH00ex1niF7URfJGQ7j8DhnIzuUmtTIgSYP34=;
        b=P/KQuFqt2OaL9FzwRawWv9RzzIuN1Mbeht5J8iHzrBIa8hRIWD2uPni7vpJLXp1S9x
         mojrA/2CpPZmLisK+fYveWQhMjzPk2AD2BjnR1O6mgKTcVZs4tYnBHN4WMzC0vYeqQhs
         WLGGuQAlvHNmRNREY3hUGskA+YRCKHM3NnggvO8cVg3rMiKkKT5r1iExpjG3MIMkofHY
         Kbx9NpKkY5ZBI6iMDoSyFserl3ZBSFA6Hc+moJOqX24v+iRfIcT+GFf44qvzglnepL2Y
         x2OvAWNGEQ5ePCQ7o2Yeot/p8/eyqywTd750D2NY8+h7P/1VnGk8BThYjUh0hGOmH6VK
         jpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2YXL0jHH00ex1niF7URfJGQ7j8DhnIzuUmtTIgSYP34=;
        b=PjOzAVusvayv3Uel0u3RCHG9dt1bcVNHfjJil8b9WjJx9Bkc0vmEfvKaAqJhiFNIrV
         bkoZoz2ZhljTXUbkwIV4VfgdQJXanCPGVMUAd2BubCg7m+MfSydj9DTMwenPCKITsF8G
         D48uvWB6bzC5h59PzEAWVDU3pHhMa3kkBHGmbGTtVX7arDgsziqwPTnOpgda5Hl5li+J
         W19Ujk7aRLAraPz5yJ2NPacRnOR0u5lfdDBGkuANa4YjI10GJN9YSqLNa9hm5qmetiye
         F1Part3hCidHAT6CpWJXTitJQyK99Zu3B1EnMxuhPiPEMin9bKk4xhbAOkKZlMeFOTLM
         Kx3A==
X-Gm-Message-State: AODbwcCsBrKFQc5c5Ms+JEPomD80uebFZ0m8L074iwwS3Hspk7cBO+Bc
        WCrAaZkRtVSgO1oF
X-Received: by 10.98.223.28 with SMTP id u28mr4688508pfg.97.1495836201867;
        Fri, 26 May 2017 15:03:21 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:56f:46ea:751:c7c2])
        by smtp.gmail.com with ESMTPSA id p76sm3783033pfa.53.2017.05.26.15.03.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 15:03:20 -0700 (PDT)
Date:   Fri, 26 May 2017 15:03:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Prathamesh Chavan <pc44800@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, ramsay@ramsayjones.plus.com,
        sbeller@google.com
Subject: Re: [GSoC][PATCH v5 3/3] submodule: port subcommand foreach from
 shell to C
Message-ID: <20170526220319.GC4592@google.com>
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
 <20170526151713.10974-3-pc44800@gmail.com>
 <83801d05-e3a9-b7e4-8f29-cd8172257dac@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83801d05-e3a9-b7e4-8f29-cd8172257dac@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/26, Johannes Sixt wrote:
> Am 26.05.2017 um 17:17 schrieb Prathamesh Chavan:
> >+	argv_array_pushf(&cp.env_array, "path=%s", list_item->name);
> 
> Not good! On Windows, environment variables are case insensitive.
> The environment variable "path" has a very special purpose, although
> it is generally spelled "PATH" (actually "Path" on Windows).
> 
> Lowercase "path" may have worked as long as it was only used in a
> shell script (and perhaps only by lucky coincidence), but this I can
> pretty much guarantee to fail. (I haven't tested it, though.)
> 
> The correct fix can only be to rename this variable here and in
> shell scripts that need the value that is set here.
> 
> -- Hannes

Nice catch, the only reason why this would have worked before was
because it was a shell script before...

-- 
Brandon Williams
