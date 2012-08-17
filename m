From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 23:19:59 -0700
Message-ID: <7vfw7mvy40.fsf_-_@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
 <2BB1E674DD214C66B06660612F34109D@PhilipOakley>
 <7vk3wy1t7l.fsf@alter.siamese.dyndns.org>
 <B7310EA0CC00423EB5B26E3FAAB54541@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Vajna" <vmiklos@suse.cz>, "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 08:20:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Fum-0003IQ-Nf
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 08:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab2HQGUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 02:20:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab2HQGUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 02:20:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFC4D9E91;
	Fri, 17 Aug 2012 02:20:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=49/tTr1E3DkU+WjhORJYo9h80Ew=; b=dtnCff
	Xo6MAeEIGdH8kT7FuVWH3E4Rw0lT3JP4Mwx5GvhFZvUq60EhRf9s4JXqv4iQUNec
	8OGqLa7fOaEWLzLo6w/ki2CElQ8MwuQhLGhiKFhXbhgTPfxGk5GEjSGsfkLbmRf9
	wVZY/w0rro4EcR9sZQqSYOClTnmpkOWPPT5Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rTpK/ImWwltK0PcxXtAXHNVxdHwnPcPc
	5SK50b7DHRLUhmUMX1NKb3cCg4y9qTpWZG9/HIHEVNTjSP1V9lhCmhj4tm99xEyA
	mZpZO5nEMr+qCj4xLw9pOYtFovD5BCMrS6+K+8Cb7SiPzmj1/94SzjdiaLA7e6de
	5TBJxH0Ly1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C7339E90;
	Fri, 17 Aug 2012 02:20:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FCF39E8F; Fri, 17 Aug 2012
 02:20:00 -0400 (EDT)
In-Reply-To: <B7310EA0CC00423EB5B26E3FAAB54541@PhilipOakley> (Philip Oakley's
 message of "Thu, 16 Aug 2012 23:36:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9360A224-E833-11E1-B79D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Thursday, August 16, 2012 9:23 PM
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> I wasn't aware of the  "abbreviated options" capability. Is meant to
>>> be in the man pages as I couldn't find it, or is it described
>>> differently?
>>
>> $ git help gitcli
>>
>> is the closest that comes to mind.
>>
>> If it is not reachable from "git help git", we may want to sprinkle
>> some more linkgit:gitfoo[$n] around the documentation sources.  I
>> didn't check.
>>
>
> I eventually found a reference in the parse-options API to the fact that
> 'Long options may be abbreviated, as long as the abbreviation is
> unambiguous.'
>
> It may be worth bringing some of those parse-options API basics bullets'
> forward into the gitcli page, if appropriate.

OK, how about doing this?  Sort of killing two birds with one stone.

-- >8 --
Subject: [PATCH] gitcli: describe abbreviation of long options

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcli.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index ea17f7a..3e72a5d 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -62,6 +62,14 @@ scripting git:
    `git log -1 HEAD` but write `git log -1 HEAD --`; the former will not work
    if you happen to have a file called `HEAD` in the work tree.
 
+ * many commands allow a long option "--option" to be abbreviated
+   only to their unique prefix (e.g. if there is no other option
+   whose name begins with "opt", you may be able to spell "--opt" to
+   invoke the "--option" flag), but you should fully spell them out
+   when writing your scripts; later versions of Git may introduce a
+   new option whose name shares the same prefix, e.g. "--optimize",
+   to make a short prefix that used to be unique no longer unique.
+
 
 ENHANCED OPTION PARSER
 ----------------------
-- 
1.7.12.rc3.2.gbd120e3
