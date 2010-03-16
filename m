From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch 06/15] diff-defaults.patch
Date: Tue, 16 Mar 2010 00:22:53 -0700
Message-ID: <7vsk80n31u.fsf@alter.siamese.dyndns.org>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054326.850936000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:23:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrR7K-0003JI-DN
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937508Ab0CPHXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:23:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937499Ab0CPHW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:22:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26D58A2FD7;
	Tue, 16 Mar 2010 03:22:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=bS6Ot3YerdFVtmlEqVv2TtNs3aw=; b=MrjWYSeHOSTdml9IWVWHOg0
	pJ68bVysscHIizXNPGC/kLLJah1dM96cLZFywFAS0d9VT0QTkmqmkSFNIb3lZFwS
	VXXEC8Efd20ZA9OSRobTXS3woNAfPjC8PJC2JQBxmYbzU86qQdQKf71gNjpGPk6o
	tRFcGprbhbQ+IK0e9DkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xoPMfjgt+R8WC2IlM9a3+vDjFqfLA0QQwfhptLXd/gPk0/thL
	Zua6ReltMhgLAgrp0R8JsFrURo9hbJFXFaJrmclAnYMM9PoHJxDdjAn3/2MYf3PA
	clR1yBwpeEhGwaCj5X4T59WliKZFHQ1vlc7BfRFQTt5P1kmIJjUDTMtAEg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 00992A2FD4;
	Tue, 16 Mar 2010 03:22:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62675A2FD2; Tue, 16 Mar
 2010 03:22:54 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BE5D1D66-30CC-11DF-9D6F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142327>

"Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:

> By default the testsuite calls 'diff -u' whenever a file comparison is
> called for.  Unfortunately that throws a "diff: unknown option '-u'"
> error for most non-GNU diffs.
>
> This patch sets GIT_TEST_CMP to 'cmp' on all the architectures where
> that happens.

Wouldn't most of these platforms you listed have a working "diff -c" at
least?  Using it would make debugging the tests easier, as it would be
more readable than output from "cmp".

I also saw your patch to install-webdoc used "$DIFF -u"; as the patch
series seem to assume a unified-capable diff implementation is available
somewhere, perhaps you do not need this patch after all, but instead just
need to default GIT_TEST_CMP to "$DIFF -u" in t/test-lib.sh, no?
