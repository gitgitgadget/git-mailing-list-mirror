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
	by dcvr.yhbt.net (Postfix) with ESMTP id C648A211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 19:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbeLBTax (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 14:30:53 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35791 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbeLBTaw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 14:30:52 -0500
Received: by mail-wm1-f41.google.com with SMTP id c126so3599575wmh.0
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=t58/04vLpWDEFoJFEtyYbPFY3E7AFd7m1EDOj80IHQo=;
        b=QN7twF6lswBsHoUeD/Y5BRD97UA6dbWuZL06x3RL92QvEgnNlC2r0oa0o6fuu4moon
         V11bXX/9tpdh5lRyWDiEu7nBV2e6qW7kAH+3DK4Wqrmt39N4NBx9Os4ANbLTnADwiI4W
         gHx/xd/COM60So9vKrQZsBMTsYUsTodJDcrROjDkZlgLHjmfmR4efVwGSfTfSNAl1axo
         fB8Nj602wdkqGoeUf9iVuO73GXdq2MxzJjYOgL5zpHwdOleb/SqkEdf0V3OcH3/eoEa9
         2x68SofAZCtL4AWKhRUUw6BPtVhwFlkRax/JkuSfZ4V6Ixhp+TuDzm2pELsvbSscrfLX
         foBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=t58/04vLpWDEFoJFEtyYbPFY3E7AFd7m1EDOj80IHQo=;
        b=PRfeq2FrcNqV5QSwG6rF1WqqBJxtDZfLTijnERz6TOT0lcNBlrsoRF6ZIn74HcmMY9
         sWoHDqP0oCPsuo8TSysYpLSrTThqTONcS5J+XQyelhXv/kttSEZUA25UOf0k76RlvX46
         6J/GaNh3SbnbXdmZeu2XjjB6eclTjd1SM68yfc118yIEqUsC6UOBz/VS3w6bUzSbzgem
         ejmsAGW2gJnhIPWTs6vntE0AjHL8gWb37nYizKTKCHhWqDLb+MJHvHlwNo0GhZWq3H0e
         d8s5jWdTn2iaH6Xdu4P5B7FAlCjHhzChp2OmiUXcxY4pM/qpxMb+MJvXd/qKpkujx5GP
         O+cg==
X-Gm-Message-State: AA+aEWaEx2WxM4V+kviFwQd5XLNSUjtn/QNEqN44jRhxgN1rdUTYIWrU
        vDtuOXqkyWPEpncu2Fo=
X-Google-Smtp-Source: AFSGD/XTrD+nik9ZOdSeG2WCY7s+XdYGNvCXRbLtU0lYx7WUXQ9pyccoKMBdCPRpg8lhVIrXdgDb4w==
X-Received: by 2002:a1c:83c8:: with SMTP id f191mr5769145wmd.134.1543779048496;
        Sun, 02 Dec 2018 11:30:48 -0800 (PST)
Received: from [192.168.25.100] (ip-178-203-18-118.hsi10.unitymediagroup.de. [178.203.18.118])
        by smtp.googlemail.com with ESMTPSA id n17sm1966911wmc.5.2018.12.02.11.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 11:30:47 -0800 (PST)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
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
 <xmqqk1kwr5tp.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <7a4ecc75-2dc4-041b-3d12-46cddae0a27f@googlemail.com>
Date:   Sun, 2 Dec 2018 20:31:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqk1kwr5tp.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Am 29.11.18 um 03:11 schrieb Junio C Hamano:
[...]
> This was misspoken a bit.  Let's revise it to
>
>  	When producing a colored output (not limited to whitespace
>  	error coloring of diff output) for contents that are not
>  	marked as eol=crlf (and other historical means), insert
>  	<RESET> before a CR that comes immediately before a LF.
You mean
     ...
     <RESET> *after* a CR that comes immediately before a LF."


OK, AFAICS this produces the desired output in all cases if eol=lf.

Now what about the case eol=crlf ?
Keeping the current behavior of '-' lines is correct.
But shouldn't ^M now be suppressed in '+' lines for a consistent behavior ?

With other words:
"If CR comes immediately before a LF, do the following with *all* lines:
<RESET> after the CR if eol=lf but do not <RESET> after the CR if eol=crlf."

Regards,
Frank
