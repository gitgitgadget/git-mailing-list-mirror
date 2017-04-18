Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3927E1FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757534AbdDRQIQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 12:08:16 -0400
Received: from mout.web.de ([212.227.15.14]:49320 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757418AbdDRQIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 12:08:12 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7ssy-1c5VA32pTE-00vMoP; Tue, 18
 Apr 2017 18:07:47 +0200
Subject: Re: [PATCH v2] xgethostname: handle long hostnames
To:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Duy Nguyen <pclouds@gmail.com>
References: <20170417161748.31231-1-dturner@twosigma.com>
 <xmqq1ssqikc5.fsf@gitster.mtv.corp.google.com>
 <xmqqwpaih4q2.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <281d0843-d48a-b7ab-737b-b9528689d44e@web.de>
Date:   Tue, 18 Apr 2017 18:07:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <xmqqwpaih4q2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:VB+wElFbEo4b2h08ECf1BGOjzrhuX3PKB2Qr7niRJmgcIK8U1ve
 JG8cjcJvyJKReVZRpsxkWK0qHC7K4xPhslWvCvA010pTBtTHpqv0MCIPLPTaE683d8lMBAj
 wp4Xs1FgdHMZju65C27mOLwWwtOOXjjdSbvKQDgZAcw3uICp+fd+mizct+rYnpUz2ll2OZO
 R2c4dr7L0z2lJwhCHwzWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UX0cPreZ1w4=:G+8gcGedo5XA4VjUhgCoMo
 +vgaSjZILWTQRI2DXtnT94sMd4pk+9hjozH0OisOigsd19ry0WxgpN9xg0FoImgGV0AiqQsGG
 yCgnWStyq0svdHWJXZ/vXTaJCpDdnk1YGqCrOfNnyYKxN3zfAhYbkIuxX999f6MYOR96sI7o5
 WPbCEG4y1pBHPep/Rgo+zl1VEdx7MkLgVGBBGzq4e8Uz/4JmcAun+VufYhVipq/YNxoXlFaYa
 zPHh8K0fgrAKxl9Xd6/sCE0YoSPyGnyM7FSPWmSd6HXdOSFZ3wi6CVfn5gIohP/x6s2C4571Y
 /1vBxa3ILfZzjz3Xccf4LfLr4M43y8R13SwuTBLarmTysngGDdWlQlhV5C9tHsz6LJM4wivnV
 dJLSbXvTmNS1yPZ0UhW+Z2tHvU3G7vu5GSAMukA6CFgCKlqEbQuFPSXRDywIzkBhZ0otuaU+f
 FxGpfOg9UkAjuEq3bQ4HihfFxFw4xuLtUn71aAVfwoXgaGrZ8Sf87usyxlt/NKo4zVMtJQ7lK
 GaLlcbMrCyTLnPVvS1aCy9QGauiV6KI2VabP0Sf14QdZ6YZZvYAtsfG1JqonTPRPXD5paztNO
 i6vMF0ZzkNT0nAtMB1RUXs7f3epJvfA5PRplFQLcsrxMCrhxo0JnXLMEJgKLUI+RXEbndv/eT
 ZcbyDxXICIpwB/vFsDwjwP+KQaBzSHEzUSQdH+TcPOC6yojN/qIiqfDsg0kVEVSr/6s4ndyif
 mKo1VtO0KAhrPtbQgqxgARCd3m5gtbaCx41jHmdA57AWBZvMNtTC5QwJHsGxLam0O5TZvTSdQ
 EGlWV+/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.04.2017 um 03:41 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> David Turner <dturner@twosigma.com> writes:
>>
>>> @@ -250,14 +250,14 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>>> ...
>>>   	if (!force) {
>>> -		static char locking_host[128];
>>> +		static char locking_host[HOST_NAME_MAX + 1];
>>>   		int should_exit;
>>>   		fp = fopen(pidfile_path, "r");
>>>   		memset(locking_host, 0, sizeof(locking_host));
>>
>> I compared the result of applying this v2 directly on top of master
>> and applying René's "Use HOST_NAME_MAX"and then applying your v1.
>> This hunk is the only difference.
>>
>> As this locking_host is used like so in the later part of the code:
>>
>>   			time(NULL) - st.st_mtime <= 12 * 3600 &&
>>   			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
>>   			/* be gentle to concurrent "gc" on remote hosts */
>>   			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
>>
>> I suspect that turning it to HOST_NAME_MAX + 1 without tweaking
>> the format "%127c" gives us an inconsistent resulting code.

Oh, missed that.  Thanks for catching it!

>> Of course, my_host is sized to HOST_NAME_MAX + 1 and we are
>> comparing it with locking_host, so perhaps we'd need to take this
>> version to size locking_host to also HOST_NAME_MAX + 1, and then
>> scan with %255c (but then shouldn't we scan with %256c instead?  I
>> am not sure where these +1 comes from).
> 
> That is, something along this line...
> 
>   builtin/gc.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index be75508292..4f85610d87 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -240,7 +240,11 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>   				       LOCK_DIE_ON_ERROR);
>   	if (!force) {
>   		static char locking_host[HOST_NAME_MAX + 1];
> +		static char *scan_fmt;
>   		int should_exit;
> +
> +		if (!scan_fmt)
> +			scan_fmt = xstrfmt("%s %%%dc", "%"SCNuMAX, HOST_NAME_MAX);
>   		fp = fopen(pidfile_path, "r");
>   		memset(locking_host, 0, sizeof(locking_host));
>   		should_exit =
> @@ -256,7 +260,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>   			 * running.
>   			 */
>   			time(NULL) - st.st_mtime <= 12 * 3600 &&
> -			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
> +			fscanf(fp, scan_fmt, &pid, locking_host) == 2 &&
>   			/* be gentle to concurrent "gc" on remote hosts */
>   			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
>   		if (fp != NULL)
> 

How important is it to scan the whole file in one call?  We could split
it up like this and use a strbuf to handle host names of any length.  We
need to be permissive here to allow machines with different values for
HOST_NAME_MAX to work with the same file on a network file system, so
this would have to be the first patch, right?

NB: That && cascade has enough meat for a whole function.

René

---
 builtin/gc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 1fca84c19d..d5e880028e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -251,10 +251,9 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	fd = hold_lock_file_for_update(&lock, pidfile_path,
 				       LOCK_DIE_ON_ERROR);
 	if (!force) {
-		static char locking_host[128];
+		static struct strbuf locking_host = STRBUF_INIT;
 		int should_exit;
 		fp = fopen(pidfile_path, "r");
-		memset(locking_host, 0, sizeof(locking_host));
 		should_exit =
 			fp != NULL &&
 			!fstat(fileno(fp), &st) &&
@@ -268,9 +267,10 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 			 * running.
 			 */
 			time(NULL) - st.st_mtime <= 12 * 3600 &&
-			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
+			fscanf(fp, "%"SCNuMAX" ", &pid) == 1 &&
+			!strbuf_getwholeline(&locking_host, fp, '\0') &&
 			/* be gentle to concurrent "gc" on remote hosts */
-			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
+			(strcmp(locking_host.buf, my_host) || !kill(pid, 0) || errno == EPERM);
 		if (fp != NULL)
 			fclose(fp);
 		if (should_exit) {
@@ -278,7 +278,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 				rollback_lock_file(&lock);
 			*ret_pid = pid;
 			free(pidfile_path);
-			return locking_host;
+			return locking_host.buf;
 		}
 	}
 
-- 
2.12.2
