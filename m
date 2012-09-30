From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] git log --pretty=lua
Date: Sun, 30 Sep 2012 11:31:13 +0700
Message-ID: <CACsJy8AvC9=6owwzMByZq2Wv1P_YS5xCUXRHH_Lr4qHA1BXyRQ@mail.gmail.com>
References: <20120925002325.GA19560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 30 06:31:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIBC6-0002iK-NJ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 06:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab2I3Ebp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 00:31:45 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59503 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab2I3Ebo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 00:31:44 -0400
Received: by ieak13 with SMTP id k13so10072135iea.19
        for <git@vger.kernel.org>; Sat, 29 Sep 2012 21:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AqmHm2MZC6RQ0y4aupx32ec1Jh9Qb9FVR1tOZd8i3d0=;
        b=sUIVoX1N78FOy850wu077VmzLjRYasrTkqEg0P0B2CZ6vrieCOOGq8WeSs7kjlbWQe
         d10qpzJ8zXFpiYUt6GtMv+CnwANTr5qkI5CnImcZjArf9KFTN2nYRfHfiSGb55g0G0rB
         RKLg5CczjfhsMxoP+IKRAvNmeg0gDUy4isA6Xwr1h3XGqUViFwI2Ud9vk8A0B84OF7jl
         XwrTPXNgRzEHQ9IAy1R5b02CdFb70+GOwyPRFPFD7Js7q4U2+iOpYrk9dpS6OlGPOle9
         H2vHYZzYFYEWcYBa0mlg485MYXu+Az+6XH59mLh9bXCdcpnFoD7TLA35d6GYI0+DDYXD
         atxQ==
Received: by 10.50.207.33 with SMTP id lt1mr2552720igc.40.1348979503552; Sat,
 29 Sep 2012 21:31:43 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Sat, 29 Sep 2012 21:31:13 -0700 (PDT)
In-Reply-To: <20120925002325.GA19560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206665>

On Tue, Sep 25, 2012 at 7:23 AM, Jeff King <peff@peff.net> wrote:
> Why Lua? I don't especially like it as a language. But it's designed for
> this purpose, which makes it very lightweight and relatively simple to
> embed.

Another option is tcl. String-based approach feels more natural for
pretty.c and shell users. >=8.1 supports utf-8. We might be able to
share some routines between the embedded tcl interpreter and
gitk/git-gui. The drawback is we won't get the speed of luajit if we
ever need to (I'm looking at filter-branch, but I assume eliminating
fork() should already give decent speedup).
-- 
Duy
