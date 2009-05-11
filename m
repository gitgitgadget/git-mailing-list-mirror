From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: auto-merge after push?
Date: Mon, 11 May 2009 07:35:45 -0700 (PDT)
Message-ID: <m34ovrn1ww.fsf@localhost.localdomain>
References: <20090511142326.GA18260@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon May 11 16:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Wbh-0000UI-ME
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 16:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbZEKOfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 10:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbZEKOfr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 10:35:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:42653 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbZEKOfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 10:35:46 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1652455wah.21
        for <git@vger.kernel.org>; Mon, 11 May 2009 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=uXKfS9lmn58KIZ3OoQytbE4zzG9zoampgfF7E7fRolI=;
        b=lTJsNAFR/9scgn/ALwehW3dWaVdbjRkfU88N98KgOF+4OKTBhi5OCM27DI/QJ5Nv/C
         0PMH3qPF8wXtHoi0oMfCY9ayeZGYZlFi+iRj0z5qOMUkwhJqnpKDuX6sXjhs4KUeD0pg
         AOqAv/lv3s0jIpGnObHhXcgzFQJiYlgghrh4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=S80JjWBRwScw+X4HwBu1aQRfvXyTbJWVyLUrKqU9t09Ec4qIXF+xh1ubMIoy8xMxmX
         U9ltuwES5fL8v2wAbva7A+2/9tvuVBaJ9tPeA1vruY0n9Uul3YOegIwVJsW2qznWxuds
         BkpYi9TRi6ijA+noB2q3r+q9mY7Ow0Wr4LKFM=
Received: by 10.114.80.18 with SMTP id d18mr5703564wab.147.1242052546355;
        Mon, 11 May 2009 07:35:46 -0700 (PDT)
Received: from localhost.localdomain (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id y25sm18123625pod.1.2009.05.11.07.35.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 07:35:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4BEZ9uH009000;
	Mon, 11 May 2009 16:35:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4BEYtmN008996;
	Mon, 11 May 2009 16:34:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090511142326.GA18260@redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118803>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Hi!
> I'm working on two machines, and git allows me to switch between them
> and sync by means of git pull. When one machine is behind a firewall, I
> can sometimes only do pushes, but then I have to rememeber to merge when
> I log into remote machine.
> 
> Is there a way to trigger merge on remote after push somehow,
> so that running on local machine:
> $ git push remote
> would be equivalent to
> $ ssh remote git pull local

In general this is not possible, because pull can result in merge
conflicts, which you cannot resolve without access.  Why not push into
remotes, and when you are on second machine, complete pull by merging
changes?  See GitFaq (or GitTips, I don't remember which) where such
approach is described in more detail.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
