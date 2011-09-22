From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Thu, 22 Sep 2011 02:01:30 +0000
Message-ID: <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com> <7vwrd1z9it.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	computerdruid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 04:02:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6YcD-0003C0-HP
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 04:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab1IVCCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 22:02:03 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60675 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab1IVCCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 22:02:01 -0400
Received: by qyk7 with SMTP id 7so2354937qyk.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 19:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ey0h/gtve2ENaoWjRw6/GBXlpY6mcWbMxUDIz2jdJzo=;
        b=JIpoLpZl+hfIuWAuh8EFE3xrEsJnKH0x+bCB31tSOT1keCAtlx7nNZa7+uclnopcrt
         8V0AfVoqy4Qcao+RlofOF35uSZAqqR8oh5L91r5TL4sIn4PttrltJHsxd3NWyO+O8EgC
         6mo6cf9sbaZPrrn4n3lqqF9gHG5pD2h8EadTY=
Received: by 10.229.72.208 with SMTP id n16mr1185453qcj.165.1316656920274;
 Wed, 21 Sep 2011 19:02:00 -0700 (PDT)
Received: by 10.229.233.6 with HTTP; Wed, 21 Sep 2011 19:01:30 -0700 (PDT)
In-Reply-To: <7vwrd1z9it.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181873>

On Thu, Sep 22, 2011 at 00:49, Junio C Hamano <gitster@pobox.com> wrote:
> --tags is merely a short-hand for "refs/tags/*:refs/tags/*")
> explicitly from the command line

[Disclaimer: I don't know the code or the semantics]

Why not just use that explanation?

  This option is merely a short-hand for writing
  the refspec `refs/tags/*:refs/tags/*'; consequently,
  using this option overrides any default refspec that
  would be used if no refspec were provided on the
  command line. That is,

    git fetch --tags origin frotz

  is equivalent to:

    git fetch origin frotz 'refs/tags/*:refs/tags/*'

In fact, if the command line parsing performed by `git fetch'
is reasonably intelligent, then it might be worthwhile
to relocate `--tags' in the example:

  That is,

    git fetch origin frotz --tags

  is equivalent to:

    git fetch origin frotz 'refs/tags/*:refs/tags/*'
