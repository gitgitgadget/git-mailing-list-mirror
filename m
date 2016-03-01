From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [PATCH] builtin/receive-pack.c: use parse_options API
Date: Tue, 1 Mar 2016 23:18:49 +0530
Message-ID: <56D5D601.8030601@gmail.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
 <vpq60x62jvt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 18:49:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaoPr-00028h-13
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbcCARsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:48:54 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34415 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbcCARsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:48:54 -0500
Received: by mail-pf0-f179.google.com with SMTP id 4so38391458pfd.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=G3evWkLaQL0BGNpebvMZm3+EsVQfQe7/xBYmNp1jU7M=;
        b=Zi5PLAMS/GB6o59GU0nUALNerNUgnHUyxmiLelkEM+4URi+lKaEXWqFkf3KZ45rQ6S
         k3hcOvF4+adBAWfWZR/rZuGquCg1Zbp6DOUJFQUgF/AhZC3jQhnERMRv77KtjZLr+kLf
         tqmStaOud+dhVMPjvte7yTrYmnOR2tbaGmzYJPrPfjpYzpuTbeYtHgWsHIaocHTVEk0N
         RJdvsqBYcasDHMTAL4fmOdlC48ywhwil6i9J6A1xjieVu71WbN3TJH/vWmoWFSS9mCwt
         DfjWlA5btYDuccW0vS2RVgi+Gju7tjOmUUVidTGA31a/h/b36heW70Hr5zRjqA/E7GKt
         8fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=G3evWkLaQL0BGNpebvMZm3+EsVQfQe7/xBYmNp1jU7M=;
        b=d+wBzePfqL1l5Ft4tq8UdMSgMoOc9Q1qmMPNhi0FOCO/1cxirKLqsatGL6loSvC0Rg
         Fx8hR/t7M3iVsK652RSajPHzyl7mzW4J2ZifP+LP0eckDN6p0QLUisFIU3XHb+9/ixS8
         Ka3b4UljGiqZbBdMl555DkvFhvnuEJ3P4TzYTluKV4W2lyeVrjfQ36gBlgsPWZMlKMd5
         MeHtbAR1BiQBshqABCS/TrVDADl2nlPALQchAUqHRBfJawNgujKreEUzLk0Smd4tYquV
         sUKxYTlmPCNNGKXF2ti9cSSF6y1tmFm6ANxU+xdd0H0JfZKbM6x8Vcg1i4gYV0THTv0+
         AqYg==
X-Gm-Message-State: AD7BkJIve7HHgbJjyQ/pCLBpdT/pM+ljnUR19feIPUfdSzMykvVQtugEX10U6haY9kXGCw==
X-Received: by 10.98.66.133 with SMTP id h5mr6152180pfd.89.1456854533571;
        Tue, 01 Mar 2016 09:48:53 -0800 (PST)
Received: from [192.168.1.10] ([182.68.185.50])
        by smtp.gmail.com with ESMTPSA id by3sm47133340pab.39.2016.03.01.09.48.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 09:48:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <vpq60x62jvt.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288045>


> Hi,
>
> Thanks for your patch.
>
> "Sidhant Sharma [:tk]" <tigerkid001@gmail.com> writes:
>
>> This patch makes receive-pack use the parse_options API,
> We usually avoid saying "this patch" and use imperative tone: talk to
> your patch and give it orders like "Make receive-pack use the
> parse_options API ...". Or just skip that part which is already in the
> title.
>
>> @@ -45,12 +48,12 @@ static int unpack_limit = 100;
>>  static int report_status;
>>  static int use_sideband;
>>  static int use_atomic;
>> -static int quiet;
>> +static int quiet = 0;
> static int are already initialized to 0, you don't need this explicit "=
> 0". In the codebase of Git, we prever omiting the initialization.
>
>> +	struct option options[] = {
>> +		OPT__QUIET(&quiet, N_("quiet")),
>> +		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
>> +		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
>> +		/* Hidden OPT_BOOL option */
>> +		{
>> +			OPTION_SET_INT, 0, "reject-thin-pack-for-testing", &fix_thin, NULL,
>> +			NULL, PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0,
>> +		},
> After seeing the patch, I think the code would be clearer by using
> something like
>
> 	OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &reject_thin, NULL)
>
> and then use !reject_thin where the patch was using fix_thin. Turns 5
> lines into one here, and you just pay a ! later in terms of readability.
OK, will correct the above points.

>>  	packet_trace_identity("receive-pack");
>>
>> -	argv++;
>> -	for (i = 1; i < argc; i++) {
>> -		const char *arg = *argv++;
>> +	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
>>
>> -		if (*arg == '-') {
>> -			if (!strcmp(arg, "--quiet")) {
>> -				quiet = 1;
>> -				continue;
>> -			}
>> +	if (argc > 1)
>> +		usage_msg_opt(_("Too many arguments."), receive_pack_usage, options);
>> +	if (argc == 0)
>> +		usage_msg_opt(_("You must specify a directory."), receive_pack_usage, options);
> Before that, the loop was ensuring that service_dir was assigned once
> and only once, and now you check that you have one non-option arg and
> assign it unconditionally:
>
>> +	service_dir = argv[0];
> ... so isn't this "if" dead code:
>
>>  	if (!service_dir)
>> -		usage(receive_pack_usage);
>> +		usage_with_options(receive_pack_usage, options);
> ?
>
>
Yes, I just realized that is dead code (sorry). Removing the 'if' statement would correct that? Also, is the unconditional assignment to service_dir correct in this case, or should some other test condition be added?

Another thing I'd like to ask is when I prepare the next patch, should it be sent as reply in this thread, or as a new thread?



Thanks and regards,
Sidhant Sharma  [:tk]
