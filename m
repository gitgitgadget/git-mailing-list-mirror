From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 20:27:55 +0200
Message-ID: <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: cte <cestreich@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:29:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOctb-0000Cq-R7
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 20:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbYGaS16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 14:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757407AbYGaS15
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 14:27:57 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:24037 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380AbYGaS14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 14:27:56 -0400
Received: by wf-out-1314.google.com with SMTP id 27so900016wfd.4
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AAxjGM41MwHqsVek71WU80R3lhG5KPO1aWUQXR2yHTw=;
        b=o1l1HncLDCz1wAwgI2+9/B3wZylrPvIasuJPW6OgkWtNI9qpXJF+On+pMC5kMJPBKb
         DgI7jwF/tpLHC3TVlXgC9qKUxj1zoK/FSfXW6o39CPWGcCDKUd3YURA7oIwWPd0ZTFwC
         /+pos6S+5t4LrBjz1H3dU2kjBw5l1tlKlGZ+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=UtqfMHGMw6+MeHGVvZgpMY3qnIoTHHYgB2B6v96OXPM2BlPfhIKbN0qA3zSN9qShaN
         BKGMCJN9TjnrokzrU4FrW+y2DA/Z//qI1iXIPAh7cPnWFqC0jICE79kZUD2SEo0DPldm
         rWk1iteGI9K81Z+eAOGH/OF29wfcY4RBUlfFA=
Received: by 10.142.218.6 with SMTP id q6mr3389029wfg.164.1217528875782;
        Thu, 31 Jul 2008 11:27:55 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Thu, 31 Jul 2008 11:27:55 -0700 (PDT)
In-Reply-To: <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90957>

On Thu, Jul 31, 2008 at 13:10, cte <cestreich@gmail.com> wrote:
> I'm not worried about the interfaces changing; the gui is tied to a
> particular version of git, and I will update the code that calls into
> libgit I pull new changes from the mainline into my local clone.

You should be ;). Unless you are planning to learn a lot of C very
fast, you should be worried about the interfaces changing. That is, if
you want your GUI to be able to stay up to date with the current git
version.

> who's to say that the output of the various commands won't change
> formats with future releases of git?

Junio is to say. Plumbing output format is git's API.

> There is no correct solution if
> you are worried about forward compatibility, unless a well defined API
> is created (which would be sweet btw, but is probably not a priority).

There is, use the plumbing, forward compatibility is 95% assured. With
the exception of major releases, for which any plumbing
output/behavior changes will be announced in the changelog, usually
including an explanation on how to change your code to match.

In short, use the forc-... errr, plumbing ;).

-- 
Cheers,

Sverre Rabbelier
