From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 12:50:38 -0800
Message-ID: <7vobg5f55t.fsf@alter.siamese.dyndns.org>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org> <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org> <20130131200434.GI27340@google.com>
 <7v622dgl2o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:51:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1167-0005EI-LM
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab3AaUum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:50:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506Ab3AaUul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:50:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4CD4C47F;
	Thu, 31 Jan 2013 15:50:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3h/4wnNww+TrZZhOzEOb402lsqY=; b=hQCcg4
	rzPD/+0Fi/3ORcN7QxtP/cmBzP+sIak1aGJr26spYwPVLOMeS7/2Q9Noap5+GI8J
	68ws0lz8ZYc3KIW6R5KT/esnpDMWZfz3tpmFDlpC6kyzfpectmrW+8zu+MATYlhl
	3yqHvu/Z0ixZpRyJ36sJ876oiGpCKVECJqz2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qRXcnjUwP4ed+IHi9zNeekMe1JL4nJoj
	N6Tj1mI4+VfWBxAyVT4MoZilsMunAPmapqdCTAjj55LIbTdobWsy5cOvvvaSHCK+
	2p3ILenFMNZoQLErKhIksDxSbRqQi5WUHpD4yXptfBKEPZ9rm5R+WVv3ujr5nAxM
	BycyJncDUe4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9977CC47E;
	Thu, 31 Jan 2013 15:50:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DB80C47D; Thu, 31 Jan 2013
 15:50:40 -0500 (EST)
In-Reply-To: <7v622dgl2o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 31 Jan 2013 12:21:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF467AC8-6BE7-11E2-A10A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215170>

How about doing it this way?  I do not think anything that is
deprecated even deserves a separate section and "do not use it!"
heading.

-- >8 --
When looking at a configuration file edited long time ago, a user
may find 'pull.default = tracking' and wonder what it means.
Instead of not mentioning it, add it to the description in a way
that makes it clear that users have no reason to add new uses of it
preferring over 'upstream'.

 Documentation/config.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d7ec507..8441050 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1795,7 +1795,8 @@ push.default::
   +
   This is currently the default, but Git 2.0 will change the default
   to `simple`.
-* `upstream` - push the current branch to its upstream branch.
+* `upstream` - push the current branch to its upstream branch
+  (`tracking` is a deprecated synonym for this).
   With this, `git push` will update the same remote ref as the one which
   is merged by `git pull`, making `push` and `pull` symmetrical.
   See "branch.<name>.merge" for how to configure the upstream branch.
