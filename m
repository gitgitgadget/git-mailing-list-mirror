From: Nico Williams <nico@cryptonector.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Tue, 19 Aug 2014 20:19:36 -0500
Message-ID: <20140820011935.GC3104@localhost>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 03:19:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJuYv-0008Jw-PW
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 03:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbaHTBTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 21:19:37 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:52321 "EHLO
	homiemail-a33.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728AbaHTBTh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2014 21:19:37 -0400
Received: from homiemail-a33.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a33.g.dreamhost.com (Postfix) with ESMTP id B7EBD594061;
	Tue, 19 Aug 2014 18:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=cryptonector.com; bh=Nl69YQcOZI1sd4
	JvGELi/ayFpdA=; b=fHrUfPA0UCTce/mLMPWJVBTT1yGmPc+DDaN1XuluAPWoQr
	KH9fkJMIkaRaq+wHxustqp+oFCaIODrsCV9t1zlK42qQ3rABZ+P4RCzCOn7wzn7a
	yRMTdlKt6QyRUTmmrf1SAFj5zERcBul1pXdJWPI4Legl45CR8ikV7BIrWr0OI=
Received: from localhost (108-207-244-174.lightspeed.austtx.sbcglobal.net [108.207.244.174])
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a33.g.dreamhost.com (Postfix) with ESMTPA id 7472459405E;
	Tue, 19 Aug 2014 18:19:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255545>

On Tue, Aug 19, 2014 at 03:06:09PM -0700, Junio C Hamano wrote:
> While signed tags and commits assert that the objects thusly signed
> came from you, who signed these objects, there is not a good way to
> assert that you wanted to have a particular object at the tip of a
> particular branch.  My signing v2.0.1 tag only means I want to call
> the version v2.0.1, and it does not mean I want to push it out to my
> 'master' branch---it is likely that I only want it in 'maint', so
> the signature on the object alone is insufficient.
> 
> [...]
> 
> This series introduces a cryptographic assurance for ref updates
> done by "git push" by introducing a mechanism that allows you to
> sign a "push certificate" (for the lack of better name) every time
> you push.  Think of it as working on an axis orthogonal to the
> traditional "signed tags".

Sounds a lot like the "branch object" concept I suggest earlier, where
each push would also push a commit to a branch object describing the
updates to the branch, including signing of the updates to the branch
(hey, it's just a signed commit), groups of commits pushed together / to
be backed out together, rebase history, ...  (What about pushing
orphaned commits?)

Code-wise, would that be more or less generic?

Nico
-- 
