Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C699120133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbdCCOwN (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 09:52:13 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:59067 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751415AbdCCOwL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 09:52:11 -0500
X-AuditID: 1207440e-cb3ff7000000340b-0c-58b9826c486a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id AB.55.13323.C6289B85; Fri,  3 Mar 2017 09:49:16 -0500 (EST)
Received: from [192.168.69.190] (p5B105007.dip0.t-ipconnect.de [91.16.80.7])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v23EnDtg031303
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 3 Mar 2017 09:49:14 -0500
Subject: Re: [PATCH v5 16/24] files-backend: replace submodule_allowed check
 in files_downcast()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-17-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8fafd49f-71a6-ee97-6a69-c23e23c5d515@alum.mit.edu>
Date:   Fri, 3 Mar 2017 15:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-17-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1M1p2hlhsHallkXXlW4mi4beK8wW
        /cu72CyWPHzNbNE95S2jxcyr1habN7ezOLB77Jx1l93jw8c4jwWbSj262o+weVy8pOyxf+k2
        No/Pm+QC2KO4bFJSczLLUov07RK4Mu5enM5esE6o4tmibqYGxmt8XYycHBICJhL/t/SwdjFy
        cQgJ7GCSWHrhKBOEc5pJ4mNbG0sXIweHsECSxKs3sSANIgJpEosnv2eGqJnAKPHt2F12EIdZ
        4AajxKWJH5lAqtgEdCUW9TSD2bwC9hKnWy6xgNgsAioSJx8uZgSxRQVCJOYsfMAIUSMocXLm
        E7AaTgELifUP7oH1MguoS/yZd4kZwpaXaN46m3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5u
        YmZOcWqybnFyYl5eapGusV5uZoleakrpJkZIuPPtYGxfL3OIUYCDUYmHV9N+R4QQa2JZcWXu
        IUZJDiYlUd5DBTsjhPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwtlYC5XhTEiurUovyYVLSHCxK
        4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKEryqjUCNgkWp6akVaZk5JQhpJg5OkOE8QMMvNoAM
        Ly5IzC3OTIfIn2JUlBLnVQdJCIAkMkrz4Hph6egVozjQK8K8W0BW8ABTGVz3K6DBTECD/WTA
        BpckIqSkGhj1KveZ/1Iysz+1YLFNle5r2UMzl/lP+dXu+nOCdHiU8FTrezMk65oc3uzut3dP
        edM29cif4/+tXdbN/r6+SvKbyrQZ9aazdGtj+4JLl2mwXwrcretqlN+3pO9EQO/mf4vOL/n9
        ZemqfUvf5gYotalKPCtuW9c0TfhuywGvz5kZ05a/WTdtsYe5EktxRqKhFnNRcSIAElN9aCID
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> files-backend.c is unlearning submodules. Instead of having a specific
> check for submodules to see what operation is allowed, files backend
> now takes a set of flags at init. Each operation will check if the
> required flags is present before performing.
> 
> For now we have four flags: read, write and odb access. Main ref store
> has all flags, obviously, while submodule stores are read-only and have
> access to odb (*).

I'm surprised that you have implemented a "read" flag. Do you expect
ever to support ref-stores that are unreadable? In other words, couldn't
"read" just be assumed for any ref store?

> The "main" flag stays because many functions in the backend calls
> frontend ones without a ref store, so these functions always target the
> main ref store. Ideally the flag should be gone after ref-store-aware
> api is in place and used by backends.
> 
> (*) Submodule code needs for_each_ref. Try take REF_STORE_ODB flag
> out. At least t3404 would fail. The "have access to odb" in submodule is
> a bit hacky since we don't know from he whether add_submodule_odb() has
> been called.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c               | 15 ++++++---
>  refs/files-backend.c | 86 +++++++++++++++++++++++++++++++++-------------------
>  refs/refs-internal.h |  9 +++++-
>  3 files changed, 73 insertions(+), 37 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 67acae60c..2dc97891a 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> @@ -1821,10 +1829,14 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
>  static int files_peel_ref(struct ref_store *ref_store,
>  			  const char *refname, unsigned char *sha1)
>  {
> -	struct files_ref_store *refs = files_downcast(ref_store, 0, "peel_ref");
> +	struct files_ref_store *refs =
> +		files_downcast(ref_store, REF_STORE_READ | REF_STORE_ODB,
> +			       "peel_ref");
>  	int flag;
>  	unsigned char base[20];
>  
> +	files_assert_main_repository(refs, "peel_ref");

Instead of this call, couldn't you add `REF_STORE_MAIN` to the flags
passed to `files_downcase()`?

> +
>  	if (current_ref_iter && current_ref_iter->refname == refname) {
>  		struct object_id peeled;
>  
> [...]

Michael

