From: Yaroslav Halchenko <debian@onerussian.com>
Subject: wishlist bugreport: make limit configurable for do_fmt_merge_msg
 (merge.log)
Date: Thu, 19 Aug 2010 22:01:27 -0400
Message-ID: <20100820020127.GG22469@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 04:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmHEW-0006cy-6O
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 04:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab0HTCVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 22:21:20 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:56335 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0HTCVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 22:21:13 -0400
X-Greylist: delayed 1184 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Aug 2010 22:21:13 EDT
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1OmGv9-0006Ib-S6
	for git@vger.kernel.org; Thu, 19 Aug 2010 22:01:27 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1OmGv9-0006IY-LO
	for git@vger.kernel.org; Thu, 19 Aug 2010 22:01:27 -0400
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153971>

Hi Git Developers,

Shame on me but couldn't figure out if there is any official bug tracker
for git -- previously I just complained here, so keeping the tradition:

merge.log (or merge.summary) enables a really nice feature of including
a list of commits involved in the merge.  Unfortunately it is limited to
20 entries and only includes total number of included commits if that is
larger than 20.

Looking at the source code (if I got it right)

static int do_fmt_merge_msg(int merge_title, int merge_summary,
	struct strbuf *in, struct strbuf *out) {
	int limit = 20, i = 0, pos = 0;
.... no line touches limit ....
			shortlog(origins.items[i].string, origins.items[i].util,
					head, &rev, limit, out);

so, limit of 20 is hardcoded and cannot be altered via configuration.  I
would love to have it configurable, so, if desired, be set to infinity
(configuration wide or as a cmd line parameter for a specific merge).

Thanks in advance
-- 
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
