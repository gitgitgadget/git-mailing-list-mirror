Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1031F453
	for <e@80x24.org>; Mon, 21 Jan 2019 11:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfAUL7b (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 06:59:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32873 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfAUL7b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 06:59:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so23060610wrr.0
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 03:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OC3ibb59laI2k4kCA1Mgz6/9FymOdIU2FadjixH5sro=;
        b=GslpwA/tXynNNaXojIGuSmnJKFamkilYZ0lEmx2vEYEREHjzytZQ/rMDy2tL32/AuC
         5uj+pS8GrgpYO816tqjlCrDTGp2t5nEzbdlZm25Ts8PlmqoGzEoGmbiCAOdbS3kJ9wE6
         bwjHzj9SHFruHPrXoxIUmX7H8+3BRi2JJTr9DLMiYuNHk1HyFkTkA7Se/9Cxvbwyqmbq
         CTtoxr0zAWMBBnyQNGSkkfBI/OKQa635jqs8R0WPcgjN4qRYdchZffnYnWIenSgazvCc
         utMFumHkS67UpKMi9k0zDd5xNPAC00FEqBwXxZC8nuhAyrCpj0WKKlUBcUiCd2aniX16
         Rp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OC3ibb59laI2k4kCA1Mgz6/9FymOdIU2FadjixH5sro=;
        b=dH6RmHnXO62xFHAMj1WpVnc0ZRvtF2oA4Bp3hJJoz/JKyouGjp0QPXjtQd/TP1tdA0
         hTNyxV++SHPt6QGcSGfDWR6/v8Yphzkydf+90Tkrf8Yt5DzBrf8xNCntlgdgOnB2RFTE
         Fh6Clu2zMvzdBA4Hdkd2MI6AaAn12TgHRUUqAvr9k3Q7hrm9tH+CIp4hGzwOkdVDCuzW
         DwT2+ew6Z0gX+beeGRIF2g59hRQwrU1xCrJfUrusCl6VLn4d3d99GsbOpdtxPCiopNED
         /OzKTOl7qNFn/FBDRnY1274nFd+vGn0uNVGoeuPB7i370/+jMdxBVKeHAuHPHUyF4dwY
         zbAw==
X-Gm-Message-State: AJcUukeafABWM3EhdWnLB2XQRFtW92ME7aXBpG+LjTJr2gYXNac6ffKd
        YEKvsNXN5JRBpN0cZBAsALeJo3Sb
X-Google-Smtp-Source: ALg8bN4uVbuVWE2LXJTTmumy1rDmHyUqHgBLHFIdchlgYVOLjiFxSq/yNV7tvqHM6OmmUDy0mLhdDQ==
X-Received: by 2002:a05:6000:14f:: with SMTP id r15mr29432993wrx.53.1548071969183;
        Mon, 21 Jan 2019 03:59:29 -0800 (PST)
Received: from [192.168.1.7] ([31.223.156.16])
        by smtp.gmail.com with ESMTPSA id w18sm32703992wmi.12.2019.01.21.03.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 03:59:28 -0800 (PST)
Subject: Re: [PATCH v3 7/7] add--interactive.perl: use add--helper --show-help
 for help_cmd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.103.v2.git.gitgitgadget@gmail.com>
 <pull.103.v3.git.gitgitgadget@gmail.com>
 <b9a1a7e37a477e978f19cbcc9b41f80519de54da.1548062019.git.gitgitgadget@gmail.com>
 <87fttm49hv.fsf@evledraar.gmail.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <1224d852-6009-7c91-764a-f1015ed253b5@gmail.com>
Date:   Mon, 21 Jan 2019 12:59:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87fttm49hv.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Ævar,

thanks for taking time and making review.

On 21-Jan-19 10:59 AM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Jan 21 2019, Slavica Djukic via GitGitGadget wrote:
>
>> From: Slavica Djukic <slawica92@hotmail.com>
>>
>> Change help_cmd sub in git-add--interactive.perl to use
>> show-help command from builtin add--helper.
>>
>> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>> ---
>>   git-add--interactive.perl | 11 +----------
>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
>> index a6536f9cf3..32ee729a58 100755
>> --- a/git-add--interactive.perl
>> +++ b/git-add--interactive.perl
>> @@ -1717,16 +1717,7 @@ sub quit_cmd {
>>   }
>>
>>   sub help_cmd {
>> -# TRANSLATORS: please do not translate the command names
>> -# 'status', 'update', 'revert', etc.
>> -	print colored $help_color, __ <<'EOF' ;
>> -status        - show paths with changes
>> -update        - add working tree state to the staged set of changes
>> -revert        - revert staged set of changes back to the HEAD version
>> -patch         - pick hunks and update selectively
>> -diff          - view diff between HEAD and index
>> -add untracked - add contents of untracked files to the staged set of changes
>> -EOF
>> +	system(qw(git add--helper --show-help));
>>   }
>>
>>   sub process_args {
> Both this and an earlier change in this series replaces a callback
> command with an invocation of system() without any error checking. So if
> this add-helper fails for whatever reason we'll silently fail to report
> it.
>
> I think it makes sense to put something like the following WIP code
> earlier in the series. Then if the command was e.g. ["false", "git",
> "status"] we'd see:
>
>      What now> s
>      oh noes when running 'false git status': returned error '1'
>
> WIP patch. Obviously not ready as-is, but feel free to consider this to
> have my SOB & adapt it.


And thank you for writing up this WIP patch.  I will adapt it and have 
your SOB.

-Slavica


>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 20eb81cc92..1cd5f8122b 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1777,7 +1777,7 @@ sub process_args {
>   }
>
>   sub main_loop {
> -	my @cmd = ([ 'status', \&status_cmd, ],
> +	my @cmd = ([ 'status', ["git", "status"] ],
>   		   [ 'update', \&update_cmd, ],
>   		   [ 'revert', \&revert_cmd, ],
>   		   [ 'add untracked', \&add_untracked_cmd, ],
> @@ -1794,11 +1794,23 @@ sub main_loop {
>   					     ON_EOF => \&quit_cmd,
>   					     IMMEDIATE => 1 }, @cmd);
>   		if ($it) {
> -			eval {
> -				$it->[1]->();
> -			};
> -			if ($@) {
> -				print "$@";
> +			my $cb = $it->[1];
> +			if (ref $cb eq 'CODE') {
> +				eval {
> +					$cb->();
> +					1;
> +				} or do {
> +					print "$@";
> +				};
> +			} else {
> +				if (system(@$cb) != 0) {
> +					if ($? == -1 || $? & 127) {
> +						print STDERR "oh noes when running '@$cb': unexpected '$?'\n";
> +					} else {
> +						my $ret = $? >> 8;
> +						print STDERR "oh noes when running '@$cb': returned error '$ret'\n";
> +					}
> +				}
>   			}
>   		}
>   	}
>
