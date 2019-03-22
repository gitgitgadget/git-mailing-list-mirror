Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6330220248
	for <e@80x24.org>; Fri, 22 Mar 2019 05:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfCVFXx (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 01:23:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34158 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfCVFXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so929739wrq.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 22:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=He0cbT5rozKqKLtlm+XdzVRpTpj0aJ/SDqfOQmnkLcw=;
        b=IHbftnZDLGY86F7aRa/2C6Fteb1gME7SZwjv+PA0/gORjqJLfty79BklEpdQD64DfS
         mLYZLNrgorANmCeT45xRiWe81QBT9dinc11gE7EipxMStQq5UzGPhkcH3MCqt9idpBi1
         xvkaw+laHTG2qudxfT1ut1kD2CwSFTF2RAOjZ4Tk+sXJRCka9fx2oTE5WCaJ7iJzOyYG
         Li372W7wXnyaJBI8xA3+JTkjNRB/sy5ZaD8emWmst22oZ3qbgz1CDo4Iu3m8cONcARQo
         krzqzFJuJ5O6OlUCqcE203jM39okcIvXifejTyDcfSC7u3AtOjKsd+s0W3pkmoAtGDCy
         XAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=He0cbT5rozKqKLtlm+XdzVRpTpj0aJ/SDqfOQmnkLcw=;
        b=rgl3FdWndZPGwxjygpDb0SGBb4wxSLW+yE5yDoW6T69Sbm4ObY3Fom3nqfJBpJ7cdm
         xg0phMGFFcJf/rlApLrDS7Sswa0niepj4iCqYTcqcd5n5xHsZMdjAhF27I3VYKt3HJq3
         zmO3HwXqFlZhjYlttln9jE46mEBKMt7T7bDTCXmVvsWrQACJDNg/txsuPOF7Spc4aA0G
         nzdNoffvCJ6uucJZ05cEXj0z2xhtOKfXPr1BfdMRqW5bZEEctMSRTRisep4FW19qnwvG
         5GuBDtFZayEIz9EpkzmrsSntzV2OnAN6BlpkfN1NVix7SAUggKSgTcJjWUozSTdYrOGT
         lcSQ==
X-Gm-Message-State: APjAAAUXrmwu8ea7KI0GhFKYvzgCDYT6JR08E+UEBF0na2MLWYdl1IOV
        Egud4zVMe/DMX5lTnTSM4Z8=
X-Google-Smtp-Source: APXvYqzJT00ZqSF1ylAFv0jdmGFw0rObJ8od+l4NarYEwUrDWvJqr2aDW+d7XeGoLokr0E9yGsmfnQ==
X-Received: by 2002:adf:f64d:: with SMTP id x13mr5196500wrp.298.1553232197997;
        Thu, 21 Mar 2019 22:23:17 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 204sm11408772wmc.1.2019.03.21.22.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 22:23:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Write trace2 output to directories
References: <cover.1552519463.git.steadmon@google.com>
        <cover.1553202340.git.steadmon@google.com>
        <fc057cb5-c1c9-5466-1d45-c7d1e89a9894@jeffhostetler.com>
Date:   Fri, 22 Mar 2019 14:23:17 +0900
In-Reply-To: <fc057cb5-c1c9-5466-1d45-c7d1e89a9894@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 21 Mar 2019 17:16:52 -0400")
Message-ID: <xmqq36nfqy7u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 3/21/2019 5:09 PM, Josh Steadmon wrote:
>> Persistently enabling trace2 output is difficult because it requires
>> specifying a full filename. This series teaches tr2_dst_get_trace_fd()
>> to create files underneath a given directory provided as the target of
>> the GIT_TR2_* envvars.
> ...
> Looks good.  Thanks.
> Jeff

Thanks, both.  Will queue.

