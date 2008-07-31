From: cte <cestreich@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 14:31:44 -0700
Message-ID: <ac9f0f090807311431p3e943441xce8f2ac03ba1700@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <4891B872.3040707@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Boaz Harrosh" <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:32:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOflP-0005fy-2S
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbYGaVbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 17:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbYGaVbq
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:31:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:19037 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbYGaVbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 17:31:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so457933ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x0MP4ZkGjfQaABXgTessTxEyaQihi09atND1bXQgWbU=;
        b=lAE504ZBAi8772eUz5CXJ22i7pLAzdGsc4Dc57+dRPzsqL2+4jRnU1CBzFHLoWQi1w
         T3KVNBNf4AM9TRs55xDeP+eYJbO4B34jW6Oqorl11EWrIcCZLOyxMFBkxTdYJNBUEt8c
         ZN06fUzCZgf5Zwm6rMOqdQ87Ydx3/JM2KpMrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Wt3+csCUq5DulI6cLo26Yhk9wSnIiJkxU8abxtHaa9vZukE0Lk2Y++3PNCbqsf6NGp
         TfwjlBXfm6zlEgSWmtd0YtUAm2jhPr5lHWuLeYkTcgLtUvUTHcc53cb+zMtELgTic/5y
         NmdM7cxLy/X2Yg6TRudfmzSPUu1eZUBz39OYQ=
Received: by 10.151.109.11 with SMTP id l11mr1955421ybm.204.1217539904437;
        Thu, 31 Jul 2008 14:31:44 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Thu, 31 Jul 2008 14:31:44 -0700 (PDT)
In-Reply-To: <4891B872.3040707@panasas.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90997>

Excellent idea; thank you!

> The practice of avoiding C++ keywords from public C headers is
> very welcome. You should send a patch and try to push it.
>
> That said the problem can be easily avoided.
>
> Produce a C file and header that defines some stable API to your
> GUI application, that does not expose any git internal headers.
> Then compile that, say git_api.c, with C compiler in Makefile
> and extern "C" link that file to your C++ application. This will
> completely insulate you from any git code.
>
> This could also solve the other problem of API changing, only
> the git_api.c need change, your outer GUI code stays the same.
>
> And if you do all that maybe you can submit it for inclusion
> as a: somewhat stable high-level library, for developers.
> Ala git-dev
>
> Cheers
> Boaz
>
>
