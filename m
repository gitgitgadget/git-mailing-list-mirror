From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v6 1/3] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Fri, 20 May 2016 12:47:47 +0530
Message-ID: <CAFZEwPPDU4NXP-nMXsEa2iB8j5nApxOdXXjGSW_OyLoum11ttw@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-2-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cQM2tyXWek7cMZkfks1SA4MHcf9yvfJ1SRZ2-mRf1Q47g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 20 09:17:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3eh1-0007WO-Iv
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 09:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbcETHRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 03:17:48 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36091 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbcETHRs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 03:17:48 -0400
Received: by mail-yw0-f181.google.com with SMTP id x189so101302116ywe.3
        for <git@vger.kernel.org>; Fri, 20 May 2016 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=StnpE2AKSqJKRsWSKZ9Gzuos40p2T4LSm7cmLB7/z+M=;
        b=sksdt3ilteVfkwomz1DzwH19PJPZdmiZ99Hm1dAyL5Uq0Aww7LprBpbLfh2c5RrG1J
         czAJch5Tg+b7F4jTrY79Eb5MtTPhKy31OLyQ+kOAQ10nKKpilI3Q9pmHaATlpZyx9cAu
         u0mo1BNrNXy0bZMq/Vr0aL8LcVsrv6fYUfEduy9mJGWKIl7+D/nwL5qlXdkAMmCoL4Pj
         QRUJhxBKAKc9xcSMuE0DHmI0jpOL10WTcw/fj7gnhyj0m5RtkgC7I/1dkYclCY1r6AUS
         7TIxmqev2130kSx93GVbzasfDymbg8T/AT0VYXexMPjApdV4dKHVVe0Bk6m/ujxU33Q8
         ZssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=StnpE2AKSqJKRsWSKZ9Gzuos40p2T4LSm7cmLB7/z+M=;
        b=T1VOFgLSRdQH5IrsVBJpAff8V8jZxHyA8ANBSFPFGAio/Wod0gKEt1O0ZToc/q7VvL
         9DPbU27CHFnLmtTswk5ALR8vBDnwBVDGkpfXEOBkhRnrczIxDMcoKH9aHLCqfoh0+RVC
         ObmZsMX1aAjkzHGatx+my3SiCtqoevpCnuRRbnC/3y5dZrMJc3sc1a4xq4oioqrP8Tre
         s7XysM3QzcNmddwfAnuwx/o9zmicrLnQIszIp/fWQN28lImKaIBM2mlQ1RELqzSpErMX
         CKuyf9UcuH5kAQd0SmSHhVoMwbQY31ZxTnNLL2pG5kxEdJw4YDD8fJ9staTB9FGw7sMS
         IB1g==
X-Gm-Message-State: AOPr4FUYU8Eh+tDQazbu7Bw9yF4MnAEi9n4kizZtkuDCEQ3WoIKOdOUzDSli5IMddmnaQSxDBgiD6lSOr/B8xw==
X-Received: by 10.13.235.143 with SMTP id u137mr928026ywe.20.1463728667172;
 Fri, 20 May 2016 00:17:47 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Fri, 20 May 2016 00:17:47 -0700 (PDT)
In-Reply-To: <CAPig+cQM2tyXWek7cMZkfks1SA4MHcf9yvfJ1SRZ2-mRf1Q47g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295152>

Hey Eric,

On Mon, May 16, 2016 at 12:37 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, May 12, 2016 at 1:32 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> `--next-all` is meant to be used as a subcommand to support multiple
>> "operation mode" though the current implementation does not contain any
>> other subcommand along side with `--next-all` but further commits will
>> include some more subcommands.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -23,9 +23,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>> -       if (!next_all)
>> +       if (!cmdmode)
>>                 usage_with_options(git_bisect_helper_usage, options);
>>
>> -       /* next-all */
>> -       return bisect_next_all(prefix, no_checkout);
>> +       switch (cmdmode) {
>> +       case NEXT_ALL:
>> +               return bisect_next_all(prefix, no_checkout);
>> +       default:
>> +               die("BUG: unknown subcommand '%d'", cmdmode);
>> +       }
>> +       return 0;
>
> What happens if you remove this useless 'return 0'? Does the (or some)
> compiler incorrectly complain about it falling off the end of the
> function without returning a value?

I tried removing it. It works fine with gcc and clang. You can see the
build on travis-CI[1]. I am not sure of other compilers and also don't
know a way to test it either. You could use my branch on github[2] if
you want to test it on other compilers. I think its better to keep the
return 0 if we aren't sure whether it would work on every compiler.

[1]: https://travis-ci.org/pranitbauva1997/git/builds/131622175
[2]: https://github.com/pranitbauva1997/git/tree/return-try

Regards,
Pranit Bauva
