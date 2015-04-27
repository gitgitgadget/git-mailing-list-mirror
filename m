From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify documentation on commit message strip
Date: Mon, 27 Apr 2015 10:31:28 -0700
Message-ID: <xmqqh9s1xytr.fsf@gitster.dls.corp.google.com>
References: <xmqqmw1w259r.fsf@gitster.dls.corp.google.com>
	<1429940565-14947-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 19:31:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymmsb-0006OG-8x
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 19:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbbD0Rbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 13:31:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932416AbbD0Rbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 13:31:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 087394B8CF;
	Mon, 27 Apr 2015 13:31:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g2G+akkq2iKvaRtggQ/SH4PDvbs=; b=xJX+vT
	zU+sqDY9Lk9T14WR3iMur5APirfPJvlIGJhXxuDO8hgKFfPDpne6/FmW9zlENPfW
	sCm+l1GWgxloLH+IKAdXBbrdJ4Hw3vNsOa+6P/kHqFBykVz+93tyxy+/ikjEn79L
	bc61pTiSLCD2ItOpxzjZNwvPDnRB4MyF9VQZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P5z2rDydb6YCzUCRQ1ZUI+rddo8gaHV8
	0I7EJ1EnBCu3tAHYxSLo0ZDmXC6s5/DARfQU2D/N1XkcR0+Pr1ZFI43mf5EOHu/z
	SRk1AXk7/GIjNwRDmufPWfIGDFj9N6pc6H0DH+abkvwYXFdyQvcSdyIVfmwyiVGI
	R4+CGn7v3l8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00C574B8CE;
	Mon, 27 Apr 2015 13:31:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 690ED4B8CC;
	Mon, 27 Apr 2015 13:31:29 -0400 (EDT)
In-Reply-To: <1429940565-14947-1-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Sat, 25 Apr 2015 07:42:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3D2431BE-ED03-11E4-BA72-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267858>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> I agree that it is very clear once you do edit the commit message. My main
> point with this patch was to clarify -v, since it's not obvious from the
> documentation that it will be removed.

While I agree with you that the documentation should make it clear
that the patch will not be part of the commit, I think the root
cause of the current "unclear-ness" is because the documentation
does not make it clear *WHY* the "-v" option gives the patch text
there.

Doing something like this on top of your patch may clarify the
reason what "-v" is used for, and I suspect that it may even make it
unnecessary to explicitly say that the patch text will not be part
of the log message (but I didn't remove that with this "how about
this" follow-up).

 Documentation/git-commit.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1db4c7f..617dea0 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -282,7 +282,9 @@ configuration variable documented in linkgit:git-config[1].
 --verbose::
 	Show unified diff between the HEAD commit and what
 	would be committed at the bottom of the commit message
-	template.  Note that this diff output doesn't have its
+	template to help the user describe the commit by reminding
+	what changes the commit has.
+	Note that this diff output doesn't have its
 	lines prefixed with '#'. This diff will not be a part
 	of the commit message.
 +
