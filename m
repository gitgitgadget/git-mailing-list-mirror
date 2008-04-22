From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.5.1
Date: Wed, 23 Apr 2008 00:22:32 +0400
Message-ID: <20080422202232.GC26950@dpotapov.dyndns.org>
References: <7vej8yako4.fsf@gitster.siamese.dyndns.org> <20080421235610.GB2631@dpotapov.dyndns.org> <480D2FEE.3010904@nrlssc.navy.mil> <20080422005556.GC2631@dpotapov.dyndns.org> <480E2268.6050907@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Apr 22 22:25:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoP24-0004el-JG
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 22:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759266AbYDVUXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 16:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759308AbYDVUXQ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 16:23:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:14046 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759110AbYDVUXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 16:23:15 -0400
Received: by nf-out-0910.google.com with SMTP id g13so880515nfb.21
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=tgQdq2SshRMMQj/MwwuTypef3ZtVv73JW2SqD12IG8k=;
        b=ObZaG7DJtR7IMflasLtHeOr2Jz3O0pwbN9nrojcGYWtTOi/vx5KvfA8g85JKaEUyDkY81c+rriPWMAcLCND9Ebo1b2E6rnUAvw/WRQbVur/UquwVqfyE67zS5+qNcx5pnF0+iOM3EqnBwfwB3ekYIjbKrXZCK0lniJlU87HsPik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=t04Lv8Qb/zE9M4vTuKet+2UH3xS2EW8kgYUn4OMYactrhOV40pjf0TL0cIMiraw3GRgo6UnAl2Y3dMdSyEo0LAsozQeibdavtSmfvEv+POehfPJJ6fMmiEG0O7fYyWCBTh+sYh6KePB8MPmnkSge2ENB8VoazmknyYR6G1cW0DM=
Received: by 10.78.106.3 with SMTP id e3mr32306huc.97.1208895756420;
        Tue, 22 Apr 2008 13:22:36 -0700 (PDT)
Received: from localhost ( [85.140.171.25])
        by mx.google.com with ESMTPS id 5sm8605166nfv.32.2008.04.22.13.22.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Apr 2008 13:22:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <480E2268.6050907@nrlssc.navy.mil>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80164>

On Tue, Apr 22, 2008 at 12:37:44PM -0500, Brandon Casey wrote:
> Dmitry Potapov wrote:
> > 
> >  ... repository using this option and then delete branches (or use any
> >  other git command that makes any existing commit unreferenced) ...
> 
> That's fine, but one of us needs to resubmit. Care to do the honors? :)

Here it goes:

-- >8 --
From 21a905febd728f8839a1c96d0dfa83d8f252b132 Mon Sep 17 00:00:00 2001
From: Brandon Casey <casey@nrlssc.navy.mil>
Date: Thu, 3 Apr 2008 13:26:13 -0500
Subject: [PATCH] git-clone.txt: Adjust note to --shared for new pruning behavior of git-gc

Since git-gc now always calls prune, even with --auto, unreferenced objects
may be removed by more operations than just git-gc. This is important for
clones created using --shared or --reference.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 Documentation/git-clone.txt |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9758243..9b56442 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -65,10 +65,13 @@ OPTIONS
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand what it does. If you clone your
-repository using this option, then delete branches in the
-source repository and then run linkgit:git-gc[1] using the
-'--prune' option in the source repository, it may remove
-objects which are referenced by the cloned repository.
+repository using this option and then delete branches (or use any
+other git command that makes any existing commit unreferenced) in the
+source repository, some objects may become unreferenced (or dangling).
+These objects may be removed by normal git operations (such as git-commit[1])
+which automatically call git-gc[1]. If these objects are removed and
+were referenced by the cloned repository, then the cloned repository
+will become corrupt.
 
 
 
@@ -79,6 +82,8 @@ objects which are referenced by the cloned repository.
 	an already existing repository as an alternate will
 	require fewer objects to be copied from the repository
 	being cloned, reducing network and local storage costs.
++
+*NOTE*: see NOTE to --shared option.
 
 --quiet::
 -q::
-- 
1.5.5

--
