From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Lines missing from git diff-tree -p -c output?
Date: Wed, 15 May 2013 19:33:12 +0200
Message-ID: <20130515173312.GR25742@login.drsnuggles.stderr.nl>
References: <20130515143508.GO25742@login.drsnuggles.stderr.nl>
 <7vhai4cgco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 19:33:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcfZq-0002ad-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759766Ab3EORdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 13:33:18 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:45289 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759724Ab3EORdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:33:17 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UcfZg-0003Ph-OA; Wed, 15 May 2013 19:33:13 +0200
Received: (nullmailer pid 13121 invoked by uid 1000);
	Wed, 15 May 2013 17:33:12 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhai4cgco.fsf@alter.siamese.dyndns.org>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224429>

Hi Junio,

> I think the coalescing of two adjacent hunks into one is painting
> leading lines "interesting to show context but not worth showing
> deletion before it" incorrectly.
Yup, that seems to be the case.

> Does this patch fix the issue?

Yes, it fixes the issue. However, I think that this patch actually hides
the real problem (in a way that will always work with the current code,
though).

I had come up with a different fix myself (similar to the one I sent to
the list as a followup, but that one still had a bug), which I think
might be better. In any case, it includes a testcase for this bug which
seems good to include.

I'll send my patch as a followup in a minute, feel free to use it
entirely or only partially.

Gr.

Matthijs
