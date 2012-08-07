From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Mon, 6 Aug 2012 22:44:07 -0700
Message-ID: <CA+sFfMdVhTwAFLUgrO-mLBh8apG-5X1OJKCN9xgq3-N+1RBrvg@mail.gmail.com>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
	<1344315709-15897-1-git-send-email-drafnel@gmail.com>
	<1344315709-15897-2-git-send-email-drafnel@gmail.com>
	<7vtxwfw9rp.fsf@alter.siamese.dyndns.org>
	<7vpq73w9i8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 07:44:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SycaV-0003Xs-1f
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 07:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab2HGFoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 01:44:09 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:44452 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab2HGFoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 01:44:08 -0400
Received: by vcbfk26 with SMTP id fk26so3603074vcb.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g39kg63OmcEgw5RMOc8U+jAYbHGwlHBGEZMztar2Pmk=;
        b=F5B7T8hN0exQ3/KbsJXUCgZAzivKFrFKD4DmQbdUIUNSUymH2VQU7H//sn+aYR86Jv
         RMOTJrFHXMzyxrsAp/jsS6md8xtKw+nmOAIYOYxuzn/6K+Mts9uPr9D8aV6tZUPbxP0l
         knnBGzN9iBUbBVvfgqf1PJZGIFdxO7hOal/EyHAYH0rUn1vaCoRzZgEm1Ub5ft0G4gFu
         Xp9aUqn1ehy18h3Dz/bcubmmBlWdcIn58/WvQVUfpCr1/9FXZr8VMtKiH47NfHe8dVRJ
         3GVcUTv8KwrrvzxoEJHFDKj2maEGrDuJduMW95/7NZeP9p+Byu66XxSWx1OAp1HYSDxm
         hTcQ==
Received: by 10.52.35.45 with SMTP id e13mr8662947vdj.100.1344318247968; Mon,
 06 Aug 2012 22:44:07 -0700 (PDT)
Received: by 10.59.5.196 with HTTP; Mon, 6 Aug 2012 22:44:07 -0700 (PDT)
In-Reply-To: <7vpq73w9i8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203017>

On Mon, Aug 6, 2012 at 10:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> Ok, now a tested patch, on top of your 1/2


On Mon, Aug 6, 2012 at 10:32 PM, Jeff King <peff@peff.net> wrote:
>
> This seems like a band-aid. The real problem is that auto-gc can
> interfere with the pack protocol, which it should not be allowed to do,
> no matter what it produces.
>
> We could fix that root cause with this patch (on top of your 1/2):

Anyone else? :)

Ah, I wasn't aware of that feature of run_command.  Both look obviously correct.

And the comment I made yesterday about leaking the full path to the
remote end can be disregarded, since prune will report the path
relative to the repository base.

Thanks,
-Brandon
