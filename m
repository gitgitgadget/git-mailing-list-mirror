From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Fri, 27 Jun 2008 13:01:20 -0400
Message-ID: <32541b130806271001t35eb97d2gb841e194b54f214@mail.gmail.com>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
	 <20080626112233.GA17625@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:02:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHL6-0002ps-UX
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYF0RBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYF0RBW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:01:22 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:30098 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbYF0RBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:01:21 -0400
Received: by fk-out-0910.google.com with SMTP id 18so519008fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qRCKqDjApYscl+h8Agy5Az/oj9CNyCKy/Ty4a+ofBB4=;
        b=HKnhpmPGOXi4nhjMM+E7Qktx2nt234ZzZmbIHrK9KamiOVXvgWVtNJIlzo7IweX2+7
         zh2L0+h2zFcJF4tJ2EUkz9fk537kE9rQf+MW5PQZfC4BJtmGxPFlPtmqy3Ul8j+ks4Ed
         ylfStoBxijMZ88QR11SqEyyMIMk/Z2rENB6nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IPoTbqJgExh8gNdny9fYZfeUD6zkMOJvIIbMojEkPAbeEaiEMdMCeVOj94qSCHkUYb
         goIvknaphdxXIsrl0yf+Ooomd2CR8z6WsFyS3M0f5hhRglDWjms0nwVokPPiHR84h0TN
         oN+H/zidmXJzeNmu3DYeDTkcwh+oFjeS02j64=
Received: by 10.82.175.7 with SMTP id x7mr70261bue.35.1214586080419;
        Fri, 27 Jun 2008 10:01:20 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Fri, 27 Jun 2008 10:01:20 -0700 (PDT)
In-Reply-To: <20080626112233.GA17625@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86598>

On 6/26/08, Stephen R. van den Berg <srb@cuci.nl> wrote:
> Avery Pennarun wrote:
>  >1) What's a sensible way to tell git to *not* opendir() specific
>  >directories to look for unexpected files in "git status"?  (I don't
>  >think I know enough to implement this myself.)
>
> Would checking the mtime on the directory itself help?

I'm guessing it would help somewhat (although not as much as not
checking anything at all).  However, we'd still have to check the
mtime *against* something, and I don't think the index stores
information about directories themselves.

Thanks,

Avery
