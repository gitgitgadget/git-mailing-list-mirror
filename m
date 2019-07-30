Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30921F462
	for <e@80x24.org>; Tue, 30 Jul 2019 12:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfG3MuK (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 08:50:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44982 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG3MuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 08:50:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so65624724wrf.11
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7rTbJrjZWX9xIAsBA1x8hjIVtity8T1RkOfC59f+wuM=;
        b=nxWQ1aKt1TPVtjakp7DpfUt8Sl/a/8uIZAXZZ1NCJwo32/wjYRbsAfI/Qc27mPw1eA
         47gfLIMRnbJENd/dpzSBiP4sYEJ8yVfgang4qgg3yV+201ZsE9KdZWBY7ZYHdbcBMsf+
         N+FuMs/RQweBkQhTdLkazdtZWFWpt6CN1uZQVYzVKKGze3VdOQHuvuYKJRxO/WqH/i7M
         uKj7V2uZfv1e2HEST5ALI5O6R88OYmBfQ4vlJ47z24q+LiQAcnvNLm+PhZsihubZXNAL
         Z2vCfYspYXLYZvYva9zk5je00JrGIl6FPFnKXazDjOBJFOtLtKiXByDw8wyebhYAua0D
         rqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7rTbJrjZWX9xIAsBA1x8hjIVtity8T1RkOfC59f+wuM=;
        b=Exc6zw7WW0NGd6OCTk5mh8q3HWcRiH9Jpr8ZpVIV08QDRXcjDaWc2ebXNq16nyYe7Y
         39svrcGFmunqbVL2Yc+GVLpfTh7u94LkQ8EzXQbqlMkttoGJQt1EbJO1MSFB8yy1sN3K
         eWGYD3aAIwbimqgV8AUr/CBwaUvJg6WWdB5QvoMHtZ0PEZDH7AhbYBBU2mIMPIX+E4Cc
         LxoUjqqR1rbgMox07MaKw/2vRz9sPKtlU/6W19ilJfonuDvACWDlXJbgDg1Sfzi4eBE2
         cY5Dn/q/dQKwPTGpEtD8Q5+sqfLgsH+snwQZ+flubLUHHv8dwifTYSCYABQMWI3F8Byo
         LGhg==
X-Gm-Message-State: APjAAAW7fQD7ErS/7CjnzXALUfGGrFEluzZcSLZII9AXyoVejlhEcybC
        tMyq1Glk0jHTal/Gp1j27JPDSdBg1GwdpLq0bkCC2mA2UOvnvUxA1pza3glyKSMMsTTqNMafjYg
        nYQmlwjNWlB/wl0fMWmdfKVkxk+aPrNzd5ojUBNdNC9G3SMgQTxL4reLoiWxgCcESaNl3PNyb4F
        hEkwU0KWGUWg==
X-Google-Smtp-Source: APXvYqzmB6E6qifpNLa4xgpf8fgCmowY7x4kapJeJNDrubMmJNZ4zTwiG1FqnnuB77qaclr52LktEQ==
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr12566167wrx.65.1564491006688;
        Tue, 30 Jul 2019 05:50:06 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w67sm83057824wma.24.2019.07.30.05.50.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 05:50:06 -0700 (PDT)
Subject: Re: [PATCH] send-email: Ask if a patch should be sent twice
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
References: <20190730001352.7477-1-dima@arista.com>
 <87r26768lc.fsf@evledraar.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <59e47154-5b07-4ef0-9883-dc3f53b31fc2@arista.com>
Date:   Tue, 30 Jul 2019 13:50:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87r26768lc.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/19 12:54 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 30 2019, Dmitry Safonov wrote:
> 
>> I was almost certain that git won't let me send the same patch twice,
>> but today I've managed to double-send a directory by a mistake:
>> 	git send-email --to linux-kernel@vger.kernel.org /tmp/timens/
>> 	    --cc 'Dmitry Safonov <0x7f454c46@gmail.com>' /tmp/timens/`
>>
>> [I haven't noticed that I put the directory twice ^^]
>>
>> Prevent this shipwreck from happening again by asking if a patch
>> is sent multiple times on purpose.
>>
>> link: https://lkml.kernel.org/r/4d53ebc7-d5b2-346e-c383-606401d19d3a@gmail.com
>> Cc: Andrei Vagin <avagin@openvz.org>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  git-send-email.perl | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> There's tests for send-email in t/t9001-send-email.sh. See if what
> you're adding can have a test added, seems simple enough in this case.

I wasn't sure if that needs a test or some `--send-them-twice` option.
Decided to send it early.. Will add a test.

> 
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 5f92c89c1c1b..0caafc104478 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -33,6 +33,7 @@
>>  use Net::Domain ();
>>  use Net::SMTP ();
>>  use Git::LoadCPAN::Mail::Address;
>> +use experimental 'smartmatch';
> 
> We depend on Perl 5.8, this bumps the requirenment to 5.10. Aside from
> that ~~ is its own can of worms in Perl and is best avoided.

Yeah, I'm not very into Perl and Stackoverflow *blush* suggested to use
~~. Will drop.

> 
>>  Getopt::Long::Configure qw/ pass_through /;
>>
>> @@ -658,6 +659,17 @@ sub is_format_patch_arg {
>>  	}
>>  }
>>
>> +sub send_file_twice {
>> +	my $f = shift;
>> +	$_ = ask(__("Patch $f will be sent twice, continue? [y]/n "),
> 
> These cases with a default should have "Y/n", not "y/n". See other
> expamples in the file.

Ok.

> 
>> +		default => "y",
>> +		valid_re => qr/^(?:yes|y|no|n)/i);
>> +	if (/^n/i) {
>> +		cleanup_compose_files();
>> +		exit(0);
> 
> Exit if we have just one of these? More on that later...
> 
>> +	}
>> +}
>> +
>>  # Now that all the defaults are set, process the rest of the command line
>>  # arguments and collect up the files that need to be processed.
>>  my @rev_list_opts;
>> @@ -669,10 +681,19 @@ sub is_format_patch_arg {
>>  		opendir my $dh, $f
>>  			or die sprintf(__("Failed to opendir %s: %s"), $f, $!);
>>
>> -		push @files, grep { -f $_ } map { catfile($f, $_) }
>> +		my @new_files = grep { -f $_ } map { catfile($f, $_) }
>>  				sort readdir $dh;
>> +		foreach my $nfile (@new_files) {
>> +			if ($nfile ~~ @files) {
>> +				send_file_twice($nfile);
>> +			}
> 
> One non-smartmatch idiom for this is:
> 
>     my %seen;
>     for my $file (@files) {
>         if ($seen{$file}++) { ...}
>     }
> 
> Or:
> 
>     my %seen;
>     my @dupes = grep { $seen{$_}++ } @files;
> 
>> +		}
>> +		push @files, @new_files;
>>  		closedir $dh;
>>  	} elsif ((-f $f or -p $f) and !is_format_patch_arg($f)) {
>> +		if ($f ~~ @files) {
>> +			send_file_twice($f);
>> +		}
>>  		push @files, $f;
> 
> ...but picking up the comment above, I'd expect this to be in the "if
> ($validate)" block below or something similar, seems like this fits
> right in with --validate.

By default it's on - sounds good to me.

> Then you can also ask "do you want to send this set of patches twice
> <full list>?".
> 
> Now the user is asked a file-at-a-time.

Ok, thanks for the suggestions.

-- 
          Dmitry
