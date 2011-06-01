From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: unable to get type of object
Date: Wed, 01 Jun 2011 02:39:24 -0700 (PDT)
Message-ID: <m3ei3dyjqe.fsf@localhost.localdomain>
References: <4DE5E60B.2030903@garrigos.cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Garrigos <robert@garrigos.cat>
X-From: git-owner@vger.kernel.org Wed Jun 01 11:39:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRhto-0006Wk-7t
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 11:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab1FAJjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 05:39:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60377 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1FAJj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 05:39:27 -0400
Received: by fxm17 with SMTP id 17so3646611fxm.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 02:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=hG0/tFnqUaK3WJbUsvSS8WZW0SRPG3C5wqQd6gmrHFg=;
        b=g83LqoYLOjstgo8ntH2DdvDwFoaRssdLb42Z3BD1JykKz1sYtEHc3MA4RoY2KSWdQQ
         f5avv2Jowx4pDYVlne5n9icBNoxtmR6RQftgwAWWQDaaLJdKEL9vze5gpu8b5QgWvIpR
         rKkczPqPJFPPSkRROB8bAqeopPUjbjQqQtpR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=k6g7WQYTG4Gxb7kyhsysXCY/fQ9PoABVEMA569QKYRcG0LdNEwoKlWhAwZ3Ib2vUHi
         +0g+J8J14sP6cHor3Wgqaaz9Cnu9Ggk+HOyT7pC8qe6q2XqWW8H2khLbSmyHBi/60W4N
         3fIdfOAqegfkTpQokEKH/mPbR4SN5ZgGVqyY0=
Received: by 10.223.5.212 with SMTP id 20mr8029295faw.40.1306921165864;
        Wed, 01 Jun 2011 02:39:25 -0700 (PDT)
Received: from localhost.localdomain (abwk140.neoplus.adsl.tpnet.pl [83.8.234.140])
        by mx.google.com with ESMTPS id g8sm316950fai.44.2011.06.01.02.39.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 02:39:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p519con3010730;
	Wed, 1 Jun 2011 11:39:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p519cYub010722;
	Wed, 1 Jun 2011 11:38:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4DE5E60B.2030903@garrigos.cat>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174856>

Robert Garrigos <robert@garrigos.cat> writes:

> I'm having one of those nasty 128 errors which I cannot debug:
> 
> ************
> predircam@eduab:~/public_html/idosing> git pull
> Generating pack...
> Done counting 117 objects.
> error: unable to find c3117d23df0c01ba8558bad81ad3488f0e8d430a
> fatal: unable to get type of object c3117d23df0c01ba8558bad81ad3488f0e8d430a
> fatal: early EOF
> fatal: git-unpack-objects died with error code 128
> Fetch failure: /home/predircam/gitrepos/idosing.git
> ***************
> 
> google suggests me to run git fsck to get a list of corrupted
> files. Besides that I'm running git 1.2.4 and that the git command for
> that version is fsck-objects, I'm not having any result at all.
> 
> Could this be a compatibility problem? As I said, I run git 1.2.4 on
> the repo server and git 1.7.0.2 on my development server. BTW, on my
> devel server running the git command fsck gives no result either.

Do this repository uses submodules?  IIRC pre 1.4.x (or even later)
git didn't understand modules.

Or it might be problem with deltabaseoffset, i.e. when objects is
stored in pack as a difference (delta) from other objects, it refers
to base by offset in pack, and not by sha-1 id.  I don't remember if
ancient 1.2.4 supports this feature.  This is more likely.

Why don't you upgrade git (perhaps installing it locally in your home
directory)?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
