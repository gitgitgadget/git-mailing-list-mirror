From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 30 Mar 2012 15:15:34 -0700
Message-ID: <7vvcllka61.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <20120330210112.GA20734@sigill.intra.peff.net>
 <7vzkaxkccg.fsf@alter.siamese.dyndns.org>
 <20120330215344.GD20734@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 00:15:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDk6j-0001kZ-CU
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 00:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090Ab2C3WPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 18:15:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965044Ab2C3WPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 18:15:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC0FC54A5;
	Fri, 30 Mar 2012 18:15:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5syEgsz1rImA+bhgNSGY8C+d3MY=; b=cNcpMM
	8CebnyOsCf3b4NEUubOlAGQyITb5vp0LwBTslONYtL/pSLSVta7/3n7u1BbIzXRY
	G1zvZEzl/ip6V+REFV7X+mnECMae1lh26g4oWpI4PhNvhPRotIwVxgKE+EZ49TZl
	jpIGCJk39lhkqUDh0EdZKeqbeMJ8WE2ZL1ODQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oYVlmExFtp7S2/2rv61V7m6ctJRk2lBt
	V3iaUQLli+81dMZ5w3Oxgz/YqsRBVUc56iFxF8FJrZNCS+sdywYsHuTFP1DmHmoe
	9ZKRWdLyBtmmwSt3WcoJdxGuCoRtqynSp42qE/jjO12M863LECWvfz2BtfDBH3QR
	u4X3eJQKZTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2BC354A4;
	Fri, 30 Mar 2012 18:15:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38F6954A3; Fri, 30 Mar 2012
 18:15:36 -0400 (EDT)
In-Reply-To: <20120330215344.GD20734@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 30 Mar 2012 17:53:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFEE6D88-7AB5-11E1-B567-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194416>

In the meantime, we can do this.

 Documentation/RelNotes/1.7.10.txt |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.txt
index d326ff8..6dcaf45 100644
--- a/Documentation/RelNotes/1.7.10.txt
+++ b/Documentation/RelNotes/1.7.10.txt
@@ -32,12 +32,9 @@ Compatibility Notes
  * When you do not tell which branches and tags to push to the "git push"
    command in any way, the command used "matching refs" rule to update
    remote branches and tags with branches and tags with the same name you
-   locally have.  In future versions of Git, this will change to use the
-   "upstream" rule to update the branch at the remote you would "pull"
-   from into your current branch with your local current branch.  The
-   release after 1.7.10 will start issuing a warning about this change,
-   to encourage you to tell the command what to push out, e.g. by setting
-   push.default configuration.
+   locally have.  In future versions of Git, this will change to and push
+   out only your current branch according to either "upstream" or "current"
+   rule (we haven't yet decided which).
 
 
 Updates since v1.7.9
