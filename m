From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Equivalent of "fixup" for git filter-branch
Date: Fri, 11 May 2012 15:04:18 +0200
Message-ID: <CAGK7Mr6Z44iJqATgiWHXeutOHJM-vXauYeyYB0Z6c+mGYCr1Cg@mail.gmail.com>
References: <CAGK7Mr5D0WQn-Tc1B5=F7+3OgZd1uy54Be-ZrbyFv0CP8JY5bw@mail.gmail.com>
 <m21umsylz8.fsf@igel.home> <CAGK7Mr7qdTwfha8aUdXE4FeXjA0rW3JL0q=a9kHArirjv5bygg@mail.gmail.com>
 <m2havmop75.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri May 11 15:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSpX3-0008Ou-Dr
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 15:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759633Ab2EKNEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 09:04:51 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62580 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758964Ab2EKNEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 09:04:50 -0400
Received: by yhmm54 with SMTP id m54so2545477yhm.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RiGQiRdGFOem9lLbO1zRe3QPUX36uoB+pcdyYSVMh9g=;
        b=ymMMzgo6W0ej2h1PaV1mRGgRVI/Bg6E4iIzkN0QzgJS6QRw5hduZ8RxE/gSmr/xJg0
         WVwDNqdv1BBbNjRHHbrztSvpPXHf1s9spACNKKFX0bupY1007/ppc/mBnbnj/V4tLdlg
         VwKi/u36LFHjV/aUzjkIV4NoCResijhVpaImqY/HwCqUZ73sj+oW9mkvP2TliXVxdwuO
         e1/sXpUpW2AnzM/CPEIUVGEAGciY3cZWvZuxXJDZ/Phlb2tY41sSdUSKPjCmjKOr4cKg
         tnwAiIjmi69g+EEzHTxlvGG6lCKOQGxkUOQiaPNlgGQ79bz+2mF1PB9ENEDZ0wEe9e6g
         8pxg==
Received: by 10.42.77.69 with SMTP id h5mr4140347ick.44.1336741489193; Fri, 11
 May 2012 06:04:49 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Fri, 11 May 2012 06:04:18 -0700 (PDT)
In-Reply-To: <m2havmop75.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197674>

>> Also, how can I know in advance that the next commit will be a fixup commit?
>
> In the index filter, when $GIT_COMMIT equals the parent of the fixup
> commit, update the index with git read-tree from the fixup commit.

Right, good idea.

I was also thinking maybe I could use --parent-filter: when I find a
fixup commit, I set its parent to its parent's parent?

Philippe
