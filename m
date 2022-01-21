Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A8AC433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 09:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379414AbiAUJnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 04:43:07 -0500
Received: from mout.web.de ([212.227.15.4]:32967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231417AbiAUJnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 04:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642758179;
        bh=rywMXzo2LtRMoezaQmZy5irU5/FVSlbj2PZDyq8wl5k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Xy8gwVCH98VJ2wyurKDY3/pR086DpoIEPPS9LDoq4SCl8ShNdbO2RIl9kBMYyicTn
         F61IzLPhfa5GR3PxEbW3Rq/6hil6CBAuRm7mcf/m5OwPfFtwgrHe32x+zoBiF0WwVi
         7qq/3H5USZlmcgFpnxA/x1XDAcs9WFq2Hv82TBlI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjIG-1n0zbq3gyK-00CTf2; Fri, 21
 Jan 2022 10:42:58 +0100
Message-ID: <f6cc8042-a455-6398-9f91-0e64921252e4@web.de>
Date:   Fri, 21 Jan 2022 10:42:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] parse-options: document automatic
 PARSE_OPT_LITERAL_ARGHELP
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        avarab@gmail.com
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
 <xmqqh7a0r87q.fsf@gitster.g> <ba624c59-5330-360e-dc4a-432752d22fc1@web.de>
 <xmqqlezboakd.fsf@gitster.g> <c6ab4408-1091-4d14-849e-afe5f3053e8b@web.de>
 <xmqqiluejmcp.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqiluejmcp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4N1b8ggdJEeHqHj3ddPbWWDJYBqEp7P21osmmtilP5VCJRo5bd+
 EakfjAk0cTM2LCbSlnpfR0vTqyRJAHUNTGeo5kNFxyw5WFXTW3OGL/N+DIE3zfOpEmxwnL/
 bWfuhu5hNYnZxinTnOACR0mg886WPNzY2OCHf7dGPzOcdWeXIoAnhjiWQr3husMR9dbpwQ1
 vYFm3q/HA8bgVx2y2jH5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EBVpD9HRm3A=:jfTZA+AfpBgpqCGT/67636
 irO+hvIoN2f3+T1V7vSGdUoiP87sJhkfUO/6/ePlFHDybVCPefFpCZfG5exAmycpkqm7bWQ9h
 2i3R98US1xfPPHvRKnA0h4bBIAogG+3MkLDDXhGHev9EKh2AzEhg5AKJg6Wj4IHS8PHhVSigI
 wybyxbUjM5xFm9pFJftr2rf+iwK8r8Ou4Q7I/lncR75HeyYy3vFapKT/VLm1DEpT0HvZh3yKS
 zxohg2a7oswTqRfg0zYq9tPfFlYkMwuBvZtp2fdVM7Lg55SJUZFVKVH4lS1MEIT/Bui1MWS22
 XIm2f6RN9uA+RH26PmL3yzt1ZZN+X2rzt5Nep8KRiBYgciQKLa+H6eonqhWGXfNFeOrXgF5RS
 Bs+rSAYRb9choXvXYTL0rxc7OPqyN7rR2e9MxPqxZYq8Ao2m9QrIT4Q03PCI+551Rsv7IAsrn
 D0kF28rwgHmSnG5p3tdAZL02tG8cLwMbcVJRQ6w2cfANY4DBhE3z1ljAGlrWgMpFWh7QkmzZb
 HazkjLTVV/KnjeqLHyzmIDxYxZApVq1qlObVPeo7jWLfiUkeQeuo2invpqkejjRSV6JanKXYE
 kDrYWYKgC9GTN0SPo2LHwi37r7PuZt9zfZkntxXBpzm3M7l6pIwbOOGWr0o9ukCYqRV9ayr74
 XkUnVDFb4LLc4hHciZvRLqedCrjx2RYUckI0fZQpckcqduW+Vb9xNhr5d1HZpxoa0Ot+VQQtq
 xYmT1eToI2aSVt25ig+I9iaLbdrzeGrP5ozBZli7fPLDkhNlqqFof48iAowFtT8PB8sIydARZ
 tCGdaWVD+BQE094bv+w/fOySF/CQcw4U+HA4WcC7fky6bhsD3Z9dkOHN8MQfVFlfW88l3gVGD
 WKIsJG/y4EG9wvZkeVFapFMGPMTevQnrF9iQ3NZG/91FagSHf+m3E8yvdMwTQ/dIc2AHwgEV+
 0oapvvRYycnqExJnY5nTxl7oPznjaIRn/tSCH9Cm1XOBr6QRka/aaosVkfWtJpKvqXgSHpW8w
 WC6aekm6XoKWm7XE8B5xlJuYmE/Q4ux7mUP1PD6aSsB1LIz5UVJ1kL/BNPyKmo3dFw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.01.22 um 19:25 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Now that I read the whole comment, I think the right place to introduce
