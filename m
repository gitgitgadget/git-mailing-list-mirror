From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: configuring cherry-pick to always use -x?
Date: Mon, 14 Feb 2011 16:53:30 -0500
Message-ID: <AANLkTikKXLBf2HYk2CZmVMzgVhYUAL=URFTZ851eb5do@mail.gmail.com>
References: <4D596435.9020605@gmail.com> <AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adam Monsen <haircut@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:54:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6Mx-0002r4-3l
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799Ab1BNVyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:54:02 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46960 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1BNVyA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:54:00 -0500
Received: by iwn9 with SMTP id 9so5279401iwn.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 13:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=iqYvwhVPSB/VSqRBhzDOVGbX5gPagjVBTx92P5kZeBw=;
        b=MWJwWzdL9R58EXFrYz8LdAjkdx7R34axzs+dMb9B00dTQVMgcUSldYTeZniGRV4LuS
         q1aW/UoOKfpmg84+8pvRGYiVaeCKqLAX/96mqzEvzDjk+eUVzXdEcEbKhl9HGo9oj4Ys
         jVI715O5Ff1jKlfxdehhZr9GnFaHn8HPDV0ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ImmrIM+c+x21xXWGjBZmbFgHuRjeiOmEOSyFHuMkNJLdbRS4FDCiBEn1ShZziFtKGQ
         6RYrzwcA8wBjHPtmVhPgOOvmogi47oXhxcm9WYRIjzibq6l9Ktvtm4OwtkJbKYQWYtNg
         Ome9yMZv0HQ+j2fLOYPx6NzhmkuBsYgkGlnsg=
Received: by 10.231.36.69 with SMTP id s5mr3294079ibd.167.1297720440234; Mon,
 14 Feb 2011 13:54:00 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 14 Feb 2011 13:53:30 -0800 (PST)
In-Reply-To: <AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166777>

On Mon, Feb 14, 2011 at 4:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Not currently, but before we go any further, could you please justify
> in what workflow it would make sense to use -x most of the time?

In one of my repos, most of the time my cherry-picks are between two
public branches. Perhaps a better enhancement would be something like:

  branch.<name>.annotate_cherry_pick = {true, false}

which could be set to true for source branches that you wish to
default to -x. Or, maybe it makes sense in cases where the source
branch is a remote-tracking branch:

   cherry_pick.annotate = {local, remote}

I'm not sure how good a remote-tracking branch is as an indicator of
'public branch', though, so I think explicitly configuring it
per-branch makes more sense. I hesitate there only because we don't
currently put remote-tracking branches in the branch section names.

j.
