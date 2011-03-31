From: Alexandru Sutii <sutii.alex@gmail.com>
Subject: Re: GSoC questions
Date: Thu, 31 Mar 2011 12:36:15 +0300
Message-ID: <AANLkTinZ2zbhCRAqAYkiAa1=K8aUhcAuEe6Q_gO-v2h_@mail.gmail.com>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
	<20110328001152.GA11294@elie>
	<AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com>
	<AANLkTink4wVb6O+yVm=HUh_s1GhKhyL4baqYGe=XFu04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	libgit2@librelist.org, Jeff King <peff@peff.net>
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 11:36:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5EIg-0001Ga-Mk
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 11:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542Ab1CaJgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 05:36:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40822 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab1CaJgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 05:36:16 -0400
Received: by iyb14 with SMTP id 14so2183006iyb.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Nr9F9I/h2WUdVfGxC5f3FN+LtwYc4QmiO7VaFDaEqS0=;
        b=dQjk2QhbNRSH2AOVC21NWucNuJE/NPIv0h9of35PKCfhmeu1aWahC2j59oiBvNCvNg
         b1Upy7+BQ1iT7B04sWGZ+IVvVr2dlBuUKNLwwuy/AuxQz+sLlGsoxthU0j0A9SEhc1mx
         a19C/W6+RZDiyjw4/SxJ3QJFkVZVOY5iVvBs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=q1KscMJFJ16eW1y2M4btDvobcToaVnWgdRAZMjnyemc9plEpQj2aejuq1z++y6zXyc
         DiKBhuvyabzsHkcsVFUjZdIN8TAfqt88NaBLYs07YWug4RkVCPD8MaXP/hWApVoeallv
         XON4MbhmQUKA4NgMxnbGVR/BM9k7ZcFStXVmU=
Received: by 10.42.150.73 with SMTP id z9mr2846424icv.392.1301564175799; Thu,
 31 Mar 2011 02:36:15 -0700 (PDT)
Received: by 10.43.133.2 with HTTP; Thu, 31 Mar 2011 02:36:15 -0700 (PDT)
In-Reply-To: <AANLkTink4wVb6O+yVm=HUh_s1GhKhyL4baqYGe=XFu04@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170463>

> Here are some places to get you started on writing your proposal:
>
> http://libgit2.github.com/libgit2/index.html (the full API
> documentation -- priceless)
> http://libgit2.github.com/api.html (the usage guide, with examples)
> https://github.com/libgit2 (the list of language bindings, so you can
> see real-life usage samples)

Hello again!

First of all thanks a lot for the references. You have helped me a lot.

> Also, I have to agree with Jeff once again: Start researching and
> impress us with an awesome application that shows how are you planning
> to solve the problem you are facing -- in this case writing a minimal
> git client.
>
> Remember that the sooner your application gets on Melange, the more
> feedback it will receive!

I began implementing the minimal git client[1]. I have implemented the
"git-mktag" command. For this I have modified the "mktag.c" file from
the "builtin" directory in order to make it run with libgit2. Basically the
input file verification code is the same with the original one. I have just
extracted the sha1, the object type, the tag name, the tagger, the
comment and created a tag with git_tag_create.

I have also used the original "usage.c" and "git-compat-util.h" for
error handling.
Is there a problem if the git2 client will reuse non-gitcore code, such
as string parsing code, parameter parsing code, etc?

Can someone look on my code and give me some feedback?

Just before ending the implementation of the mktag command I have
started thinking that maybe there was no need to reimplement this
command, as it can be considered that libgit2 already has this feature.
Even if it is so I am not sorry I did this, because by reimplementig it I
had the chance to get used with git code and with libgit2 API.

--Alex

[1] https://github.com/sutiialex/Git2
