Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D215D205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 14:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933277AbdABOed (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 09:34:33 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:46197 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933062AbdABOec (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 09:34:32 -0500
X-AuditID: 1207440e-7c7ff700000009ec-45-586a64f2192f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 79.D4.02540.2F46A685; Mon,  2 Jan 2017 09:34:27 -0500 (EST)
Received: from [192.168.69.190] (p5B10411C.dip0.t-ipconnect.de [91.16.65.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v02EYNB8028435
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 2 Jan 2017 09:34:25 -0500
Subject: Re: [PATCH 09/17] builtin/merge: convert to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
 <20170101191847.564741-10-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f6b59780-a76c-1e13-f983-c0cc767cc2b8@alum.mit.edu>
Date:   Mon, 2 Jan 2017 15:34:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170101191847.564741-10-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqPs5JSvCoPedmUXXlW4mix8tPcwW
        bTN/MDkweyy/+ZfJ41nvHkaPz5vkApijuGxSUnMyy1KL9O0SuDIeHehnL7jEVfHl+VPmBsZj
        HF2MHBwSAiYSyzvsuxi5OIQELjNKPJt2jx3COcMk8XvSHHaQImEBV4kdn+W7GDk5RAS8JOY/
        msEKYgsJ1Eh82raAGcRmFpCVWL/iLyOIzSagK7Gop5kJxOYVsJeY9+kyWD2LgIrE/rM7WUBs
        UYEQictzjrJB1AhKnJz5BCzOKeAicfBSNyPETD2JHdd/sULY8hLb385hnsDIPwtJyywkZbOQ
        lC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGusl5tZopeaUrqJERKgfDsY29fLHGIU4GBU
        4uF9EJMVIcSaWFZcmXuIUZKDSUmUN2FDRoQQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd738UDl
        vCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3vZkoEbBotT01Iq0zJwS
        hDQTByfIcB6g4UUgNbzFBYm5xZnpEPlTjIpS4ryTQBICIImM0jy4XlgCecUoDvSKMG8nSBUP
        MPnAdb8CGswENPhrXDrI4JJEhJRUA+PaoloV59rPrGtOhCqyVE+J9zrLG+6y+kXBM9eVR3fw
        sU5cWP5ZXI/HXPPVIX5rN4eZJ5a9OhjG6ZzNzbYs0aLIPGfBDEvOup1hGnsqdzzy/sq/PG1H
        Apdz2eIIp1Wrhe+k7rF3/c0kwb98xbf7d3WLxI5PSn7w48nlp6Z+oa8ubax/cEVx+RwlluKM
        REMt5qLiRABMfbfH+wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/01/2017 08:18 PM, brian m. carlson wrote:
> Additionally convert several uses of the constant 40 into
> GIT_SHA1_HEXSZ.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/merge.c | 136 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 68 insertions(+), 68 deletions(-)
> 
> [...]
> @@ -437,25 +437,25 @@ static void merge_name(const char *remote, struct strbuf *msg)
>  	strbuf_branchname(&bname, remote);
>  	remote = bname.buf;
>  
> -	memset(branch_head, 0, sizeof(branch_head));
> +	memset(&branch_head, 0, sizeof(branch_head));

I think this could be

        oidclr(&branch_head);

>  	remote_head = get_merge_parent(remote);
>  	if (!remote_head)
>  		die(_("'%s' does not point to a commit"), remote);
> [...]
> @@ -1113,9 +1113,9 @@ static struct commit_list *collect_parents(struct commit *head_commit,
>  
>  int cmd_merge(int argc, const char **argv, const char *prefix)
>  {
> -	unsigned char result_tree[20];
> -	unsigned char stash[20];
> -	unsigned char head_sha1[20];
> +	struct object_id result_tree;
> +	struct object_id stash;
> +	struct object_id head_oid;

These could comfortably be declared on a single line now.

>  	struct commit *head_commit;
>  	struct strbuf buf = STRBUF_INIT;
>  	const char *head_arg;
> [...]

Michael

