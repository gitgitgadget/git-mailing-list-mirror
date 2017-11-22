Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F9820954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbdKVQzc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:55:32 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37975 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdKVQzb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:55:31 -0500
Received: by mail-wm0-f42.google.com with SMTP id 128so11524468wmo.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JpwTjCN1KriaRKlmITpavJ+URDpC8kO7UsiXoKU6eMo=;
        b=jtBXgRdn8pyS4jZF7kelCvwegOB1aR7XaBP2N8+XZzhJD6NHvJe9r9siVRLQV4NvAP
         d4HYyeZQiowvpY+DzpNtRmc5/UYUUOPsWVDOlnkcF7dH3QNrvZCJ1rONOboycs6Xellt
         2vBeF4cz6qO0yo8sSMIOfp249S4YWbYk0rtye1arEFSRQ+LhxI414HMJeJotHHVGvXaI
         N/2YbyDz1xdTXXaGcwwc54mUZWYbP/eN/Il9MdmxQBKbfuqF6TKN5V4LduzOqsUN/a3C
         iIKireg0T+dK/5o6dUUcGQ747sk22IVaxOnnqXRkY3sPzc2qXk7EAyai8utEA5LBHauy
         j2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JpwTjCN1KriaRKlmITpavJ+URDpC8kO7UsiXoKU6eMo=;
        b=F4FS07K97zH8sKGURXutIDg1s/S1vZz+FH6FzMVgjawWDYlI27lmRKguCPmIzF7CbU
         LIEZg9Tj3V6mUclhWgnjDHkEcB52O2/D8LAGQjmdDXya9v79X85vqLspAwASSoTF8bEI
         mtSiE5rycGNQ2sHBv0dPyOLTMD2N+28C1jRQ31CAcKBmUU5vSzr+Jt77Ahh3UkEcgrOA
         Yxv/YgsOPS76FNNfIViNNhh8TeF3HJhZYBj+mg20nMYg66HehcoO2Xj3bUT9kIlN4ifs
         XECo8cVdkz5v1N00KNFOKtQ3cmrCGU/PqkQo3sBw74n43+STmejFIkgBOFixDdqfN3H7
         Ca8g==
X-Gm-Message-State: AJaThX682lRhluLEZ7e2ke/kEZmhgz+Uv1c3ZY8OumToU1snUHXMZe1J
        4wx1UcB9fHlrPXCzToDrUBI=
X-Google-Smtp-Source: AGs4zMZPlriClokc89rBXJdjH1MYBl3A883FVRf0Z/Sx1f9g3tgR4Hw4nsomVDWzLivJ+t2NtSFrTQ==
X-Received: by 10.28.137.80 with SMTP id l77mr4515465wmd.24.1511369730686;
        Wed, 22 Nov 2017 08:55:30 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id c12sm5865944wrc.92.2017.11.22.08.55.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Nov 2017 08:55:30 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvai5ollx.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 17:55:29 +0100
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <998E3A52-C710-447A-82A3-50C58354CC31@gmail.com>
References: <20171117135109.18071-1-lars.schneider@autodesk.com> <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com> <xmqqh8tsqs83.fsf@gitster.mtv.corp.google.com> <d53a655b-f51e-3f44-23db-581071010fd2@gmail.com> <xmqqvai5ollx.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 20 Nov 2017, at 01:11, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>>>> However, it's not clear how much benefit you gain from stashing this
>>>> away in a static variable. Premature optimization?
>>> 
>>> The variable being "static" could be (but it was done primarily
>>> because it allowed me not to worry about freeing),
> 
> The current code happens to be safe because I do not allocate.  I do
> not know what others will do to the code in the future, and at that
> point, instinct kicks in to futureproof against the worst ;-).
> 
>>>> Should printing of close_notice be done before the error()? Otherwise,
>>>> you get this:
>>>> 
>>>> --- 8< ---
>>>> Launched your editor (...) ...There was a problem...
>>>> --- 8< ---
>>> 
>>> In my version with a far shorter message, I deliberately chose not
>>> to clear the notice.  We ran the editor, and we saw a problem.  That
>>> is what happened and that is what will be left on the terminal.
>>> 
>> 
>> It might be a good thing to keep the notice but I think it would be
>> better to have that error message in a "new line". I'm not sure if
>> it's possible or not.
> 
> Of course it is possible, if you really wanted to.  The code knows
> if it gave the "we launched and waiting for you" notice, so it can
> maintain not just one (i.e. "how I close the notice?") but another
> one (i.e. "how I do so upon an error?") and use it in the error
> codepath.

I think a newline makes sense. I'll look into this for v3.

Thanks,
Lars
