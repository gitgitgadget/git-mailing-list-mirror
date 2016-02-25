From: Stefan Beller <sbeller@google.com>
Subject: Re: git submodule add --single-branch
Date: Thu, 25 Feb 2016 11:05:55 -0800
Message-ID: <CAGZ79ka-SAiBC0EHKkESvapS1dvxADOrBvq5ik1r61jjb=jepg@mail.gmail.com>
References: <8e46e2f93895fb33421e7b09ccfe7de5@www.hilie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alter Depp <Alter.Depp@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 25 20:06:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ1Ef-0006iN-0F
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 20:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933353AbcBYTF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 14:05:57 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38058 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286AbcBYTF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 14:05:56 -0500
Received: by mail-ig0-f181.google.com with SMTP id y8so20330286igp.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 11:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=cvvah64uVrNYgN9R/PI2ihegm23ah78nHlxJXW5oxNg=;
        b=dQ3R/g528MrQEx9vJqZ5QKkmFWGj487uVD1LuSwrJAK6fiIumWoAkJJNvtEAafYpam
         H6cFNKDDIokkrj3I5OkSiFo6noDqhYOPkgeVSbzGQQGtNqsryRur7uYyVsh/LP/KSSJJ
         HEN92JteCU9EdB3z2u+3+YCSVvEzhrZ+Ov2SBk54NMbFL1oFmU12u/JJIw9Azvpgr88d
         lOYj1O65Ts3f37YprzXKm82r3vLq0XCR501W1hzqvMvrWS5f5YPBRau/5tbjEUwr4C9M
         MXH5mmIrBG2CT/uJSWnm2xbr6s1Y4hBS4mncILSNmaTAj4bdFw4sxeL0Xb1AXe1gWVnj
         hpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cvvah64uVrNYgN9R/PI2ihegm23ah78nHlxJXW5oxNg=;
        b=Ol8JnPu6lAZiHfCNLtwRiR1E4z+okKri5jwVtyj2CX2wQT0AlT0DT5PRYW+VkrSdtt
         F2ZrE7b61BX9+8NNDxKAmN6EMWprd5z9pMgg7D9uj1N+MwO6ESli4ym5521HgdrcIiYD
         yLsgruqN3fYcx2z0rqbZQ7h/CkFWcojhQihCVmi9LGztHnVxJ+OIQAEqo+jyovH/ll4b
         YYvYktOy2Ns+RKrWKprcPaYvqFlKwD7jSceT2DrDXy5FT4EFkCrnDFpkmDVO7qDexhly
         OkBPsohYP767N570LTvL3PXNHRT/rNDZULH1fKH1YTgkGdmcLwhgIsXOYv/rEPEgYCWJ
         G14Q==
X-Gm-Message-State: AG10YOTSvNI+tQtzJFkoUtkZYKaQWN9SA4Jrw84qfvTdL1nLhwEkzUDpAxgHzsfJx+bTjeNlklI+S/GE2zLFKcBC
X-Received: by 10.50.66.212 with SMTP id h20mr220934igt.43.1456427155512; Thu,
 25 Feb 2016 11:05:55 -0800 (PST)
Received: by 10.107.12.75 with HTTP; Thu, 25 Feb 2016 11:05:55 -0800 (PST)
In-Reply-To: <8e46e2f93895fb33421e7b09ccfe7de5@www.hilie.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287417>

On Thu, Feb 25, 2016 at 9:54 AM, Alter Depp <Alter.Depp@gmx.de> wrote:
> I would like to do a shallow clone of a submodule like this:
> $ git submodule add --branch master --single-branch --depth 5 repo dir
> but it doesn't work. I think '--single-branch' is not yet implemented for
> submodules.
>
> With the clone command it works:
> $ git clone --branch master --single-branch --depth 5 repo dir
>
> Is it possible to do something like this with a submodule?

Shallow submodules are not quite well supported.
Example:

    $ git clone --depth 2 --recurse-submodules <url>

the depth argument applies to the main repository,
and currently it is passed on to the submodules if any.

The '--depth 2' suggests that you can operate on
the 2 topmost revisions of the super project flawlessly,
so if the submodule pointer in the superproject is advanced
more than 2 commits between these 2 commits, you're missing
content.

So in this case you don't want to pass on the depth literally to
the submodule, but rather find out which commits are referenced
from the superproject and make sure those are included in the
submodule.


In your case of adding a submodule as a shallow repo,
this problem is not there.  However 'git sub add'
will eventually call 'git clone' to get that submodule and
'--single-branch' is implied by the existance of the '--depth'
argument there. See the man page of git clone for that.

So  'git submodule add --depth 5 <url>' should do what
you'd expect. Unfortunately you cannot specify
'--branch=master' though yet.

Stefan

>
> Stefan
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
