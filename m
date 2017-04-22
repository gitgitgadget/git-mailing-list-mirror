Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB2B207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 05:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1039251AbdDVFOA (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 01:14:00 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44689 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1037324AbdDVFN6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Apr 2017 01:13:58 -0400
X-AuditID: 12074413-0e1ff70000001dc3-bc-58fae694159e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 49.47.07619.496EAF85; Sat, 22 Apr 2017 01:13:56 -0400 (EDT)
Received: from [192.168.69.190] (p57907D7C.dip0.t-ipconnect.de [87.144.125.124])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3M5DovI029884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 22 Apr 2017 01:13:53 -0400
Subject: Re: [PATCH v3 04/12] refs.c: refactor get_submodule_ref_store(),
 share common free block
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-5-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c50e5ff0-52aa-aeaa-168a-9ac56c71626b@alum.mit.edu>
Date:   Sat, 22 Apr 2017 07:13:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170419110145.5086-5-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1J3y7FeEwYHH1hZdV7qZLBp6rzBb
        9C/vYrPonvKW0WLmVWuLzZvbWRzYPHbOusvu8eFjnMeCTaUeFy8pe+xfuo3N4/MmuQC2KC6b
        lNSczLLUIn27BK6MrRf72QoesldsfTqDrYFxIlsXIyeHhICJxMrHfxm7GLk4hAR2MEnsfPqG
        BcK5wCSxaXIXE0iVsECyxPzdf8BsEYE0icWT3zOD2EICiRJfJu5jBWlgFtjFKHHm+R2wBJuA
        rsSinmagBg4OXgF7ibOnckDCLAKqEqv3bGEFsUUFQiTmLHzACGLzCghKnJz5hAWknFPATOL8
        o0CQMLOAusSfeZeYIWx5ieats5knMPLPQtIxC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYn
        J+blpRbpmuvlZpbopaaUbmKEhLXwDsZdJ+UOMQpwMCrx8K5g+RUhxJpYVlyZe4hRkoNJSZQ3
        5PfPCCG+pPyUyozE4oz4otKc1OJDjBIczEoivFV3gcp5UxIrq1KL8mFS0hwsSuK8akvU/YQE
        0hNLUrNTUwtSi2CyMhwcShK8h58CNQoWpaanVqRl5pQgpJk4OEGG8wANfwBSw1tckJhbnJkO
        kT/FqMsx597X90xCLHn5ealS4rz/nwAVCYAUZZTmwc2BpaNXjOJAbwnzCgGTkxAPMJXBTXoF
        tIQJaMlZvx8gS0oSEVJSDYzGsUyz9q5fltaodbxvct2qX03xm5fdsO0rnba34s2RXyqZri56
        J3bvZ/JwXZ1zn+el0Yeiuo15U//qsJVtOHJk9YZ23SJV5tDAL1O2PM4JjDn2Tto/py7Qt4pl
        5cLH+xYeERRKa5inVnTyTn3g3sBL9sI+fttzFq/dvEUwNfwpf8JtPeV3Cy2VWIozEg21mIuK
        EwGszhRtIgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19/2017 01:01 PM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 5d31fb6bcf..5902a3d9e5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1570,19 +1570,16 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  
>  	refs = lookup_ref_store_map(&submodule_ref_stores, submodule);
>  	if (refs)
> -		return refs;
> +		goto done;
>  
>  	strbuf_addstr(&submodule_sb, submodule);
>  	ret = is_nonbare_repository_dir(&submodule_sb);
> -	strbuf_release(&submodule_sb);
>  	if (!ret)
> -		return NULL;
> +		goto done;
>  
>  	ret = submodule_to_gitdir(&submodule_sb, submodule);
> -	if (ret) {
> -		strbuf_release(&submodule_sb);
> -		return NULL;
> -	}
> +	if (ret)
> +		goto done;

After this change, the temporary variable `ret` could be eliminated.

> [...]

Michael

