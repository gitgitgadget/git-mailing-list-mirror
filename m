From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Mon, 25 Mar 2013 22:31:04 +0700
Message-ID: <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
References: <20130324183133.GA11200@sigill.intra.peff.net> <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net> <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff Mitchell <jeffrey.mitchell@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 16:32:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK9NV-0003j4-7L
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 16:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757976Ab3CYPbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 11:31:37 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:44547 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757434Ab3CYPbh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 11:31:37 -0400
Received: by mail-oa0-f45.google.com with SMTP id o6so6447690oag.4
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TLa/Ygj0Q8q484pak3u7uUGrokrCt3Jyk92AaGh4NK4=;
        b=VuQJhX3cw4V8heR7jsWgS6mVpH7DsJywDYHI64d/KQHMwMERKIk4wRGxv3rgSArkXS
         PLzeJ6brCh0UYp4c66KJpbj/FFH8TfZz70L96dZiwEtkCYSxHWUWKtsLnBNpOI+9HL+V
         rkOB//Adz8uMKmLw8rNHN+1gh6Gm/YKhecDbz5VWhFmPTD1shIvUJS+Qtm9VdTpBgts4
         nc2zHSBDqyk6Lb9WFf5SiOWWVCMGrvNmHNz7pXBk65FEYpV2bFwiKAvHQ54Fpvrz6C1s
         yYoU36XCF0DsT+vjKOa6Nibju1cDMmsLlNA7Tg0/0BoYWf4qCZ63/9MHCPeVKOjv2EvK
         mdjQ==
X-Received: by 10.60.8.197 with SMTP id t5mr12028782oea.4.1364225494348; Mon,
 25 Mar 2013 08:31:34 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 25 Mar 2013 08:31:04 -0700 (PDT)
In-Reply-To: <20130325145644.GA16576@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219035>

On Mon, Mar 25, 2013 at 9:56 PM, Jeff King <peff@peff.net> wrote:
> There are basically three levels of transport that can be used on a
> local machine:
>
>   1. Hard-linking (very fast, no redundancy).
>
>   2. Byte-for-byte copy (medium speed, makes a separate copy of the
>      data, but does not check the integrity of the original).
>
>   3. Regular git transport, creating a pack (slowest, but should include
>      redundancy checks).
>
> Using --no-hardlinks turns off (1), but leaves (2) as an option.  I
> think the documentation in "git clone" could use some improvement in
> that area.

Not only git-clone. How git-fetch and git-push verify the new pack
should also be documented. I don't think many people outside the
contributor circle know what is done (and maybe how) when data is
received from outside.
-- 
Duy
