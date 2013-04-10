From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Wed, 10 Apr 2013 14:22:44 -0700
Message-ID: <CAGdFq_iUEg8gxgDXvKsEW=M=hW0CmO7yZURd82s5fW+rOiBMrg@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net> <20130410211552.GA3256@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:23:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2UM-0006gp-Cj
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab3DJVX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:23:26 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53709 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab3DJVXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:23:25 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so1195775iec.27
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BoKZTwz2aLviEYmKrgEVkSXpX9AUujK4yF6m0a9ROkM=;
        b=EQ06mrmfK/m53sozFjNUlM4/PCNVwpAR7+PwMO1V5SGRC9Rg2VzEh/HYZhCL0QUhKC
         9N5J5jIq8P5QxCJok8hBvAEcl4t3i3odKBIaH8cwkhj63P+Hgo02KNd06+QP03qC+E92
         f9H0NyRd/T3HluyywKpgPDmuDvpPrPgC1ZmflUkuufHVTq0niJwjXCfrngmoBtFp1CKr
         WMb6Bqfjxy2k7OFwZlWXDll6nEeVC0jmKm3yBAGHl/fdcOj30dxYuow0/txm3mO5MJNm
         cQJWscfRIGufKCbbsO94K4AM5zHduzqCnA1V8FJlTrcRRKZ9EbRelQDitb3uf1RvC6EP
         GXPg==
X-Received: by 10.42.155.66 with SMTP id t2mr535011icw.10.1365629004934; Wed,
 10 Apr 2013 14:23:24 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Wed, 10 Apr 2013 14:22:44 -0700 (PDT)
In-Reply-To: <20130410211552.GA3256@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220770>

On Wed, Apr 10, 2013 at 2:15 PM, Jeff King <peff@peff.net> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> If a push fails because the remote-helper died (with
> fast-export), the user does not see any error message. We do
> correctly die with a failed exit code, as we notice that the
> helper has died while reading back the ref status from the
> helper. However, we don't print any message.  This is OK if
> the helper itself printed a useful error message, but we
> cannot count on that; let's let the user know that the
> helper failed.
>
> In the long run, it may make more sense to propagate the
> error back up to push, so that it can present the usual
> status table and give a nicer message. But this is a much
> simpler fix that can help immediately.
>
> While we're adding tests, let's also confirm that the
> remote-helper dying is also detect when importing refs. We
> currently do so robustly when the helper uses the "done"
> feature (and that is what we test).  We cannot do so
> reliably when the helper does not use the "done" feature,
> but it is not even worth testing; the right solution is for
> the helper to start using "done".
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>

The fixes you made to this patch make a lot of sense, glad to not have
a 'sleep 1' in our tests.

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

--
Cheers,

Sverre Rabbelier
