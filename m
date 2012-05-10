From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/9] apply: document --3way option
Date: Thu, 10 May 2012 15:32:53 -0700
Message-ID: <1336689173-15822-10-git-send-email-gitster@pobox.com>
References: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbvB-0006Aa-N3
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606Ab2EJWdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:33:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36767 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569Ab2EJWdN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:33:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 402848440
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5loC
	8bW3PkTd+5dR7ACTa9NNQyM=; b=rnKqnxaESafAatTLUBmcgP7ceqjDl5R9IR9v
	deM+1HGRv86FI4z2WCj3vaJpGxrNre/m9m49zRzSZYSNO3hqTQ7Rx+Iso/0Hs6Ej
	ej8bRV0AlJUK1IihjFC/am1qhbwnIq4QdcX0YTwdgaxbX1qsbxdqQREsJg9Ykh2e
	JZXGo5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fW11zj
	AG5MAOHtpj4WvXjmMpfrH6E9ooVJp81CPz44/Si/x+suX/9DwEIMjJXkfZIiJkpA
	XwdFVEydRQbU00ROtp345cSeKcBAS+97AzOcCwL9BcZmdDc8nsXfBwFNKoOQcLSq
	QxBYE6a1IeXbifb4UeiEeVuXXT5RHJNKIbOHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38CD3843E
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE805843D for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:33:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
In-Reply-To: <1336689173-15822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2094370A-9AF0-11E1-87C8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197641>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-apply.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index afd2c9a..354ff95 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,7 @@ git-apply - Apply a patch to files and/or to the index
 SYNOPSIS
 --------
 [verse]
-'git apply' [--stat] [--numstat] [--summary] [--check] [--index]
+'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
@@ -72,6 +72,14 @@ OPTIONS
 	cached data, apply the patch, and store the result in the index
 	without using the working tree. This implies `--index`.
 
+-3::
+--3way::
+	When the patch does not apply cleanly, fall back on 3-way merge if
+	the patch records the identity of blobs it is supposed to apply to,
+	and we have those blobs available locally, possibly leaving the
+	conflict markers in the files in the working tree for the user to
+	resolve.
+
 --build-fake-ancestor=<file>::
 	Newer 'git diff' output has embedded 'index information'
 	for each blob to help identify the original version that
-- 
1.7.10.1.574.g840b38f
