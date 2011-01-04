From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] gitweb: skip logo in atom feed when there is none
Date: Mon, 3 Jan 2011 23:02:47 -0600
Message-ID: <20110104050247.GB8280@burratino>
References: <20110104050206.GA8280@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 06:03:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZz32-0008Ql-Cr
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 06:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026Ab1ADFC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 00:02:59 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47198 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab1ADFC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 00:02:59 -0500
Received: by gxk9 with SMTP id 9so2829724gxk.19
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 21:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9I9zlrRZMvhZMRc2wNtKijBTNDsY1m9LCyBezCCxPYM=;
        b=DLKrgm8hbnxKQn5953xZyv5UazcRjsZn110QfCSO0mGiL3fdmV3XD+sMvf7LZfRBoh
         W+y5dpIrgSzbZt0BPV8DEQ4nbUrIpbSwgoRuQw+i6ROBxWWs/+HaksLeWb1FMywxWFUq
         cU9Sz6moSdoQsxNeoTO0R+1yA9hMh4tYhSHB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LMyFGd90JvkPuSLdnqW1BaaLuGGD4cc8X1qAfpPgpC3VfascX2Be9g9dDZqVa0szHh
         IIax/Rr9tR6Mq0bjviDaNdu/xoTmAUstg9t+oLoYxXZm4T6kMQ8oPnDlEigQ4XLm9d+X
         crSasMHvddR1ORmbpjZs9IMduPup0Dt48iqYY=
Received: by 10.100.112.9 with SMTP id k9mr12918572anc.50.1294117378540;
        Mon, 03 Jan 2011 21:02:58 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id c34sm29049353anc.10.2011.01.03.21.02.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 21:02:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110104050206.GA8280@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164476>

Date: Fri, 3 Sep 2010 19:44:39 -0500

With v1.5.0-rc0~169 (gitweb: Fix Atom feed <logo>: it is $logo,
not $logo_url, 2006-12-04), the logo URI to be written to Atom
feeds was corrected but the case of no logo forgotten.

Acked-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4779618..c65af1a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7169,7 +7169,7 @@ XML
 		if (defined $favicon) {
 			print "<icon>" . esc_url($favicon) . "</icon>\n";
 		}
-		if (defined $logo_url) {
+		if (defined $logo) {
 			# not twice as wide as tall: 72 x 27 pixels
 			print "<logo>" . esc_url($logo) . "</logo>\n";
 		}
-- 
1.7.4.rc0
