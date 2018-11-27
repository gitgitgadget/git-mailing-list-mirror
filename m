Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B7B1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 20:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeK1HHv (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 02:07:51 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43932 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeK1HHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 02:07:51 -0500
Received: by mail-wr1-f48.google.com with SMTP id r10so23995273wrs.10
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 12:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HoeKDavXnz+zA9O17FCuF9RyRlrqoqWHGG5QxaFSSCE=;
        b=dqyohDDk5N4u5nFmiLCOZGlBllIi/ACYb1cMsOb//L+TqagmmTK+Tim3Xj126tMDB2
         P3czO2ysmwlbZffnpG+lFkcTkcv67bIRI/Jtw1cp84lgYYFp92yeiTY5aG1eV6wo/pqN
         G5uvUk+mpOckFvZAqY0uaDusG+3z2Q/+9HEWk1OhuLWswCPsqCmZSytdiclKBORXWqwl
         BTZ2HehT1Vu84O6vhPPePjERPTqFVEQPyewyY4JVu5ETz1zieGdmpgt6ByMy/s5/hEjb
         4COmefPRiWZWqELk7KJQyPigLw4v5C7+M34NvWewgIwMG8N2KggINXveHh+aPSZaVDn5
         l3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HoeKDavXnz+zA9O17FCuF9RyRlrqoqWHGG5QxaFSSCE=;
        b=gcEsIToxgjnimUONWfFi1DU1XM8l3dYkgOzQSyTrywXPwkEECPdYtc03GgfT5X5rax
         ZRI1sASdQTJyy70t78bbZQkTnpjnHvnmBlhQSyL31mliFbwXpilJC1f9ngKEgxd5LTCh
         cRpucoHqgiRtOheTY3DlwnVlsAnWFOQkVzJZ8OYQWcngjKXOPgPwxSwCiBKiWQrZkX6r
         3fpzAB70DN3Cls2I3ZQqF5oiyPFuU/JyAASoKES2khdakLcIaowlwUmJfSAkKbjmam+a
         Lv/he3jqXQlaFRvQUhXiqfN60qM7o9JVjbPQmidLZxCYFd1pF2Oq0JKhvDdtnzBRyVp4
         s8Jg==
X-Gm-Message-State: AA+aEWbTz3yNTt+0LgOITyClPMpE5TrfCkKPa2iZnjGiu0GAoAtUlGeZ
        L2cgMwpCyDDTip2cTP8=
X-Google-Smtp-Source: AFSGD/VTcaSkEpWmGPecFp7QnIpUIQusTyNHKgB7kP+gouGH6dyIiOQP/VlnTiZCfhlZxq1rSYJ1sQ==
X-Received: by 2002:adf:fb4c:: with SMTP id c12mr10520511wrs.297.1543349328438;
        Tue, 27 Nov 2018 12:08:48 -0800 (PST)
Received: from [192.168.25.100] (ip-178-203-18-66.hsi10.unitymediagroup.de. [178.203.18.66])
        by smtp.googlemail.com with ESMTPSA id d5sm4431253wrx.22.2018.11.27.12.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:08:47 -0800 (PST)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
 <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
 <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
 <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
 <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
 <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
 <3e24a770-47fc-50e4-d757-1e4a28dcd019@kdbg.org>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <fefed4ac-33ce-20f0-d777-510c01919f95@googlemail.com>
Date:   Tue, 27 Nov 2018 21:09:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <3e24a770-47fc-50e4-d757-1e4a28dcd019@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 27.11.18 um 19:15 schrieb Johannes Sixt:
> Am 27.11.18 um 00:31 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>> Am 26.11.18 um 04:04 schrieb Junio C Hamano:
>>> ... this goes too far, IMO. It is the pager's task to decode control
>>> characters.
>>
>> It was tongue-in-cheek suggestion to split a CR into caret-em on our
>> end, but we'd get essentially the same visual effect if we added a
>> rule:
>>
>>     When producing a colored output (not limited to whitespace
>>     error coloring of diff output), insert <RESET> before a CR
>>     that comes immediately before a LF.
>>
>> Then, what Frank saw in the troublesome output would become
>>
>>     <RED> -something <RESET> CR <RESET> LF
>>     <GREEN> +something_new <RESET> <BG_RED> CR <RESET> LF
>>
>> and we'll let the existing pager+terminal magic turn that trailing
>> CR on the preimage line into caret-em, just like the trailing CR on
>> the postimage line is already shown as caret-em with the current
>> output.
>
> I wouldn't want that to happen for all output (context lines, - lines,
> + lines): I really am not interested to see all the CRs in my CRLF files.
>
>> And a good thing is that I do not think that new rule is doing any
>> decode of control chars on our end.  We are just producing colored
>> output normally.
>
> But we already have it, as Brian pointed out:
>
>    git diff --ws-error-highlight=old,new
>
> or by setting diff.wsErrorHighlight accordingly.
... but that also turns on displaying normal space/tab errors in removed
lines.
So to make both of us happy, we would need separate switches.

Any chance this can be done easily enough ?

Regards,
Frank

