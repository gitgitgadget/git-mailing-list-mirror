From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Thu, 7 Jan 2016 09:13:09 +0700
Message-ID: <CACsJy8BGskjxKKw0RGOxSzJYoA2=w_iW_cdrmKyPhpfp+AMmDw@mail.gmail.com>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
 <20160105150602.GA4130@sigill.intra.peff.net> <CACsJy8AQ9s4VkFn+TNJLD55xJc40+-54BTYbC4Os71uSkL1QSA@mail.gmail.com>
 <5E517AD0-CD4E-4F85-8FEB-89B7A0183967@mikemcquaid.com> <CACsJy8CvPqYGRXB845+4fHjkXH_kSAWG684CoxtWAnXE-gM6ag@mail.gmail.com>
 <CAPc5daX+uGQfKEteT2dqax-m9dR76Gkg1YeiFjVU9dsTqnHDmw@mail.gmail.com> <20160107020406.GA9358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike McQuaid <mike@mikemcquaid.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 03:13:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH05A-0000r3-Br
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 03:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbcAGCNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 21:13:41 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35408 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbcAGCNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 21:13:40 -0500
Received: by mail-lf0-f50.google.com with SMTP id c192so147778763lfe.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 18:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eG5W7z17AW/kKLnYX4zuZBHYiN1KC/0B41YcrX6F2Sw=;
        b=xt4BfYyZm9uCm702yEkSksf5D4pMVvG3my5qC/mbrqBZOOle6SzLP1PyZ2keRiZJnV
         2Ih6n79UAuVoPYuTZCC8aT8aku3cI5gdSruJPfdYdiXmlsKu8QrmBdEl41tU+RKrZw4S
         1fgo04OMsXbQJe1EjdVpLk7FfVMPMnH0tVBplBXmzEtMt6HwYWMtSv6XluX0QV691XUK
         RWa2BeNX6HATrsThYLyTT+/ItGr3Im4S0ysNZBNEp3nTxFK0Run1UunryGjcKYqFNRAg
         o5NBPqtD8mEJn2WuIHv0LETHDcZvQpiGPTGPnENrVwiMe5X6Q14TgKpj4yDm6MbZIERg
         YeJA==
X-Received: by 10.25.144.17 with SMTP id s17mr22799474lfd.94.1452132818638;
 Wed, 06 Jan 2016 18:13:38 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 6 Jan 2016 18:13:09 -0800 (PST)
In-Reply-To: <20160107020406.GA9358@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283465>

On Thu, Jan 7, 2016 at 9:04 AM, Jeff King <peff@peff.net> wrote:
>> Yup, an area that is reasonably isolated from the remainder of the system like
>> this might be a good starting point. But I suspect that the invasion needs to
>> happen in the opposite direction in this particular case before it happens.
>> That is, if libgit2's implementation does not behave like how we do, it needs to
>> be fixed, possibly by discarding what they did and instead importing code from
>> us. After the behaviour of libgit2 is fixed, we can talk about the
>> invasion in the
>> opposite direction.
>
> Unfortunately, "importing code from us" is not so easy. :(
>
> They'll either need to contact the wildmatch authors, or rewrite
> wildmatch from scratch.

wildmatch author relicensed it on request before [1] so he might do it
again (hard to say). I'm not sure if there are other authors though.
But even with wildmatch good to go, there still a lot of work to do.

[1] http://thread.gmane.org/gmane.comp.version-control.git/264312/focus=264328
-- 
Duy
