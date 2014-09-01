From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v8 1/4] cache-tree: Create/update cache-tree on checkou
Date: Mon, 01 Sep 2014 16:49:28 -0400
Organization: Twitter
Message-ID: <1409604568.3057.8.camel@leckie>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	 <20140831120703.GA1240@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Sep 01 22:49:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOYXg-0004I2-GU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 22:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbaIAUtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2014 16:49:32 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51309 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbaIAUtb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2014 16:49:31 -0400
Received: by mail-qa0-f53.google.com with SMTP id w8so5350746qac.40
        for <git@vger.kernel.org>; Mon, 01 Sep 2014 13:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WMIlgzrp2mbGpyWx3fbwzvxf0AmfeIKKIpkzHTAjxRg=;
        b=dUe9FAnMTAvTgE/hn9LnSTK4jc4uTXraGVUaTnwMgbJ3HoN2sjlz/IuWzlemaMu162
         DI0qIseJ5wGsx5UoD9GJ8EZPKKtmhDOU2Bs/n85DPeLUPMxZzpq/DHiIdDKvytncFcMW
         iz81wzWSE2myalYUwbt5QhWcIXCW3A1G5DUPE8gMpibk3Xbzu7LL96xtv1xk706P/ExL
         huEfKwn/53tH0OxBz42Cmr9OZrR6ths4YRRsXDIpYvxF/dYFBuy/8gRNJzdsmbZx8yly
         3AbPHcaKLEsQX2itL3mCPOXfmMRL4TnNsKvGjBbElplYf56Sz8WzTFSr7Kln3YsoLYVQ
         RdEA==
X-Gm-Message-State: ALoCoQmHf2PkAi9nCVGwiZvk80t+4NNF8hMwHGMnhXc2QvdzMQg+P265UbqOH542irArlxI4vfSe
X-Received: by 10.140.19.201 with SMTP id 67mr46156453qgh.28.1409604570783;
        Mon, 01 Sep 2014 13:49:30 -0700 (PDT)
Received: from [172.18.25.133] ([8.25.196.26])
        by mx.google.com with ESMTPSA id f4sm4660745qag.5.2014.09.01.13.49.29
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 01 Sep 2014 13:49:30 -0700 (PDT)
In-Reply-To: <20140831120703.GA1240@serenity.lan>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256312>

On Sun, 2014-08-31 at 13:07 +0100, John Keeping wrote:
> On Fri, Jul 11, 2014 at 09:44:33PM -0700, David Turner wrote:
> > When git checkout checks out a branch, create or update the
> > cache-tree so that subsequent operations are faster.
> > 
> > update_main_cache_tree learned a new flag, WRITE_TREE_REPAIR.  When
> > WRITE_TREE_REPAIR is set, portions of the cache-tree which do not
> > correspond to existing tree objects are invalidated (and portions which
> > do are marked as valid).  No new tree objects are created.
> > 
> > Signed-off-by: David Turner <dturner@twitter.com>
> > ---
> 
> This causes an incorrect error message to be printed when switching
> branches with staged changes in a subdirectory.  The test case is pretty
> simple:
<snip>

I tried to reproduce this problem, but I could not.  I tried to
reproduce against just this patch 1/4, and also against all 4 of the
patches.  Can you reproduce this on Junio's 'next' branch, which
includes this series of patches?

Do you have some sort of unusual configuration that might cause
different results? 

Thanks.
