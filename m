From: "Jakub Narebski" <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: Fixes and improvements related to diffs
Date: Fri, 21 Sep 2007 23:31:14 +0200
Message-ID: <8fe92b430709211431m7a93a11cp915988a57801edd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 23:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYq5s-0004CC-5A
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 23:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763629AbXIUVbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 17:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763594AbXIUVbQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 17:31:16 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:43176 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763560AbXIUVbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 17:31:15 -0400
Received: by rv-out-0910.google.com with SMTP id k20so902086rvb
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Ma7JBYwPZeBYu9s9GFMl4kuPupdIs9+36usC7DPJK+E=;
        b=fqEQiSqHH9ulVmXyX8nltJW4dPK755um7n1nWS1K7sF5Og9z6kQ5xxacpsg20AaKktMXqwqGsSs4MqFIS0th3+pQOyo6GnoPobUsGpgnqgHu2zz49GSoSFi47Tsv56HYlGJrzWAUEnUucMez1w202Bfh1EhzsYFDo6XzNoi6M1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ghqLqlAJs073LMgFmtqyM/v8BMHQFRO6mLaNFlU14cmdw5XBN655UPEuXu12dmmORhTitoLc56XnnGJhr/lPQ/Eu+hvfQiH8FSZfA8WxDYYwGDQAYYSpFUkQ8u1TCOlH2ZoqEZr7M6OMPmPHhOsf2dYHIHuChG11jPYJR8j/mqk=
Received: by 10.114.210.2 with SMTP id i2mr3177521wag.1190410274422;
        Fri, 21 Sep 2007 14:31:14 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Fri, 21 Sep 2007 14:31:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58883>

This series of patches adds fixes, simplifications and improvements
related to diff handling in gitweb ('commit', 'commitdiff' views).

Becaus I didn't have access to Internet, this series is based
on 1e61b7640d09015213dbcae3564fa27ac6a8c151 (v1.5.3.1-1-g1e61b76).
As I am sending it via GMail WWW interface, patches are send as
attachements.

I send this series now, even without good Internet access,
because it contains two bugfixes, and one code fix. I'll try to
resend it rebase on top of current master later...

Shortlog:
=========
Jakub Narebski (5):
      gitweb: Remove parse_from_to_diffinfo code from git_patchset_body
      gitweb: No difftree output for trivial merge
      gitweb: Fix and simplify "split patch" detection
      gitweb: Always set 'from_file' and 'to_file' in parse_difftree_raw_line
      gitweb: Add 'status_str' to parse_difftree_raw_line output

Diffstat:
=========
 gitweb/gitweb.perl |  208 ++++++++++++++++++++--------------------------------
 1 files changed, 80 insertions(+), 128 deletions(-)

-- 
Jakub Narebski
Poland
