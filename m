Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00AF7201A7
	for <e@80x24.org>; Mon, 15 May 2017 18:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbdEOSKS (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 14:10:18 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34814 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdEOSKR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 14:10:17 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so27102576pfj.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tv0LILs9AfYnGS2og6CBl3q8kMRIbJEsxxrt5EawLxM=;
        b=hu1n5BmfzhLQNYYwaQ2dA5+KPy0IMoOZa7eOw4XweWvxn1eokOY9oNVZu2Nm+ghxpB
         RISOovRla6EfAWhgIYa2hqQVckODq6KFBbYzYTI/2nd7ozlZVjw9NxkLxH4QE8Tmykip
         0adUFcqEleOdfTWpV8zppMdhqDA9+KDlg6/BflL3S/qE1Xs85I63q2z+jJUnz6wxipEd
         MqWf4nervLfUhVN9LV4/6ZCJZahi4sS3NYwkseq7lLCLJOK6py1r8VAjaR7vB7j6WFFW
         BkXkHRHuO4y87L9Yr63J8g7+9cmqKO0ph2DZvV0L0oc63VjJXPhLkmZgurWS6LuhD2wE
         72Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tv0LILs9AfYnGS2og6CBl3q8kMRIbJEsxxrt5EawLxM=;
        b=E4k9iq0ck/40QepPbw6yi8BZTyHslxcMfZIT90jsjErDANG94DQP9wIcqt2nUVuT3f
         Lob3lPfjY7J+SFtlsrXQK4iiOz8BGcmNvj/dNp5MiQ7Pw9qsbFoWE/nUZnnnIduq8ChR
         R25aE7lAkuFIq2X+xNGIwLOatN/4m7JPZxgGd0E8/sSAVcUn8E1LgzIULZyNS9792hs4
         JGU7xpCnKKnvNbAyOHmk+b3xNgNwYy5ERwnXIth71aDlH05kuZiIEY5yAp4IjHeQtzsX
         6ARuBF/BlYQfS5OD1k/svNwehAJQf4nGfugoXJnjNXy5Sq5k2CKz3OaXZYPzoIXe/nzk
         C/CA==
X-Gm-Message-State: AODbwcDqEwC54hNDTPyffk2I6JAYDNoPOet22eS9YL0Q6BL2IQXYvV+v
        X35cWlpcj4Q3kTHw
X-Received: by 10.99.23.102 with SMTP id 38mr7543581pgx.4.1494871816781;
        Mon, 15 May 2017 11:10:16 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f484:2515:b6cf:fcc0])
        by smtp.gmail.com with ESMTPSA id z3sm21664939pfk.99.2017.05.15.11.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 11:10:15 -0700 (PDT)
Subject: Re: [PATCH v2] send-email: support validate hook
To:     Junio C Hamano <gitster@pobox.com>
References: <20170511193753.19594-1-jonathantanmy@google.com>
 <20170512223827.21372-1-jonathantanmy@google.com>
 <xmqqk25iyjbr.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <a3ab7799-f849-2f9a-79d6-a0f4693dc7a7@google.com>
Date:   Mon, 15 May 2017 11:10:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqk25iyjbr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/14/2017 06:55 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index 706091a56..b2514f4d4 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -447,6 +447,14 @@ rebase::
>>  The commits are guaranteed to be listed in the order that they were
>>  processed by rebase.
>>
>> +sendemail-validate
>> +~~~~~~~~~~~~~~~~~~
>> +
>> +This hook is invoked by 'git send-email'.  It takes a single parameter,
>> +the name of the file that holds the e-mail to be sent.  Exiting with a
>> +non-zero status causes 'git send-email' to abort before sending any
>> +e-mails.
>> +
>
> I briefly wondered if an interface that allows only the name of the
> file will close the door to future enhancements, but in the end
> decided it is OK.  E.g. users may want "here is the contents, is it
> appropriate to be sent to this and that address?"---but this hook is
> meant to enhances/extends the existing "make sure the contents do
> not syntactically bust the technical limit of underlying transport",
> and sits at a place best to do so in the codeflow, i.e. before we
> even start to decide who the recipients of the patch are.  So those
> who want "given the contents of the patch and list of the recipients,
> decide if it is OK to send the patch to all of them" would be better
> served by a separate hook, not this one.
>
>> +	write_script .git/hooks/sendemail-validate <<-\EOF &&
>> +		# test that we have the correct environment variable, pwd, and
>> +		# argument
>> +		case "$GIT_DIR" in
>> +			*.git)
>> +				true
>> +				;;
>> +			*)
>> +				false
>> +				;;
>> +		esac &&
>> +		test -e 0001-add-master.patch &&
>> +		grep "add master" "$1"
>> +	EOF
>
> I'd squash in cosmetic changes to de-dent the contents of
> write_script (our standard style is that the body of the script is
> written as if the column at which write_script..EOF starts is the
> left-edge of the page; I think this file already has a few style
> violations that may want to be updated with a separate clean-up
> patch when the file is quiet), and then de-dent the case arm (case
> arms are indented at the same depth as case/esac).  Also I think we
> care that 0001-add-master.patch not just exists but is a file, so
> I'd do s/test -e/test -f/ while at it.
>
> Thanks.

Thanks to you too. I agree with these changes - sorry, your previous 
reply must have slipped my mind when I was writing v2.
