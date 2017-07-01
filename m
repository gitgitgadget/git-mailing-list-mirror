Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63BF20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdGASwL (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:52:11 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33717 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751911AbdGASwK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 14:52:10 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so18808023pgb.0
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=wadh7eYvwT9ZANWawLg6B1LqvDvxwzR1uATgj5zf2nk=;
        b=Jw+aAz+v6HVZ97D6eOmF65nxMR2GVvC+qfodk7p0m+ehcDoLU8wZrirzkQ4tliBOLq
         t/fhaEKgt3bjOtuXiQoMtmYCzRkKni6CGFauukLGSaV7fkR2SHM1w9rmYpfFtf4+UTLU
         adcQpAR+V4homQeu5SRsIFhjS23VolcMbRsXw/N649BgmUM6aDW8a2BTIIvT01KaNAru
         Wpn77fsGv+Z1rnf3E32sC9keCoc5JG4cPU7u6iaMkIv3BESEsT93JgANgzQRFWobVRuh
         o6N65e0wVc2vPCKGS42jtJGsUYPVYSXJLb8NDDG9/taNZFDXHl9hE2KgufIpjedNgXhM
         /4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=wadh7eYvwT9ZANWawLg6B1LqvDvxwzR1uATgj5zf2nk=;
        b=UIV8+ey0GaX+x4D8GBPKeUC2FNPcvLBpQYjrp/cQ34n3LPsXo+e6wrdvPHIC8JQSO9
         /oxvg7UIQRtDZqh63JecIii8xm9xSyHXgU2VjF9j7KFzF8abeGvlL7zrDzaAvzFGkd7X
         4Hm+C6GnXEy9Lk/Mdovr9tCV7Jt5kFxVefT0lQmEV1liC9XHuRgwHejJqN6KjbpR7z+K
         gYmY5NuV6kbRCKVAvcpR22pNOq5rizBc47FfZuB+CDS0hmOG1QEYRsjgCmlMJ4R0oGSL
         +2g4oDwpl9ihfjAagTPkX7HdmARrT6PxJi3sBKj2UKk+H5bYSoEV9BXywsirlx7eKSm0
         fUmQ==
X-Gm-Message-State: AIVw110b5XTIO70nNK5Msi2+Ur6PJZ2MIFnbGgDABYWrSF5PSlUtkoIP
        gM5CrWIVFW9QfQ==
X-Received: by 10.84.148.134 with SMTP id k6mr1926138pla.150.1498935129948;
        Sat, 01 Jul 2017 11:52:09 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id d24sm27915722pfk.43.2017.07.01.11.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 11:52:09 -0700 (PDT)
Message-ID: <1498935127.11617.1.camel@gmail.com>
Subject: Re: [PATCH] hooks: add signature to the top of the commit message
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Date:   Sun, 02 Jul 2017 00:22:07 +0530
In-Reply-To: <xmqqfuegnjnt.fsf@gitster.mtv.corp.google.com>
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
         <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
         <1498918546.4321.1.camel@gmail.com>
         <xmqqfuegnjnt.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-07-01 at 10:36 -0700, Junio C Hamano wrote:
> Actually I was wondering if it is a good idea to remove it, as it
> seems to have outlived its usefulness.
It does seem  to be a good idea but it would leave the 'prepare-commit-
msg' hook with no scripts that could be used by just activating it.
That's why I thought of adding a script that removes the "Please enter
your.." message from the comments if it exists. A typical patch will
follow.

Enabling the "prepare-commit-msg" hook with the patch that follows
would do have following result,

Before,

    # Please enter the commit message for your changes. Lines starting
    # with '#' will be ignored, and an empty message aborts the commit.
    # On branch hook-test-merge
    # Changes to be committed:
    #    	    new file:   commit-msg
    #

After,


    # On branch hook-test-merge
    # Changes to be committed:
    #    	    new file:   commit-msg
    #


A typical consequence for "git commit --amend" would be,

Before,

    Test commit

    # Please enter the commit message for your changes. Lines starting
    # with '#' will be ignored, and an empty message aborts the commit.
    #
    # Date:      Sun Jul 2 00:11:28 2017 +0530


After,

    Test commit

    #
    # Date:      Sun Jul 2 00:11:28 2017 +0530
    #

