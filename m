From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Wed, 23 Mar 2016 16:47:21 -0700
Message-ID: <CA+55aFxBhTK0sa9qfXus3+ct7gZ+BV1aODF7xawQF3crQYYGJQ@mail.gmail.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
	<1458775426-2215-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 00:47:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aisV1-0007Cb-1K
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 00:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbcCWXrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 19:47:25 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33071 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbcCWXrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 19:47:22 -0400
Received: by mail-io0-f194.google.com with SMTP id v187so7687836ioe.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=2ilgFEKoL5wM8DMZ2MlExomsJy6zu3vdr+JSGbS3lnQ=;
        b=XceZ1GqpFO1ApCWueAePLwTtkyivaE+HvDpeejvEIZ6dSoWMefHt4dfFg/WHY4oBnM
         QNJ1Eh8QaiQURpgwcoNbXK8RZih+/9h325N8d2s31WQvnY4M6+M842gYPeIfVnCtMCWk
         PpaAWyPLil/iLwH99KaVXDCclAvciYeLUagyCaMHAt368+m7wKeYrc6M/Y57T5fliZp0
         1YazbOlIMnpE861v3a1bUf6ea3fLdbVHUp3Hs53SCp6V3/ucO9mYyfzYMScmU3rR6LoF
         KlJBJ/CMZ8uRzd1zS7eKV6yLSI/37CCQjfuaoNh2ZXThUma3vAQdXDe9vzctZmA01w0Q
         wrgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=2ilgFEKoL5wM8DMZ2MlExomsJy6zu3vdr+JSGbS3lnQ=;
        b=M+F0tgTTgEfl+rnMSAUK8VfD20E7UaEDMsJft4KRBXXxbP1XD2QHYMmUiaNMpvPjGl
         5fmibFc8o14WTnoBKNlxJrQM9Paxk7P28WdVYO0IO1ZcG5aV85ZQDZ01gC5fUI4yUa7I
         BU+pXEEJda9T4EnX0OJ8R7Zz1F3hp4puPvsQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2ilgFEKoL5wM8DMZ2MlExomsJy6zu3vdr+JSGbS3lnQ=;
        b=GDHyTmT0vAiEypUrkQqQdClEAyyudKwF/+tEsIjd9PRvjwcqrETyKAIzvAtLnIt3Jt
         V96jXZTjVebeI569lHL9QqFieTMCOYK+1KvGl8S0Y7FbPyDHOIvWCP0h9a8X9RudXABK
         +zBEYkHqWXmJWC9t4YQt+TvyLE2QTdnX3PWsZZ34BJME7C8VWUGJiVgNXbgRREHIEUYJ
         CHRM6916aZPLKMP2nxIEKSGjBtCeOECv7j0wvHnLk/kz1WwB94jrCADDxCMCN1RUAj8t
         mlMn2O4dz6U9reTZUfDGQlbme+vZ2+5fz3ARhKBpp90djrBXMoq78puUR8cG3Qy9mKqY
         ZJwg==
X-Gm-Message-State: AD7BkJLUBC4UZYrJ94M5HEL3/Qpa81IIqyPd0FmCRd5ZUF0MVjmSojnAesjHClCpKINcSAp3C3uz2lnvhkCF6A==
X-Received: by 10.107.5.2 with SMTP id 2mr6112457iof.89.1458776841185; Wed, 23
 Mar 2016 16:47:21 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Wed, 23 Mar 2016 16:47:21 -0700 (PDT)
In-Reply-To: <1458775426-2215-1-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: 78mrtAgyr1rDYfV3uSVzynIYMFY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289701>

On Wed, Mar 23, 2016 at 4:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> So here is the third try (previous round is found at $gmane/289166
> and the very first one is at $gmane/288987).
>
> The first three patches are essentially the same as v2.  The last
> two updates how the tab-expansion is internally controlled:

I tested this (as it in in 'pu', rather than applying the patches),
and it all seems to work fine. So Ack.

And I agree that it would be good if all the commit printout logic was
unified rather than having some ad-hoc "let's just set the format",
but I think that's a separate cleanup.

It might be more regular to have that "--expand-tabs" flag too (which
would then work with the email and raw formats), but I don't see any
actual real use for it so it really doesn't matter.

          Linus
