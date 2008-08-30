From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] change Perl syntax to support Perl 5.6
Date: Sat, 30 Aug 2008 19:39:47 +0200
Message-ID: <20080830173947.GF7185@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 19:41:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZURb-0002fc-Or
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 19:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYH3Rjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 13:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbYH3Rjw
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 13:39:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:63122 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbYH3Rjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 13:39:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so828507fgg.17
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :from:reply-to;
        bh=OZw9TacszKeUPLP0JlfSJM6Q/l3eZW3H43mnss3J5AA=;
        b=YyEQUSoPyD+CTZVYMze+1ajRRDaSuKmvmWgZJ/ifUckIfZxZKAXQu8J4iJzJagLDdp
         mfvq97UhWPKUP7BRcHOJixvQcS7scwGhKRDxB5e/izdVd4rwnIXrbBY9skXCfitD/B9J
         ikafVma2M7IMfTZsCk7bNJEWY7fHObPvcT5J8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:from:reply-to;
        b=u4OEj7eeg8t0QK3drT62QL4iRomgP0y/UYZgHBE7R3ln8yH1UgDmU31cBuGQuc7jWa
         mYtj1ZYVr6W2TtoIyPJCD0jW9d9eAoFYxYS0pXG/p8jbr8G9AMAX1yKN+ORBK7FegMDB
         VRrXNeMObdOj2oLO/CrBOtOJweeVOnc4d62zw=
Received: by 10.86.73.3 with SMTP id v3mr3130045fga.28.1220117989526;
        Sat, 30 Aug 2008 10:39:49 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.78.90])
        by mx.google.com with ESMTPS id e20sm3653939fga.1.2008.08.30.10.39.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 10:39:48 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 627CF16057; Sat, 30 Aug 2008 19:39:47 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94394>

git-add--interactive has one Perl command that was not yet present in
Perl 5.6.  Changing this single command makes it compatible again.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
This is an alternative to my previous patch that just declared Perl 5.8 to
be the required version.

 git-add--interactive.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index da768ee..777ec5f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -61,7 +61,7 @@ sub run_cmd_pipe {
 		return qx{@args};
 	} else {
 		my $fh = undef;
-		open($fh, '-|', @_) or die;
+		open($fh, '-|', join(' ', @_)) or die;
 		return <$fh>;
 	}
 }
-- 
1.5.4.5
