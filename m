From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Sat, 13 Jun 2009 08:13:55 +0100
Message-ID: <e5bfff550906130013j3a9802cen48ac5828a2357bf1@mail.gmail.com>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 13 09:14:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFNRP-0006m4-U2
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 09:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbZFMHN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 03:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758168AbZFMHNz
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 03:13:55 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:41764 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759783AbZFMHNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 03:13:54 -0400
Received: by ewy6 with SMTP id 6so3587980ewy.37
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jX+dRPvcniklMNy0ztKCGF/3VPDIRGhTGLVghwvf+SA=;
        b=iLpHbmmHZawP2LCd6rW+CtLgg9daM7R8zGSyXPtMBqMQpRX9xvEDOhgjlXkeZm5iG2
         CNfPyS+Ya99pI5itEZrtjGYWPEwYqk/hdbJsOKi1ztlbIkKX/wxAjo7aoN69Na9TufwG
         DAW/wUifNRzdokeap0orO3g6oioyctR06WVSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HBTvVuTa/Bwa5qSvu4aitZ9f6Xyyp6EFMbSN+ySmrWDYz28CWTKvOWrCwlS4FU5aDX
         9CVn1ZYE4wQLLqtZUDyKJgFGSDawDwXbFZ20h2kNyI40FFJOCa7dycgNKAu5gw+PVe5n
         vE9mfQi030GdCYwvc2UcR5HNBGX5qq4xdFbsg=
Received: by 10.216.71.83 with SMTP id q61mr1629420wed.14.1244877235402; Sat, 
	13 Jun 2009 00:13:55 -0700 (PDT)
In-Reply-To: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121483>

On Sat, Jun 13, 2009 at 00:29, Markus
Heidelberg<markus.heidelberg@web.de> wrote:
> Creating a patch series didn't work, because the SHA1 list was
> interpreted in the wrong order.
>
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---

I think they are generated in apply order as should be.

As example, from git repo we have the following revisions:

GIT 1.6.3
t4029: use sh instead of bash
t4200: convert sed expression which operates on non-text file to perl
t4200: remove two unnecessary lines

Now if I select the 4 revisions and use "Save patch..." I have

0001-t4200-remove-two-unnecessary-lines.patch
0002-t4200-convert-sed-expression-which-operates-on-non.patch
0003-t4029-use-sh-instead-of-bash.patch
0004-GIT-1.6.3.patch

That is correct because if I go to apply the patches I have to apply
in the reverse cronological order, from the oldest to the newest.
