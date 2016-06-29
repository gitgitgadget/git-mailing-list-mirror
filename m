Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF9720FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 19:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbcF2TwM (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 15:52:12 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36075 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbcF2TwK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2016 15:52:10 -0400
Received: by mail-qk0-f174.google.com with SMTP id j2so52525534qkf.3
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 12:52:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=v8hlwZ/n/F3HqgilO7q4bxwEI4LSJRo1oiAldsek6QA=;
        b=oBpyo9OyxNKGuyx3E9DmBlt3H89zBBOMHxlVDOEURqJ3eIa3r3qvO0d5QgrOqQE320
         Vv4v8P/TxwlxU0+sZmx3IbEbccL6MoROL8gcT1/EMTEG3pP0vaRedbw3K5jhlOV15noP
         uI1rysd7A1QK3gBUtyuAESIFcqp1zW9V+N7UTQ7lBWrKNRLolXaHPhFY/7+DWu44EiJ+
         UgLW9OOWO8484yx4sd2grU7yDNMyR9wcgEHgkUqJgc1nC2CgYlVDCp/g/+sw3YGp7mAl
         aFdLzJiJjwvrViZa4hvXDWyc4nID8HFrYgQ+Oq0CPsJFoREdeQsf4utc1auw5IQ0wkRb
         7Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=v8hlwZ/n/F3HqgilO7q4bxwEI4LSJRo1oiAldsek6QA=;
        b=cCT3Ha6HEE62HgwTN4p6PVne7Iw9pT1xETAg6VbdSFwAIlvUnwYSZBDzPyBNtPpVS/
         g84NgiyCCJuxREyzksw4tqF7G6vP5J1bdA2fNbGW9PlIcAc1ozeq2kGvU9Rjfpwh6Rrm
         0fEOZ5ahvW7j+B7qsTb3IINHQYhcXgWqVfvmzrwwymH5OEXcQ2w2IrH9l9rYXEKDqyY4
         N2fpRWBtqjJZMHQ3yowNLr1w9qsJU7hTYv7q3EutsTrT/N7O6GSMG/GDi0C6CREhmBYn
         XN0R5T+OqokT1jLFRQbVii9Fp+37ra5rJ84xGGp95aJj9kXitI3uclliaHJ/ewedLdbr
         gPkA==
X-Gm-Message-State: ALyK8tI5nnBzovQu3dCcbycJm9e/Lrpq+A5jpPt42o/N5663M1naZ/HObK+gOoa255Atg8P9dlN7grvrXZUnZQ==
X-Received: by 10.37.4.10 with SMTP id 10mr4440360ybe.28.1467229929244; Wed,
 29 Jun 2016 12:52:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Wed, 29 Jun 2016 12:51:49 -0700 (PDT)
In-Reply-To: <577425EF.6030900@gmail.com>
References: <577425EF.6030900@gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 29 Jun 2016 12:51:49 -0700
X-Google-Sender-Auth: n37-S6hLFgHbE6LRdyM1XW6lV3Y
Message-ID: <CAPc5daVqjhWrJjNX6monHdMTRwimbjz==j9B2FS-nXNCqPDCYQ@mail.gmail.com>
Subject: Re: [RFD] Place to document magic pathspecs like ":/" and pathspec handling
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 12:47 PM, Jakub Narębski <jnareb@gmail.com> wrote:
>
> I have noticed that the magic pathspec ":/" is described only in RelNotes
> for revision 1.7.6:
> |I think the reason might be that there was no good place to put that
> information in.  Nowadays we have gitcli(7) manual page, but perhaps

$ git help glossary

look for pathspec.
