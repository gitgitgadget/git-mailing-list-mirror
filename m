Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2CAD1FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 16:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbcFYQjI (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 12:39:08 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34743 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbcFYQjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 12:39:07 -0400
Received: by mail-io0-f182.google.com with SMTP id g13so115407321ioj.1
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 09:39:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=il1zn95H2ym/9pbzPnGq2AVyp8w0g2jH2Ir2TpHM6xU=;
        b=0E1+ySFkTa0ATBHCx1ceEIqJxGkmwTKRJ7bj4t9p2OQ7CKq/AAl/Lh/7wt7PmlcZxn
         iq8xIttZF3ojZQ6n/CXVLRqcEayQ0DrKLCvaxcPg14pbVNI52KisVYwtSTH6gXA8FDV2
         Hb5LDOS4pbckZvccgaQnboJX0zipjFkQAfvcP7A2RJPUSFu1n85zcafeGdVMLkBhwuZh
         7Djxm/Q4o5t6Wymy/wEmPgueoxuMb4DfxKQBoRMtUHG8LrRMrJgwErGDoTD7RQGsPftw
         cKj4IqVk94fDGIjHip3hEz1jZktsXiQ2umWK4zsDZrBVvbhAUKCQ0KpwQmqeTdsowe/V
         DcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=il1zn95H2ym/9pbzPnGq2AVyp8w0g2jH2Ir2TpHM6xU=;
        b=bzD73MNDxVpRX0xFronWecaQq4K0/RJbqe9rmFTKpHBB3BUhY1oUA2Ej2Ds1isAgoV
         7feb8maPNis8aYtB8ig94rsMqXLjqOjX0I2m2LkjTMdwT4NHOna2jTZYjO8gmaS5GrS1
         H6EmlwCyfnULVMG++u00oR/ELE06WwacUgxwikjk+1sEliAY2K6gghgwc6qOo0DXtRRD
         pJKMae59srmT6BzeMZgT546jOCLGCObbU128Fs3mPYLbjcVBhzJxhaVeQiE9Vzaex3s7
         +igzOw5sdXez5XnkWVbOTPynDl0VTCqeb3iLA2+h68i5mriVZOOO7hmcc8ou2Y98wjei
         hZBA==
X-Gm-Message-State: ALyK8tJ0/FXz6SA4bUFwyfGZ/45kDQmPFsIENcvW6MpaIG6MgrANyELojHSfvkMlrhSU463f5w9vyBfEPoC1ag==
X-Received: by 10.107.8.220 with SMTP id h89mr10462953ioi.95.1466872745712;
 Sat, 25 Jun 2016 09:39:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 09:38:36 -0700 (PDT)
In-Reply-To: <1463694357-6503-19-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-19-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 18:38:36 +0200
Message-ID: <CACsJy8CaN4fkd9tzvR8NeqpVHmKH5p6S151-A+SN0_LtrU3_fw@mail.gmail.com>
Subject: Re: [PATCH v12 18/20] index-helper: optionally automatically run
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> +static void autorun_index_helper(void)
> +{
> +       const char *argv[] = {"git-index-helper", "--detach", "--autorun", NULL};
> +       if (want_auto_index_helper() <= 0)
> +               return;
> +
> +       trace_argv_printf(argv, "trace: auto index-helper:");

I'm pretty sure run_command() does call this (with "trace:
run_command:" prefix instead, maybe drop this line?

> +
> +       if (run_command_v_opt(argv,
> +                             RUN_SILENT_EXEC_FAILURE | RUN_CLEAN_ON_EXIT))
> +               warning(_("You specified indexhelper.autorun, but running git-index-helper failed."));
> +}
-- 
Duy
