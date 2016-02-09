From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-clean.txt: don't mention deletion of .git/modules/*
Date: Tue, 09 Feb 2016 09:34:22 -0800
Message-ID: <xmqqpow54wkh.fsf@gitster.mtv.corp.google.com>
References: <1454790889.23898.225.camel@mattmccutchen.net>
	<xmqqvb5y6dx2.fsf@gitster.mtv.corp.google.com>
	<1454971010.2511.89.camel@mattmccutchen.net>
	<20160208224739.GH6104@lakka.kapsi.fi>
	<20160209075553.GI6104@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:34:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTCBJ-0003n7-Ux
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 18:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbcBIRe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 12:34:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753084AbcBIReZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 12:34:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC704404A8;
	Tue,  9 Feb 2016 12:34:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dsyYVnVr0kjY34ybylJvjAnPxqA=; b=mIcjq2
	iWgKhx4DHzjIWFCjjMwwglx42fVkenoQ13oeSNBhVbNf0jUM83QP9gD8NazpsOnc
	YZjFfhttqX0FR3S4q67jb8PsiOocjKFEBab8Cugxg755TxSXhnh6pI5iu9bzN5aP
	/fvgWZybk+cE4dH6lJw6VOQN6MiT8A03YhA54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rRXqYpmYpU6noqKuBcMPAeUBTA7zvn+h
	eb2MZXmnrXMHEiJNi/BtHd1P72oCDtTN7DgqeZy0hFE4ThbjIvnrudf5R9SOrMDp
	PmvaR9Wp+0enxfxGC744BbdxthEJ5NizqVYfbQKR6oSh4UdpvIcQQLD0Pqzse+tc
	ltZvmJdrCLA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3717404A7;
	Tue,  9 Feb 2016 12:34:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3027D404A6;
	Tue,  9 Feb 2016 12:34:24 -0500 (EST)
In-Reply-To: <20160209075553.GI6104@lakka.kapsi.fi> (Mikko Rapeli's message of
	"Tue, 9 Feb 2016 09:55:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C4785C2-CF53-11E5-B480-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285841>

Mikko Rapeli <mikko.rapeli@iki.fi> writes:

> Sorry, can't reproduce the problem where submodules stayed in the tree until
> git clean was called with two -f's.
>
> You are right in removing the second part.

Thanks, then let's do this.

-- >8 --
From: Matt McCutchen <matt@mattmccutchen.net>
Date: Sat, 6 Feb 2016 15:25:41 -0500
Subject: [PATCH] Documentation/git-clean.txt: don't mention deletion of .git/modules/*

The latter half fo this sentence, the removal of the submodules, was
never done with (or without) double -f back when it was written, and
we still do not do so.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
Acked-by: Mikko Rapeli <mikko.rapeli@iki.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clean.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 641681f..51a7e26 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -37,9 +37,7 @@ OPTIONS
 	to false, 'git clean' will refuse to delete files or directories
 	unless given -f, -n or -i. Git will refuse to delete directories
 	with .git sub directory or file unless a second -f
-	is given. This affects also git submodules where the storage area
-	of the removed submodule under .git/modules/ is not removed until
-	-f is given twice.
+	is given.
 
 -i::
 --interactive::
-- 
2.7.1-358-gd2e280b
