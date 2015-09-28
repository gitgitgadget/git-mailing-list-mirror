From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Single brackets matching in .gitignore rules
Date: Mon, 28 Sep 2015 10:40:45 -0700
Message-ID: <xmqq7fnae92a.fsf@gitster.mtv.corp.google.com>
References: <2606743.RipZrg6Xoz@pinguin>
	<CACsJy8DiTevhSnkkab-kfvpibitoUMHdjC2UdGT244JwLRxqWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrey Loskutov <loskutov@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 19:40:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgcQ0-0006xd-BE
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 19:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934407AbbI1Rks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 13:40:48 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35107 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbI1Rkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 13:40:47 -0400
Received: by pacfv12 with SMTP id fv12so184044765pac.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qwbZ+yJZ3gj50QBWuRK19TbCnUNESAlGxIReiM5N97Q=;
        b=tnXZ5iSpn9kDKY4sidJI1brZDqnPmRodjQ2BdekuK9DHuGfoqtxvZUK8AvfoG9rW/f
         NAHNnDLB1nInAeaHO+oazcuz/X2ZORlZOMjCckrUm1va8r0J1PhtQ4jHr0D215SXQUH8
         KqNQRm7LBD1nHa6LQi9DEOrDU0YDPMePZE6DwjF1D/7+iXSA4ffEC4RsPmfIHDnM12Vc
         8/1o8/kcmSzgsfVGXSRcreguk+2Qh+GPI6aidZ6oDSao4qXnayB/YfepO41AWt7vyAsx
         0YkA7SfzVII2s7csJrmmKv8gadtPATtdoYifZBqBXrIgMg2wxO0wJ0fFV0fHo38tw+qM
         NRsw==
X-Received: by 10.69.16.166 with SMTP id fx6mr27555677pbd.18.1443462047325;
        Mon, 28 Sep 2015 10:40:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id rl17sm20690248pab.2.2015.09.28.10.40.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 10:40:46 -0700 (PDT)
In-Reply-To: <CACsJy8DiTevhSnkkab-kfvpibitoUMHdjC2UdGT244JwLRxqWQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 28 Sep 2015 20:15:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278734>

Duy Nguyen <pclouds@gmail.com> writes:

> This is already answered. I just want to add that C Git has stopped
> using system fnmatch for some time (part of the reason is system
> fnmatch behaves differently in corner cases). If you don't mind C,
> have a look at dowild() in wildmatch.c, or t/t3070-wildmatch.sh for
> some corner cases (but your cases aren't there, may be worth adding
> too)

What exactly are you suggesting to "fix", though?  Barf when an
unmatched ] appears as a part of the pattern, instead of taking it
literally?
