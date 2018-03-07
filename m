Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2BB1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934346AbeCGWph (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:45:37 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:53478 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933533AbeCGWpg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:45:36 -0500
Received: by mail-wm0-f48.google.com with SMTP id e194so7766447wmd.3
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kD6yfol5l/OIhdVXRw+jSNV9BkdKOQGFvOOP50JMVgw=;
        b=pEz6b8yZLahq5EuOT4PCvpPIrIk7ouDsggcX90QmrzSwxhSZM2FV8vavrwBpG390ic
         mqeFwYmffJhTapa4HBk09TILYyEsDPl3R3TPmBt0JZMCA8Gs75MRcY9IKOeus/ncGnDe
         +iI2Ejl1GgqA+JYzSFSh16L6rJMwCoy0MTncB8RB0h5DfhmHRC1QEuey6H2ZkwRfATQO
         EPLvYsDEpxixc3hCryvgs5Tx/+80cB6h9X69W23BlcKFWYcMovC2aHxev64F2UHh09VZ
         NivMNFTkQTuIph+PB5QuoL7KMqbXdIB1nlEU7dgIcvwRJLf+i/O7MsZt2hix8YM6J47l
         Rh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kD6yfol5l/OIhdVXRw+jSNV9BkdKOQGFvOOP50JMVgw=;
        b=CDow608rzSC/KeYRmP5crU0S0abxdUnnPg2S3qTzyAWDzVx+sF22hXLt8mbJ7v83zv
         qWb053NSySfQVOINTj2eEU3nvG/LT6VBFxk7iTWvyLY0XGtyrCj8ox/d9Jq16aGvLVAK
         qDbHEt6MQCLCGWdcKqNu6fZhXLbe2TXVUWNtnfQkqslM89pbdA+YTjE83SJbBsy5xA+G
         Me0zAKk6T2Qtj2y6V3ZBxYFVfGyo/CI9YPpCXTSDEwshDafcO9gNHjjh+GoayattcaOP
         YPUiQcDL9QTKRBr7c/tdIP1orpHhy07Pl0jkGd5weBj1mwIqUgulBrlB5+zo1v0ulunW
         VwAw==
X-Gm-Message-State: AElRT7GJJ86sCnQ3/V0bNfucLardKOYjAh5N0LpvIeJuxbLpfvuE6ZQj
        IW9x1Rqccmu/qPsZHk8YNhgbgEnRSIc=
X-Google-Smtp-Source: AG47ELvf/IMp74kLKvLc55GcqwuHT1Sl2dq9NDADFJLCL3ajmwQBqQpb0m5B7uV8kq7OzsL6EB/odg==
X-Received: by 10.28.69.133 with SMTP id l5mr5486196wmi.100.1520462735180;
        Wed, 07 Mar 2018 14:45:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a1sm19609038wra.41.2018.03.07.14.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 14:45:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     kalle <kalle@projektwerkstatt.de>
Cc:     git@vger.kernel.org
Subject: Re: git help clone: questions
References: <6ea2b41f-37c3-8540-4763-7688f56fe202@projektwerkstatt.de>
        <xmqqinaa6l3b.fsf@gitster-ct.c.googlers.com>
        <81c78c4f-b690-d06c-bb7d-9c65e33777b5@projektwerkstatt.de>
Date:   Wed, 07 Mar 2018 14:45:34 -0800
In-Reply-To: <81c78c4f-b690-d06c-bb7d-9c65e33777b5@projektwerkstatt.de>
        (kalle@projektwerkstatt.de's message of "Wed, 7 Mar 2018 23:30:39
        +0100")
Message-ID: <xmqq4llrzer5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

kalle <kalle@projektwerkstatt.de> writes:

> Am 06.03.2018 um 02:36 schrieb Junio C Hamano:
>> kalle <kalle@projektwerkstatt.de> writes:
>> 
>>> -In the explanation of the option --reference: shouldn't there be
>>> written '<repository>' instead of  'reference repository'?
>> 
>> "Shouldn't X be Y?" is not an effective way to communicate; it
>> solicits a "no, the current one is fine." without any explanation.
>> 
>> If you think X should be Y for some reason, please say "I think X
>> should be Y BECAUSE Z" instead.  Without stating why you think
>> differently from what those who wrote the current text, it is hard
>> for people to respond either with "Yeah, you're right---I agree
>> with Z" or with "No, Z does not hold because..."
>> 
> I wrote this, because when it is written about 'reference repository', I
> consider it not totally clear, which repository is meant, as the option
> '--reference <repository>' only names one as <repository>.
> For reasons of clearness, I now propose writing "reference repository
> <repository>".

I do not have particularly a strong opinion, but I think it is very
sensible to call the value given to the option "--reference" with a
phrase that is not just "repository".

As the command line of "clone" must name one repository (i.e. the
one which we clone from), and its "--reference" option must name
another repository as its value (i.e. the one that we borrow from in
order to reduce the object transfer), calling both <repository>
makes it easier to confuse readers unless the writer carefully makes
sure that <repository> in the desription is unambiguous and it is
clear which one of these two repositories is being discussed by the
context.

I just re-read the existing Documentation/git-clone.txt and looked
for "reference".  All uses of "reference repository" in the prose
made sense and I found it would not be an improvement if any of them
is replaced with just "repository".  It may be helpful to add
something like:

	 --reference[-if-able] <repository>::
	+	Define a repository (reference repository) to borrow
	+	objects from.  
		If the reference repository is on the local machine,
		...

to define which repository we mean by that term, though.
