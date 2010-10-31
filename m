From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add support in sample hook script for denying annotated
 tags.
Date: Sun, 31 Oct 2010 15:24:33 -0500
Message-ID: <20101031202433.GB21240@burratino>
References: <201010311457.17817.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Oct 31 21:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCeSR-0002dp-7u
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 21:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730Ab0JaUYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 16:24:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55975 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0JaUYo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 16:24:44 -0400
Received: by gwj21 with SMTP id 21so2815913gwj.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hicy7H830TQ70MZR7ZduaXACq//IBD6VizGTVGgSl9A=;
        b=an5Uaszsc7mZgWW6JerSWUOJgK+3wOLsa7nN3xcwsPT/xXnF2+erE0sUuuI13GBR+w
         537TIEefeICQtGI4PZ5+pTUMF52UmGgYnKX1Bkw6jFBwYy84emZC/KdLmXD+HutIIXHh
         1Vwze88J/Z84XdITPbSoTFZZxiFbeneazOOck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LwoOlL0gjgnqEdIKqcwgOxt/Efg+a10SsEkWKJVZQAq+NIQQpts9xM+GftA9MuG2UM
         k+0DkkCFZ75SUTit6UPpndVomwcu4tV+18H2JP0DlyOAWX+nerAu1xfrRp5ho2/z1clZ
         YwNsbRpzzgKQy9wr4Vzb+IoT/nJODA0Ki56PY=
Received: by 10.151.48.13 with SMTP id a13mr26706955ybk.55.1288556683935;
        Sun, 31 Oct 2010 13:24:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id y21sm4384407yhc.14.2010.10.31.13.24.41
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 13:24:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010311457.17817.bss@iguanasuicide.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160450>

Hi,

Boyd Stephen Smith Jr. wrote:

> Signed-off-by: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
> ---
>  templates/hooks--update.sample |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> In one project I'm in we are using a centralized Git repository that many 
> developers have access to.  As such, we want to prevent tags from being 
> created by push operations and have them created by the administrators.
> 
> This is a modification to the sample update hook to allow this to simply be 
> a configuration option.

This kind of justification belongs above the "---", I think.

No opinion on the functionality itself.  Just:

> --- a/templates/hooks--update.sample
> +++ b/templates/hooks--update.sample
> @@ -7,6 +7,9 @@
>  #
>  # Config
>  # ------
> +# hooks.allowannotated
> +#   This boolean sets whether annotated tags will be allowed into the
> +#   repository.  By default they won't be.

hooks.denyannotated (defaulting to false) would be more consistent
with hooks.denycreatebranch, no?

Or maybe hooks.denycreatetag --- a situation in which unannotated
tags should be allowed but annotated denied seems hard to imagine.

Hope that helps,
Jonathan
