From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 1 Feb 2011 02:24:44 -0500
Message-ID: <AANLkTinx9HnKpyjqc34sGnDAiChB67Nd68apOhz9HEFJ@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home> <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home> <20110131231210.GD14419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 08:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkAc9-00085s-8p
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 08:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab1BAHZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 02:25:16 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55786 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1BAHZP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 02:25:15 -0500
Received: by iwn9 with SMTP id 9so6207903iwn.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 23:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=KxbiRKutapCyeFa2wrMORC/1dwO8xVhqvl/NXuH4OVU=;
        b=lFQSPjBqXJQKVwHVGN7+quemLn0eIxzD5PReoXxtwpIwJp/ugR0RGbmKCk/ltPCWqY
         kqQ4FIXOSJMux7S0GZWBekAxuFeWqp7tSqA26nm/xFJqO+50vmYkSwd9c+XOb9xFuRU7
         a4sel6yRoYr7U6lLkDTf0pTRc4vCJo4+bjDrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iOg1908RUoNWqHioM2FWNyjhepCBZKZr6GdfwdVd8EgI9QODGjmXeHlsXGEiJRMyag
         QjvSN5cglOEuPrNati0NioptE3tzXzJZAcfk2Ki2miv0i/XqLLLPXzCzByt9mW6XGOSX
         KJJ1aeoAwTpi/UItGRWoohJMI81SwqFf1L+mk=
Received: by 10.231.12.132 with SMTP id x4mr7759095ibx.177.1296545114359; Mon,
 31 Jan 2011 23:25:14 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Mon, 31 Jan 2011 23:24:44 -0800 (PST)
In-Reply-To: <20110131231210.GD14419@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165797>

On Mon, Jan 31, 2011 at 6:12 PM, Jeff King <peff@peff.net> wrote:
> And no matter what your model, renames can be annoying. On-going topics
> will have a painful rebase or merge. And people looking at history will
> have to deal with the code-base having different names at different
> points. Yeah, you can say it's all just "content", but the filenames we
> put things in are actually useful.

I have been dealing with this quite a bit lately as Chromium has been
doing mass renaming. It's no small project and sometimes those merges
are big:

[diff]
	renames = copies
	renameLimit = 2000

:-)

What I can say is, yes, it's annoying, but also: git does quite a
decent job of it. I've found myself having to do this occasionally,
but not too often:

  git diff ...MERGE_HEAD -- /path/to/old/name | patch /path/to/new/name

(Typically when a header is renamed, a stub is left in place at the
old name which just includes the new name, and the local changes don't
come across to the new name 100% cleanly.)

Anyway, I would welcome git.git getting a little taste of that. :-) :-) :-)

j.
