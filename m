From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] rev-parse: Allow @{U} as a synonym for @{u}
Date: Thu, 18 Aug 2011 08:53:29 +0700
Message-ID: <CACsJy8CX7X3u4i_kXChVHkFK=Q--pRBrxmdvjxrF7wr5_SyakA@mail.gmail.com>
References: <CAMK1S_hZkdXiQb_UTB=snLAXPmo5yrCnFaQFHZqYq5AXqOgWng@mail.gmail.com>
 <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com> <7vhb5fd4zy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 03:54:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtroB-0001Dt-Nn
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 03:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab1HRByD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 21:54:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44888 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155Ab1HRByA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 21:54:00 -0400
Received: by bke11 with SMTP id 11so1114338bke.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 18:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xXA3CdjCfMtuMhzaH5wvPqTHdVuF2nMzv9Owkki6qz8=;
        b=JsI4g9odFH9I3qcFNIGW/0rCfnqXrzo/Yrl2Ci0ApMsrI3Qurg1bNI42M1RbOBe3rq
         WFfht6RuYlMgPKLuR1231b3td6K2FvCzJ0Z/KWyMfxoLBcBAlM9M+8Um24N+goOuRDxC
         GOeWHmZ/pu4DPSD3ejsc/Xr+HRV8S2cRchSyY=
Received: by 10.204.166.2 with SMTP id k2mr53168bky.123.1313632439284; Wed, 17
 Aug 2011 18:53:59 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Wed, 17 Aug 2011 18:53:29 -0700 (PDT)
In-Reply-To: <7vhb5fd4zy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179551>

On Thu, Aug 18, 2011 at 5:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Letting u/upstream spelled case-insensitively does improve consistency
> among the above, but at the same time if we ever wanted to enhance @{...}
> notation even further in the future, we are restricted to a payload that
> is case insensitive to retain the consistency.
>
> The only remotely semi-plausible enhancement I could think of is perhaps
> to allow @{/regexp} to find a reflog entry that matches the given pattern,
> and in such a use case we would certainly want to take the pattern in a
> case sensitive way. This change closes the door to that, and that is the
> only downside I can think of right now.
>
> I hate to declare that we will never support such a feature with this
> change, but at the same time, I do not think I would need such a feature
> that often. But for that matter, I do not think I would miss @{UpStREAM},
> either, and that takes me back to "Meh" for this change.
>
> What do people think?

The itch is probably because people have to release shift, then press
shift again to type "@{u}". How about allow case insensitive match if
there's only _one_ letter inside @{}?

That would solve the shift problem while leaving door for @{...} extension.
-- 
Duy
