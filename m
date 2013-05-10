From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: stdout versus stderr for cmd line git
Date: Thu, 9 May 2013 20:28:43 -0700
Message-ID: <20130510032843.GA12036@elie>
References: <CAKk5qjVoDUzeurgAL51jixXsm4rJCMCDf620vAv_Gsafk8N7iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Hunley <michael@codecobblers.com>
X-From: git-owner@vger.kernel.org Fri May 10 05:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uae11-0002Qr-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 05:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab3EJD2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 23:28:52 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:38066 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab3EJD2v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 23:28:51 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so1826513bkc.0
        for <git@vger.kernel.org>; Thu, 09 May 2013 20:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=x5Mdm+I1psywsXGlvRa5aSwNyNTplWryTPKbpVWojXk=;
        b=cxRJkN0LkB6BJq6NSuKJ2FRN2vWoszSqc3O1qJde3uFoTFQ9Ms0c68O0atERKtwnNU
         fu9ri3gM1r2YLC8YtUSSxDWzdIEBxGjBMWp6t/bWHZrhuOZgTO6Fhv/4biBfCN5jPEc+
         zGqvT24ixSPOxbGyjgoiKhmcpDUoTy34khxlHW44d6opDO81kKs+2cg4+VHiAxgjHu2/
         eYUEuTFRhKQGD2Qh2R9ZPywuI8oS9uKVd3zDNgNN22FE59zJ5cAEJHm6b9uHimrFrSza
         HnQTMvB7O9Eqd2iHOZbA7aUs2WpBGjJ62hAGofCg1E2CM5uTHkZOijCJAS/5En4a84tN
         mLgg==
X-Received: by 10.204.98.77 with SMTP id p13mr3841190bkn.86.1368156530438;
        Thu, 09 May 2013 20:28:50 -0700 (PDT)
Received: from elie (p5795BBA6.dip0.t-ipconnect.de. [87.149.187.166])
        by mx.google.com with ESMTPSA id f3sm143797bkj.21.2013.05.09.20.28.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 May 2013 20:28:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKk5qjVoDUzeurgAL51jixXsm4rJCMCDf620vAv_Gsafk8N7iA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223812>

Hi,

Michael Hunley wrote:

> Ok, we can filter that out.  But worse is that actual errors in a pull
> request are sent to stdout instead of standard error.  For example,
> merge conflicts or pull failures because you have unstaged changes.

Yes, errors and progress output should go to stderr.  The git-pull.sh
script is pretty old and is probably just a bit sloppy about
forgetting to redirect output from "echo".  Patches welcome.
(See Documentation/SubmittingPatches for details.)

Hope that helps,
Jonathan
