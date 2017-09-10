Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4941FADE
	for <e@80x24.org>; Sun, 10 Sep 2017 04:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbdIJEpP (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 00:45:15 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47037 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750807AbdIJEpO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Sep 2017 00:45:14 -0400
X-AuditID: 1207440d-86bff70000000f42-89-59b4c359ebee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DD.99.03906.953C4B95; Sun, 10 Sep 2017 00:45:13 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC2B0.dip0.t-ipconnect.de [87.188.194.176])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8A4j9Re015191
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 10 Sep 2017 00:45:10 -0400
Subject: Re: [PATCH 00/12] Clean up notes-related code around `load_subtree()`
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
 <20170909103131.pppm346qbj2cdxuo@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <2b7c0053-bf7a-fbdd-3cf9-39b5d9a962c3@alum.mit.edu>
Date:   Sun, 10 Sep 2017 06:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170909103131.pppm346qbj2cdxuo@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqBt5eEukQdc2FYuuK91MFg29V5gt
        5t3dxWTRv7yLzeJHSw+zxebN7SwObB4fPsZ5LNhU6nHp5Xc2j2e9exg9Ll5S9vi8SS6ALYrL
        JiU1J7MstUjfLoEr4/Wx/II76hVrf3ewNzD+keli5OSQEDCRWLqug72LkYtDSGAHk8ShG6tZ
        QRJCAheYJO4skAKxhQX8JBr2HGYCsUUEZCW+H97ICNLALHCMUWLro3PMEA2FEmdWX2EDsdkE
        dCUW9TQDNXBw8ArYS3x/Gw9isgioSiz8kQBSISoQIdH39jI7iM0rIChxcuYTFhCbU8BFYvnV
        32A2s4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoMAtJ+ywkLbOQtMxC0rKAkWUVo1xiTmmu
        bm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkgU8O5g/L9O5hCjAAejEg/vC9ctkUKsiWXF
        lbmHGCU5mJREeRs2AIX4kvJTKjMSizPii0pzUosPMUpwMCuJ8BofBMrxpiRWVqUW5cOkpDlY
        lMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4t4A0ChalpqdWpGXmlCCkmTg4QYbzAA2vAxte
        XJCYW5yZDpE/xagoJc47FSQhAJLIKM2D64UlqVeM4kCvCPMaHQKq4gEmOLjuV0CDmYAGlzzf
        ADK4JBEhJdXAWLn54WmR+ui17G1mjTNS5FjNl/CsWfWjUutKfvMpnpcGPKm35jX2OieI3z+m
        /N7ln0TBcd9mNalo40Vu7L9/Fc+/t1nj2af4WNejpcaW83qr1NdqaR5XeNkvtNlmV6Xe2/D0
        nv3zmbO/OSyVK3XJOsveLpi3wDlltm0nx7mnJRGzsv7ONWFVYinOSDTUYi4qTgQA/2F2vS0D
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/09/2017 12:31 PM, Jeff King wrote:
> On Sat, Aug 26, 2017 at 10:28:00AM +0200, Michael Haggerty wrote:
> 
>> It turns out that the comment is incorrect, but there was nevertheless
>> plenty that could be cleaned up in the area:
>>
>> * Make macro `GIT_NIBBLE` safer by adding some parentheses
>> * Remove some dead code
>> * Fix some memory leaks
>> * Fix some obsolete and incorrect comments
>> * Reject "notes" that are not blobs
>>
>> I hope the result is also easier to understand.
>>
>> This branch is also available from my Git fork [1] as branch
>> `load-subtree-cleanup`.
> 
> FYI, Coverity seems to complain about "pu" after this series is merged, but
> I think it's wrong.  It says:
> 
>   *** CID 1417630:  Memory - illegal accesses  (OVERRUN)
>   /notes.c: 458 in load_subtree()
>   452     
>   453     			/*
>   454     			 * Pad the rest of the SHA-1 with zeros,
>   455     			 * except for the last byte, where we write
>   456     			 * the length:
>   457     			 */
>   >>>     CID 1417630:  Memory - illegal accesses  (OVERRUN)
>   >>>     Overrunning array of 20 bytes at byte offset 20 by dereferencing pointer "&object_oid.hash[len]".
>   458     			memset(object_oid.hash + len, 0, GIT_SHA1_RAWSZ - len - 1);
>   459     			object_oid.hash[KEY_INDEX] = (unsigned char)len;
>   460     
>   461     			type = PTR_TYPE_SUBTREE;
>   462     		} else {
>   463     			/* This can't be part of a note */
> 
> I agree that if "len" were 20 here that would be a problem, but I don't
> think that's possible.
> 
> The tool correctly claims that prefix_len can be up to 19, due to the
> assert:
> 
>      3. cond_at_most: Checking prefix_len >= 20UL implies that prefix_len may be up to 19 on the false branch.
>   420        if (prefix_len >= GIT_SHA1_RAWSZ)
>   421                BUG("prefix_len (%"PRIuMAX") is out of range", (uintmax_t)prefix_len);
> 
> Then it claims:
> 
>     13. Condition path_len == 2 * (20 - prefix_len), taking false branch.
>   430                if (path_len == 2 * (GIT_SHA1_RAWSZ - prefix_len)) {
>   431                        /* This is potentially the remainder of the SHA-1 */
> 
> So we know that either prefix_len is not 19, or that path_len is not 2
> (since that combination would cause us to take the true branch here).
> But then it goes on to say:
> 
>     14. Condition path_len == 2, taking true branch.
>   442                } else if (path_len == 2) {
>   443                        /* This is potentially an internal node */
> 
> which I believe must mean that prefix_len cannot be 19 here. And yet it
> says:
> 
>     15. assignment: Assigning: len = prefix_len. The value of len may now be up to 19.
>   444                        size_t len = prefix_len;
>   445
>   [...]
>      17. incr: Incrementing len. The value of len may now be up to 20.
>      18. Condition hex_to_bytes(&object_oid.hash[len++], entry.path, 1), taking false branch.
>   450                        if (hex_to_bytes(object_oid.hash + len++, entry.path, 1))
>   451                                goto handle_non_note; /* entry.path is not a SHA1 */
> 
> I think that's impossible, and Coverity simply isn't smart enough to
> shrink the set of possible values for prefix_len based on the set of
> if-else conditions.
> 
> So nothing to see here, but since I spent 20 minutes scratching my head
> (and I know others look at Coverity output and may scratch their heads
> too), I thought it was worth writing up. And also if I'm wrong, it would
> be good to know. ;)

Thanks for looking into this. I agree with your analysis.

I wonder whether it is the factor of two between path lengths and byte
lengths that is confusing Coverity. Perhaps the patch below would help.
It requires an extra, superfluous, check, but perhaps makes the code a
tad more readable. I'm neutral on whether we would want to make the change.

Is there a way to ask Coverity whether a hypothetical change would
remove the warning, short of merging the change to master?

Michael

diff --git a/notes.c b/notes.c
index 27d232f294..34f623f7b1 100644
--- a/notes.c
+++ b/notes.c
@@ -426,8 +426,14 @@ static void load_subtree(struct notes_tree *t,
struct leaf_node *subtree,
 		unsigned char type;
 		struct leaf_node *l;
 		size_t path_len = strlen(entry.path);
+		size_t path_bytes;

-		if (path_len == 2 * (GIT_SHA1_RAWSZ - prefix_len)) {
+		if (path_len % 2 != 0)
+			/* Path chunks must come in pairs of hex characters */
+			goto handle_non_note;
+
+		path_bytes = path_len / 2;
+		if (path_bytes == GIT_SHA1_RAWSZ - prefix_len) {
 			/* This is potentially the remainder of the SHA-1 */

 			if (!S_ISREG(entry.mode))
@@ -439,7 +445,7 @@ static void load_subtree(struct notes_tree *t,
struct leaf_node *subtree,
 				goto handle_non_note; /* entry.path is not a SHA1 */

 			type = PTR_TYPE_NOTE;
-		} else if (path_len == 2) {
+		} else if (path_bytes == 1) {
 			/* This is potentially an internal node */
 			size_t len = prefix_len;

