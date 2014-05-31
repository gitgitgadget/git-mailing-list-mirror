From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] t5538: move http push tests out to t5542
Date: Sat, 31 May 2014 08:03:32 +0700
Message-ID: <CACsJy8B22uypM3-Zt-1NP0ZxfZ242fBnHR0rHmt-xg7yG30+Aw@mail.gmail.com>
References: <87y4xk8asq.fsf@spindle.srvr.nix> <20140530010649.GD28683@sigill.intra.peff.net>
 <20140530013419.GE28683@sigill.intra.peff.net> <87lhtj8sqx.fsf_-_@spindle.srvr.nix>
 <20140530172051.GB25443@sigill.intra.peff.net> <20140530173621.GD25443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nix <nix@esperi.org.uk>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 31 03:04:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqXiZ-0002Yo-9o
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 03:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbaEaBEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 21:04:05 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:52075 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbaEaBEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 21:04:04 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so7554172qgd.27
        for <git@vger.kernel.org>; Fri, 30 May 2014 18:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3jLC5NLXs38nrOjMNm9Yrx9DRxICqF/65v6YZJD/508=;
        b=pCe3m4ZKrsugQSloN/myCHgHVyHBQfAGOmAej0o0nT2tuaxm9NnffQ9krmnhaXNqUN
         MkQrGD6AtiR+0L3XbpKZNeakKRN+2edKyxRfdEFWTn6+oq0ZMwS7cD1YZ3D4OLJ7iygs
         u5kDqVofWQZmJEk8eoa0kdPxM+4EDBWfE7UYlbv98rHAKlvRUXUJZI5zmRJpOs3RFrMf
         v5ZBDpDBsC7zzDRqJ7fSIrNlk33iHXMvXmplI73juoCDcWNa3e4kuz6yBb+2dP4LRqb7
         2ggWjzQbgtXQ+9imzuKdk9RRcDzMBWE4qprxQXacR/8Jz/VpOSeaWjxlq1Ygk1tawkEp
         tt4w==
X-Received: by 10.229.220.197 with SMTP id hz5mr26580009qcb.9.1401498243077;
 Fri, 30 May 2014 18:04:03 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Fri, 30 May 2014 18:03:32 -0700 (PDT)
In-Reply-To: <20140530173621.GD25443@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250496>

On Sat, May 31, 2014 at 12:36 AM, Jeff King <peff@peff.net> wrote:
> From: Nick Alcock <nick.alcock@oracle.com>
>
> As 0232852b, but for the push tests instead: this avoids a start_httpd
> in the middle of the file, which fails under GIT_TEST_HTTPD=false.
>
> Note that we have to munge the test in a few ways while
> moving it:
>
>   1. We drop the `test -z "$GIT_TEST_HTTPD"` check; this is
>      too simplistic since 83d842d, and we should let
>      lib-httpd.sh handle it.
>
>   2. We have to port over some of the old setup from t5538.
>
>   3. In the final test, we no longer expect the extra commit
>      "1" built on top of "4". This was a side effect from an
>      earlier test in t5538 which was not ported over.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Here it is with the fixups I suggested in the last email. This passes
> for me, but I'd love to have a sanity check from Duy.

Looks good.
-- 
Duy
