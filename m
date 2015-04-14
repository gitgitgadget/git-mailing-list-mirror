From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git fsck: unreachable vs. dangling
Date: Tue, 14 Apr 2015 10:58:39 +0200
Message-ID: <CAHGBnuPepR11r9qpxb2G7pGhq0iiaqCCLnbt5NB_xohHi=cVxA@mail.gmail.com>
References: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com>
	<CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>
	<552CD4C8.2020700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 10:58:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhwgB-0000Mv-7I
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 10:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbbDNI6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 04:58:43 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33061 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbDNI6k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 04:58:40 -0400
Received: by igbpi8 with SMTP id pi8so43180019igb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VFyoFw7DiHZr7pfFJPOWkk8jYoHXkf3kYKrP4bHC83k=;
        b=odYYKRi8aTtCVf4AsuZXJOGnFA97dSrCCSRagfTlv9uu1DUtZCRXIL1tEM7NUAW35p
         2jybrF+jKomrtC00ZAm/dCgzPzQIUDU2H96AT75iuPUKqWATd7KG25F5f6j0y4GfeBHp
         2VB3QV5Vq3h8vRn9FQcQ7uhUv7ieHr33gFayTQh4V6a8fz3rf9MVRRzZdRmjrXN6k8hp
         R/rAwCnEsBROlfbckzMTgTof7ceLhh5t3luIzVHM2O8xuscfOmLTfPW1WUoUapwKhQdw
         nzwd6x4FZVqcFbdneetIyFnSxRjGw1U5qmC4NSaf/8XWZdy0W9ODl6L6SZ4epJu9u3Pl
         oHhw==
X-Received: by 10.42.86.12 with SMTP id s12mr24163217icl.47.1429001919991;
 Tue, 14 Apr 2015 01:58:39 -0700 (PDT)
Received: by 10.107.159.82 with HTTP; Tue, 14 Apr 2015 01:58:39 -0700 (PDT)
In-Reply-To: <552CD4C8.2020700@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267124>

On Tue, Apr 14, 2015 at 10:50 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> "to dangle" means "to hang loosely".
>
> So, in the description above, "A^ dangles from A loosely" because it
> hangs from A (you can reach it from A) but loosely, because it would
> "drop" if A gets dropped and A is "likely" to be dropped (because it is
> unreachable by refs). But A^ is not dangling in our terminology.
>
> If you *reverse the arrows*, i.e. consider A^ pointing to A, it becomes
> more apparent that A is dangling: it is an unreferenced leaf node.

That's exactly what confused me. In the very literal sense, something
can only "hang loosely", i.e. dangle, if it's only tied at *one* end,
and that's the case for A (which is only connected to A^) but not for
A^ (which is connected to its parent, and A). Especially when talking
about A as a "leaf" node, like in the leaf of a natural tree, I would
think that A is dangling.

-- 
Sebastian Schuberth
