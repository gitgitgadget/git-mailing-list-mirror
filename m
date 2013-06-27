From: Johan Herland <johan@herland.net>
Subject: Re: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 15:14:05 +0200
Message-ID: <CALKQrgdiRg--A4-cp7Y0c3-rc-gDX+QVgPxKDpmW5Exx_HeWHg@mail.gmail.com>
References: <20130627124656.GA2620@zuhnb712>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 15:14:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsC1g-0001K7-VT
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 15:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab3F0NOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 09:14:12 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:63144 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab3F0NOK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 09:14:10 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UsC1Z-000LO8-AI
	for git@vger.kernel.org; Thu, 27 Jun 2013 15:14:09 +0200
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UsAqz-000LTc-6v
	for git@vger.kernel.org; Thu, 27 Jun 2013 13:59:09 +0200
Received: by mail-oa0-f46.google.com with SMTP id h1so811969oag.33
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 06:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wAn8UfuENPlZ5EoADmzTaZMGv79EcM1cskOEZt/FZYY=;
        b=FjKqMFUUOmfK7z76x7QB15QABkU2KG18AywQE31IaHn0WkFPXZaN1aDUvR/MquNdGy
         ONRNqqBKySs3NG3w5mWLoOA949pc9ceB+Y4ON7vBWXRqEyZNu7X9BFNV4jToBtlSWlX5
         Ke00sGh38/15ZZgfVZPnOidV1k8DmfniFGWz7eDFp5IkmhAIZuviU03V7R4Szof9oc8Y
         G0EHPgD4w9Te0hNQSp7MGRpafTUIskzcG7ZntkFtq2SLFCLeXGRIm48i/9gyzLYQAXsI
         ulZvi3/2K2Qj2cx1XmYGDALSaFZVxFUSVarD8qjV/cZuRvDzyPoP1qO3Gb1BVpT1k7zd
         EQiA==
X-Received: by 10.60.97.1 with SMTP id dw1mr2803836oeb.1.1372338845576; Thu,
 27 Jun 2013 06:14:05 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Thu, 27 Jun 2013 06:14:05 -0700 (PDT)
In-Reply-To: <20130627124656.GA2620@zuhnb712>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229100>

On Thu, Jun 27, 2013 at 2:46 PM, Woody Wu <narkewoody@gmail.com> wrote:
> I have a colleague who has to left our office for three month, but still
> need to work on the project which is hosted on our in-office git
> repository. Problem is that our company has firewall, it's not possible
> or not allowed to access the company LAN outside the building.  So I
> want to ask you expert, can you suggest a best practice of git workflow
> that suitable to my situation?

If he can set up an SSH server on his machine (outside the company
network), then he can set up a mirror repo on his machine, where you
can push changes from the office to him, and pull changes from him
back into the office. Of course, you will probably need to synchronize
this with him, especially if he's travelling and frequently offline or
changing IP addresses. Also you need to be able to make outbound SSH
connections through the company firewall, but AFAICS that is usually
allowed.

His work repo is then a local clone of the mirror repo, and when he's
ready to publish some work to you, he pushes it to the mirror repo,
and asks you to pull from the mirror repo.

If the source code is not secret, you could even synchronize through
GitHub or some other repo hosting service, which would be even easier
to set up.


Hope this helps,

...Johan

> Thanks in advance.
>
> -woody
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Johan Herland, <johan@herland.net>
www.herland.net
