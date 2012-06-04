From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Mon, 04 Jun 2012 12:26:44 -0700
Message-ID: <7vwr3mswsr.fsf@alter.siamese.dyndns.org>
References: <7vvckihyqm.fsf@alter.siamese.dyndns.org>
 <7vk40yhv5q.fsf@alter.siamese.dyndns.org>
 <20120430081939.GA27715@dcvr.yhbt.net>
 <7vipghgq9a.fsf@alter.siamese.dyndns.org>
 <20120430165315.GO4023@login.drsnuggles.stderr.nl>
 <20120430190200.GA27108@dcvr.yhbt.net>
 <20120430192016.GQ4023@login.drsnuggles.stderr.nl>
 <7vy5pcd7xu.fsf@alter.siamese.dyndns.org>
 <20120603104914.GA21276@hashpling.org>
 <7vfwacxe7p.fsf@alter.siamese.dyndns.org>
 <20120604090016.GA4023@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Matthijs Kooijman <matthijs@stdin.nl>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 21:26:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbcvU-00070W-NW
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 21:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab2FDT0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 15:26:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274Ab2FDT0r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 15:26:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11FE88D1E;
	Mon,  4 Jun 2012 15:26:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tU2t99AkpKSlnKR7ksKI494ofzY=; b=GkgmCx
	3UearbRlDrW3HsNDZS3rNVlcKVi+2uQtx1TUE/j0IO6RHgAiU952OPS2uC49cGIk
	WDGEad1zF1OYWkq7R28sACCljVaKLEAaI5t+JYxZfcx+44NGroC0Xbuh7wwJtg+Q
	uEV0ZsN1A5cmaW3iqdLC4+BVUQB2r5/OdfgY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rYmlFBuhdfofI3ZVM4vibrIRFUczgL8Q
	G00c5oumxB7eBj79PlQNDpTI678G9KQeDZIw/aTqo/dv5KXbVspANjZhXL4aRYi6
	uD29udNjXExxNQ17JtsbpYwUhHXX8DlpoR0wIIrX3B43/tAPz0PAUh/MpuPGEnb6
	hasOIJrPHsw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 054618D1D;
	Mon,  4 Jun 2012 15:26:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81DF78D1C; Mon,  4 Jun 2012
 15:26:46 -0400 (EDT)
In-Reply-To: <20120604090016.GA4023@login.drsnuggles.stderr.nl> (Matthijs
 Kooijman's message of "Mon, 4 Jun 2012 11:00:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39701A70-AE7B-11E1-862C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199170>

Matthijs Kooijman <matthijs@stdin.nl> writes:

> It seems this is indeed the case. I can't remember what I based the
> 1.6.12 on, but looking at the svn changelog [1], the first working version
> is 1.6.15:
>
>     Version 1.6.15
>     [...]
>        * improve some swig parameter mapping (r984565, r1035745)
>
> [1]: http://svn.apache.org/repos/asf/subversion/trunk/CHANGES
>
> Gr.

Thanks.  I find that "improve some mapping" is a bit too subtle way
to say "we are fixing a bug that can lead to a segfault" to my
taste, though ;-)

Eric, I can directly queue this as a regression fix in my tree, you
can eyeball and give your blessing (or "No, that is wrong--here is
the right version" is even better), or you can queue it and tell me
to pull from you.  How do we want to proceed?

-- >8 --
Subject: [PATCH] git-svn: platform auth providers are working only on 1.6.15
 or newer

Matthijs Kooijman reports that the cut-off point 082afee (git-svn:
use platform specific auth providers, 2012-04-26) set at 1.6.12 to
use this feature safely was incorrect, and it is 1.6.15 instead:

    http://svn.apache.org/repos/asf/subversion/trunk/CHANGES
    Version 1.6.15
       * improve some swig parameter mapping (r984565, r1035745)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-svn.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 1a17f94..abbd6b8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5481,7 +5481,7 @@ ()
 
 	# earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
 	# this function
-	if (::compare_svn_version('1.6.12') > 0) {
+	if (::compare_svn_version('1.6.15') >= 0) {
 		my $config = SVN::Core::config_get_config($config_dir);
 		my ($p, @a);
 		# config_get_config returns all config files from
-- 
1.7.11.rc1.2.g33fe195
