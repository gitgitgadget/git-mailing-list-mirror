From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: is it kosher for pre-commit to change what's staged?
Date: Thu, 11 Nov 2010 01:17:04 +0300
Message-ID: <AANLkTi=W_hwU=3PTTqE4R8Cg5T=GMdMfBsKQ1YE0HWRe@mail.gmail.com>
References: <20101110170819.GA3031@gnu.kitenet.net>
	<7v1v6thrzc.fsf@alter.siamese.dyndns.org>
	<20101110200650.GA13439@burratino>
	<20101110204542.GA11201@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Nov 10 23:17:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGIyh-0001SU-2y
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 23:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241Ab0KJWRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 17:17:07 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49831 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757229Ab0KJWRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 17:17:05 -0500
Received: by qyk1 with SMTP id 1so67372qyk.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rjkgT6euducxTS0FkzI6Wn4DcXJ/pCPhOvdLhihGQKQ=;
        b=EhuynFZBFQzjrcsPmtu0OZQac6mIFAj16RQ4ln4hggJNEEQtKHmMQcntgC8d+WWzWe
         /lmU/pr+TImL+nAiOfLbHdkMw6GiuMR7cF/a/5l3iWBzcMC974ssirN58biQIWeMh8Zx
         9Ina4luJeggK0K+S6eIOrTLZib14JPHPL3jQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=X1cut43z7aus8v6i7s+nWV1TTepz7FVuQUXfmcTjsk11mxRX/ASJpDAxlyU2yJw3xG
         rRJDdPj4PKfi9RVypzZgi//eZjAHfk8/+zXa6qqLrwt6DS4PR1BEP8HOpz4GkL5ONjCO
         XxVFL/uFlMVrVltslhW05mcmZuQxRr2o23eio=
Received: by 10.224.2.73 with SMTP id 9mr103381qai.260.1289427424103; Wed, 10
 Nov 2010 14:17:04 -0800 (PST)
Received: by 10.229.230.202 with HTTP; Wed, 10 Nov 2010 14:17:04 -0800 (PST)
In-Reply-To: <20101110204542.GA11201@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161189>

On Wed, Nov 10, 2010 at 11:45 PM, Joey Hess <joey@kitenet.net> wrote:
>
> That said, since git commit stages the whole large file into the index,
> which is the kind of expensive operation git-annex exists to avoid,
> it's still not very practical to intercept the commit like that. What
> I ideally need is a hook that is run before git commit stages anything.

Then maybe you should look at git smudge&clean filters. They perform
conversation between the working tree and the index.  Though I am not
sure how well they work with big files.


Dmitry
