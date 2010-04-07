From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitk pays too much attention to file timestamps
Date: Tue, 6 Apr 2010 20:01:09 -0500
Message-ID: <20100407010109.GB11346@progeny.tock>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
 <20100406233601.GA27533@progeny.tock>
 <u2r32541b131004061658r555f21dbgbe011960d9152d3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 03:01:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzJdy-0005cJ-86
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 03:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339Ab0DGBBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 21:01:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39249 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab0DGBBN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 21:01:13 -0400
Received: by gwb19 with SMTP id 19so275959gwb.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 18:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TuJisoXu+wKMgyIw/ao0gNi84o3Iu4EarguhuJoQWiE=;
        b=g2ucrCf15HG+ou9zGvTOmTTSs5+q2zCsxKJSMiUjikE9Hr0Aw6pbAM//N2mkYbuzbU
         ClLMdmAFJgZdwg5i3pdB8K5HdfF3VGk9wHR/kBGdDEv3NyALC/aP6g5HYLwOi4X29XVE
         qRuv+VfNpSXWZt5ixMkD7bi2ZKlZvxQU2RWG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iti3TEQF0vJPJM59GfXq/kDY0IkwUkLl0pALPS7o4cbybmYSTiSsG0ppwrYRnCHWFn
         uxRXA7pNLq2Wa0Q/2HAO9Mfj5TgF1R+Yo2WDwBFoNIY8m+xSrhGMFEmQ+eRbeqSr+EYC
         1RvXC3SJvVPTUfuV3R3fcelovlDgo6zvjef9k=
Received: by 10.100.243.8 with SMTP id q8mr7878688anh.241.1270602072796;
        Tue, 06 Apr 2010 18:01:12 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 6sm3413340yxg.12.2010.04.06.18.01.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 18:01:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <u2r32541b131004061658r555f21dbgbe011960d9152d3c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144183>

Avery Pennarun wrote:

> I'm not sure why I'd want to know accurately
> whether or not my file matches the index, but then have gitk fail to
> tell me about *what* doesn't match.

Ah, yes, I am not thinking very well.  Please forget what I said before.

v1.5.3-rc5~10 (git-diff: squelch "empty" diffs, 2007-08-03) has the
answer for your question.  I am not sure I agree with its conclusion.

v1.5.3~8 (git-diff: resurrect the traditional empty "diff --git"
behaviour, 2007-08-31) tweaked the porcelain more by dropping the
warning message and adding the diff.autorefreshindex variable.

What is missing is a --refresh-index option for diff-files and
diff-index, to make it easy for porcelain, especially long-running
porcelain like gitk.

Jonathan
