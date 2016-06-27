Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3892018B
	for <e@80x24.org>; Mon, 27 Jun 2016 17:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbcF0Rcm (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 13:32:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36758 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcF0Rcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 13:32:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so26529280wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 10:32:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7zINLD1mUfUlS7zUjJzVoEu7sk/JhvS9GLlQWLfr0jI=;
        b=acKeaP+CiIuecTyP1sWrAsLm0CfFh5MpW+E53HW6oXmP884q8VmuLwMpAlf6QkbVwq
         AH3y7Yr/ecew7TWNi1K2+1o54fJ2Efuc357v+6CvKCqfhXi8M6BmjE49E2SNbDt4krZV
         jqmX/04KyLYsWvKBCyyY0eFVbqw2CcrVvccoFJ6T3iWKfxGr75V2fvRgnkX27oVPgazt
         BxVMUjKKaEGs0/iEMIlhbBmq2hlhS2LceR4VI5Rie9UHgEDkr64tNQHdtaJRCUb1NC8J
         h0r3V1Yw0jxi42j3tLmjNTmBrjvthMSCFyaAcVoVWOVivoBcV24Cg241RXXYQRvprJte
         hu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=7zINLD1mUfUlS7zUjJzVoEu7sk/JhvS9GLlQWLfr0jI=;
        b=AXQ+Knsz0LVaty22X4MMlUjZ0lUJpaKOwyzGUPToIn3RExwfrJRk5QQ8G6Jg3NvZHx
         hHg/ByNIcYGKcmQYhja9Jg6IYbSRPy3qy+oDyQFZn/bCNNRuOYVOgZgC2ceSKFC/DmcH
         yKh95p5Iwz0S4Ef6n6ngod82R14Ld+9MWf8o1x1gIA9EnRvDuliDQzf2GtuG/zeJfkc4
         wUy7LW9JoDRvl9J8ULhwlnpJZcvTn7ZEVKh34xnIe+G+ydms38uJOkWo7Ysa7Efpxebc
         S3YUTvOz5ZLWUD3MGeWSHX2yR9hLGxyZpcSjH7SpRefZokC/v+ugQaXwfRjMzTlGA26u
         e4nw==
X-Gm-Message-State: ALyK8tJJK1yQxMC8Z3cN5vgkpPJ//5LL3LF+UVcNoIeFQDrKbEvHbL1AjZUtQdmBJsr5oQ==
X-Received: by 10.195.9.200 with SMTP id du8mr2009081wjd.89.1467048760005;
        Mon, 27 Jun 2016 10:32:40 -0700 (PDT)
Received: from [192.168.1.34] (afj108.neoplus.adsl.tpnet.pl. [83.25.139.108])
        by smtp.googlemail.com with ESMTPSA id b200sm6747123wmb.9.2016.06.27.10.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 10:32:39 -0700 (PDT)
Subject: Re: [PATCH 2/2] Ensure the file in the diff pane is always in the
 list of selected files
To:	Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org
References: <20160627132137.GC4194@pflmari> <20160627132308.GD4194@pflmari>
Cc:	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57716329.8000809@gmail.com>
Date:	Mon, 27 Jun 2016 19:32:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20160627132308.GD4194@pflmari>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-27 o 15:23, Alex Riesen pisze:
> It is very confusing that the file, diff of which is displayed and which is
> marked as selected in the file list, is not, in fact, selected. I.e. the array
> of selected files does not contain an entry for it.
> 
> Fixing this also improves the use of $FILENAMES in custom defined tools: one
> does not have to click the file in the list to make it selected.

Could you improve the readability of the commit message, please? Perhaps
something like the following:

  It is very confusing that the file which diff is displayed is marked as
  selected, but it is not in fact selected (that means the array of selected
  files does not include the file in question).

  ...

This patch lacks sign-off.

> ---
>  lib/diff.tcl | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 0d56986..30bdd69 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -127,6 +127,9 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
>  	} else {
>  		start_show_diff $cont_info
>  	}
> +
> +	global current_diff_path selected_paths
> +	set selected_paths($current_diff_path) 1
>  }
>  
>  proc show_unmerged_diff {cont_info} {
> 

