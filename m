Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 744C120196
	for <e@80x24.org>; Thu, 14 Jul 2016 19:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbcGNTUx (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 15:20:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751153AbcGNTUw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 15:20:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFECD2A1C0;
	Thu, 14 Jul 2016 15:20:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=e
	dqXNHxIJkKYotgBwMzYx/LLkKw=; b=D+REAoAgut6r1L71HtxGMxnQmTqKw+XPo
	fck7pdvPtUW+u+vb5P5/QCV1zB4uuyuyi4Io3AzlQBJ+nAk8jZr+o4NkjV8sS4o2
	MzCi1SDxaorh1AZtnU/U6tuAfvXGwAljtyzebjhn/KVg28RlNtyTib+nZZq7ZX5/
	qoNI/7Hty4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=YnP
	0d+zaGNSpp8J9XW6pcgyl/TElPE11/mE9mrZTmIxfAuEkbApmcUWKFzQKgam8aiS
	j64zZmMMttmOrBtKZ7qENvnIIS+IewWaB9UzbMVqFsDGFsO5an3Dvof+3lBbb875
	/TCO7KVsKkf6ge0A2ahiopCBuvoURavO0nhREgKI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C82C82A1BF;
	Thu, 14 Jul 2016 15:20:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BFA42A1B9;
	Thu, 14 Jul 2016 15:20:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: [PATCH] diff: document diff-filter exclusion
Date:	Thu, 14 Jul 2016 12:20:49 -0700
Message-ID: <xmqq7fcoqb5a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13BCC8D8-49F8-11E6-AD99-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In v1.8.5 days, 7f2ea5f0 (diff: allow lowercase letter to specify
what change class to exclude, 2013-07-17) taught the "--diff-filter"
mechanism to take lowercase letters as exclusion, but we forgot to
document it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3ad6404..073c7e5 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -399,6 +399,9 @@ ifndef::git-format-patch[]
 	paths are selected if there is any file that matches
 	other criteria in the comparison; if there is no file
 	that matches other criteria, nothing is selected.
++
+Also, these upper-case letters can be downcased to exclude.  E.g.
+`--diff-filter=ad` excludes added and deleted paths.
 
 -S<string>::
 	Look for differences that change the number of occurrences of
-- 
2.9.1-545-g8c0a069

