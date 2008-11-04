From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git SVN Rebranching Issue
Date: Tue, 4 Nov 2008 12:42:24 +0300
Message-ID: <20081104094224.GC24100@dpotapov.dyndns.org>
References: <20081103140746.GA5969@mars.cyantechnology.local> <20081104084111.GB14405@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kern <matt.kern@undue.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 10:43:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxIRt-0007de-CS
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 10:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYKDJmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 04:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbYKDJmb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 04:42:31 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:43156 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYKDJma (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 04:42:30 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3671654fkq.5
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 01:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jcV3HgK17olxBrTw10mrqpR13yS8TqL8HtaQSZH6xPc=;
        b=ELxCujrmwVbtFHP45QQbUiSZ8GnnMnC8OdpIhU7/tKLnT9N1114L0SXx6OMglbSrx+
         WcmahFX3Lxi9dCgAaICvJqyBUd3Y/oo5pK/7/1tTlPkjbGYdT8gbGQ7tGIJYfMTRcBKR
         nLlzCNOs5MEdEV7pbrLVLDuyNBTdyWydxSJ5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wtUD8Op2ONPEw6FMkw63ZcIKwyW178kF4Tfs0Ub1By1u4m2zKYjzxCVTjuZX7G+5oC
         X3gQqnAjrshPsCW5MRDzFqx+kb6AL8YXafDTeTIT0fdNJ6kV6KqvUtTK7EWh2/CPL3c1
         /WuWv856RNCMUDlJHueguTW1IeMkrpQBmoxdc=
Received: by 10.180.253.12 with SMTP id a12mr275323bki.147.1225791748453;
        Tue, 04 Nov 2008 01:42:28 -0800 (PST)
Received: from localhost (ppp85-141-189-211.pppoe.mtu-net.ru [85.141.189.211])
        by mx.google.com with ESMTPS id e17sm11284471fke.10.2008.11.04.01.42.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Nov 2008 01:42:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081104084111.GB14405@untitled>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100064>

On Tue, Nov 04, 2008 at 12:41:11AM -0800, Eric Wong wrote:
> 
> Short answer: you can use grafts to remove parents.

Using grafts requires some cautious, especially when it is used to make
some commits unreachable, because git gc can remove unreachable commits.
Also, a repository with grafts cannot be cloned.  So using grafts looks
like more as workaround rather a real solution.

> 
> It was actually an intentional design decision on my part preserve
> parents based on branch name.  We would eventually otherwise lose
> history of the now-deleted branches, as reflogs can expire.

Would it not be better to save the old branch using "@SVN-NUMBER" as
suffix? Thus, those do not need the old branch can easily delete it.


Dmitry
