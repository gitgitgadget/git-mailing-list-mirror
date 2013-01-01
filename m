From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation: full-ness of a bundle is significant for
 cloning
Date: Tue, 01 Jan 2013 13:07:05 -0800
Message-ID: <7vehi4a9za.fsf_-_@alter.siamese.dyndns.org>
References: <1357053973.22772208@f75.mail.ru>
 <7vvcbgaapq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Brilliantov <brilliantov@inbox.ru>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:07:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq93X-0001Bv-Fh
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab3AAVHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:07:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445Ab3AAVHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:07:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69B8F906D;
	Tue,  1 Jan 2013 16:07:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=It0GfhiZFyGjFGLhLrNCWvXBDtk=; b=E/oXv9
	fjgd6dFmt4W94DYpoQAQK9pqCWCRaZc0A0DtjUclyq2f/TE4JwmjZnbB6MC9gX7Z
	qOuka2DdEUEFYAjdzpJ/17e0P7nYjGs+Ean47lMbPHxXfuhhlmkpiYYDzpXaHkAU
	3BC8Ljpffjd26qloMugl/qGMtIRJzl7JRXwmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bXphM91h4/81H34rZdqtE+XuWTjiTgQB
	f1rqqErWxn/6sfg64fKBqs5cGqAH1hLPtIYD/jBSaOOqIAw5RMQd+pjO10csRz7q
	8NwA9pZj8lA1MTJ2pFD8TON7IkLyiDUy77IwRoRNv7nYaRvvkfUnwdUhHUgrWQBj
	RLLExnLItqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BBB8906C;
	Tue,  1 Jan 2013 16:07:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7729906B; Tue,  1 Jan 2013
 16:07:06 -0500 (EST)
In-Reply-To: <7vvcbgaapq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 01 Jan 2013 12:51:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32E96B70-5457-11E2-A6A4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212441>

Not necessarily every bundle file can be cloned from.  Only the ones
that do not need prerequisites can.

When 1d52b02 (Documentation: minor grammatical fixes and rewording
in git-bundle.txt, 2009-03-22) reworded this paragraph, it lost a
critical hint to tell readers why thhis particular bundle can be
cloned from.  Resurrect it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As I noticed this while I was looking at Kirill's patch...

 Documentation/git-bundle.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 5c8ba44..bc023cc 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -112,10 +112,9 @@ machineA$ git bundle create file.bundle master
 machineA$ git tag -f lastR2bundle master
 ----------------
 
-Then you transfer file.bundle to the target machine B. If you are creating
-the repository on machine B, then you can clone from the bundle as if it
-were a remote repository instead of creating an empty repository and then
-pulling or fetching objects from the bundle:
+Then you transfer file.bundle to the target machine B. Because this
+bundle does not require any existing object to be extracted, you can
+create a new repository on machine B by cloning from it:
 
 ----------------
 machineB$ git clone -b master /home/me/tmp/file.bundle R2
-- 
1.8.1.209.gc32ab23
