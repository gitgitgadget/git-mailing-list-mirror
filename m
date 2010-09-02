From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] gitweb: skip logo in atom feed when there is none
Date: Thu, 2 Sep 2010 18:55:47 -0500
Message-ID: <20100902235546.GC6466@burratino>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino>
 <20100902223624.GA9613@dcvr.yhbt.net>
 <20100902235237.GA6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 01:58:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrJfY-000052-Qp
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 01:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab0IBX6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 19:58:07 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:32864 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab0IBX6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 19:58:06 -0400
Received: by qwh6 with SMTP id 6so1108899qwh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C42JUD4fVkRGmmFIS9U5sb4Knc1eiVn5GrEoJNhawg0=;
        b=lUXQ4Y232iI4/q3ld9+tzxrz9PrIMK8Onj2fvmb7qoo0TE2kmR2JQcqrVkooUQkOnm
         7ycih+BQhq557SvRhj5Rtt92BUVKWIbyiwW6CwO4MuH6CLNqXJcXr7yA0rVdKlKb8cfi
         8VmfRfQy08CTJnQOrratUp1x/DfQ7vLclbepY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qmz/rvcFwhNWK/yhGKX5UE+1J7eFmPwz3i+X8NwAsWrPaoDwLQTeEKKtUrrTpr8D9h
         40NKKCDccMTQpZvTQjDeyDnCPAl7uK5Z2ALnFOdZFjoYdZwjCAdkr5qE+g5BPxR7l5GH
         1Q0dmMGB8M2tDkc76BmJ87e1901t9EfqrmxmY=
Received: by 10.229.222.8 with SMTP id ie8mr1618556qcb.106.1283471854784;
        Thu, 02 Sep 2010 16:57:34 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t18sm1108404qco.44.2010.09.02.16.57.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 16:57:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100902235237.GA6466@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155226>

With v1.5.0-rc0~169 (gitweb: Fix Atom feed <logo>: it is $logo,
not $logo_url, 2006-12-04), the logo URI to be written to Atom
feeds was corrected but the case of no logo forgotten.

Cc: Jakub Narebski <jnareb@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Theoretical, untested.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a97ce03..cc20e74 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6630,7 +6630,7 @@ XML
 		if (defined $favicon) {
 			print "<icon>" . esc_url($favicon) . "</icon>\n";
 		}
-		if (defined $logo_url) {
+		if (defined $logo) {
 			# not twice as wide as tall: 72 x 27 pixels
 			print "<logo>" . esc_url($logo) . "</logo>\n";
 		}
-- 
1.7.2.2
