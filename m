From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Meaning of double + and - in Gitk's diff pane
Date: Mon, 21 Mar 2011 13:40:24 -0700
Message-ID: <7vwrjsnr5z.fsf@alter.siamese.dyndns.org>
References: <4D879B25.9090300@dirk.my1.cc>
 <7vr5a0p8n1.fsf@alter.siamese.dyndns.org> <4D87AAD6.6000704@dirk.my1.cc>
 <7vaagop83d.fsf@alter.siamese.dyndns.org> <4D87AD9D.7080501@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:40:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lu2-0000Fj-NH
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab1CUUkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 16:40:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab1CUUkd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 16:40:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A5E714A59;
	Mon, 21 Mar 2011 16:42:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4pmjSeQ9+jNI
	NIN0Utv3Tj2gXsw=; b=dTfbCuRvOE9DtAOoIFGKhbIqa/stt3P1nQDbvvTGAjuF
	hIu8CVEH+cGoBb5DPYkZHgYR+jbTRxU0TJgZz0FWQFg0o/VHTh1+OnZLFFViHbrc
	+mw4RjPxUSylRgfUjZArR059cGDabjaTK4xnclWf1t5WSwK+acKaIf1MxfxhJns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kZsXLK
	VDpsMkmRKjwMIw1aU+wp5H0Vi4Lqj4oFzxNTAzciPelMzOVEJ3htrWOnVik05+AN
	0WplQ1nuQjf9MVp5XN596iITbJ80jTmwnCfHN1IKisKyu0q7FmI/x+WE673x6IZL
	n+YhhGlMLt7M9IY76AoYFIwEIMr6GG1KDryp8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 84B894A58;
	Mon, 21 Mar 2011 16:42:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5AEB64A57; Mon, 21 Mar 2011
 16:42:05 -0400 (EDT)
In-Reply-To: <4D87AD9D.7080501@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserot?=
 =?utf-8?Q?t=22's?= message of "Mon, 21 Mar 2011 20:57:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B085C348-53FB-11E0-85EF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169667>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> Am 21.03.2011 20:49 schrieb Junio C Hamano:
>>>
>>> Junio, thanks. When I've found the time, I'll probably condense Lin=
us'
>>> explanations and submit a documentation patch. It's not explained
>>> in the actual git docs, right?
>>
>> How about checking "git diff"?  The same conclusion should be in the=
re, as
>> I wrote the implementation, docs and the messages there.
>>
> Uhh, sorry, I missed that. That was actually what I was searching for=
=2E

Hmm... re-reading "git diff --help" and looking at the section on combi=
ned
diff, I notice that we talk about how to understand its output, but we
don't say under what rule the --cc option condenses what would be produ=
ced
with the -c option.  Perhaps we would need a patch after all at the end=
 of
Documentation/diff-generate-patch.txt file.

Here is a quick attempt.

 Documentation/diff-generate-patch.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff=
-generate-patch.txt
index c57460c..20a603d 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -183,3 +183,21 @@ parents).  When shown by `git diff-files -c`, it c=
ompares the
 two unresolved merge parents with the working tree file
 (i.e. file1 is stage 2 aka "our version", file2 is stage 3 aka
 "their version").
+
+The "combined" format (`-c` option) shows the diff to the result (i.e.=
 the
+result of the merge, or the file in the working tree during a conflict
+resolution) from two or more originals (i.e. parents of the merge or
+branches being merged) combined, but it often shows many trivial chang=
es
+that the result takes the change from a single original verbatim.  The
+"dense combined" format (`--cc` option) removes such hunks with only
+"trivial" changes. A hunk that has only two versions (or less) in the
+original (in a usual two-parent merge, this always is the case, simply
+because there are only two originals) and whose result matches exactly=
 one
+of the originals, is considered "trivial" and is omitted from the outp=
ut
+in the "dense combined" format.  In the previous illustration of a
+combined diff on `describe.c` file, there are two originals, one that =
had
+the describe function with a single `char *arg` parameter, and the oth=
er
+with two parameters, but the result matches neither of them, hence it =
is
+not "trivial" and the hunk appears in the output.
+
+
