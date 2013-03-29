From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1300: document some aesthetic failures of the config
 editor
Date: Fri, 29 Mar 2013 13:35:22 -0700
Message-ID: <7vvc8alzat.fsf@alter.siamese.dyndns.org>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
 <20130329170032.GA3552@sigill.intra.peff.net>
 <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
 <20130329172307.GA11099@sigill.intra.peff.net>
 <20130329175058.GA13506@sigill.intra.peff.net>
 <7vobe2nins.fsf@alter.siamese.dyndns.org>
 <20130329195155.GA19994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Phil Haack <haacked@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 21:36:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULg1m-00018S-DZ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 21:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920Ab3C2Uf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 16:35:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756827Ab3C2UfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 16:35:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A34A9E3DF;
	Fri, 29 Mar 2013 20:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ewiMo4isdBA2T1vLaafYJNlz43U=; b=DpdaL9
	KuVgvmyfqZhxhdS/J/WwUzcFxdZb0dX+rNy01a+/ibJhvRJqu+7zCMWGzEyw/AuQ
	AXOqu/L1/3HCE0zfFL/7MWJ4rnNDr6W+sdijGOFCp/HcoL7hef/7zuEBmzJWWXbZ
	Jmi7psCeEyZY56nJx6FPwuEN8XA27y4VEBEB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yVgXiWQ0CSmwsUHxjN3eP47zM6QrYvoH
	SkgUQAoRywl2TlSL/VaRRDWmr4EIyXxxfvObN2odWXtqBo+buRFeXRxNkAHaDGSj
	Y7f7eQA8VPI41OfmMHzMCnT7geN4E1cDeIoDwFtwfSKUc3evMPUVJ4i62+ooP5HN
	j2um1rTlABU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B5C1E3DE;
	Fri, 29 Mar 2013 20:35:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04256E3DC; Fri, 29 Mar 2013
 20:35:23 +0000 (UTC)
In-Reply-To: <20130329195155.GA19994@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 29 Mar 2013 15:51:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EBBCF3C-98B0-11E2-B716-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219528>

Jeff King <peff@peff.net> writes:

> Here it is with the updated expectation. I don't care _that_ much, so if
> you feel strongly and want to drop the first test, feel free.

As long as we are adding expect_failure without an immediate fix,
let's document the ideal, with this patch on top.

 t/t1300-repo-config.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 213e5a8..133f26d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1089,16 +1089,20 @@ test_expect_success 'barf on incomplete string' '
 
 # good section hygiene
 test_expect_failure 'unsetting the last key in a section removes header' '
 	cat >.git/config <<-\EOF &&
+	# some generic comment on the configuration file itself
+	# a comment specific to this "section" section.
 	[section]
 	# some intervening lines
 	# that should also be dropped
 
 	key = value
 	EOF
 
-	>expect &&
+	cat >expect <<-\EOF &&
+	# some generic comment on the configuration file itself
+	EOF
 
 	git config --unset section.key &&
 	test_cmp expect .git/config
 '
