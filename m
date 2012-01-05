From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] More on pulling signed tags
Date: Wed, 04 Jan 2012 16:22:32 -0800
Message-ID: <7vobujngl3.fsf@alter.siamese.dyndns.org>
References: <1325715058-11984-1-git-send-email-gitster@pobox.com>
 <7vsjjvnh4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 01:22:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rib6Q-00046K-Ag
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 01:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453Ab2AEAWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 19:22:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757414Ab2AEAWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 19:22:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC7416CC2;
	Wed,  4 Jan 2012 19:22:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=So7HciNq0w4DSmhNQ/jqk/+Mdlk=; b=KdOmrZ
	AaEbjVALbEOXnFWk49Rwialx09YAj6OxzDCQsR7KsVqknabbI4KgWXp80KGN6heE
	UW1dNcPRkNg6qT/rjTC6tS+kWpCPIff+PiMPmxEP3zSdxy+c3OTcTPqZTUflUWDg
	9EZgqoTwdik77U7czoMR/yI5SO8Tj02A6Xt+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uIU/uuTjvrEw8vxAanXVDy6us/BWH0Kl
	awiW2qZxCX2bG6dM6mwyuCud9cD4PLBCniIM43xhnxBcU7rlVPdUwTjO6rU/5Kpo
	8dHp+y3ABJan/gCwJi/GyAr428adMsZO2uxfKVVnd9CYAXOoJfQHdp8HAccBl9jh
	rjTuZDSTaMU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C32696CC1;
	Wed,  4 Jan 2012 19:22:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07B166CBC; Wed,  4 Jan 2012
 19:22:33 -0500 (EST)
In-Reply-To: <7vsjjvnh4e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Jan 2012 16:10:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CF797C6-3733-11E1-9C24-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187957>

Junio C Hamano <gitster@pobox.com> writes:

> We might want to reword "parent #2", by the way. The code was designed to
> apply even to an Octopus, but I suspect 99.9% of the mergetag will be on
> the second parent of a two-parent commit. You will never see "parent #1"
> (i.e. direct parent you pulled into) unless you hand-craft the merge
> commit object, and you are not likely to create an Octopus that pulls
> multiple signed tags into one commit.

... and this is a fix-up patch on top of the series. With this, the output
becomes like this:

  commit 2240a7bb479c38434bd636da9ce6afbd3f49447a
  merged tag 'tytso-for-linus-20111214'
  gpg: Signature made Wed 14 Dec 2011 11:15:13 AM PST using RSA key ID C11804F0
  gpg: Good signature from "Theodore Ts'o <tytso@mit.edu>"
  gpg:                 aka "Theodore Ts'o <tytso@debian.org>"
  gpg:                 aka "Theodore Ts'o <tytso@google.com>"
  Merge: 30aaca4 5a0dc73
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   Wed Dec 14 18:25:58 2011 -0800

      Merge tag 'tytso-for-linus-20111214' of git://git.kernel.org/pub/scm/l...

      * tag 'tytso-for-linus-20111214' of git://git.kernel.org/pub/scm/linux...
        ext4: handle EOF correctly in ext4_bio_write_page()
       ...


 log-tree.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index b87dd53..37510da 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -456,6 +456,13 @@ static int which_parent(const unsigned char *sha1, const struct commit *commit)
 	return -1;
 }
 
+static int is_common_merge(const struct commit *commit)
+{
+	return (commit->parents
+		&& commit->parents->next
+		&& !commit->parents->next->next);
+}
+
 static void show_one_mergetag(struct rev_info *opt,
 			      struct commit_extra_header *extra,
 			      struct commit *commit)
@@ -474,6 +481,11 @@ static void show_one_mergetag(struct rev_info *opt,
 	strbuf_init(&verify_message, 256);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
 		strbuf_addstr(&verify_message, "malformed mergetag\n");
+	else if (is_common_merge(commit) &&
+		 !hashcmp(tag->tagged->sha1,
+			  commit->parents->next->item->object.sha1))
+		strbuf_addf(&verify_message,
+			    "merged tag '%s'\n", tag->tag);
 	else if ((nth = which_parent(tag->tagged->sha1, commit)) < 0)
 		strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
 				    tag->tag, tag->tagged->sha1);
