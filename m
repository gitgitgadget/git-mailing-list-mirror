From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 12:32:04 -0800
Message-ID: <20141118203204.GM6527@google.com>
References: <20141118194129.GI6527@google.com>
 <Pine.LNX.4.44L0.1411181523320.879-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqpRa-0002xj-AI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbaKRUcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:32:05 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:45495 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159AbaKRUcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:32:04 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so2903978ier.13
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 12:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LK8YyRO3uVNnWHBE+1ErWIpQCpvaNcvjVMlPVnNe+0I=;
        b=hia59GEp/OIzeJLqG9J1q1Fwmg5l3+1GD/usNhavRUuIXjr2QAD2Nvsg6Vvpxur+5e
         6etKNI3lIAfs91Q3feEuOpR1t5SvEZISWBCvYJdz9ZADQZwVhbk1yjAp/dI72Mo45Gd3
         0c4AjLVr7TA5TBk7w9mBuJ3PqxHQeAVqH69hltsAlkzJNrlldo6boL/949U14BdllCks
         o6GqLcTXK2yusngNcoJC/ZvCAFZhJtuRWjBvIEO6LXu7x2u+Q91qwAmiUt29cgFNRJEy
         qpC2wPDfR+Iy8o4Tr5PHoRKh3mTu+D/2rw3GfX+nODe6ikfXITfugpGSpTRp9V50eR3g
         pEjA==
X-Received: by 10.42.142.201 with SMTP id t9mr11204783icu.60.1416342723369;
        Tue, 18 Nov 2014 12:32:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id h199sm21161049ioh.0.2014.11.18.12.32.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 12:32:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411181523320.879-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alan Stern wrote:

> Tracking down regressions.  Bisection isn't perfect.  Suppose a
> bisection run ends up saying that B is the first bad commit.  It's easy
> enough to build B and test it, to verify that it really is bad.
>
> But to be sure that B introduced the fault, it would help to find the
> latest commit that doesn't include B's changes -- that is, the latest
> commit that B isn't reachable from (or the maximal elements in the set
> of all such commits).

Isn't that B^ (or B^ and B^2, if B is a merge)?
