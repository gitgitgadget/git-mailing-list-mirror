From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 00:38:45 -0500
Message-ID: <535600656ba3_1c81125730c6e@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <20140422051918.GC60610@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 07:49:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcTZx-00043q-8W
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 07:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbaDVFtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 01:49:09 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:48482 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaDVFtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 01:49:07 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so3992851obc.29
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=QJUkYxZxurz0npUD8mlIWkvxUIzoDJr6glWExlFEFJc=;
        b=GLMFRKNR3FKu/6+VCAeJeDEzx+GAhi5MSvR8trxl2BNSZDZlU9RGtllF5LpUzQk42/
         bNYSbAmSwYVWCTxqPZ0F5+PNzq95NPgTwR4ntWOPKQ6GgSMzwPTZJ3kToLwhfQjdm+Xg
         lgtN9LwwgaNaTD2VFqbcDkIwLIn2o0AyY7LOcq7xEViEGCePRQ1DuwVHcRC+8oxLKnWC
         B/qEL4lEAr+51SEmtp53TtxvVBYGXGfxa08Qg3IbHkcOV2a9Ork+A5VS/rCb1aor2rYA
         S1p5+pd2d3GHtIFcwfAjCYaCXMq7dDK2qAEjxKRCbaef4i0M6Fb9CSFIvwoSyLa/JMEh
         HIQw==
X-Received: by 10.182.200.131 with SMTP id js3mr36010376obc.0.1398145747473;
        Mon, 21 Apr 2014 22:49:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm173704018oeb.13.2014.04.21.22.49.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 22:49:06 -0700 (PDT)
In-Reply-To: <20140422051918.GC60610@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246696>

David Aguilar wrote:
> On Sun, Apr 20, 2014 at 05:41:05PM -0500, Felipe Contreras wrote:
> > = Reject non-fast-forward pulls by default =
> > 
> > Many new-comers end up making merges by mistake when they pull because
> > they don't understand what is a non-fast-forward and what they should
> > actually be doing. Most people, even Linus Torvalds, agreed that by
> > default `git pull` should fail and guide the user, instead of silently
> > making a merge which might not be what the user wants (even though he
> > doesn't know it), and messing up the project's history, which affects
> > other people.
> > 
> > The patches were sent, the issues were addressed, people agreed, and
> > yet nothing happened.
> 
> We can currently set pull.ff = only to get this behavior.

It is not the same behavior as my patch series, you get:

  fatal: Not possible to fast-forward, aborting.

With that message we certainly cannot make it the default. In my patch series you get:

  The pull was not fast-forward, please either merge or rebase.
  If unsure, run 'git pull --merge'.

> I would like it if this were the default (but I am biased).

I don't know if you followed the discussion, but virtually everyone (including
Linus) agreed this should be the default.

> > = Use "stage" instead of "index" =
> 
> I'm probably biased about this one too, but I should probably speak up.
> 
> git-cola has used "Staged", "Modified", "Untracked", etc. since
> the beginning of time.  Sorry 'bout that, but it seemed like the
> simplest word to use.
> 
> I often hear users talking about "staging" files.
> I'm probably in an echo chamber, but I never really had to
> explain "the staging area" since the concept is pretty natural
> when interacting with the GUI.

Again, virtually everyone (except Junio) agrees.

-- 
Felipe Contreras
