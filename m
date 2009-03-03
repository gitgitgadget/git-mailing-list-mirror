From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: add --blame so grep can show blame result at the 
 same time
Date: Tue, 03 Mar 2009 07:33:18 -0800
Message-ID: <7v7i36ei4h.fsf@gitster.siamese.dyndns.org>
References: <1b29507a0903030425j7723e7f4wb46f5adf5a3c7c91@mail.gmail.com>
 <1b29507a0903030427y15ad89d7y9f55a945612f0e20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: pi.songs@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 03 16:34:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWe0-0008MZ-FD
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbZCCPd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbZCCPd2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:33:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbZCCPd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 10:33:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 144512F7C;
	Tue,  3 Mar 2009 10:33:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 72FF62F7B; Tue, 
 3 Mar 2009 10:33:20 -0500 (EST)
In-Reply-To: <1b29507a0903030427y15ad89d7y9f55a945612f0e20@mail.gmail.com>
 (pi song's message of "Tue, 3 Mar 2009 23:27:41 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A22432A8-0808-11DE-A7E4-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112087>

pi song <pi.songs@gmail.com> writes:

> My god, this is too big. I cannot attach or paste in email. What should I
> do?

For a starter, try removing hunks that record only unwarranted changes,
such as the following.  They are all style regressions.

@@ -517,6 +563,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 				show_name(opt, name);
 				return 1;
 			}
+
+                        
 			/* Hit at this line.  If we haven't shown the
 			 * pre-context lines, we would need to show them.
 			 * When asked to do "count", this still show
@@ -524,7 +572,9 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 * deserves to get that ;-).
 			 */
 			if (opt->pre_context) {
+                            
 				unsigned from;
+
 				if (opt->pre_context < lno)
 					from = lno - opt->pre_context;
 				else
@@ -590,8 +664,10 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	 * make it another option?  For now suppress them.
 	 */
 	if (opt->count && count)
+        {
 		printf("%s%c%u\n", name,
 		       opt->null_following_name ? '\0' : ':', count);
+        }
 	return !!last_hit;
 }
 
