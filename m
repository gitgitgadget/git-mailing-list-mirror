From: Johan Herland <johan@herland.net>
Subject: [BUG?] 'git verify-pack -v' on multiple packs fails for all but the first pack
Date: Fri, 22 Aug 2008 14:39:31 +0200
Message-ID: <200808221439.31219.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 14:40:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWVwc-0006tf-Ny
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 14:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbYHVMjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 08:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbYHVMjk
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 08:39:40 -0400
Received: from sam.opera.com ([213.236.208.81]:35014 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900AbYHVMjj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 08:39:39 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m7MCdVIJ004876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 12:39:37 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93290>

(I don't have time to look into this right now, but will do so later if 
nobody comes up with a solution in the meantime...)

When running 'git verify-pack -v' on multiple packs (.idx files), it 
fails for all packs, except the first, with exit code 128, and the 
following single line:

	fatal: internal error: pack revindex fubar

This does not happen when given only a single pack, or when given 
multiple packs, but without '-v' option.

To reproduce, simply do:

	git verify-pack -v .git/objects/pack/*.idx

in any repo with more than one pack file.

This happens with a fairly current 'next' (1.6.0.96.g2fad1). AFAICS, it 
also happens in v1.6.0.


...Johan


PS: Does someone knows a better way to generate a sorted list of all the 
blob objects (by SHA1 sum) in a packed repo?

-- 
Johan Herland, <johan@herland.net>
www.herland.net
