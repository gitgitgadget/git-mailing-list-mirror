From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 0/3] Improve POSIX compatibility and general portablity
Date: Sun, 24 Mar 2013 19:37:40 +0000
Message-ID: <1364153863-27437-1-git-send-email-pcampbell@kemitix.net>
Cc: greened@obbligato.org, Paul Campbell <pcampbell@kemitix.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 20:46:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJqrk-00078V-NZ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 20:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab3CXTpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 15:45:31 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:63392 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab3CXTpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 15:45:17 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so5955095wib.4
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 12:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=WpyUEHVei00kNG4eMFG3EEDULPIAFgbXhe5FFMECvTI=;
        b=Whh5GeOZUnZGQ+t2WQHfzWPKKtjtqajyKWzyn/7+I4W5rIeegMtnkeCVt31KEIOyb8
         kJkgw8giieyA02SDNfe8pcvRL6zrx6I3RuLyVLPbtQ7WJue+LJCvOQMioxg0iJyGtpkP
         6iLBTRrwyvayFhoGzsEvd8FgU8Mwe2tCvCoE+5QBf9onUacVE87xHz7VpQmUzEpS2W/r
         8sa1CxL6x9KnKtXBDntG0KU+LN3G8rtGXzDWlS2Z8HAU5BTVCxzP4kwVTpIjjHYn3h6i
         Uf+R1i/tkn789YJS3uBU1nh9nif6ISTvMPpGs/GRKjFHUqYiZ6oqYSrAqnbLmZuSfs9M
         G04w==
X-Received: by 10.194.173.167 with SMTP id bl7mr13812974wjc.50.1364153880915;
        Sun, 24 Mar 2013 12:38:00 -0700 (PDT)
Received: from coyote.home (host-2-102-87-178.as13285.net. [2.102.87.178])
        by mx.google.com with ESMTPS id ek4sm23825220wib.11.2013.03.24.12.37.59
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 12:38:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
X-Gm-Message-State: ALoCoQkw5NYBpgl5GHxjYF4nD2cltWX9uYOnVkyMABHUtSqJ8ApGjEjy5ucenPTcxhEVs/+Ji8+W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218971>

git-subtree is considered to be a Bash only script and not POSIX
compatibile.

I removed the /bin/bash and tested with dash. All the tests 
passed.

I also followed some of the advice found in 
https://wiki.ubuntu.com/DashAsBinSh for converting a bash script to be 
more portable.

Paul Campbell (3):
  contrib/subtree: stop explicitly using a bash shell
  contrib/subtree: remove use of -a/-o in [ commands
  contrib/subtree: replace echo options with printf

 contrib/subtree/git-subtree.sh | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

-- 
1.8.2
