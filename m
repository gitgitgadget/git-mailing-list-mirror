From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: make clear --assume-unchanged's user contract
Date: Fri, 05 Dec 2014 15:32:08 -0800
Message-ID: <xmqqbnnhoepz.fsf@gitster.dls.corp.google.com>
References: <1417818117-368-1-git-send-email-philipoakley@iee.org>
	<1417818117-368-2-git-send-email-philipoakley@iee.org>
	<xmqqtx19ogn9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>,
	?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:32:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx2MM-0007Jv-QX
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbaLEXcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 18:32:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753777AbaLEXcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 18:32:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB663233A2;
	Fri,  5 Dec 2014 18:32:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yoB724w0hAPP/tw8d1TG2X1y6DI=; b=n8PIpP
	vPvUm/kC5x+U/Q/9QlMuLXXf/ZqDMXVxmS/6oRAWSk3VOCy04DAuG/eICNDZAVsh
	hszP/uqabFmv7vgl7qWiA3bvjOzfWWIgc/whQA0jFiu42HRMNOpRX4jhMHk5gDzF
	zwlHLIN4Yuu4fsKlFPSjVYW7lA+QT4zQlzblo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FngzZlJMLeKn47cj/AtQRZCbJt8JCe7U
	3iEQDmWao1C8frFF0rMVCY6KlOQVgfaZSMxDnXxoTbGWviteJR4AkCPDsTADaspp
	AzqwCfGLXKA/CdcpDJSuxGRVg8Xf77k7oCNB0phhfVfnqsJirUcCKZkooyYUi1fW
	lBzx77C0ajY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D185E233A1;
	Fri,  5 Dec 2014 18:32:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F23C233A0;
	Fri,  5 Dec 2014 18:32:18 -0500 (EST)
In-Reply-To: <xmqqtx19ogn9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 05 Dec 2014 14:50:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3DB5858-7CD6-11E4-938E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260915>

Junio C Hamano <gitster@pobox.com> writes:

> This reads much better than the original, but you may want to go a
> bit further.  How about removing the original a bit more, like so:
> ...

So here is what I came up to squash into your version when queuing
it to 'pu'.

-- >8 --
Subject: [PATCH] SQUASH???

 - Further matching of number and verb; we are talking about a single
   flag bit.

 - The bit tells Git that it can assume that the files marked as
   such are unchanged.  Mentioning "Git stops checking" does not
   help the reader, as it is only one possible consequence of what
   that assumption allows Git to do, but

   (1) there are things other than "stop checking" that Git can do
       based on that assumption; and
   (2) Git is not obliged to stop checking; it merely is allowed to.

 - Drop the stale and incorrect information about "poor-man's
   ignore", which is not this bit is about at all.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-update-index.txt | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index f1f5f7f..da1ccbc 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -79,20 +79,17 @@ OPTIONS
 
 --[no-]assume-unchanged::
 	When this flag is specified, the object names recorded
-	for the paths are not updated.  Instead, these options
-	set and unset the "assume unchanged" bit for the
-	paths.  When the "assume unchanged" bit is on, the user promise
-	is not to change the file, so Git stops
-	checking the working tree files for possible
-	modifications, so when you change the working tree file you
-	need to manually unset the bit to tell Git . This is
+	for the paths are not updated.  Instead, this option
+	sets/unsets the "assume unchanged" bit for the
+	paths.  When the "assume unchanged" bit is on, the user
+	promises not to change the file and allows Git to assume
+	that the working tree file matches what is recorded in
+	the index.  If you want to change the working tree file,
+	you need to unset the bit to tell Git.  This is
 	sometimes helpful when working with a big project on a
 	filesystem that has very slow lstat(2) system call
 	(e.g. cifs).
 +
-This option can be also used as a coarse file-level mechanism
-to ignore uncommitted changes in tracked files (akin to what
-`.gitignore` does for untracked files).
 Git will fail (gracefully) in case it needs to modify this file
 in the index e.g. when merging in a commit;
 thus, in case the assumed-untracked file is changed upstream,
-- 
2.2.0-155-g395db3e
