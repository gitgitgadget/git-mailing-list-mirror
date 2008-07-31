From: cte <cestreich@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 04:20:44 -0700
Message-ID: <ac9f0f090807310420y23150005jbd0bcaec061301c4@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
	 <0EC13CCC-0F7B-41A0-BEB2-67E6EC8D5E37@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: "Pedro Melo" <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:21:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOWEA-0006ET-5s
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 13:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbYGaLUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 07:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbYGaLUq
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 07:20:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:56447 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbYGaLUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 07:20:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so293646ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ng+ap88P6aNWbIK5vMk0M5kgjd8m7/A9RsXt1idTxuc=;
        b=K47/5FORXn7jH930cTQNBDTdgSgpOel460kmsGcns1+fTG5DNklWVNF4zNhMFq628J
         mmvGSqB+fpq9a/bVqWcwJLxpnFOEy6wpFeUjV1llaHhmkS2ok1xEi6w64jtdPSmERxVT
         PAstQX6aj9y6pgOMaSal7dsPB1obI98ngCKAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KkJ+Akk9xBVIY0ck1TzUJGheNT0SWK4CVmPdfu4xo+YrRjJJHVUqYqmcOVNrdu0cfp
         QbByI2e69/SEhWVdYLIpIjg1/zrsxnO9ZySwt3ICW3p+JTG9AgA9fD4cgZ3AUFV83CH/
         aR47h1tYgxnOYydd0ySUQgtLkyE/bnAbFXk3M=
Received: by 10.150.92.12 with SMTP id p12mr1049796ybb.236.1217503244699;
        Thu, 31 Jul 2008 04:20:44 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Thu, 31 Jul 2008 04:20:44 -0700 (PDT)
In-Reply-To: <0EC13CCC-0F7B-41A0-BEB2-67E6EC8D5E37@simplicidade.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90932>

>> Fortunately, g++ can compile C programs and link static libraries that
>> were compiled by C compilers, unless of course, they use C++ keywords.
>> I don't think it is unreasonable to rename the _very few_ C++ keywords
>> in git's source in the interest of allowing C++ projects to leverage
>> libgit.
>
> I think the point Dmitry was trying to make is that you should compile
> libgit as C, using gcc, and then link it with your C++/Objective C code.
>
> No patch is required to git, only to your makefile/xcode project file.

The git .h files must be in your include path, and must not contain
C++ keywords in order to link against libgit.a.
