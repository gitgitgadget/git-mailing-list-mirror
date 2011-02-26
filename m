From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] trace: give repo_setup trace its own key
Date: Sat, 26 Feb 2011 00:34:08 -0800
Message-ID: <7v7hcn8a9r.fsf@alter.siamese.dyndns.org>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224143030.GH15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 26 09:34:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtFbf-0004pO-Jq
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 09:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634Ab1BZIeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 03:34:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab1BZIeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 03:34:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD923270A;
	Sat, 26 Feb 2011 03:35:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FDujEhXPjJY3dl2SWFYRtPSQq40=; b=QZQjlx
	wE0PVV5RB0jkbuBNF90qQsJ3fpjVRg7JwzFDqJZJeicsY/Pa15HBrnBSojQWo9ih
	sPh1Jw52zXeQtrc9N5X1p00sjg9Abx3WQDvIyOLavtm1/sV5Zmj4KVYPUA/RUJry
	98xgoYaNnlmREzda81Pfo38CdT2zzXeXaRYOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s4GhIQIEANC7wc9a18zVGuACXlMbZ6/0
	iI6WwzJdZ5Oa5/i/IQ2+um62v4FFaME25nQuSVnKMGT/cZdBPZizz0RbAVu8x8Ot
	9bfsDLUhOhUpl9ig32zUOAP5y3Tl6MK/rUwMvKxx9H+henJY0T35h9vnT60SuHiM
	wy7mSKFQx40=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6DE892709;
	Sat, 26 Feb 2011 03:35:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 310972708; Sat, 26 Feb 2011
 03:35:25 -0500 (EST)
In-Reply-To: <20110224143030.GH15477@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 24 Feb 2011 09\:30\:30 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F28406E-4183-11E0-8C39-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167964>

Jeff King <peff@peff.net> writes:

> You no longer get this output with GIT_TRACE=1; instead, you
> can do GIT_TRACE_SETUP=1.
>
> Signed-off-by: Jeff King <peff@peff.net>

Hence you would need this on top?

 t/t1510-repo-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 15101d5..ec50a9a 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -57,7 +57,7 @@ test_repo () {
 			export GIT_WORK_TREE
 		fi &&
 		rm -f trace &&
-		GIT_TRACE="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
+		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
 		grep '^setup: ' trace >result &&
 		test_cmp expected result
 	)
