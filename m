From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: "git checkout -b/-B/--orphan" always takes a branch
 name
Date: Sun, 26 Aug 2012 11:42:19 -0700
Message-ID: <7v4nnpv6k4.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 20:42:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5hn2-0001fu-Tr
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 20:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab2HZSmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 14:42:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230Ab2HZSmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 14:42:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 693FD8FB4;
	Sun, 26 Aug 2012 14:42:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3nY05BQiMDFQGFYmEJBK7GVGODQ=; b=LPhXv3
	gCLUfR2lC7tC0Ut8bRP6GdOM0t+n6cWTMqZb6buyUkBqED7RHMN+px6XsCcUQsPC
	OZbvx7Kl2aeewOVKmVfP31wx89MUVXMclCo2elO7biWtDyZ9AINZssMTZEHETEWG
	j+J92GtNE0f/EIrGz/BD2yIr+KC2ufpKCpKks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F8RENgGTRok/50vWIaT9+c/QHG1Lzfxc
	89qGFMOGEw5rkeauFujXrIPNaCt3x4AZJLq7VFYxEupP49VD6A+Q6/vQ7/NvLQr3
	VHkm0y8iSBYzQBTJYpzVli0wefTYG3fYGJXsFKV2dV38NXUjMQ9zGg6yW2HfuPyI
	/OJ2GSRmQPk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 575A98FB3;
	Sun, 26 Aug 2012 14:42:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA2FB8FB2; Sun, 26 Aug 2012
 14:42:20 -0400 (EDT)
In-Reply-To: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com>
 (=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Sun, 26 Aug 2012 15:27:26
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4BEB474-EFAD-11E1-8D89-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204309>

While the synopsis section makes it clear that the new branch name
is the parameter to these flags, the option description did not.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-checkout.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c0a96e6..e3270cd 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -84,11 +84,11 @@ entries; instead, unmerged entries are ignored.
 	When checking out paths from the index, check out stage #2
 	('ours') or #3 ('theirs') for unmerged paths.
 
--b::
+-b <new_branch>::
 	Create a new branch named <new_branch> and start it at
 	<start_point>; see linkgit:git-branch[1] for details.
 
--B::
+-B <new_branch>::
 	Creates the branch <new_branch> and start it at <start_point>;
 	if it already exists, then reset it to <start_point>. This is
 	equivalent to running "git branch" with "-f"; see
@@ -124,7 +124,7 @@ explicitly give a name with '-b' in such a case.
 	<commit> is not a branch name.  See the "DETACHED HEAD" section
 	below for details.
 
---orphan::
+--orphan <new_branch>::
 	Create a new 'orphan' branch, named <new_branch>, started from
 	<start_point> and switch to it.  The first commit made on this
 	new branch will have no parents and it will be the root of a new
-- 
1.7.12.252.gef4e272
