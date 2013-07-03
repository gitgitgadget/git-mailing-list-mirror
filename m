From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: unexpected file deletion after using git rebase --abort
Date: Wed, 3 Jul 2013 15:56:43 -0700
Message-ID: <20130703225642.GU408@google.com>
References: <20130703224402.GF9016@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Paul A. Kennedy" <pakenned@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 00:56:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuVyp-0001EH-RH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 00:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935Ab3GCW4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 18:56:51 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:51805 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab3GCW4v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 18:56:51 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so695041pab.24
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aurYYpt/UE1KvFJLG/AcvRs1/hl7Lj4E5Ai/PB5a40o=;
        b=NlHn2zsNhFvNYqc2vJj1ztJCFtIdnUsplbimwneWiswt+tPN39PuA1ILKTmIo4fEyd
         CbGlh3dAreiPOuyYTAd49zmJeBwxmr7Lu2imHPgtTNHaX7TwSop8zmZnFB7bOMHQN3Ck
         5YGWnv5LLeLmGbomJG/i/dwbUw8DxmGYFgBQQXzgxEj5hShIsIIjoTNj4ICvrIC4ZMc3
         1OLyFQgk3y+CE4FQcULgEnfbhcLzZCWQhQghV9HvWFAwyigw97YC2wsDZV+YHr8ohuz1
         etd+1XYnc1aepgICDitHnLVJZXWED5wvnJj3zDXDlJU+Yecwjkwgema7BiWoyIi2Cv+e
         SiFA==
X-Received: by 10.68.50.69 with SMTP id a5mr2849269pbo.122.1372892210562;
        Wed, 03 Jul 2013 15:56:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dj5sm165735pbc.25.2013.07.03.15.56.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 15:56:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130703224402.GF9016@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229544>

Paul A. Kennedy wrote:

> If we don't expect this, should we update the documentation for the
> --abort heading in the git rebase man page to indicate that newly
> staged content will be lost after a git rebase --abort?

How about something along these lines?

diff --git i/Documentation/git-rebase.txt w/Documentation/git-rebase.txt
index 6b2e1c8..dcae40d 100644
--- i/Documentation/git-rebase.txt
+++ w/Documentation/git-rebase.txt
@@ -240,6 +240,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	started, then HEAD will be reset to <branch>. Otherwise HEAD
 	will be reset to where it was when the rebase operation was
 	started.
++
+This discards any changes to files tracked in the working tree or <branch>.
+You may want to stash your changes first (see linkgit:git-stash[1]).
 
 --keep-empty::
 	Keep the commits that do not change anything from its
