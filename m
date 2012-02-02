From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] vcs-svn: rename check_overflow arguments for clarity
Date: Thu, 02 Feb 2012 10:56:03 -0800
Message-ID: <7vr4ydvzcs.fsf@alter.siamese.dyndns.org>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino> <7vipjpzxav.fsf@alter.siamese.dyndns.org>
 <20120202104128.GG3823@burratino> <20120202105923.GJ3823@burratino>
 <CA+gfSn9Exv3T0UCB-bFShmSvRCMgygVuWraiToR6ZjgOA_sZ8A@mail.gmail.com>
 <20120202111628.GN3823@burratino>
 <CAFfmPPOeFk871m_N+nLXgQx3Uj4wVhgR9BNFzM2ggtseop0JaA@mail.gmail.com>
 <20120202112732.GA15537@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:56:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1pN-0004k5-A5
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093Ab2BBS4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:56:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278Ab2BBS4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 13:56:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADCEF62AC;
	Thu,  2 Feb 2012 13:56:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2pK2gJq33M6d9NzSvUL3dbumgpw=; b=A3j/pb
	C2RUhL3utqtep23LEfNXc8uq7JFAkcmDFt6sWIm9QLcUpPx0MM7ZN5TcCsVgt4Ie
	KRxsNhVEDVfplgXxggpLtuKCpqz8HarFngWJ5447D0QZ3oBAUxvbMf6fTmXgqfxp
	usVkUosxQ97VRf7TX8O1qbhZ4m2kSND+JNnvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s8eQr7XLgV19Sr/sEVhvQOP5wqpiLS+l
	bADQqTksdudcU1ZJlTV+p3wp3RlEsALVYkdyas2YWwSecrWj3Ow8jraUxHXiRerj
	zubW4qF9Awppb70FhbQnNuRj4kppktrBpC72oxi5oEjCYyyQmdImcSGCoFdJis0Z
	vgDYaGV8YPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A52A062AA;
	Thu,  2 Feb 2012 13:56:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3092B62A9; Thu,  2 Feb 2012
 13:56:05 -0500 (EST)
In-Reply-To: <20120202112732.GA15537@burratino> (Jonathan Nieder's message of
 "Thu, 2 Feb 2012 05:27:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F1BB54A-4DCF-11E1-810A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189671>

Ok, I've tentatively queued this.

-- >8 --
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Code using the argument names a and b just doesn't look right (not
sure why!).  Use more explicit names "offset" and "len" to make their
type and meaning clearer.

Also rename check_overflow() to check_offset_overflow() to clarify
that we are making sure that "len" bytes beyond "offset" still fits
the type to represent an offset.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 vcs-svn/sliding_window.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index 1bac7a4..c6c2eff 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -31,15 +31,15 @@ static int read_to_fill_or_whine(struct line_buffer *file,
 	return 0;
 }
 
-static int check_overflow(off_t a, size_t b)
+static int check_offset_overflow(off_t offset, size_t len)
 {
-	if (b > maximum_signed_value_of_type(off_t))
+	if (len > maximum_signed_value_of_type(off_t))
 		return error("unrepresentable length in delta: "
-				"%"PRIuMAX" > OFF_MAX", (uintmax_t) b);
-	if (signed_add_overflows(a, (off_t) b))
+				"%"PRIuMAX" > OFF_MAX", (uintmax_t) len);
+	if (signed_add_overflows(offset, (off_t) len))
 		return error("unrepresentable offset in delta: "
 				"%"PRIuMAX" + %"PRIuMAX" > OFF_MAX",
-				(uintmax_t) a, (uintmax_t) b);
+				(uintmax_t) offset, (uintmax_t) len);
 	return 0;
 }
 
@@ -48,9 +48,9 @@ int move_window(struct sliding_view *view, off_t off, size_t width)
 	off_t file_offset;
 	assert(view);
 	assert(view->width <= view->buf.len);
-	assert(!check_overflow(view->off, view->buf.len));
+	assert(!check_offset_overflow(view->off, view->buf.len));
 
-	if (check_overflow(off, width))
+	if (check_offset_overflow(off, width))
 		return -1;
 	if (off < view->off || off + width < view->off + view->width)
 		return error("invalid delta: window slides left");
-- 
1.7.9.172.ge26ae
