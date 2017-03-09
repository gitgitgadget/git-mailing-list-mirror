Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C79202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 12:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbdCIMZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 07:25:18 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64173 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753196AbdCIMZQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2017 07:25:16 -0500
X-AuditID: 1207440d-041ff70000003721-6f-58c149899e18
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 73.B0.14113.98941C85; Thu,  9 Mar 2017 07:24:41 -0500 (EST)
Received: from [192.168.69.190] (p4FEDFB9E.dip0.t-ipconnect.de [79.237.251.158])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v29COb22027288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Mar 2017 07:24:38 -0500
Subject: Re: [PATCH v5 07/24] files-backend: add and use files_refname_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-8-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <984307d7-8e1f-fa7c-3d6d-6440954334c3@alum.mit.edu>
Date:   Thu, 9 Mar 2017 13:24:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-8-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1O30PBhh8OeMtEXXlW4mi4beK8wW
        /cu72CyWPHzNbNE95S2jxcyr1habN7ezOLB77Jx1l93jw8c4jwWbSj262o+weVy8pOyxf+k2
        No/Pm+QC2KO4bFJSczLLUov07RK4Mo4uvcVeMJOr4lLbNbYGxiUcXYycHBICJhK7r7xk7mLk
        4hAS2MEkse/nekYI5zyTxIVXT1hAqoQFfCXu9B0Ds0UE0iQWT37PDGILCfQzSpydkQjSwCxw
        g1Hi0sSPTCAJNgFdiUU9zUA2BwevgL3EsjOSIGEWARWJxa/egc0RFQiRmLPwASOIzSsgKHFy
        JsQuTgFziSszWsHizALqEn/mXWKGsOUlmrfOZp7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ub
        mJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6iRES7Lw7GP+vkznEKMDBqMTDKyB8IEKINbGsuDL3
        EKMkB5OSKK+E0sEIIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8Oc5AOd6UxMqq1KJ8mJQ0B4uS
        OK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG+EB1CjYFFqempFWmZOCUKaiYMTZDgP0HBLkBre
        4oLE3OLMdIj8KUZFKXFeVZCEAEgiozQPrheWjF4xigO9Isx7BaSKB5jI4LpfAQ1mAho8jQ9s
        cEkiQkqqgVFx8pKowPLzvw5um2L7K0dfyNTs358jbPuKNHfnTWS+OyuoaVetZpNn02WFScVr
        qyX5Lnbs2xdZqdd8Mm2K/BbzSekTu9oVfW8zhUoXMLwLY1rscFPnQ2/8Oc21MjG5cn07yv/r
        zs7+sW+OjMIezYZDnLX/7ZYw/mA5MLnCbn7ivs5DO3+XayqxFGckGmoxFxUnAgDwxm0vIQMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> Keep repo-related path handling in one place. This will make it easier
> to add submodule/multiworktree support later.
> 
> This automatically adds the "if submodule then use the submodule version
> of git_path" to other call sites too. But it does not mean those
> operations are sumodule-ready. Not yet.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 7b4ea4c56..72f4e1746 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> [...]
> @@ -1251,10 +1263,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
>  	size_t path_baselen;
>  	int err = 0;
>  
> -	if (refs->submodule)
> -		err = strbuf_git_path_submodule(&path, refs->submodule, "%s", dirname);
> -	else
> -		strbuf_git_path(&path, "%s", dirname);
> +	files_refname_path(refs, &path, dirname);
>  	path_baselen = path.len;
>  
>  	if (err) {

I just noticed another thing. After this change, `err` is never set, so
the `if (err)` block (and `err` itself) can be deleted.

> [...]

Michael

