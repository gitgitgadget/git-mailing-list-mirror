From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] commit: search author pattern against mailmap
Date: Sun, 25 Aug 2013 22:42:34 +0200
Message-ID: <CALWbr2xRZzwUKUFZ=v21h6h1c13Hk8V2VgMQiQwjxvdKQ=CcDA@mail.gmail.com>
References: <xmqqob8ml588.fsf@gitster.dls.corp.google.com>
	<1377424889-15399-1-git-send-email-apelisse@gmail.com>
	<20130825103041.GB12556@sigill.intra.peff.net>
	<CALWbr2zfpZYGri9aGL3DGhadnYF=0xx_h95ZjN7S4beoAES68A@mail.gmail.com>
	<20130825165153.GC21092@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 25 22:42:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDh91-00030b-4I
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 22:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756627Ab3HYUmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 16:42:36 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:43345 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab3HYUmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 16:42:35 -0400
Received: by mail-qa0-f44.google.com with SMTP id w8so273836qac.17
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gT0Krm8uFM2+Y/uEf9c+lr6Rb1fOqtpnrJ1isiSf4PE=;
        b=GQiX98emT2Pz6h6V3wie/agRDUOuJOpjw9qkLOpQIKXtlzQUarRsNSFpbHYQ0VPgI8
         aWSK9maMdKKM2kY0VL6E4DExP8VCK/7dpatD2Ox85RAOSVzc5GQ6eIs63Li/SEx4ih/Z
         bkkBhstLVIGmbcn+4YMK5aSnf/O6OnWCcUzYD5uYBPg9+JXby32NWg/+9N78zSKdO9oG
         B8hwQZo0cZix9dlFiL5tF0STzBVsSLFX+j8fG+L84WkUuXUx+ztVX3132bMcTLMhMRbp
         +purFgGwpIbwiVsoYGpZWCLWdv7B/O6ObpDnCgIolAr7850THV8DSNaIxcFgO48KOrHE
         qD7Q==
X-Received: by 10.49.97.134 with SMTP id ea6mr6238969qeb.34.1377463354933;
 Sun, 25 Aug 2013 13:42:34 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Sun, 25 Aug 2013 13:42:34 -0700 (PDT)
In-Reply-To: <20130825165153.GC21092@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232968>

On Sun, Aug 25, 2013 at 6:51 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 25, 2013 at 03:37:24PM +0200, Antoine Pelisse wrote:
>
>> So we would stop passing mailmap string_list along down to map_user(),
>> and the mailmap file (or blob) would be read the first time it's
>> needed, and stored in a static global variable in mailmap.c. I think
>> I'm OK with that because I don't think it would make sense to have
>> multiple instances of a mailmap string_list in the same git-command
>> instance.
>
> Exactly. Sample (largely untested) patch is below if you want to use it
> as a starting point. There are probably a few additional cleanups on top
> (e.g., "git log" understands "--mailmap", which should probably be
> centralized to handle_revision_opt).

I'm not exactly sure how I would improve the patch you sent. I
remember Junio was not willing to move --use-mailmap option to
revision options and wanted to keep it just for "log" (though I don't
have a reference to that email).

I've tested the patch against the test-suite and have given a thorough
read to it, and I think it's fine.

Would you mind sending it as a proper patch ? I have nothing to add,
and I'm terrible at writing commit messages :-/
Or maybe someone else's opinion would be nice. I'm still not convinced
this is even necessary.

Thanks !
