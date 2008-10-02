From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to remove a commit object?
Date: Thu, 02 Oct 2008 07:02:32 -0700 (PDT)
Message-ID: <m3ljx7qemk.fsf@localhost.localdomain>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>
	<48D36DF4.3030607@drmicha.warpmail.net>
	<33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Git Users List" <git@vger.kernel.org>
To: "Klas Lindberg" <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:09:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOmh-0000Q0-4q
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbYJBOCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbYJBOCh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:02:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:35740 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbYJBOCf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:02:35 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1022782ugf.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=5/KDWe+L8Y81jgXdticpp1qE9pXKlVxo5C/vlug3ym0=;
        b=kwPLNQr7+rOd7MZa05rXMei91j8iYXAHJFxbdwNxlkF4CHZJHNuMMl4PXWOYj5v1CE
         5cfLp4BWjAn4dxfN0115VvM+mVPOfxiv8g9n9IGSwCpUd4qDM8i5D+atdzkokhDRYVke
         snt4Fp0a7aLapwRAkaGrZGcguRx1+HHmlfX4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=HE2Yz2cgPk+MvRWZ9Q2oNR5+QrH4NiFPilVNGbprx4mQ93A6eXaMka8/gUpVEtxQW2
         79w+7xzmH+e01OTw1bFyCC0+m74dGRVfMfPIfS2gplMGIOBZLy5d1otByATkM8lZUWox
         0FfisS0HRAXVz//ta62gnLIGQzOshcfEfa/4o=
Received: by 10.67.15.15 with SMTP id s15mr3998519ugi.28.1222956153746;
        Thu, 02 Oct 2008 07:02:33 -0700 (PDT)
Received: from localhost.localdomain (abwk221.neoplus.adsl.tpnet.pl [83.8.234.221])
        by mx.google.com with ESMTPS id q1sm12001595uge.48.2008.10.02.07.02.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 07:02:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m92E2Tjv018345;
	Thu, 2 Oct 2008 16:02:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m92E2Rck018342;
	Thu, 2 Oct 2008 16:02:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97335>

"Klas Lindberg" <klas.lindberg@gmail.com> writes:

> This doesn't seem to work for me. I will soon be in a situation where
> I need to selectively delete commits in such a way that they become
> completely irrecoverable. I.e. it is not enough to revert a commit.
> The *original* commit must be removed. And of course, the repo history
> is too complex to allow for rebasing followed by garbage collection or
> something like that.
[...]

> Would it be feasible to write a tool that can selectively replace a
> specific commit in the commit DAG, or would that automatically
> invalidate every SHA key for every commit that follows the replaced
> original?

It would invalidate SHA1 for every commit after first rewritten.
There are two tools which you can use to rewrite large parts of
history automatically: git-filter-branch, and git-fast-export +
git-fast-import.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
