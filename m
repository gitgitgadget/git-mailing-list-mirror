From: Matthias Kestenholz <mk@spinlock.ch>
Subject: git pull error message woes
Date: Thu, 19 Jun 2008 09:32:53 +0200
Message-ID: <1213860773.6444.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 09:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9EeW-0003TW-DO
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 09:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbYFSHc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 03:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbYFSHc5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 03:32:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:54156 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbYFSHc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 03:32:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so328511fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 00:32:55 -0700 (PDT)
Received: by 10.86.28.2 with SMTP id b2mr1771987fgb.78.1213860775093;
        Thu, 19 Jun 2008 00:32:55 -0700 (PDT)
Received: from ?192.168.1.150? ( [213.3.44.95])
        by mx.google.com with ESMTPS id d4sm586032fga.8.2008.06.19.00.32.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 00:32:54 -0700 (PDT)
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85455>

Hi,

I noticed strange behavior while pulling git.git today (this isn't new,
it just occurred to me for the first time today that there is something
wrong going on)

I run the 'pu' branch most of the time, and do not create a local branch
because 'pu' is constantly rebased. I just run git checkout origin/pu
after pulling (I know I should fetch if I don't want to fetch+merge, but
it's hard to retrain the fingers)

Although I am on no branch ($curr_branch is empty), I get the error
message from error_on_no_merge_candidates instead of being notified that
I am on no branch currently. Something around line 150-160 in
git-pull.sh does not seem to work as it should.

The reason might be, that every line in .git/FETCH_HEAD is marked as
not-for-merge?

I don't know if that's the sign of a deeper problem or if it's just
confusing behavior.

I tried fixing it myself, but got lost somewhere in the fetch machinery.

Matthias
