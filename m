From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Sun, 27 Jan 2013 12:47:09 -0800
Message-ID: <7v622iuzea.fsf@alter.siamese.dyndns.org>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org> <5104B0B5.1030501@alum.mit.edu>
 <20130127141329.GN7498@serenity.lan> <20130127145056.GP7498@serenity.lan>
 <7vzjzuv224.fsf@alter.siamese.dyndns.org>
 <20130127200401.GT7498@serenity.lan>
 <7vr4l6v11z.fsf@alter.siamese.dyndns.org>
 <20130127202106.GU7498@serenity.lan>
 <7va9ruuzsf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:47:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzZ8a-0000ie-TC
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 21:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163Ab3A0UrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 15:47:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756116Ab3A0UrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 15:47:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34CE2BEF2;
	Sun, 27 Jan 2013 15:47:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x8q+D8fxe68bYYQhOUYCYAWVb3E=; b=OLEfFE
	rIa76j7XpvburoIurB7qmevq4jTP8MNcN6jx0DK36q6FpjdnXyPHWWc1pEJQxSip
	cTF5eI4O3Sz5pfpJh3Fh2yalnbJLrt1viE9E5ZcR7C3mafIw6cSLNKmTWLqt7kdJ
	XP6loelcT0kNMNOu+wlJjJ4x/YwoXJdz2DgFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ctDiKszYjGfMX2G8NRdKKDNwFUn3eDwb
	UFhr9tmCVftX1VX1wBKzrszV66/irdbb7vTPYSamueDanWv6jdxL607/lI1LfTTk
	atgr8cM5USd6gAI1gskER7r6gIqzNuA9I/cwc/ZVAARnHY4cRQTJIoEkZ7Dyi7se
	tvHUDpZdxhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28D92BEF0;
	Sun, 27 Jan 2013 15:47:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AAB3BEE9; Sun, 27 Jan 2013
 15:47:11 -0500 (EST)
In-Reply-To: <7va9ruuzsf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jan 2013 12:38:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B91CC51E-68C2-11E2-BAD9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214731>

Junio C Hamano <gitster@pobox.com> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> So I think the answer is "habit, but I probably shouldn't have put it
>> in in this case".
>
> OK, then I'll queue with a local amend to drop the leading
> underscore.

So this is what I will be queuing (I'd appreciate the second set of
eyes, though), with the leading-underscore removal and log message
typofixes.

I remember that I earlier asked somewhere if we want to say "Python
3.x that is older than 3.y is unsupported"

    http://thread.gmane.org/gmane.comp.version-control.git/213920/focus=213926

but I was told that we will support all versions in 3.x series, IIRC.

Does this patch contradict with that?  If so I think we would need
to revisit the update to CodingGuidelines in that thread.

I am perfectly fine with discarding early 3.x as "0.x releases of
Python3", but I would want to see our document say so if that is
what we do.

-- >8 --
From: John Keeping <john@keeping.me.uk>
Date: Sun, 27 Jan 2013 14:50:56 +0000
Subject: [PATCH] git-remote-testpy: fix path hashing on Python 3

When this change was originally made (0846b0c - git-remote-testpy:
hash bytes explicitly , I didn't realise that the "hex" encoding we
chose is a "bytes to bytes" encoding so it just fails with an error
on Python 3 in the same way as the original code.

It is not possible to provide a single code path that works on
Python 2 and Python 3 since Python 2.x will attempt to decode the
string before encoding it, which fails for strings that are not
valid in the default encoding.  Python 3.1 introduced the
"surrogateescape" error handler which handles this correctly and
permits a bytes -> unicode -> bytes round-trip to be lossless.

At this point Python 3.0 is unsupported so we don't go out of our
way to try to support it.

Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-remote-testpy.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index c7a04ec..6098bdd 100644
--- a/git-remote-testpy.py
+++ b/git-remote-testpy.py
@@ -36,6 +36,22 @@ if sys.hexversion < 0x02000000:
     sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
     sys.exit(1)
 
+
+def encode_filepath(path):
+    """Encodes a Unicode file path to a byte string.
+
+    On Python 2 this is a no-op; on Python 3 we encode the string as
+    suggested by [1] which allows an exact round-trip from the command line
+    to the filesystem.
+
+    [1] http://docs.python.org/3/c-api/unicode.html#file-system-encoding
+
+    """
+    if sys.hexversion < 0x03000000:
+        return path
+    return path.encode('utf-8', 'surrogateescape')
+
+
 def get_repo(alias, url):
     """Returns a git repository object initialized for usage.
     """
@@ -45,7 +61,7 @@ def get_repo(alias, url):
     repo.get_head()
 
     hasher = _digest()
-    hasher.update(repo.path.encode('hex'))
+    hasher.update(encode_filepath(repo.path))
     repo.hash = hasher.hexdigest()
 
     repo.get_base_path = lambda base: os.path.join(
-- 
1.8.1.1.550.g40037fd
