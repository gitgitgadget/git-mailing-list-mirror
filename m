Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C943620988
	for <e@80x24.org>; Sat, 15 Oct 2016 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754293AbcJOPDL (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 11:03:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35940 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754311AbcJOPDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 11:03:09 -0400
Received: by mail-pf0-f194.google.com with SMTP id r16so9345995pfg.3
        for <git@vger.kernel.org>; Sat, 15 Oct 2016 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3fUV+a73fOMsRJgm/lquI09MXyF5694/0kQyhpUaLF8=;
        b=wI7dOFTdsiPgbLhkPG8Sa1YteJ0sOFZv9lFs8CDX2DgrqI4eoOj9nNJ5QnhyvKfTkQ
         7gS2uPcvky0bylkPt0oJnRYC1skll0KsVXE5tZqD0lxbBmWL4rfL4HYyEFLcu9hOUtAS
         mi1o8dnpSakMarpcNCTD9JuL2vtXK5nGZm6LZc3Buqbi5Vyta6DUflyKj2MJ3wJH48hR
         ArvFrRYXqoQE2Q1zPOaeIJURsw/Ma/NmxB87x9/wki7ejO2G6EUzReeg0FlGZwnsP0BR
         kSehxOwpf3C8us3KSUVyp6/mEc4wlm2lH2grNqPgptQ9OmXJLchLzH+oKd3yapJyfsAs
         xfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3fUV+a73fOMsRJgm/lquI09MXyF5694/0kQyhpUaLF8=;
        b=KfKKkfH+or24vLgPod3gZNKm+1AJBo9oo6VrYfebjMT2Wp95SckxakFt3P7vOJTdMG
         q9/Y8UL2JGWQJx//UMDhhIAzD4gDQ/iPDBfjqGzjGmxzoG+lLhjXn2UPA0LHn1sHrwCW
         aWHOQvMowxv7pBeH2CSKz44mg1GJmKKZT18PoFkgEsOLmF/zd73btA1T6rThE68Ej7rp
         xLVZwskaNOkZTA29jn2TJCaReCszHTjJ5dHDmZqjYh47oiGfb5bqSzWS6qBPmJ9zRkOb
         xLNdkERvYxUNstxyH8wwE5r+FDQ3WF2Of5WVJddbT0MsesGqU4X9TQOKh2sV6k1nHpw4
         0d3Q==
X-Gm-Message-State: AA6/9RleB+KBfsuhb5Fuzsz/1Z08NnSMTtIRRI8vk8R4Z1Y1O+8CaglIAFmz931jbTpvHg==
X-Received: by 10.98.134.78 with SMTP id x75mr26082419pfd.6.1476543762412;
        Sat, 15 Oct 2016 08:02:42 -0700 (PDT)
Received: from mtl3z26wz1.ads.autodesk.com (adsk-nat-ip11.autodesk.com. [132.188.71.11])
        by smtp.gmail.com with ESMTPSA id xn11sm35809273pac.38.2016.10.15.08.02.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Oct 2016 08:02:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 04/14] run-command: add clean_on_exit_handler
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1610111407080.3492@virtualbox>
Date:   Sat, 15 Oct 2016 08:02:40 -0700
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C686FFB-CB07-445E-B812-97781CAB113D@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-5-larsxschneider@gmail.com> <alpine.DEB.2.20.1610111407080.3492@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Oct 2016, at 05:12, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi Lars,
>=20
> On Sat, 8 Oct 2016, larsxschneider@gmail.com wrote:
>=20
>> @@ -31,6 +32,15 @@ static void cleanup_children(int sig, int =
in_signal)
>> 	while (children_to_clean) {
>> 		struct child_to_clean *p =3D children_to_clean;
>> 		children_to_clean =3D p->next;
>> +
>> +		if (p->process && !in_signal) {
>> +			struct child_process *process =3D p->process;
>> +			if (process->clean_on_exit_handler) {
>> +				trace_printf("trace: run_command: =
running exit handler for pid %d", p->pid);
>=20
> On Windows, pid_t translates to long long int, resulting in this build
> error:
>=20
> -- snip --
> In file included from cache.h:10:0,
>                  from run-command.c:1:
> run-command.c: In function 'cleanup_children':
> run-command.c:39:18: error: format '%d' expects argument of type =
'int', but argument 5 has type 'pid_t {aka long long int}' =
[-Werror=3Dformat=3D]
>      trace_printf("trace: run_command: running exit handler for pid =
%d", p->pid);
>                   ^
> trace.h:81:53: note: in definition of macro 'trace_printf'
>   trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
>                                                      ^~~~~~~~~~~
> cc1.exe: all warnings being treated as errors
> make: *** [Makefile:1987: run-command.o] Error 1
> -- snap --
>=20
> Maybe use PRIuMAX as we do elsewhere (see output of `git grep
> printf.*pid`):
>=20
> 	trace_printf("trace: run_command: running exit handler for pid =
%"
> 		     PRIuMAX, (uintmax_t)p->pid);

Thanks for hint! I'll change it!

However, I am building on Win 8.1 with your latest SDK and I cannot
reproduce the error. Any idea why that might be the case?

Thanks,
Lars

