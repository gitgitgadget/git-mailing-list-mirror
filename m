Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE07F20966
	for <e@80x24.org>; Wed, 29 Mar 2017 10:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756032AbdC2K6W (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 06:58:22 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47159 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756079AbdC2Kzx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Mar 2017 06:55:53 -0400
X-AuditID: 12074414-7efff70000002bfd-14-58db92b2ab6c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E1.34.11261.2B29BD85; Wed, 29 Mar 2017 06:55:46 -0400 (EDT)
Received: from [192.168.69.190] (p4FEDF5D2.dip0.t-ipconnect.de [79.237.245.210])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2TAth22017966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 29 Mar 2017 06:55:44 -0400
Subject: Re: [PATCH v6 18/27] files-backend: replace submodule_allowed check
 in files_downcast()
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-19-pclouds@gmail.com>
 <004082a0-871f-cd41-edc5-522b5c2b3b58@alum.mit.edu>
 <CACsJy8CpUzRjZG7V8a6XvzcjxhwTnAfpwYed3OSLrygUPOK66g@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a44dfc2e-8196-a782-be69-682f252d2592@alum.mit.edu>
Date:   Wed, 29 Mar 2017 12:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CpUzRjZG7V8a6XvzcjxhwTnAfpwYed3OSLrygUPOK66g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqLt50u0Ig96pjBZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyti13Ligjb3i48cu5gbG3axdjJwcEgImEvs+TWTqYuTi
        EBLYwSTxd8VzRgjnApPE4sYDbF2MHBzCAkkS75oCQBpEBJQk3nRsY4ao6WOS6Jh3lAXEYRaY
        xSRxce8iNpAqNgFdiUU9zUwgNq+AvcTindfA4iwCqhInb2xgBLFFBUIk5ix8wAhRIyhxcuYT
        FhCbUyBQYueCN2C9zALqEn/mXWKGsOUltr+dwzyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3
        MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMk2EV2MB45KXeIUYCDUYmHd0ferQgh1sSy4src
        Q4ySHExKorwnDG9HCPEl5adUZiQWZ8QXleakFh9ilOBgVhLh1VcEyvGmJFZWpRblw6SkOViU
        xHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfAmTQRqFCxKTU+tSMvMKUFIM3FwggznARo+CaSG
        t7ggMbc4Mx0if4pRl+PG8QNvmIRY8vLzUqXEeT9MACoSACnKKM2DmwNLUq8YxYHeEuZdAzKK
        B5jg4Ca9AlrCBLRE3OYWyJKSRISUVAOj94NHZZleLhqfCyIDGyd/V9+hWrGteYnrT3eVnjnM
        cbqZ3YuvcoaqKzemmmZqOshx/eOfJH5EqPhe6fvtssnLHv6ZLX/qzHzbDcLFdxOD86fs8fKw
        d5hcf9zu3xe37XL8UVsWFPB/OhMt995/ZlfbeWalpJwHjHbOC64uPpxvOfmmxn7fn2lKLMUZ
        iYZazEXFiQBAVCdgLQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/26/2017 04:16 AM, Duy Nguyen wrote:
> On Mon, Mar 20, 2017 at 4:18 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> +/* ref_store_init flags */
>>> +#define REF_STORE_READ               (1 << 0)
>>
>> I asked [1] in reply to v5 whether `REF_STORE_READ` is really necessary
>> but I don't think you replied. Surely a reference store that we can't
>> read would be useless? Can't we just assume that any `ref_store` is
>> readable and drop this constant?
> 
> I deleted it then I realized many lines like these
> 
>     files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
> 
> would become
> 
>     files_downcast(ref_store, 0, "read_raw_ref");
> 
> I think for newcomers, the former gives a better hint what the second
> argument is than a plain zero in the latter, so I'm inclined to keep
> it.

That's OK with me; I don't feel strongly about it.

Michael

