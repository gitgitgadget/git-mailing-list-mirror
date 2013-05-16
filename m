From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCHv2 04/10] remote: Reject remote names containing '/'
Date: Thu, 16 May 2013 15:18:37 +0530
Message-ID: <CALkWK0k=P265MCmvj9C7MFiF=tkhCZ__3oF8FWmWd4sNx3VcTw@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
 <1368289280-30337-5-git-send-email-johan@herland.net> <7vtxm7scn5.fsf@alter.siamese.dyndns.org>
 <CALKQrgcry9bwmonaeWA4M7a3k36S_Q3ZQLmv7Ui5r+tdzdMr_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu May 16 11:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuoS-0005Un-5N
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab3EPJtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:49:22 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:62943 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3EPJtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:49:19 -0400
Received: by mail-ia0-f177.google.com with SMTP id z13so3308087iaz.36
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RAga6wAKBb+MU4X7k9fX/hg9+xGTLy7N31E4VLngrRU=;
        b=K8izB7Cj7IgoRaXx29icebJXN+Ff6xpW2SNRx02lHq432B8eO3/C2IKnDyj50V4Cln
         Vj1Ys5ks3aRZZUprWvy864JWBFEC4UBcBO8xovWz8MTWp3xNVEiniI8vBJGWi8tggPrF
         Z5KEdvhy/PO12YC3FAD/4fUANg2e+fVShq/QTSofeLdq2ndR2SdfJHQ31xtwbvKFz4mI
         2QkI2xRS94wl8b+fDPqvBGgmwRByhW96WbTPF8DDZK/RdDbfR0q9Sn9OrIPVjzRupY+E
         ZOSiaQPf87mT397FuPomMvRgQEc6l3AgCuzHunrrx86EOcVTC0uYAdfajsmFnoX41h1C
         KO8w==
X-Received: by 10.50.128.44 with SMTP id nl12mr8577673igb.0.1368697759248;
 Thu, 16 May 2013 02:49:19 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 02:48:37 -0700 (PDT)
In-Reply-To: <CALKQrgcry9bwmonaeWA4M7a3k36S_Q3ZQLmv7Ui5r+tdzdMr_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224527>

Johan Herland wrote:
> The disambiguation can probably be resolved, although the resulting
> code will obviously be somewhat more cumbersome and ugly (and IMHO the
> current code is plenty of that already...). Combine this with the
> problems of clobbering of the same remote-tracking ref (describe
> above), and the fact that AFAIK a multi-level remote name has never
> been observed "in the wild" (none of the people I asked at the Git
> Merge conference had ever observed multi-level remote names, nor did
> they directly oppose banning them), I'm not at all sure it's worth
> bothering about this at all. Simply disallowing multi-level remote
> names seems like the simpler and naturally ambiguity-resistant
> approach.

The problem with multi-level remote names is that we use the same
delimiter as in the ref namespace: '/'.  So, obviously, there's a lot
of room for confusion.  I wonder if we should banish multi-level
remotes altogether though: is it possible that they will be useful to
someone in the future?
