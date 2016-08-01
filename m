Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68011F855
	for <e@80x24.org>; Mon,  1 Aug 2016 12:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbcHAMF2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 08:05:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34709 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbcHAMF1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 08:05:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so25890299wma.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 05:05:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lBgDdRMlZ2rc3RwTnkOpoePHAShpGknk09n/RHha9cE=;
        b=iJYaCBuCSW62hhEEby4EyrNSSroOYrM7yW3imR0i52UK1rz0c2dNxx2JlXkBXZ3ek9
         phHvPF+WjGpbPS3HUMRrkJQRotUtKoRAKkidlHLx8yYzieQWyFS07K7B1eSSWu5zUkei
         3G5fV+ZAB7TZKvHi4U1AxrXpBlz6UsjRpH9gP7MvtK9REB9kO3ArrcH4/3rb7Iyr7HS9
         00AwrXk5YMKAFzy8qTeweum4ro5e7xeE1FsmuFaIYAO8YB8iNH7kN5p8KTTXqWSfsh9P
         zlYKgMGnTQ4J33EGReB3C7qqADeHIgu6teeteggPe2NhpNWKBPgWztwqSmQKT46nILmT
         eJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lBgDdRMlZ2rc3RwTnkOpoePHAShpGknk09n/RHha9cE=;
        b=BkRWTeckg+jy0Etp4ueegoNYAH7s1UqKBeNdL+uYwhjJCVfJjeuOqMeAXODn5RanxO
         hy7eMkEZwB7ZPlDXYGO0qp/r4wE/K+oj5NM2CHO2BsULjTr10ZSI5RCLuNH6upgVbX2x
         CizcXlgb9WgS0Qx2gKWS1cN1EzFUcTb7taJ1TwQ29qHmbCJgkqZXX8NH3my9R08L9e2J
         cSZfutwshtUA2Du060Tglcn9noMyeJK/xNDJJueiTXrXTAhtTYorelkfvggWyxHomp1g
         2a2aZ3mx17ING09pvHVFUCbPa52fT5PMOHBIzvdm5ls/qWBdsLmAFdQTSrpmaIaIYCDy
         GeJg==
X-Gm-Message-State: AEkoousQxryq/CeS4/zh+lyle6MVQ7sgEQ+qceLlQhDAWG8LPGW8x3IV8WaxzBMc8S0Nfg==
X-Received: by 10.28.228.132 with SMTP id b126mr13918166wmh.93.1470050051479;
        Mon, 01 Aug 2016 04:14:11 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xa2sm30079943wjc.0.2016.08.01.04.14.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 04:14:10 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 06/10] run-command: add clean_on_exit_handler
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <ef6c6152-a720-6bd5-22bb-6ebf375ca919@kdbg.org>
Date:	Mon, 1 Aug 2016 13:14:06 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com, e@80x24.org,
	peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <EBBE9E5E-1A39-4124-AB0D-D74EE01FA0DA@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-7-larsxschneider@gmail.com> <ef6c6152-a720-6bd5-22bb-6ebf375ca919@kdbg.org>
To:	Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 30 Jul 2016, at 11:50, Johannes Sixt <j6t@kdbg.org> wrote:
> 
> Am 30.07.2016 um 01:37 schrieb larsxschneider@gmail.com:
>> Some commands might need to perform cleanup tasks on exit. Let's give
>> them an interface for doing this.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> run-command.c | 12 ++++++++----
>> run-command.h |  1 +
>> 2 files changed, 9 insertions(+), 4 deletions(-)
>> 
>> diff --git a/run-command.c b/run-command.c
>> index 33bc63a..197b534 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -21,6 +21,7 @@ void child_process_clear(struct child_process *child)
>> 
>> struct child_to_clean {
>> 	pid_t pid;
>> +	void (*clean_on_exit_handler)(pid_t);
>> 	struct child_to_clean *next;
>> };
>> static struct child_to_clean *children_to_clean;
>> @@ -30,6 +31,8 @@ static void cleanup_children(int sig, int in_signal)
>> {
>> 	while (children_to_clean) {
>> 		struct child_to_clean *p = children_to_clean;
>> +		if (p->clean_on_exit_handler)
>> +			p->clean_on_exit_handler(p->pid);
> 
> This summons demons. cleanup_children() is invoked from a signal handler. In this case, it can call only async-signal-safe functions. It does not look like the handler that you are going to install later will take note of this caveat!
> 
>> 		children_to_clean = p->next;
>> 		kill(p->pid, sig);
>> 		if (!in_signal)
> 
> The condition that we see here in the context protects free(p) (which is not async-signal-safe). Perhaps the invocation of the new callback should be skipped in the same manner when this is called from a signal handler? 507d7804 (pager: don't use unsafe functions in signal handlers) may be worth a look.

Thanks a lot of pointing this out to me!

Do I get it right that after the signal "SIGTERM" I can do a cleanup and don't 
need to worry about any function calls but if I get any other signal then I can 
only perform async-signal-safe calls?

If this is correct, then the following solution would work great:

		if (!in_signal && p->clean_on_exit_handler)
			p->clean_on_exit_handler(p->pid);

Thanks,
Lars