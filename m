From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: git-am: indicate where a failed patch is to be found.
Date: Thu, 12 Jul 2012 23:18:35 +0200
Message-ID: <20120712211835.GA858@vidovic>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
 <7vhatcc1ql.fsf@alter.siamese.dyndns.org>
 <4FFF1821.7030705@windriver.com>
 <7va9z4byl3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 23:18:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpQmd-0007H9-7o
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 23:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934253Ab2GLVSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 17:18:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:54367 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934248Ab2GLVSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 17:18:41 -0400
Received: by weyx8 with SMTP id x8so2021520wey.19
        for <git@vger.kernel.org>; Thu, 12 Jul 2012 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7jxgJqeqLQHw2/3T/gt782fVtwSQX3IytVhdj3rUajs=;
        b=VCd2zhWcl3WfvidQW5+gaFOZI3abUG+Abd4Wng2VrashqCQFm7K5B/r5SPMF1jj6EA
         kF+rwu/UV4BbxXoYSJSTHsvKKDl3TeXAO8QdzWXWovUM3+4PrRRnUBwh7pGv1okRQ5oe
         wPlJk6wQuntz0wnX/ueAd1uW+jwh96ymZSDXbpWDcy91rnjraF+Bxo37IHPdqeWvftX1
         hSLIVlvgUQsjA3LLX9Qcrg31+sA7X0k/ozFEZdfkbhcekEKTThMqvQpr0a/wTzsZg375
         SFWln/IePgN2oTex0OC4HChHaUgi9iLQwLAKJM6mU9H2PP8x0Gp0abV/yZPgpPA4ev+b
         6oyw==
Received: by 10.216.215.201 with SMTP id e51mr23208087wep.214.1342127920068;
        Thu, 12 Jul 2012 14:18:40 -0700 (PDT)
Received: from vidovic (147.214.116.78.rev.sfr.net. [78.116.214.147])
        by mx.google.com with ESMTPS id eu4sm960109wib.2.2012.07.12.14.18.37
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jul 2012 14:18:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7va9z4byl3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201383>

The 12/07/12, Junio C Hamano wrote:

> It does not matter at all that 0001-foo.patch only has a single
> patch.  If you are going to fix up the patch after you saw "git am"
> failed, you will be fixing .git/rebase-apply/patch with your editor
> and re-run "git am" without arguments, at which point "git am" will
> not look at your 0001-foo.patch file at all.

Hugh! Didn't know that.

Is it actually expected from users to manually edit
.git/rebase-apply/patch path? I can't find any reference about that in
the documentation and it really sounds like interfering with the git
internals.

Shouldn't git-am/git-rebase expose this to the user (I'm thinking about
something like

  git am --edit-offending-patch
  git am --fix-patch

)?

-- 
Nicolas Sebrecht
