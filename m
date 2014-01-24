From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Fri, 24 Jan 2014 17:05:35 -0500
Message-ID: <CALkWK0mgGyYaTmSTLL5BRpr6cOWgx7VJuQTtuqDnmjCMbXhgqA@mail.gmail.com>
References: <20140108093338.GA15659@sigill.intra.peff.net> <20140108093716.GE15720@sigill.intra.peff.net>
 <xmqqob32s08p.fsf@gitster.dls.corp.google.com> <20140124213521.GA26602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 23:06:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6otI-0007mb-RQ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 23:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbaAXWGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 17:06:16 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:65072 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbaAXWGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 17:06:16 -0500
Received: by mail-ig0-f173.google.com with SMTP id c10so3767091igq.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 14:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PxSHaPzSVwZJTYAj+6fMvR/IWG0A2d12DD/fJSr6htU=;
        b=N00O1VIyijZAWBxbGLGa5XWa5O/n/dRVGw6Lo4rfG0P5HELV1pu1YCU55hkeKybiAH
         5Zhz+PV3r4moleIE1nSm45TkBvj/HcSkbJOpC7aNOD5hvyJsYfM09Odwixzahn4Z7vSC
         EVqEdNar8NFxH36lVRlAD+g2OUEFIj/Xr8iK/hI4mvl4Ow56azj9/JhGtwdDiPzpYk/7
         q+tU1eNbK2Oz2P5KkC87cZfA4J4UxS5+appE84i3lqPT86equui8+8XZFSyVHigiWX3f
         WovPdyPqLxFJ2j6f/5xhqUmZrEp8eFbtBJWc7WEn2kwYAwbVKi9liBTu1zYZoC7GSt7W
         bgFg==
X-Received: by 10.50.36.67 with SMTP id o3mr6570098igj.47.1390601175579; Fri,
 24 Jan 2014 14:06:15 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Fri, 24 Jan 2014 14:05:35 -0800 (PST)
In-Reply-To: <20140124213521.GA26602@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241046>

Jeff King wrote:
> As far as merging it to 'next', I had not really intended it to go that
> far. :) It was more for Ram to use as a base.

Sorry about not having posted a follow-up yet; I'm adjusting to a new
timezone and environment.

> I find some of the
> refactoring questionable, including:
>
>   1. The meaning of branch->pushremote is subtly different from that of
>      branch->remote. Ram's followup refactoring did a better job of
>      that (but he is missing the patches on top to finish out the
>      feature).
>
>   2. We are duplicating the "where to push" logic here. That should
>      probably be factored out so that "git push" and "@{publish}" use
>      the same logic.
>
> And of course there are no tests or documentation. It might work,
> though.

Actually, task (2) is somewhat involved: I still haven't figured out
how to share code with 'git push'.

> I don't mind if you want to merge it and do more work in-tree, but I do
> not think it should graduate as-is. And you may want check from Ram that
> he is not in the middle of his own version based on the patches he sent
> earlier, as reworking them on top of mine would probably just be
> needless extra work.

On that note, can you hold off graduating
jk/branch-at-publish-rebased, Junio? Hopefully, I'll come up with a
replacement over the weekend.

Thanks.
