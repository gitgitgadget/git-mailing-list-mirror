From: Eric Gillum <eric@color.com>
Subject: Re: git rebase keeps saying local changes would conflict..what changes?
Date: Thu, 14 Jun 2012 16:49:54 -0700
Message-ID: <2652085F-C1BC-4EAB-9289-F508E64982F0@color.com>
References: <D8381FF2-A6B4-4596-B565-7E5BB3F239D8@color.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Gillum <eric@color.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 01:50:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfJnc-0001TV-3u
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 01:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab2FNXt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 19:49:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60020 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab2FNXtz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 19:49:55 -0400
Received: by dady13 with SMTP id y13so3235583dad.19
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 16:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer
         :x-gm-message-state;
        bh=1wQQEHTu45peeFwbXuv+4itzzLE66nS14MzqDxap51I=;
        b=Z/rHvny9iDreKCPl6fYPAy/E6VGw8dkopJ09m6TD+UmeNHnjr+gyPPk2niBFK3Nekn
         PBKqSYZB1Span9Obce07HjrJUZoFNhoE4C+ZUCFglJXO/bxHD8oXvZ7N+/hbYnu/SrUu
         n18aAy0SVvyQaSLfnFP4lfan6gm94DiPGFwzyL/wdAAEA8yRSd88aZ19pLoeiyAYurty
         Q58Kv0olP/4qweHCSsXiy7oYVrQAQyoHORVZ4OIlHlBYG9OAOHVEZdIFj1mTJsJucIDB
         M88SYNEhBx97QeiDKzmv2bfuguXJodmkOoTWhM1uOrWzTTnG0CglyAdsPqGQdsMJlxc6
         zCfg==
Received: by 10.68.228.39 with SMTP id sf7mr13437867pbc.45.1339717795556;
        Thu, 14 Jun 2012 16:49:55 -0700 (PDT)
Received: from [10.0.3.163] ([65.50.211.37])
        by mx.google.com with ESMTPS id pe2sm11091520pbc.59.2012.06.14.16.49.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 16:49:55 -0700 (PDT)
In-Reply-To: <D8381FF2-A6B4-4596-B565-7E5BB3F239D8@color.com>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQkBcg7JxdpBrMMoDUfN0qLR+YYKwu5Pjs2o5cr2q8+fqLKVa0CcMtA9PTDmG2WKLFPnymEp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200037>

Just found a similar problem here: http://stackoverflow.com/questions/5074136. I do use Xcode, which may be related. Maybe I'll try the proposed solution. But I'd still love to know what the issue is, or how I can help debug it.

On Jun 14, 2012, at 4:41 PM, Eric Gillum wrote:

> Hi,
> 
> I have a sometimes-reproducible issue when trying to rebase. In short, I've created a local branch B off of master, made several commits on B, switched to master and pulled, switched back to B, then tried "git rebase master", which fails. What I get about half the time is a failure that claims I have local changes to files that would be overridden by the merge. Nothing is reported by git status (I've even tried closing all editors), so I am forced to do git rebase --abort or --skip. I can't skip because the commits only exist on B. So I abort and just try the rebase from scratch, and somewhat less than half the time git claims there are conflicts in certain files. Sometimes I bite the bullet and go fix those conflicts. Sometimes I abort again and rebase again until eventually...it just s
 ucceeds!
> 
> What's wrong? Why would I get the local changes warning but have no local changes? The merge conflicts tend to be within a file that has been changed multiple times on B. These "conflicts" are literally changes I've made at one point or another on B. The relevant files were never touched on master while I was working on B. And no changes on B are amends or reverts or anything remotely tricky --  they're simply more changes committed with "git commit". So why would I have to "resolve conflicts"?
> 
> This is git version 1.7.9.3. Your insight appreciated.
