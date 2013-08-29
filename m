From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/9] Add --stage and --work options
Date: Thu, 29 Aug 2013 13:14:31 -0500
Message-ID: <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:19:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6od-0004Gp-0P
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431Ab3H2ST0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:19:26 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:48914 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab3H2STZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:19:25 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so1061976oah.23
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cSJ0GmYeIwGP8EKrazLdHD0cp+WAabBfkh6fg/CInxM=;
        b=uO+oPLCwRYTNIm5HnDY8GoywnsvbFnZxRzZO4IHSRfztQFk1Jm+clc+KEiW744ujuD
         hAKfaCFZZ03RfgCe31dp9guL+h1CjvAztBf9rbSNQDeaxvwc1dYaYDgOaCpiag8aIQe3
         e14+qLiLzDqd9v+SDc/V0iLo4GAMwI72HPAEHcPeYBPHa8j+NNjg2yA01mzKavL9XFlC
         x0Xa5rThvdgcp3J7cYHMSEEzuRd83vZ4jn/7cUQOJc8Jc4/cz7g1M3sOiFzwGK2r33CG
         T0ir3t5Kmit5+tmxs+Hp2pm7sV+h37yuptc2kyDbXH+eillrs4mXb3r7SSOCInzlU1BU
         mIDw==
X-Received: by 10.182.243.138 with SMTP id wy10mr3473489obc.83.1377800365440;
        Thu, 29 Aug 2013 11:19:25 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id pt4sm32754458obb.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:19:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <20130829180129.GA4880@nysa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233309>

Hi,

Some commands (git diff) already have the --staged alias, this patch series
document them, and do the same for the rest.

Also, add a --work (and --no-work) option, so that in addition to --stage, we
can replace --cached in 'git apply'.

The old options remain unchanged.

Felipe Contreras (9):
  diff: document --staged
  grep: add --staged option
  rm: add --staged option
  stash: add --stage option to save
  stash: add --stage to pop and apply
  submodule: add --staged options
  apply: add --stage option
  apply: add --work, --no-work options
  completion: update --staged options

 Documentation/git-apply.txt            | 11 +++++++++--
 Documentation/git-diff.txt             |  4 ++--
 Documentation/git-grep.txt             |  5 ++++-
 Documentation/git-rm.txt               |  5 ++++-
 Documentation/git-stash.txt            | 14 +++++++-------
 Documentation/git-submodule.txt        |  8 ++++++--
 builtin/apply.c                        |  7 +++++++
 builtin/grep.c                         |  2 ++
 builtin/rm.c                           |  1 +
 contrib/completion/git-completion.bash | 10 +++++-----
 git-stash.sh                           | 12 +++++++++---
 git-submodule.sh                       | 10 +++++-----
 12 files changed, 61 insertions(+), 28 deletions(-)

-- 
1.8.4-fc
