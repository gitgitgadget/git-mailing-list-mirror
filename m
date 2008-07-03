From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: finding deleted file names
Date: Thu, 3 Jul 2008 03:12:44 +0200
Message-ID: <237967ef0807021812r3ccbfbacg2cb6b12358d2ee2e@mail.gmail.com>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 03 03:13:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEDOK-0005k3-52
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 03:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbYGCBMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 21:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbYGCBMq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 21:12:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:3629 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbYGCBMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 21:12:45 -0400
Received: by rv-out-0506.google.com with SMTP id k40so724609rvb.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 18:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jIMa2xzWB6MH2wrJlIGpGjqruCt+uXzUP9KMxYGeAjs=;
        b=OlwtS2i28jOlLICgN5wvYsbOA5AguL+n7vwnq4mKVCYV/7lWeKnyWXVschY4IY4L1X
         B9dRVtLHEfhmWeCpBUErExEZZ5fVtLe9EmCwMEZr9KwPXALzJQfA4LHkSqJWLOX5JDyL
         9eMVgNZqWLkhmctSTxO7XBGMNmmlSdV4TTp2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=k/cFF2RfTuwE8uEI1qLyG0SkFSewwXiTTHayUoVmZOvALG2APFPqvEL3GDdSB6biKa
         gIg3iVW1MQefpujFpJmGylmBG1fpJYMRuUUte6QlIXgT2a0ykQVx8u711lzfxt6GyHf8
         4L5OOKxxAxQ+59uEit9t85e5UXhkyj5Z+VlIc=
Received: by 10.141.34.12 with SMTP id m12mr4785122rvj.26.1215047564808;
        Wed, 02 Jul 2008 18:12:44 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Wed, 2 Jul 2008 18:12:44 -0700 (PDT)
In-Reply-To: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87217>

2008/7/3 Geoff Russell <geoffrey.russell@gmail.com>:
> git diff --diff-filter=D --name-only HEAD@{'7 days ago'}
>
> finds files deleted during the last 7 days, but if my repository is
> only 6 days old I get a
> fatal error.
>
> fatal: bad object HEAD@{7 days ago}
>
> Is there something that says "since repository creation", ie., go back as far
> as possible, but no further? Is there a symbolic name for the initial commit?

There's no symbolic name for it, since there might not be only one initial
commit. git.git for example has at least three root commits. You will
probably get what you want with $(git rev-list HEAD|tail -1). If your
history is very large, $(git rev-list --reverse HEAD|head -1) is slightly
faster, but usually not enough to offset typing --reverse :).

-- 
Mikael Magnusson
