From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] fetch: silence git-gc if --quiet is given
Date: Fri, 15 Aug 2014 19:09:55 +0700
Message-ID: <CACsJy8CuiAYGA-Tkr1p+KVm=hvpKYwooJMc9-z-pR4nOBDaTug@mail.gmail.com>
References: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
 <1408017065-17437-2-git-send-email-pclouds@gmail.com> <20140814195615.GB19337@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthew Flaschen <mflaschen@wikimedia.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 15 14:10:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIGL4-00052X-5m
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 14:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbaHOMK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 08:10:28 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:40664 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaHOMK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 08:10:26 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so1700721igb.14
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ENqcjIMNGUh33F4zNDDbYdEsygs6anZAuAtb42brWW0=;
        b=FcVAOgJ9SbH7dS7e2XRPQkcb8to9sJrNxsjNjesi/z9LzLZbv2eT/bEyvMpRrhIE0n
         poNN3dflV4luNNNjgMYv+Qr5Uga6SNExPJQuMnwm/+xe6+q+loj0a/3bDBeVyMyW6qtH
         /yeQLr377uUpCqOTblcz8BuctppMG6/MuH2wnjgKBqwqj/ND5JUIENOm1hRH1GPBHYh7
         oJYtztNhDXeSfvzuc3Uk3F79NMm3llUg+6i3SB6z6R5EURldYSCXm0uqbZXpZa84OwgQ
         7pXnQUijJaDi1bYOdzt0kF5UcqNOzvAwpM93MUSal8VPOGvp/jP7VWGLzwjdPnclwDV9
         Eq7Q==
X-Received: by 10.50.43.164 with SMTP id x4mr41338949igl.27.1408104625744;
 Fri, 15 Aug 2014 05:10:25 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Fri, 15 Aug 2014 05:09:55 -0700 (PDT)
In-Reply-To: <20140814195615.GB19337@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255285>

On Fri, Aug 15, 2014 at 2:56 AM, Jeff King <peff@peff.net> wrote:
> I think this is a fine fix for this specific problem, and we should
> apply it. But I do wonder if it would be simpler in the long run to
> treat verbosity as a global option, and pass it around via a GIT_QUIET
> (or GIT_VERBOSITY) environment variable.
>
> I would not be surprised at all to find that there are other cases where
> sub-programs do not respect the parent verbosity (I know we have had
> problems with progress reporting flags carried over the transport
> interface in the past, but I think we fixed all of those).

I don't see any easy way to make everybody aware of $GIT_QUIET. But
the idea is nice.
-- 
Duy
