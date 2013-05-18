From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Sat, 18 May 2013 17:36:23 -0500
Message-ID: <CAMP44s29L1Yr0mQjUmUBr7Zm9NouG5_vrQ4cZ=TY2QbLKMB9eA@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	<7vk3mx1rox.fsf@alter.siamese.dyndns.org>
	<CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
	<7vk3mxze8v.fsf@alter.siamese.dyndns.org>
	<CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
	<CALkWK0=0SwWW+LC3iPy=A9tLBOxrXgYH1cYNazrchv3_jU_oMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 00:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udpjp-0000EM-4I
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 00:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab3ERWgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 18:36:25 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53589 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab3ERWgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 18:36:25 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so3464702lbi.33
        for <git@vger.kernel.org>; Sat, 18 May 2013 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9cc/pd9fsdNdoI/hRo8XZ+5BE7NCrSgrgGEKlQPn5UQ=;
        b=gtzBLDzxJfWUlIwBjQu7kG4gqTn4Bm3SQ73Avt165PYV38ntBtDDK0fXtWa5PnjFfo
         rbAIdmOSjWREaGmh7cWGMLD1NIRMPXvDKUi0FwX/sVLGQJKwFoksuTMCZN4ZZm942EpI
         4CtxkuXMWnF4xxtk9aYBMKREmN23NCO75oYAwKXANmWz/BS6ptlmjztH9qnjeH5q3qYI
         dg+TxLzf2BFWKaGscIyZipyXJTK/PNxFo4NohI5a7Rg2p3edQdc/Mmr5TVj7EhWHQmmh
         Zd6onRq9ZPbGi32IM3XTakB5ORvUw61PoUWsMtUuQKz5l5uPyexQZQqo3nZtCpNBXEEv
         h/cg==
X-Received: by 10.112.166.101 with SMTP id zf5mr24666573lbb.59.1368916583461;
 Sat, 18 May 2013 15:36:23 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 18 May 2013 15:36:23 -0700 (PDT)
In-Reply-To: <CALkWK0=0SwWW+LC3iPy=A9tLBOxrXgYH1cYNazrchv3_jU_oMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224812>

On Sat, May 18, 2013 at 3:07 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> I guess what I'm saying is: refspec semantics are inherent properties
>> of the remote, not of the local branch.
>
> [remote "ram"]
>     push = refs/heads/link:refs/heads/for-junio/link
>
> is saying: if the branch name matches "link", push it to for-junio/link.
>
> [branch "link"]
>     push = refs/heads/for-junio/link
>
> is saying: push _this_ branch to for-junio/link, irrespective of what
> it is called.
>
> An example illustrating this clearly:
>
> # on branch link-v2
> # work ...
> $ git push
> # work ...
> # ok, I'm ready to replace link
> $ git branch -M link
> $ git push
> # where should the push go?

Exactly where you told it to go.

> Also: putting branch-specific configuration in remote.<name>.push
> would mean that it can potentially accumulate a lot of cruft from
> deleted branches.  It's the same kind problem we face with .gitignore,
> no?

Not many people would use 'remote.<name>.push' and in very specific
circumstances. It's not a problem.

-- 
Felipe Contreras
