From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: subtree merge tries to merge into wrong directory
Date: Thu, 10 Dec 2009 09:38:13 -0500
Message-ID: <32541b130912100638v1f701183w909367cd97c8325@mail.gmail.com>
References: <4B206DCF.90202@naderman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Nils Adermann <naderman@naderman.de>
X-From: git-owner@vger.kernel.org Thu Dec 10 15:38:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIkAB-0003HG-1L
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 15:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbZLJOi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 09:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbZLJOi1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 09:38:27 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:64471 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbZLJOi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 09:38:26 -0500
Received: by gxk4 with SMTP id 4so12376388gxk.8
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 06:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=A/tcCjDrz6vjth2ciaBDYqqjAqKqlc0xTwZRgQkATHM=;
        b=bib9Mv0MbPA8PKwxqhmHdUOIdjHhnTwKdkj+MgKS/sx3ByDRUkH+rwTwRS08XwdR5A
         le5GqkMgbovufGvtd4Cr7CothEnXGoXls4u5bQRwRGgtutfG4N0aXzQKYPpqJInSFleQ
         /CA1cqtCLFJMl+TRyaaAoSL6JQbXLPLXx4NMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GIFkmlESk7icmnEOdSTOpzhaI8b7GIDxb4VVINw+aA4v2XcIR1nXJrkTpc3yofmqyA
         qJ/j6edqzWmUnmGOC13D5UjGmqYmPukXmZjHR+4SslRt6jMPrQ6qmyenUJ1uOfhjmWtV
         jYtz/5r0snEkR659MXzqy8ZVH08CIU27m5LKA=
Received: by 10.150.19.5 with SMTP id 5mr308788ybs.103.1260455913109; Thu, 10 
	Dec 2009 06:38:33 -0800 (PST)
In-Reply-To: <4B206DCF.90202@naderman.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135033>

On Wed, Dec 9, 2009 at 10:41 PM, Nils Adermann <naderman@naderman.de> wrote:
> Following
> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html
> I have subtree merged a 3rd party library (ezc-reflection) into my
> repository (pflow). The prefix I used was lib/ezc/trunk/Reflection. Now
> there have been changes to ezc-reflection but merging them into my
> repository fails. The merge is attempted in example/ rather than
> lib/ezc/trunk/Reflection.

The auto-guessing feature of "merge -s subtree" doesn't always work.
The 'pu' branch of git has some patches which allow you to use a
command line like

    git merge -Xsubtree=lib/ezc/trunk/Reflection

If you're nervous about using all of 'pu', try building git's 'master'
after merging from commit 0354b06927a1220b696a5ee1004a8f061ba9b153.

Eventually my git-subtree tool will use this automatically, but it's
obviously not much use until the patches hit a released version of
git.

Hope this helps.

Avery
