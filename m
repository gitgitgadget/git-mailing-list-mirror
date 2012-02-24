From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Fri, 24 Feb 2012 23:11:04 +0100
Message-ID: <201202242311.04787.jnareb@gmail.com>
References: <4F46036F.3040406@gmail.com> <20120224204615.GB21447@sigill.intra.peff.net> <7vk43cx7c2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nikolaj Shurkaev <snnicky@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 23:11:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S13MA-0003sw-0d
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 23:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758128Ab2BXWLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 17:11:09 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36461 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497Ab2BXWLH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 17:11:07 -0500
Received: by eaah12 with SMTP id h12so1283803eaa.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 14:11:06 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.94.200 as permitted sender) client-ip=10.14.94.200;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.94.200 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.94.200])
        by 10.14.94.200 with SMTP id n48mr2531273eef.48.1330121466332 (num_hops = 1);
        Fri, 24 Feb 2012 14:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=JDYIJArP9r32WASHD7zb9nw1Cu9k2SfMhAj4jOFs494=;
        b=xxlaHn6LO6ev7WRJ1qxD4QZtPK8/hq/hIKYWFrKNnnvkOIcKX8Kg4C+xk9oJWYbGNV
         HglRrsK09wjnhjSaQP+MgmAfDl1wqxzSaLRHOS8HosGlP+D5/BWSLD6LymXZCSJ+uPj9
         k8h6ReZNGfBgEaps06OLWcrOrOS3D3qk2Y4qI=
Received: by 10.14.94.200 with SMTP id n48mr1879874eef.48.1330121466169;
        Fri, 24 Feb 2012 14:11:06 -0800 (PST)
Received: from [192.168.1.13] (abws184.neoplus.adsl.tpnet.pl. [83.8.242.184])
        by mx.google.com with ESMTPS id a58sm23077637eeb.8.2012.02.24.14.11.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 14:11:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk43cx7c2.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191495>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > True. That is also a slightly dangerous thing to do, though, because you
> > are omitting full patches in the middle that touch the same paths as the
> > patches you include....
> > ... So
> > perhaps we are better off to refer the user to git-log(1), say that
> > commit limiting options in general would work, but be careful with
> > sending a partial result.
> 
> You seem to have spelled out everything I originally wrote in my reply
> that I later deleted before sending it out, and I think the reason that
> brought you to the three-line conclusion is the same one that made me I
> delete them ;-).
> 
> Using a partial patch essentially has the same risk as cherry-picking a
> commit into different context, and it is a more generic issue that this
> particular manual page should not waste tons of space to teach readers
> about.  I think "Be careful and clueful" is sufficient and the best we can
> do without writing a textbook on distributed software development
> disciplines.

Perhaps git-format-patch should mention that it was created with
path-limited patch in some email pseudo-header like X-Pathspec:
or something, don't you think?

-- 
Jakub Narebski
Poland
