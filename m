From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] doc/fast-import: document feature
 import-marks-if-exists
Date: Tue, 12 Jul 2011 10:00:46 -0700
Message-ID: <7voc0z8mdd.fsf@alter.siamese.dyndns.org>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
 <1310483428-29833-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:01:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QggKW-0002vr-SX
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab1GLRAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 13:00:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab1GLRAt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 13:00:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B54D2425E;
	Tue, 12 Jul 2011 13:00:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/w8r7uPwrYhsaJjC8WpexqznLHs=; b=CGBRU+
	PGZqCmtRanixcTyuwmtGjHTXx66uX0caZ+fMn8KoNWWn+gym/D5ccntJesdACplk
	pfQNi9kHjzObCNfk5yugqyoEjc7LD+pGIeS3fWyqytG9mylyTKL+c6AkZ6dAdw3y
	4peT0clCG/+tQ2m/0q2Rxj27amk5xA5YJCNLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=avRWzYp1MOAEtMfecpEazioeNvQe5o2t
	4X0+QwyJApTCahOjoZYOBReZgZ8Q5i9gnJxc3esVvFCPAkWIMZtdVQmh0ytKBmQM
	wwE4TjdCNzFhe6xM0CpJXALolxPL9AH7gJpHKcGdLja4AOCFKfZBUyehtSxjuQX2
	sG8nWVV78m0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE131425D;
	Tue, 12 Jul 2011 13:00:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D4038425C; Tue, 12 Jul 2011
 13:00:47 -0400 (EDT)
In-Reply-To: <1310483428-29833-3-git-send-email-divanorama@gmail.com> (Dmitry
 Ivankov's message of "Tue, 12 Jul 2011 21:10:27 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D5FE9FC-ACA8-11E0-BC7F-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176951>

Dmitry Ivankov <divanorama@gmail.com> writes:

> fast-import parameter --import-marks-if-exists was introduced in
> commit dded4.. --import-marks can be set via a "feature" command in
> a fast-import stream and --import-marks-if-exists has support for
> such specification too, for free.
>
> Document "feature import-marks-if-exists=<file>" command and add a
> minimalistic test for it.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>

Thanks.

>  Documentation/git-fast-import.txt |    5 +++++
>  t/t9300-fast-import.sh            |   15 +++++++++++++++
>  2 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 3f5b912..bdcc81c 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -1005,6 +1005,11 @@ import-marks::
>  	second, an --import-marks= command-line option overrides
>  	any "feature import-marks" command in the stream.
>  
> +import-marks-if-exists::
> +	Like import-marks but instead of erroring out, silently
> +	skips the file if it does not exist. Differences from --
> +	version are the same as with import-marks feature above.

Wouldn't it be more concise and complete to do it this way instead?  It
avoids duplication and also clarifies you cannot mix these two.

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 249249a..e939e74 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -995,10 +995,14 @@ force::
 	(see OPTIONS, above).
 
 import-marks::
+import-marks-if-exists::
 	Like --import-marks except in two respects: first, only one
-	"feature import-marks" command is allowed per stream;
+	"feature import-marks" command or "feature import-marks-if-exists"
+	is allowed per stream;
 	second, an --import-marks= command-line option overrides
-	any "feature import-marks" command in the stream.
+	any "feature import-marks" command in the stream. Similarly,
+	import-marks-if-exists corresponds to --import-marks-if-exists
+	from the command line.
 
 cat-blob::
 ls::

>  
> +test_expect_success 'R: feature import-marks-if-exists' '
> +	rm -f io.marks &&
> +	blob=$(echo hi | git hash-object --stdin) &&
> +	echo ":1 $blob" >expect &&
> +	git fast-import --import-marks-if-exists=io.marks --export-marks=io.marks <<-\EOF &&
> +	feature import-marks-if-exists=io.marks
> +	blob
> +	mark :1
> +	data 3
> +	hi
> +
> +	EOF
> +	test_cmp expect io.marks
> +'

Do you really want both the command line option and feature in this test?

There are at least four cases [*1*] you would want to test (a part of
blame lies in the original test you copied this from).

 - "if exists" should not fail if the marks file does not exist;
 - "if exists" reads marks if exists (not tested in this patch);
 - having "feature import-marks-if-exists" will trigger this feature
   without command line option (not tested in this patch); and
 - having "feature import-marks-if-exists" will be overridden by
   the command line option (not tested in this patch).




[Footnote]

*1* Ideally, the test should also cover these 16 combinations:

  io.marks file (2 cases: exists or missing)

times

  --import-mark-if-exists (2 cases: exists or missing)

times

 feature import-marks-if-exists (4 cases: missing,
 				same as command line,
                                different from command line,
				given more than one)
