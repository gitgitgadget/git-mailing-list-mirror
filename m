From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git blame and cherry-picking
Date: Thu, 7 Aug 2008 13:53:26 -0400
Message-ID: <32541b130808071053g5fd0ce4u24d28263f38e0207@mail.gmail.com>
References: <91A979F0-1329-4CA6-AADC-6CF55872B57A@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Users List" <git@vger.kernel.org>
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 19:54:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR9h1-0000ok-DJ
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 19:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbYHGRx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 13:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYHGRx2
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 13:53:28 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:33664 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbYHGRx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 13:53:28 -0400
Received: by qw-out-2122.google.com with SMTP id 3so53362qwe.37
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mhbvj6bL1DsqUSR5mS+vykHAUJ67nPknrpMAOwmEJaw=;
        b=m7Hr50rFZuUDn6xq5Dmxob4UqZPkazoA6MZMn9sjPzCgrEu6xFmvy9Uxc+lrGpe8KX
         hlKNhHQFpuPINrAoIm7ua0MmGXSNd7/r8aUiocv/RdsaH2adKBOzmX1q97z2m1+QydRh
         fDpa6RWKFTHAPDnmduLkqkwCEJZde5j9hQRO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XO0P0ivwo9/eNFGma0yxjrRWxO3XHo8Zx3S2gVWOcnU1mlnVB6w7YFv0pQNFZde4Qp
         Kq6ANx9BQ1Rs5WW8zIZQC/9EUX4iofRzysuBNO/UUlT34H4zbuG4pDAxKoR2y+dI4CVi
         o6N0h8fNAO0SklN3eLRBJBuHXq45nyQt5zdW4=
Received: by 10.151.48.20 with SMTP id a20mr5721195ybk.127.1218131607046;
        Thu, 07 Aug 2008 10:53:27 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Thu, 7 Aug 2008 10:53:26 -0700 (PDT)
In-Reply-To: <91A979F0-1329-4CA6-AADC-6CF55872B57A@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91592>

On 8/6/08, Steven Grimm <koreth@midwinter.com> wrote:
> What, if any, is the approved way to get git blame to follow cherry-picked
> changes? Right now blame is good about showing you the actual responsible
> revision and author in the case of merges, but if you cherry-pick a change
> with "-n" (to test before committing), the modifications are attributed to
> the person who did the cherry-pick instead of the cherry-picked revision's
> author. Even without the "-n" option, the changes are attributed to the
> cherry-pick *revision* instead of the original one.

It sounds like you at least want to avoid using "-n", if it really
does lose author information that way.  If the patch doesn't work, you
can always "git commit --amend" or "git reset --hard HEAD^".

I don't think tracing through to the original revision is useful
anyway; nothing you'd find through the original commit would be
relevant to git blame, AFAICS, since none of those other patches were
applied to the branch you're looking at.

Have fun,

Avery
