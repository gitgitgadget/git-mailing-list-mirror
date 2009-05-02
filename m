From: David Aguilar <davvid@gmail.com>
Subject: Re: Diftool problems
Date: Sat, 2 May 2009 02:05:33 -0700
Message-ID: <20090502090531.GC34467@gmail.com>
References: <7c0fdf4f0904290915i56f58981i70e7093e9bf87d8b@mail.gmail.com> <200904292142.59471.markus.heidelberg@web.de> <7c0fdf4f0904291255i4076df8cubb26fdb2d51826d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Marcin Zalewski <marcin.zalewski@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 11:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0BAP-00019z-Aw
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 11:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbZEBJFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 05:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbZEBJFj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 05:05:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:15973 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZEBJFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 05:05:36 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1498223wah.21
        for <git@vger.kernel.org>; Sat, 02 May 2009 02:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Isy8yrFXhC4A5tJxLfe4aO2gJc2cnAbcaoYodGrv8J8=;
        b=TeO1hBJ0E4ZEEkBU3mEARBogka42QIB9L2EQq6BWckg3H7Xa3bALu/YHjTMgnHVBz2
         FQ3wJu09gYp8DNVwVkMhPzNK0In+aDr0LB66BB3W+lYinGpcaUrPU6FcAeQz3PJTOz8u
         kI+obqSM0jxoZsQtyAf3DWkwXLrgGEUYMgmzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LZRw65OdWZwsjSNRaEpxp0HedTFsa+P5lgA8gjVeqT0z7tFpoeb4hvgGpWmhO4JrV0
         cVsN/XkDq3kvtlIorpCvMNECBm5kBLkEc//cSJk8wGiZyC811OMwBeCgUpWvdJLY0G+/
         DbWP6MQCGPGvzdMx4y3+XL1OGT2gEBLgmzePo=
Received: by 10.115.59.4 with SMTP id m4mr2670115wak.204.1241255136492;
        Sat, 02 May 2009 02:05:36 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j31sm6097704waf.62.2009.05.02.02.05.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 May 2009 02:05:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7c0fdf4f0904291255i4076df8cubb26fdb2d51826d4@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118126>

On  0, Marcin Zalewski <marcin.zalewski@gmail.com> wrote:
> > The real fix would be to adjust the ediff snippet for difftool support.
> 
> "$merge_tool_path" -f emerge-files-command \
> 				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"

Hi

Would the right command be:
	"$merge_tool_path" -f emerge-files-command \
		"$LOCAL" "$REMOTE"

(without $MERGED) ?


> I think that merge result could be a temporary file, like in
> mergetool. In a situation where I use git to track an SVN repository,
> difftool can be actually used to merge my uncommitted changes with a
> commit from someone else after doing svn rebase. On the other hand, I
> am no git expert so there may be a better way to handle this case.
> 
> -m

Are you able to save the result to a file with the above
snippet?  I'd prefer to not touch the way difftool deals
with files this late in the RC cycle, and if just
saving within emacs works without changing difftool
to use temporary files then that's even better.

I tried it and didn't notice any difference w/ or w/out
the patch, but if not specifying $MERGED is more
correct then we should do that.

You should have just seen a patch from me.
Let me know if you have any other suggestions.

-- 
		David
