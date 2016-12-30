Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0E11FCA5
	for <e@80x24.org>; Fri, 30 Dec 2016 01:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbcL3Bgb (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 20:36:31 -0500
Received: from mout.web.de ([212.227.15.14]:52717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbcL3Bga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 20:36:30 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpO8D-1cyqgd1kG5-00f6ts; Fri, 30
 Dec 2016 02:36:22 +0100
Subject: Re: [PATCH] submodule.c: use GIT_DIR_ENVIRONMENT consistently
To:     Stefan Beller <sbeller@google.com>
References: <20161230004739.19144-1-sbeller@google.com>
Cc:     gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6dd0a31e-d877-5311-37ef-313ed9ab9716@web.de>
Date:   Fri, 30 Dec 2016 02:36:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161230004739.19144-1-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:nDXik9CnmMSLKwvEWvqZ1RGZg44/BPFnqmEXM2OlOPe9k30HPit
 x92lX8CpH1j4qPy2lpvOoTDVoH7IhFSAGWFR9JV/13Ihmx8W/Uss5uzs9fv2BbAEIBynqIT
 QaAAPrKjTwHQdlAIBY0E3TchVrHtGONiBZ5fYGD892VleIDrNIOhZrGKoJ0uA4RULVznPnw
 fHl+CrlbQJUhhIv8v7fyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lYQuddim3/M=:/qbqjBpgILN0w0A5kCyLzu
 hEg2LwGrV2ACvsVYjmWQLt2hET2trfI0X85Ly/5yF89AzN1lNyVC7iw3E0iChtmTFUve0dwnV
 K3SXp8VTjK9pUL8QXN53y5TVedgOnUUTX6g5RpGixhC6PSiIe4ywcIPa3uvSxTBpOzWcR4oxD
 ZWtuvPUbWHumUmkFBK8bWJ3c73VAcwshu2UmNwm0amkUxGuzBvlbFax6IepztiJXLf9X7srKf
 KeLgV6hrmxmY5z5Da2wzioJVHSzjq0HLIX06dCyNipyKYAJzCz8fHDJaq+2bWqJDITBM9NYNV
 V01RcnClRy2Tsd+RdhLxf3Ce/dwQoeI58aq05rv3GJTJZv5vNirfD9mx4FGGpuAXfhAkk8xhu
 cXfUqEclFVz4a5Plw0QPvv3gZHJwqQd8+1CfW5fBVV/5kYzAFGNoGhBY9ObiLBcPw/N9xhFhw
 lSEdMdod8HFYiEy9jCqDVjBnJFwgOgKnD14pNIXXdvVezk3Iy1t3QFfhiFBHR9brUsoQ70w15
 igk2JaIIy4KUJHo9laXYnz8Fli/9XGygCfC7KLvR7ZAVuDS3QEUq0pw4MjMvX7OQS7azVnsTi
 yG+YnaJ9Lr/JMAkBLHqkL6A8XX++hxADSN9C9j+blrPkbB51up+ZMz5bQrT1nhUxxqM1KXYeP
 kek+f80/YSD0aeFAKDbyIuDREQ2yRCE+Z2RhsTsDpirjm6z1TlMJ3Bp2AJ6SvEalyWo0rv7EH
 4j5HE+UhjiIAWqU5bc1Gc+TO4cc5IpqnX9kkF12NgSQuQgIlu6YW28crAczAUFaJgJ1N5qwRw
 +WO2rha
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.12.2016 um 01:47 schrieb Stefan Beller:
> diff --git a/submodule.c b/submodule.c
> index ece17315d6..973b9f3f96 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1333,5 +1333,6 @@ void prepare_submodule_repo_env(struct argv_array *out)
>  		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>  			argv_array_push(out, *var);
>  	}
> -	argv_array_push(out, "GIT_DIR=.git");
> +	argv_array_push(out, "%s=%s", GIT_DIR_ENVIRONMENT,
> +		DEFAULT_GIT_DIR_ENVIRONMENT);

argv_array_pushf (with added "f") instead?

And indent continued lines to align them with the left parenthesis, like 
this:

	fn(arg1,
	   arg2);

>  }
>

