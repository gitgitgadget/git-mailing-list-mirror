From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug: Pulling remotes into an empty repo deletes the index
Date: Sat, 3 Aug 2013 09:57:28 -0700
Message-ID: <20130803165728.GB2893@elie.Belkin>
References: <CAJOTJ-AVamimToPo4oQ=O_Pg+mJHQhardO+NfU8b1dvRxg1KMA@mail.gmail.com>
 <CAJOTJ-Cgdg4CQs-3t1CsBkq_feVEpkoASzQSTATiVugjs+LL7w@mail.gmail.com>
 <20130803163915.GB945@analysisandsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam A <hitsthings@gmail.com>, git@vger.kernel.org
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 18:57:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5f9F-0003CO-1k
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 18:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab3HCQ5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 12:57:34 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:38259 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab3HCQ5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 12:57:32 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so1727776pdc.5
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/NdF/t6vsX0Xj/2QRhRttZorLLzXDESLGE5h8gw1nqI=;
        b=wSupP5p+Ay3295cu8zUVH/VUMTTE52p1nq769nwcCbjYgHyEQSKWKpeE1FN7PE8JLv
         Nr6VokOAYt6SSxNrMCUU9sqrrSNKVtT4Tg+6R4Q6lB2XVTItqnW4g5sJYJRalFZt/2nl
         JzY340jVAupqncP5ikPBXm78u8IeO77lw6k9eNGOew+1Kw2S45BJrq8dyFb+6TBK92yo
         ybNlUtSo3g35e9XgZKMlQm3WGYe11SURVXhrXgC0xiJcT+M6YK5Rf9IuR4R+ZkyHCOX9
         NekGJJCAKGtoXfOyZsidFX10dfViwZmQxMkoAcdhtIK1sV9nTgs/ekiJ0ZQAIfzULzpt
         Ed0g==
X-Received: by 10.68.163.131 with SMTP id yi3mr14015137pbb.55.1375549052343;
        Sat, 03 Aug 2013 09:57:32 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id oe6sm14092723pbb.20.2013.08.03.09.57.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 09:57:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130803163915.GB945@analysisandsolutions.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231605>

Daniel Convissor wrote:

> All is not lost.  Your local files should be stored in the repository's
> reflog.  Examine the output of "git reflog".  You can then reset your
> working directory to obtain those files by doing something _like_
> "git reset --hard HEAD@{1}".

Adam hadn't made a commit, so that wouldn't work in this case.

"git fsck --lost-found" should be helpful, but yeah, this is a bug.
See for example [1] for the start of a patch to play with (needs
tests).

Thanks and hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/196502/focus=196503
