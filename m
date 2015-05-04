From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] git-hash-object.txt: document --literally option
Date: Mon,  4 May 2015 14:37:28 -0700
Message-ID: <1430775451-31130-2-git-send-email-gitster@pobox.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
 <1430775451-31130-1-git-send-email-gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 23:37:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpO3d-0001H7-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbbEDVhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 17:37:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752115AbbEDVhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 17:37:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D56814FA18;
	Mon,  4 May 2015 17:37:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ueSN
	7G5pbWIAnOk+KmDQExzb7kU=; b=ApYt/bngCTj0PEHOLjKS0Jld3NZanVvfj30C
	GsSIoEGHzIru1OSkp5NFYEfURaLcFVp6gmP/AnAi1zH5hv34WGpVjoIt55UlS088
	iz9a4a84mi+QRjFJqkZDZvFICVjUjFIBMTDpSTWk6659nz+PhVs+MUpiW7JHwW+H
	gQV72Po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	qlURZUr3UCux4/G/Oer1jGq1ZLYgDD7U+PccdCOEgIYC4xuclCGDz9JS7HHgvo3R
	3asNnoQ+rnbsgI61ZEkKswkyVddlHfnuGReUBmIEGoFmZU0+7jd2QKXBwaEK8INg
	B4kS2UO8POsDBTkOl0npW0qPGA0ZH7ewzz/yor/RDTM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEB4D4FA17;
	Mon,  4 May 2015 17:37:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53E1D4FA16;
	Mon,  4 May 2015 17:37:34 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-307-g8f38e3e
In-Reply-To: <1430775451-31130-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C69B9E08-F2A5-11E4-9613-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268358>

From: Eric Sunshine <sunshine@sunshineco.com>

Document the git-hash-object --literally option added by 5ba9a93
(hash-object: add --literally option, 2014-09-11).

While here, also correct a minor typesetting oversight.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As posted by Eric

 Documentation/git-hash-object.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 02c1f12..0c75f3b 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,7 +9,7 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>...
+'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters] < <list-of-paths>
 
 DESCRIPTION
@@ -51,7 +51,13 @@ OPTIONS
 	Hash the contents as is, ignoring any input filter that would
 	have been chosen by the attributes mechanism, including the end-of-line
 	conversion. If the file is read from standard input then this
-	is always implied, unless the --path option is given.
+	is always implied, unless the `--path` option is given.
+
+--literally::
+	Allow `--stdin` to hash any garbage into a loose object which might not
+	otherwise pass standard object parsing or git-fsck checks. Useful for
+	stress-testing Git itself or reproducing characteristics of corrupt or
+	bogus objects encountered in the wild.
 
 GIT
 ---
-- 
2.4.0-302-g6743426
