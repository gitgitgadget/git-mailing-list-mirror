Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C6C1FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 08:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbcLaIBn (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 03:01:43 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53597 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753204AbcLaIBm (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 31 Dec 2016 03:01:42 -0500
X-AuditID: 1207440c-e53ff700000009a1-eb-586765d8cee1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FE.A6.02465.8D567685; Sat, 31 Dec 2016 03:01:28 -0500 (EST)
Received: from [192.168.69.190] (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV81QPd022492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 31 Dec 2016 03:01:27 -0500
Subject: Re: [PATCH v3 14/23] log_ref_write_1(): don't depend on logfile
 argument
To:     Jeff King <peff@peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <1e1295aff09039fc49188b085bda6ee5166d313e.1483153436.git.mhagger@alum.mit.edu>
 <20161231063523.fncqqpr3m42jjvbs@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <de31c8f1-28b6-9c21-2e1b-1fa114add5ed@alum.mit.edu>
Date:   Sat, 31 Dec 2016 09:01:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161231063523.fncqqpr3m42jjvbs@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqHsjNT3CoOmGiUXXlW4mi4beK8wW
        Sx6+Zrb40dLD7MDi0dV+hM3jWe8eRo+Ll5Q9Pm+SC2CJ4rJJSc3JLEst0rdL4Mpo/zOfrWAi
        b8XJG71MDYynuboYOTkkBEwkNj94yNLFyMUhJHCZUWLyzAfMEM5ZJonTZ9+zgFQJCwRL3N/9
        F8wWEZCV+H54IyNE0SFGiaZ175lBEswCGRI9d36zgthsAroSi3qamUBsXgF7iYUbb4LZLAKq
        EmfeHgOrERUIkbg85ygbRI2gxMmZT8AWcAq4SCxsaWKBmKku8WfeJaj58hLb385hnsDIPwtJ
        yywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuol5tZopeaUrqJERK4PDsYv62T
        OcQowMGoxMPbcS0tQog1say4MvcQoyQHk5Ior6VlaoQQX1J+SmVGYnFGfFFpTmox0OsczEoi
        vNEJ6RFCvCmJlVWpRfkwKWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkODiUJ3tgUoEbBotT0
        1Iq0zJwShDQTByfIcB6g4VkgNbzFBYm5xZnpEPlTjIpS4rw6IAkBkERGaR5cLyyxvGIUB3pF
        mLcMpIoHmJTgul8BDWYCGvw1DmxwSSJCSqqBUcrtxolrJw9p+UeHmuhqnvAqfvNqaVaVT97D
        uztmf1zhyXpng1FmwMw/FV5P+m/1xf+397I49+ybn6sAZ0bMUXXV1gVtU47s5voV5M9w4Z2P
        eWHdwwdTN5ff/BzF8J1RZ9p+mcao8C/7tbPkWBemavNaeYsdC3PLSHkbpLniAL9vw6KVN6JY
        lViKMxINtZiLihMBm19oXAcDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2016 07:35 AM, Jeff King wrote:
> On Sat, Dec 31, 2016 at 04:12:54AM +0100, Michael Haggerty wrote:
> 
>> It's unnecessary to pass a strbuf holding the reflog path up and down
>> the call stack now that it is hardly needed by the callers. Remove the
>> places where log_ref_write_1() uses it, in preparation for making it
>> internal to log_ref_setup().
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs/files-backend.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 7f26cf8..5a96424 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2837,14 +2837,18 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
>>  	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
>>  				  git_committer_info(0), msg);
>>  	if (result) {
>> -		strbuf_addf(err, "unable to append to '%s': %s", logfile->buf,
>> -			    strerror(errno));
>> +		int save_errno = errno;
>> +
>> +		strbuf_addf(err, "unable to append to '%s': %s",
>> +			    git_path("logs/%s", refname), strerror(save_errno));
> 
> Hmm. This means the logic of "the path for a reflog is
> git_path(logs/%s)" is now replicated in several places. Which feels kind
> of like a backwards step. But I guess it is pretty well cemented in the
> concept of files-backend.c, and I do like the later cleanups that this
> allows.

This might end up in a helper function in the not-too-distant future for
other reasons, but given that such code already appears multiple times,
I didn't feel too guilty about it.

Michael


