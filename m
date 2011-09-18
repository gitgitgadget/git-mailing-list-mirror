From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/2] fast-import: commit from null_sha1
Date: Sun, 18 Sep 2011 16:30:50 -0500
Message-ID: <20110918213050.GJ2308@elie>
References: <1316380846-15845-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:33:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Ozo-0005jp-Iq
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415Ab1IRVay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:30:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59706 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab1IRVax (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:30:53 -0400
Received: by iaqq3 with SMTP id q3so4575748iaq.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ST5gVOfdA0ZTCNZes3zYcmtkgK0GTq2jwkfNc0t5z3U=;
        b=hELycqKc0zupSF8uNxLfgs+TtuV+Y+SOkdf3dLWO6xW8bcmHLkKZ0HJKa/eSjAbThl
         TYKn852qlp2mLNYPwr3G8y3JYe9t6ohFfT4AyJ62ZqchaSbZlQ4RrA7tbV1gwoO5S4h2
         WYth2zwVo9s5VCj47nFpg8NxrJ0345vDIyZ9g=
Received: by 10.42.212.70 with SMTP id gr6mr3192984icb.21.1316381453164;
        Sun, 18 Sep 2011 14:30:53 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id j2sm22340170ibx.11.2011.09.18.14.30.52
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 14:30:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316380846-15845-1-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181644>

Dmitry Ivankov wrote:

> These patches make fast-import treat
>     commit refs/heads/master
>     ...
>     from `null_sha1`
> like any other missing parent sha1 - reject such input.

Are you sure the existing support for "from 0{40}" is not deliberate
and that no one is relying on it?  If and only if you are, then this
seems like a good idea (a single patch that both makes the behavior
change and adds a test for it should be easier to review).
