From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 11:16:32 -0800
Message-ID: <CAGZ79kZnECcGOWKr4JLpF5zh68+L8XX7yYntyZDJTbZ5cLD50w@mail.gmail.com>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
	<1421893929-7447-6-git-send-email-sbeller@google.com>
	<54C0F41F.2080705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jan 22 20:16:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YENF8-0003rX-9E
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 20:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbbAVTQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 14:16:35 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:41359 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbbAVTQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 14:16:33 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so2523790igq.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 11:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4NjsN4YBJolTKvAh0WDUFDNUvs1F7s3Csj1a983CzNs=;
        b=ID0m7h4bUWwT3gRZiVWdbHknhYVcJjIwwbvVvqiDXYqy4pHvEwrKtbjTj4wjioafYq
         kNxk7x1TiZOtGo/xtYpsDNeTfQ7737C6JOmg7Wb0DfzoRdeFjdZTaia0WZMeOsMX4fxV
         BhA+gonUdORPWwUHsL+qZB6XjsH5LakLOeGxS9J57cWbs0S/HiZAKvKh9xyPEpPT22sq
         M1y0bTSd2SlO0OrWsBTMc3zShen0ABSWleeRjojPC9ueMmPSi2DOKCNeLllOstYc4yJL
         3QPL5ozAjfzwIupyOqetG51JdSRsHJQw+iUJJFClcsEneUydJUZKJGvAMw702yqc8V1X
         2KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4NjsN4YBJolTKvAh0WDUFDNUvs1F7s3Csj1a983CzNs=;
        b=h/XZOmdAPoxDbFIWjyXX59b1rhFlLaG4KFP3q5fuCTp34xzzMUTEyOoLtmm7KLmj74
         M3tQoTJyTV4UcejS187847Y0nUyB3XiOMjbQHDavefMKqYiTzREc6eiUaXf+l6U6Z5ch
         ewXDzU4tok4jgIzv3BDxuasRHKttHdlSa3q7fHut4r8kHRA/TUwRHsJ05HBPUmLtR5Wi
         1Sa+Blqc/2ggKy3qEsPtGtptV8zwYv1FRR1Fh9dGrzudK0+sVoh9TCR3I8rNCPqDMT17
         Z6mb+s08VPpdtLE90cp0BGg6MkRXQQZ6i15sodOQYDzQRtqZOd81iGopTnuiib9rGpHz
         fFCg==
X-Gm-Message-State: ALoCoQnRW64lXJszBhB4wAMyg3F/OMevv3xwY0dU4v8+mulL1j4XtKSt22jGGs15s+DL4xAhzTxP
X-Received: by 10.42.230.67 with SMTP id jl3mr5179255icb.15.1421954192661;
 Thu, 22 Jan 2015 11:16:32 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 22 Jan 2015 11:16:32 -0800 (PST)
In-Reply-To: <54C0F41F.2080705@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262856>

How do you run sparse on git?

I noticed there is 'make sparse' though I cannot get it working
here in the corporate world as I have problems with openssl
headers not being found.

Also the line numbers seem to bit off compared to what I have
here, did you need to modify/preprocess files to get sparse running?

As for the fix, would it be sufficient to check != NULL instead of < 0?

Thanks,
Stefan


On Thu, Jan 22, 2015 at 4:59 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> On 22/01/15 02:32, Stefan Beller wrote:
>> By closing the file descriptors after creating the lock file we are not
>> limiting the size of the transaction by the number of available file
>> descriptors.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  refs.c                | 17 +++++++++++++----
>>  t/t1400-update-ref.sh |  4 ++--
>>  2 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 2013d37..9d01102 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3055,11 +3055,18 @@ int is_branch(const char *refname)
>>  static int write_sha1_to_lock_file(struct ref_lock *lock,
>>                                  const unsigned char *sha1)
>>  {
>> -     if (fdopen_lock_file(lock->lk, "w") < 0
>> -         || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
>> +     if (lock->lk->fd == -1) {
>> +             if (reopen_lock_file(lock->lk) < 0
>> +                 || fdopen_lock_file(lock->lk, "w") < 0
>
> fdopen_lock_file() returns a 'FILE *', so this causes sparse to bark:
>
>     refs.c:3105:56: error: incompatible types for operation (<)
>     refs.c:3105:56:    left side has type struct _IO_FILE [usertype] *
>     refs.c:3105:56:    right side has type int
>
>> +                 || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41
>> +                 || close_lock_file(lock->lk) < 0)
>> +                 return -1;
>> +     } else {
>> +             if (fdopen_lock_file(lock->lk, "w") < 0
>
> Similarly, sparse barks:
>
>     refs.c:3110:53: error: incompatible types for operation (<)
>     refs.c:3110:53:    left side has type struct _IO_FILE [usertype] *
>     refs.c:3110:53:    right side has type int
>
>> +                 || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
>>               return -1;
>> -     else
>> -             return 0;
>> +     }
>> +     return 0;
>>  }
>>
>>  /*
>> @@ -3761,6 +3768,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>                                   update->refname);
>>                       goto cleanup;
>>               }
>> +             /* Do not keep all lock files open at the same time. */
>> +             close_lock_file(update->lock->lk);
>>       }
>>
>>       /* Perform updates first so live commits remain referenced */
>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index 47d2fe9..c593a1d 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -979,7 +979,7 @@ run_with_limited_open_files () {
>>
>>  test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
>>
>> -test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
>> +test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
>>  (
>>       for i in $(test_seq 33)
>>       do
>> @@ -990,7 +990,7 @@ test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches
>>  )
>>  '
>>
>> -test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
>> +test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
>>  (
>>       for i in $(test_seq 33)
>>       do
>>
>
> ATB,
> Ramsay Jones
>
>
>
