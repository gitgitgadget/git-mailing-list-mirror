From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] fetch: verify we have everything we need before
 updating our ref
Date: Fri, 2 Sep 2011 10:55:33 +0700
Message-ID: <CACsJy8C4qX=p6d1v+i7TJanACOqL9R6-pv9AOaU_CM6DNjJfyQ@mail.gmail.com>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org> <1314917015-3587-1-git-send-email-gitster@pobox.com>
 <1314917015-3587-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 05:56:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzKrc-0004y3-9v
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 05:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab1IBD4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 23:56:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55272 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757Ab1IBD4F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 23:56:05 -0400
Received: by bke11 with SMTP id 11so2318689bke.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 20:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lW7HrohQ4m9fBh2JkxkYAgtwd6aXO/XP0X0xA6B3c98=;
        b=nbK8AeXIEvKuL08naTJeq6mOcP0XqhcD0drvJumYELiuMk1RA2tJk/YidliFPHpAGG
         9zRrhWOnOYRDfasPoX30H2tAU+AFAwJdLZIpRe2TH0qAcIIwa/4q2+DYLLO0KNBmXfOx
         BnkfNvKgV3FX1lM+swZNlh/zfmUtNeMY75mDQ=
Received: by 10.204.135.18 with SMTP id l18mr299528bkt.341.1314935763525; Thu,
 01 Sep 2011 20:56:03 -0700 (PDT)
Received: by 10.204.7.138 with HTTP; Thu, 1 Sep 2011 20:55:33 -0700 (PDT)
In-Reply-To: <1314917015-3587-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180594>

On Fri, Sep 2, 2011 at 5:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The "git fetch" command works in two phases. The remote side tells us what
> objects are at the tip of the refs we are fetching from, and transfers the
> objects missing from our side. After storing the objects in our repository,
> we update our remote tracking branches to point at the updated tips of the
> refs.
>
> A broken or malicious remote side could send a perfectly well-formed pack
> data during the object transfer phase, but there is no guarantee that the
> given data actually fill the gap between the objects we originally had and
> the refs we are updating to.

What about receive-pack? Does it have the same breakage?
-- 
Duy
