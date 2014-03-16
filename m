From: "Philip Oakley" <philipoakley@iee.org>
Subject: Should 'git reset --hard' keep a stashed backup?
Date: Sun, 16 Mar 2014 22:17:03 -0000
Organization: OPDS
Message-ID: <EF7B8A31C59946F8821697F3BA129043@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 23:17:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPJN0-0001U3-Rl
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 23:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbaCPWQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 18:16:53 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:29025 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752544AbaCPWQw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2014 18:16:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApVMAHwhJlMCYJvU/2dsb2JhbABYgnEKCwE6EAMbiG2xfYc9AQIBDIEMF3RpAQGBHwEBFAETAQEuHgEBLAIIAgEkOQEEGgYHHRsCAQIDAYU4BwGCByUJoQ+HFY1fnDkEjX2BIIJ2gRQEiRqGIJs7gy09
X-IPAS-Result: ApVMAHwhJlMCYJvU/2dsb2JhbABYgnEKCwE6EAMbiG2xfYc9AQIBDIEMF3RpAQGBHwEBFAETAQEuHgEBLAIIAgEkOQEEGgYHHRsCAQIDAYU4BwGCByUJoQ+HFY1fnDkEjX2BIIJ2gRQEiRqGIJs7gy09
X-IronPort-AV: E=Sophos;i="4.97,666,1389744000"; 
   d="scan'208";a="452932175"
Received: from host-2-96-155-212.as13285.net (HELO PhilipOakley) ([2.96.155.212])
  by out1.ip03ir2.opaltelecom.net with SMTP; 16 Mar 2014 22:16:50 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244211>

A bike-shedding thought:
Many inexperienced users do a 'git reset --hard' only to discover they 
have deleted something important and want it back. (e.g. git-users 
yesterday [1])

One possible option is that Git could "stash" the current work-tree 
contents (git stash create) into a commit and store its commit_id in a 
suitable file/variable such as RESET_HARD_HEAD (or GIT_RESET_HARD_HEAD), 
similar to FETCH_HEAD & MERGE_HEAD, so that it would be relatively easy 
to recover the prior state.

By only storing the id in the file/env it would be overwritten on each 
usage, and the loose commits would be garbage collected eventually.

A suitable config variable would allow it to be enabled/disabled as 
appropriate to the user. (Perhaps enabled by default eventually?)

Given the prevalence of 'git reset --hard' within internet forum advice, 
would something like this be useful?  It could even be wrapped into a 
GSoC project.

--

Philip


[1] https://groups.google.com/forum/#!topic/git-users/CwQyfwnzCVM 
