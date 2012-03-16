From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 07:39:18 -0700
Message-ID: <7vlin0ip9l.fsf@alter.siamese.dyndns.org>
References: <4F63205A.6000202@seap.minhap.es>
 <vpqlin0n8w5.fsf@bauges.imag.fr> <7vty1oivub.fsf@alter.siamese.dyndns.org>
 <4F63571D.4070405@seap.minhap.es> <vpqaa3geiso.fsf@bauges.imag.fr>
 <7vpqccipuv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 15:39:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8YJS-000237-PT
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 15:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761215Ab2CPOjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 10:39:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab2CPOjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 10:39:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3324459F;
	Fri, 16 Mar 2012 10:39:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xWR+mPN2NZHvvO6NJOA7x+ZTwyM=; b=v1LY3V
	hODlJPaDkc3RIv0TBbMXF9suYCwkWuPoaCPDn37y0Jrn8JtajKbQDCz6S/8diOen
	4be4pMlzx4tiPw2SKpSe0wl3U+qpUThbCLfHO3EQu1bnq4Ekad4jbxLOlI78MP9J
	bc7aNMA0aBODobumBeZuLNHxf30V4Ua/BwxZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G/ZW///Xe5uY9QxIbsR9I7rBFxBK6GVD
	Td26bPgUYBtQiJd1pR5OzTmdGIWoJYwTCU3yq68ztbLklOGXcAkDCHUvsd13BhLl
	DaYfbF8SH5DCn1s0Hjuseq6ChHtb5TXD4kqKNP5TVTlLk5ibuGVZHxocYFpXHnlo
	MZJaf6L0Vg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAB38459E;
	Fri, 16 Mar 2012 10:39:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D5C1459D; Fri, 16 Mar 2012
 10:39:19 -0400 (EDT)
In-Reply-To: <7vpqccipuv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Mar 2012 07:26:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0500738-6F75-11E1-AB31-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193269>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> But if the user sees the help message of "rebase -i", then I don't think
>> we will stop him from breaking anything by not mentionning that
>> reordering commits can work. We already give other commands that rewrite
>> history with more or less danger, so the additional messages isn't
>> really harmful.
>
> I was not questioning that "You can also reorder" is dangerous in any way.
>
> What is dangerous is to give an illusion that it is safe to use "rebase
> -i" without reading a decent documentation that does not even say that
> reordering is one of the primary purpose of the command, and the mindset
> that it is OK to give such an illusion with these reminder lines.

Another reason we may not want to say "you can re-order" is that we will
probably need to say that you cannot arbitrarily re-order (can s/f come at
the beginning?) unless you want to actively harm the user. Once we go down
that path, we would end up repeating the manual.

Having said that, I do not personally care about this too deeply.  Let's
queue a reworded Nelson's patch so it is not lost while waiting for others
to chime in.

How about this?  I avoided phrases "applying commit" (incorrect: you apply
patches, and you replay or cherry-pick commits) and "history" (to people
who know, it is redundant; to people who don't, it is vague mystery), but
added one more useful reminder (top to bottom).

 git-rebase--interactive.sh |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..fd04c8f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -846,6 +846,8 @@ cat >> "$todo" << EOF
 #  f, fixup = like "squash", but discard this commit's log message
 #  x, exec = run command (the rest of the line) using shell
 #
+# These lines can be re-ordered; they are executed from top to bottom.
+# 
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
 #