>> the automatic brackets is the description of argh some lines up.
>>
>> --- >8 ---
>> Subject: [PATCH 5/5] parse-options: document bracketing of argh
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  parse-options.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/parse-options.h b/parse-options.h
>> index e22846d3b7..88d589d159 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -85,6 +85,11 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct=
 parse_opt_ctx_t *ctx,
>>   *   token to explain the kind of argument this option wants. Does not
>>   *   begin in capital letter, and does not end with a full stop.
>>   *   Should be wrapped by N_() for translation.
>> + *   Is automatically enclosed in brackets when printed, unless it
>> + *   contains any of the following characters: ()<>[]|
>> + *   E.g. "name" is shown as "<name>" to indicate that a name value
>> + *   needs to be supplied, not the literal string "name", but
>> + *   "<start>,<end>" and "(this|that)" are printed verbatim.
>>   *
>>   * `help`::
>>   *   the short help associated to what the option does.
>
> Very nice.
>
> This version gives the necessary information in (almost) one place.
>
> I said (almost) because "it contains any of ..." is not the only way
> to decline the <automatic angle brackets>, and am wondering if it is
> more helpful to say something like
>
> 	... when printed, unless PARSE_OPT_LITERAL_ARGHELP is set in
> 	the flags, or it contains any of the following characters: ...
>
> and then shrink the description of the flag bit to
>
>     PARSE_OPT_LITERAL_ARGHELP: controls if `argh` is enclosed in in
>     brackets when shown (see the description on `argh` above).
>

The idea was to document the base behavior at the top and the effects of
flags at the bottom.  Blurring this distinction and cross-referencing
gives a better whole, though, I agree.  It would have helped me find the
right place to put the list of special chars, for one thing.  So how
about this?

=2D-- >8 ---
Subject: [PATCH v2] parse-options: document bracketing of argh

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index e22846d3b7..2e801b3c9a 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -85,6 +85,11 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct pa=
rse_opt_ctx_t *ctx,
  *   token to explain the kind of argument this option wants. Does not
  *   begin in capital letter, and does not end with a full stop.
  *   Should be wrapped by N_() for translation.
+ *   Is enclosed in brackets when printed, unless PARSE_OPT_LITERAL_ARGHE=
LP
+ *   is set in `flags` or it contains any of the following characters: ()=
<>[]|
+ *   E.g. "name" is shown as "<name>" to indicate that a name value
+ *   needs to be supplied, not the literal string "name", but
+ *   "<start>,<end>" and "(this|that)" are printed verbatim.
  *
  * `help`::
  *   the short help associated to what the option does.
@@ -105,9 +110,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct p=
arse_opt_ctx_t *ctx,
  *				not last it will require an argument.
  *				Should not be used with PARSE_OPT_OPTARG.
  *   PARSE_OPT_NODASH: this option doesn't start with a dash.
- *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in b=
rackets
- *				(i.e. '<argh>') in the help message.
- *				Useful for options with multiple parameters.
+ *   PARSE_OPT_LITERAL_ARGHELP: says that `argh` shouldn't be enclosed in
+ *				brackets (see `argh` description above).
  *   PARSE_OPT_NOCOMPLETE: by default all visible options are completable
  *			   by git-completion.bash. This option suppresses that.
  *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
=2D-
2.34.1
