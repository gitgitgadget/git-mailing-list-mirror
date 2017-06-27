Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E1720401
	for <e@80x24.org>; Tue, 27 Jun 2017 20:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753329AbdF0UU5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 16:20:57 -0400
Received: from mout.web.de ([212.227.15.4]:64060 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753303AbdF0UU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 16:20:56 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2dgj-1diqw62UM9-00sJc9; Tue, 27
 Jun 2017 22:20:39 +0200
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
 <20170225101307.24067-2-vegard.nossum@oracle.com>
 <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de>
 <xmqqmvd7wgc7.fsf@gitster.mtv.corp.google.com>
 <f191e3a8-a55b-7030-ebbb-3f46c74fdc94@web.de>
 <xmqq1sujnu1g.fsf@gitster.mtv.corp.google.com>
 <05fe5800-ebc0-76d7-579d-77f64a851fc1@web.de>
 <5128cdf1-39fc-59ca-5640-801777bac2fa@web.de>
 <xmqqshil1ex1.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1374711c-2cf5-ae8e-16e0-7c10be253a08@web.de>
Date:   Tue, 27 Jun 2017 22:20:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqshil1ex1.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/pz2Bl4KLb1+feHguE7oT0ETxb5yD1PN3J9k96et0TKKn7Q/F0+
 t8a+ZcAEZgkPg2AkVChcQfXb/m305iWfzv4ZOIXcAteZNd73EUetSVpWhnKm9lVEJ1UTKWp
 eEY3fpiARsjhzCbM4om4/VxgES5e6Zqe4C1xlcIigtqjPb/jQcxJ+Zc5V6rUvh4AVCVOcun
 XtRHxlgKPN8DFMVEtr0kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0yz3zaViLIE=:Ajh4fLve/tzLjME7L6luK3
 pyedDwjuvdAfNn60Chc8XK2iAUFi1YJiLBOLQHM2oIgHMGQsxaD7vrlc0ZirAwX3jzuOZv+72
 B/bDvvop0MmasQ8/1ME5m++OcRu958G26hswMj0Ybp5M95wD2R+Ql6EzysHozOBWbzNdwWYyM
 G8qJvgFh7rKuuduapUHvNqytt6oBs80Jn6E/8+5boI4du/yPCVDkXG/X11L58TwgNS+02yI1L
 AqUhlQniDQwprZaiJzyoQWSu9aFYykbfIe/ftqbmSKKEQy8/MY9TcbmD42PRNP7tIE5Hjw7Dq
 w3794a9ANvlymiz6fqhzHlfYwWAqayGC3IXLSDHhAI9Xv8ZUGMA1kI8iRIfAIDiovR+Hmyd/H
 H8VQ/TGX2Tq+W/WxoDBxhqilX3rlvLEiWzgRk99mVAED1pXodW1CZg/n6riyLez5ZafosoA+5
 fvDx8AHGZfDxHnkFXSZkFhPYRDBnsm/i0lRr0h2jALc1xEV2V2RoO6QBW3eZEjsg6ZHD7igHP
 5VnApgWurIUFCgkPizwDETjFWsYebMbOFMnk/UK3bq5kpTDTWeJ38eaD39lstRAbOfeG6y0eB
 sNbeT6vcWohK3znrKNCYnyeKZO5znJqTHHD6h/OcYjbNIgkPi+qOsSTNR70HV6xjOj+lblnmZ
 kv/TOzICtYa00JLoIB6T5EQYhwjlPLQiHGk66V5kW3Q6yfiE+ibje39Pj3y0ZvLIKK3M7qF+w
 MF7kpu/H4W9i3xoArgKMfmLbK07QKon8o1AMFl9zaalQRKZZw+1p/wsA8S0nI087T0dtq/Ugk
 m+aCkjR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.2017 um 20:08 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Thought a bit more about it, and as a result here's a simpler approach:
>>
>> -- >8 --
>> Subject: [PATCH] apply: check git diffs for mutually exclusive header lines
>>
>> A file can either be added, removed, copied, or renamed, but no two of
>> these actions can be done by the same patch.  Some of these combinations
>> provoke error messages due to missing file names, and some are only
>> caught by an assertion.  Check git patches already as they are parsed
>> and report conflicting lines on sight.
>>
>> Found by Vegard Nossum using AFL.
>>
>> Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   apply.c                | 14 ++++++++++++++
>>   apply.h                |  1 +
>>   t/t4136-apply-check.sh | 18 ++++++++++++++++++
>>   3 files changed, 33 insertions(+)
>>
>> diff --git a/apply.c b/apply.c
>> index 8cd6435c74..8a5e44c474 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -1312,6 +1312,18 @@ static char *git_header_name(struct apply_state *state,
>>   	}
>>   }
>>   
>> +static int check_header_line(struct apply_state *state, struct patch *patch)
>> +{
>> +	int extensions = (patch->is_delete == 1) + (patch->is_new == 1) +
>> +			 (patch->is_rename == 1) + (patch->is_copy == 1);
>> +	if (extensions > 1)
>> +		return error(_("inconsistent header lines %d and %d"),
>> +			     state->extension_linenr, state->linenr);
>> +	if (extensions && !state->extension_linenr)
>> +		state->extension_linenr = state->linenr;
> 
> OK.  I wondered briefly what happens if the first git_header that
> sets one of the extensions can be at line 0 (calusng
> state->extension_linenr to be set to 0), but even in that case, the
> second problematic one will correctly report the 0th and its own
> line as culprit, so this is OK.  It makes me question if there is
> any point checking !state->extension_linenr in the if() statement,
> though.

It makes sure that ->extension_linenr is set to the first line number of
an extension (like, say, "copy from") and not advanced again (e.g. when
we hit "copy to", or more importantly some line like "similarity index"
which does not set one of the extension bits and thus can't actually
cause a conflict).

Hmm, pondering that, it seems I forgot to reset its value after each
patch.  Or better just move it into struct patch, next to the extension
bits:

-- >8 --
Subject: fixup! apply: check git diffs for mutually exclusive header lines
---
 apply.c | 7 ++++---
 apply.h | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index db38bc3cdd..c442b89328 100644
--- a/apply.c
+++ b/apply.c
@@ -211,6 +211,7 @@ struct patch {
 	unsigned ws_rule;
 	int lines_added, lines_deleted;
 	int score;
+	int extension_linenr; /* first line specifying delete/new/rename/copy */
 	unsigned int is_toplevel_relative:1;
 	unsigned int inaccurate_eof:1;
 	unsigned int is_binary:1;
@@ -1325,9 +1326,9 @@ static int check_header_line(struct apply_state *state, struct patch *patch)
 			 (patch->is_rename == 1) + (patch->is_copy == 1);
 	if (extensions > 1)
 		return error(_("inconsistent header lines %d and %d"),
-			     state->extension_linenr, state->linenr);
-	if (extensions && !state->extension_linenr)
-		state->extension_linenr = state->linenr;
+			     patch->extension_linenr, state->linenr);
+	if (extensions && !patch->extension_linenr)
+		patch->extension_linenr = state->linenr;
 	return 0;
 }
 
diff --git a/apply.h b/apply.h
index b52078b486..b3d6783d55 100644
--- a/apply.h
+++ b/apply.h
@@ -79,7 +79,6 @@ struct apply_state {
 
 	/* Various "current state" */
 	int linenr; /* current line number */
-	int extension_linenr; /* first line specifying delete/new/rename/copy */
 	struct string_list symlink_changes; /* we have to track symlinks */
 
 	/*
-- 
2.13.2
