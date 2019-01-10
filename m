Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94CD1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 17:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfAJRgi (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 12:36:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51774 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfAJRgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 12:36:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so12089076wmj.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 09:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8eU2tCSE5n6c/lE0u+51817Mtykyht/iwYKrGFqxD0g=;
        b=OEqzbyj4puMNlkehD96Upvis4pJWHlcO1lLk2XTwF1V32jyhyg8RNAml8POY89ude1
         FZDHyrWxD0BICeXwSQ9xITRr9O42s7MV/DFlzefpw8biy1dk/MGOXhpJpXMS5H+91XZF
         v86aqY44XBaUCP1qlYUZvGHqWmWXRF7OWgOnfSUUl2XrY0Kafv8w0hW8FrJ7Sbwnof42
         /1E9HIWjoSlrQ58SoGkJdmwRNwN1ARolhApMrAf/sFuv9ByVcZh/z9FWoF//Yo+pt8QS
         mS6sIKShQU3UtdKhMpL889shme6VvyKbDH3tjLfbgzQhMFmJSobuBaGEJ5+mg9+ON3mb
         AASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8eU2tCSE5n6c/lE0u+51817Mtykyht/iwYKrGFqxD0g=;
        b=bXxClIwD6HimlL2ewX/LXoVUl1jSl1lv/ZvjByZj9VK2eQj2zY/PdhhCOkcR0ZClo8
         cldGQo2VXE9prb6EB8uJg5VjaUZoe2IBNMMqvll5xssuG5DSP8LU9R/3MU5okiU46XkJ
         EBN6H9H9synk247/QhxBogmTxJu0+sJgiR7IANe2yifixwAagp6ajVhOYqMIKX5pVq4f
         zfQ2FHxmUd9gWk/3dKzZP4CyjPdvxeKRGxsKHtI0fDM1lpo6BheCK9xk1NczMH3yW7oT
         d1UfN5MvOaT0hE4aFCX9uUIRKv+d5/wQ81h2T3qnA03YItMzSOtU/MN1ODNRrYIAr49F
         tHhQ==
X-Gm-Message-State: AJcUukeW+0D6WjtVrIZQdqTc0eQ5bmPJm7tb8r/ykKoCZLcpS5dvRE82
        UDjA3kJYv1aqNDiE/FIIW14=
X-Google-Smtp-Source: ALg8bN5EIsVy+wDIvtBPJjbBxoDXTQxXW7wPoypnRMTD38LkK3Bz/ZHem42wPocKm/ee3yohFwMkmg==
X-Received: by 2002:a1c:13d1:: with SMTP id 200mr10488943wmt.4.1547141796145;
        Thu, 10 Jan 2019 09:36:36 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k23sm13585792wmj.32.2019.01.10.09.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:36:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 1/3] t5323: test cases for git-pack-redundant
References: <20181219121451.21697-1-worldhello.net@gmail.com>
        <20190102043456.15652-2-worldhello.net@gmail.com>
        <20190109125628.GG4673@szeder.dev>
        <CANYiYbGqLHr-t+f6m6gyY3QiYgxbzbqsmmRw-afKe6NG_mxhPQ@mail.gmail.com>
        <20190110115704.GL4673@szeder.dev>
Date:   Thu, 10 Jan 2019 09:36:34 -0800
In-Reply-To: <20190110115704.GL4673@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 10 Jan 2019 12:57:04 +0100")
Message-ID: <xmqq5zuw4dp9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> Without `-E`, MasOS has to write two seperate sed commands, such as:
>> 
>>     git pack-redundant --all >out &&
>>     sed -e "s#.*/pack-\(.*\)\.idx#\1#" out | \
>>     sed -e "s#.*/pack-\(.*\)\.pack#\1#"

Two commands, perhaps, but does it have to be two separate sed
processes piped together?  Why won't something like this work?

	sed -e 's|.*/pack-\([0-9a-f]*\)\.idx$|\1' \
	-e 's|.*/pack-\([0-9a-f]*\)\.pack$|\1'

