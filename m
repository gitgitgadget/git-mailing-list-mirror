From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: merge conflict diff
Date: Thu, 3 Apr 2008 08:58:35 -0600
Message-ID: <b9fd99020804030758gced1981s624e50041904665c@mail.gmail.com>
References: <b9fd99020804030713n3c1a2602t847e8a132f8ccd06@mail.gmail.com>
	 <20080403142649.GA16699@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 16:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhQuN-0003tP-OZ
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 16:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236AbYDCO6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 10:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756923AbYDCO6g
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 10:58:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:44808 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546AbYDCO6g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 10:58:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3670866wah.23
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3AbBYPrlIXr0lgz2eVxjYu19MatYHB3lDf5IYbPnP+4=;
        b=ag0A5KSNPTLUcGHylvW6iZqGK3vWxF9QxVHoTHTfI+gw6dY2RHstgoeEQ7riEy8Gahi8cDEQUMVcmTv9NC7oXQe95SN7w/bnBG2Iapef8kj7xrQ58dOvJ4On6wXfM7Y9twx3S+XjQ/qO4InBzl4ki9TQXgq6cn19fM1B1YpF10Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IHQYgaKNjnUcIz3dqF+r0aTDGSeJcecTDDePbQ+8ecTf+gHyUjSf79R6Dfr9rkEZXNuoq3oZi3mtr+dUyKfYrnx9G40eBD/x3ecFdrp0boPXB25yzKrtjcWxorgWOH7z3PoQLyLU5DHsuw0menUA1xZCdNOyDu+Ce6zynk2gRUE=
Received: by 10.115.79.1 with SMTP id g1mr17594681wal.43.1207234715784;
        Thu, 03 Apr 2008 07:58:35 -0700 (PDT)
Received: by 10.114.208.13 with HTTP; Thu, 3 Apr 2008 07:58:35 -0700 (PDT)
In-Reply-To: <20080403142649.GA16699@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78760>

On Thu, Apr 3, 2008 at 8:26 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 03, 2008 at 08:13:04AM -0600, Jeremy Ramer wrote:
>
>  > I am trying to figure out how to quickly diff two source files that
>  > led to a merge conflict.  When a conflict occurs the command
>  > [...]
>
> > So far I am thinking of
>  > # git checkout-index --stage=2 --temp foo
>  > # git checkout-index --stage=3 --temp foo
>  > # git diff .merge_x1 .merge_x2
>
>  The special ref syntax :<n>:file refers to the blob in stage <n> of the
>  index. So you can see them with:
>
>   git show :2:foo
>   git show :3:foo
>
>  Or diff them with:
>
>   git diff :2:foo :3:foo

Perfect! I was not aware of that syntax. That solves the question I asked.

>  You may also want to look at the git-mergetool script, which uses both
>  versions (along with the ancestor) as the arguments to many common merge
>  resolution programs.

This suggestion solves the actual problem in a much better way than I
was thinking.  Thanks for the help!
