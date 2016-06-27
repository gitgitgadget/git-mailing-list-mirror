Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F702018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbcF0SKm (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:10:42 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37962 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbcF0SKl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 14:10:41 -0400
Received: by mail-wm0-f53.google.com with SMTP id r201so126538658wme.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:10:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R7skDXoDu1RZEjo7p/kK9KzqZulHjEyQWHnsbNKR3Oo=;
        b=nE2uCg+of5cGV/YdWgp3mM9dOp0thVejy8S+t/EimT3WELMavHoGTjsdEHFq9ipmUH
         1AfYIGTUq/D7bcpN1k+nqE1Zd1TpB7QtQEyU8Q5FpjHSYn6wcjNFrAdu6+fZ/KCyCbCn
         P4VGO9aCgDiAK1Pdnwl/JnIua6mjoObovcs0vhX1UVWrLgtT29bg+uvVDuqsbxvjif3i
         0fxxB1Kq6xdibMv/38seSyeiUuu8FJbcCF92qtLtJMtHzFrclWwJevz8A/h645q8tsro
         vz31BYjfkBQSxtdMerclGIVwCouLwXLdukeWlVpBIvwCZGdM97rFB2fjT1FS0ptxksJF
         1m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R7skDXoDu1RZEjo7p/kK9KzqZulHjEyQWHnsbNKR3Oo=;
        b=LWWozOSCfbDksXdfO6cuostPSmO9Sv9Xn1wOlfk47oo8xZrWPEDfoH+sk9aK6Y16md
         NILWA3fd3TPLZ5WC5LB0W7UZZiOo1VLdkNsqEL9j0dtKDIqL6IslVZ0QKkDiUxWx50hG
         jdQhg2MUxgth8TVnUJO0XldKPC4l/536xb5s8mgyEEjQjbfXYn+WkpFVvaHWMwr+EUKN
         4Ad82N7jdQWDeifUip2iIbcEPmGJKw9jGaS23WdVaEyECGKgZkVK92lYBGPL4bDkBkRG
         3dpFxS9woI924QkwC59bgU8IMZTrBa3arT7AalSD05kT8jAIySc1gAe9hFNjkZjVgULv
         bPTA==
X-Gm-Message-State: ALyK8tL0Io1i4RG+sEHYpIMeHarzLS5E5roQvfJgX39Ku8RIhPurT5T2XaoypTpDAdn6CXxk3XRo3jZWEGONLA==
X-Received: by 10.194.178.199 with SMTP id da7mr2085862wjc.123.1467051026972;
 Mon, 27 Jun 2016 11:10:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.164.169 with HTTP; Mon, 27 Jun 2016 11:09:47 -0700 (PDT)
In-Reply-To: <xmqq7fdabjsb.fsf@gitster.mtv.corp.google.com>
References: <20160627132137.GC4194@pflmari> <57716227.1030104@gmail.com> <xmqq7fdabjsb.fsf@gitster.mtv.corp.google.com>
From:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:	Mon, 27 Jun 2016 20:09:47 +0200
Message-ID: <CANQwDwcq=O-ZVW2=+EnZnmCZpTjP=soQ_-cQP_n0p-TJ6DFQ-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Support for $FILENAMES in tool definitions
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Alex Riesen <alexander.riesen@cetitec.com>,
	git <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 27 June 2016 at 19:53, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narębski <jnareb@gmail.com> writes:
>
>> On 2016-06-27, Alex Riesen wrote:
>>
>>> This adds a FILENAMES environment variable, which contains the repository
>>> pathnames of all selected files the list.
>>> The variable contains the names separated by spaces.
>>
>> Why not separate filenames with end-of-line character (LF)? It would still
>> be broken for some filenames, but only for unportable ones.  Filenames with
>> internal space (common on MS Windows) would work then.
>>
>>   http://www.dwheeler.com/essays/filenames-in-shell.html
>>
>> If Tcl allows it, you could separate filenames in FILENAMES environment
>> variable with NUL ("\0") character...
>
> Tcl may or may not handle a string with an embedded NUL, but I think
> it is hard to have an embedded NUL in an environment variable.
>
> Use of LF is a good suggestion regardless.

Or be a good citizen, and use $IFS... though then the user would
need to set it to something sane-ish.

-- 
Jakub Narebski
