From: Vicent Marti <vicent@github.com>
Subject: Re: [PATCH 09/19] documentation: add documentation for the bitmap format
Date: Wed, 30 Oct 2013 17:14:47 +0100
Message-ID: <CAFFjANRrC8S+Wqnxr7K7HRzLas8BdsWipoToDUyeCY=s9wgdVg@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180347.GI24180@sigill.intra.peff.net>
 <CACsJy8DFisnZZiPOWjktuMC2J289AYGtgefZob=4YFAJAxBc6w@mail.gmail.com>
 <20131025032144.GB26283@sigill.intra.peff.net> <CAJo=hJvmL0=MN7W-NW4bACK0m+Y39+LBVZ+ufXTEh8KzyjFbKg@mail.gmail.com>
 <20131030075040.GJ11317@sigill.intra.peff.net> <CAJo=hJvOb=oooJ3O0wjxt77caGOMeKwT0VRaV=znMAzm0yNCYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Colby Ranger <cranger@google.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 30 17:15:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbYQN-0001C3-7o
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 17:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab3J3QPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 12:15:09 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:62703 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3J3QPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 12:15:08 -0400
Received: by mail-ve0-f174.google.com with SMTP id pa12so1145174veb.19
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BgpRUoxk66pQwpQg9bcoiv5UDy+2zmr+A3u5KfyBz/U=;
        b=PTdu3B3K8aSewf2iFaR+kgFQiCsRsLGNeTWS5QRilY1t5T89Xn7pwkMEJQio9J4A8k
         VJYop4e0w4u8SEAgVk6/k0OzZq3pcOXWDHqp3uWkBgDAZCJsxXTOjC4POr4gMHL5Damp
         Yl0imep2ByMCJNKiG0UgCANw5cqPTeE775v8LMTwRqaLk/2tUWjUYXD8cDaK20/KVkGU
         Kuoz4aX8vNARywgtVJ02tKtrerZP1CXCM9O4gq2hmOxsESdCc39iX8K4Tcb1sHA0lSLl
         tCyudrolkc6ModHnQ+G/lw0z4Mdt7zbLnhcRIt941LvP5MjIx4W4wtaqEh9oLmow72ZE
         QpDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BgpRUoxk66pQwpQg9bcoiv5UDy+2zmr+A3u5KfyBz/U=;
        b=MsXiu+7UnF2J7ewwBYZrQModfkequVrNClB4GwFW+Nl60dcnKJhKBmT8U1Bp3ILYMZ
         kEDftPWWEPSnJFPtO4zMntpfancu8TW6RRDNWmEvt2Wflz/xxiHDZg8vnzErl7XHmq4V
         0AzY4XqNX7ZhY9ipzxz96twYWROWN8aFOcG0w=
X-Received: by 10.220.196.66 with SMTP id ef2mr3630400vcb.7.1383149708009;
 Wed, 30 Oct 2013 09:15:08 -0700 (PDT)
Received: by 10.221.65.202 with HTTP; Wed, 30 Oct 2013 09:14:47 -0700 (PDT)
In-Reply-To: <CAJo=hJvOb=oooJ3O0wjxt77caGOMeKwT0VRaV=znMAzm0yNCYw@mail.gmail.com>
X-Google-Sender-Auth: CExKTr9XmQeTIXAJkyDgA873tMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237032>

On Wed, Oct 30, 2013 at 11:23 AM, Shawn Pearce <spearce@spearce.org> wrote:
> The name-hash cache is probably important, but it would be nice to
> have a variable or flag we can use to disable the name-cache
> generation and thus permit Git to create JGit style v1 indexes, and
> also use JGit v1 indexes if the name-cache is not available.

Yes, we'll reroll the patches with name-hash cache writing disabled by
default. I still think it'd be nice for JGit to be able to ignore the
flag in the cases where it's there.
