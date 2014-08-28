From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] teach fast-export an --anonymize option
Date: Thu, 28 Aug 2014 17:30:44 +0700
Message-ID: <CACsJy8B3gFC7kLf-cLhAk3BgQ+v427rMXWHTqjU4LYP3NQte7Q@mail.gmail.com>
References: <20140827165854.GC1432@peff.net> <20140827170127.GA6138@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 12:31:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMwzB-0001Sb-0X
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 12:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936489AbaH1KbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 06:31:16 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:50658 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934654AbaH1KbP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 06:31:15 -0400
Received: by mail-ig0-f169.google.com with SMTP id r2so312460igi.4
        for <git@vger.kernel.org>; Thu, 28 Aug 2014 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jYs4a5Id8GgHh12L3U6o+kOqVEBB3m4AV8x7ndOpjSo=;
        b=EnIcybSOCHlix+DaBIxz3ZsYzyuQdnrSheOK7o/MYWMd1zcdwHy8nXWQtXdvyS4UXw
         ZOv1rn3Zc2s/zYEbEFNrjSeEprntwEVEOnsAIUDQfbc4+HoGgSSHJYAhbAgHrCxtVBqs
         yYuIRU4gZ9ik7clO9YzQEFP0sxqw/y+DvuRYbxpDXDFtNoEMZoRVVkYAfThsT4fhAfAP
         wbKgP/PxfAvXCVc66zh7Xr6QQ6BihVcRngq4HXiyGHk26GLjzFi/mivrCmUZzFbGNVFq
         DaoBmHXhQhF5nf4+8ex6AXm7yAibbWSzVVeFF4UzcX8JYHMKm6EkFGziWR/P0iA/ublH
         NGPA==
X-Received: by 10.42.216.198 with SMTP id hj6mr3412847icb.65.1409221875084;
 Thu, 28 Aug 2014 03:31:15 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Thu, 28 Aug 2014 03:30:44 -0700 (PDT)
In-Reply-To: <20140827170127.GA6138@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256077>

On Thu, Aug 28, 2014 at 12:01 AM, Jeff King <peff@peff.net> wrote:
> You can get an overview of what will be shared
> by running a command like:
>
>   git fast-export --anonymize --all |
>   perl -pe 's/\d+/X/g' |
>   sort -u |
>   less
>
> which will show every unique line we generate, modulo any
> numbers (each anonymized token is assigned a number, like
> "User 0", and we replace it consistently in the output).

I feel like this should be part of git-fast-export.txt, just to
increase the user's confidence in the tool (and I don't expect most
users to read this commit message).
-- 
Duy
