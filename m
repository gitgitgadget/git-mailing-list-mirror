From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Single brackets matching in .gitignore rules
Date: Mon, 28 Sep 2015 20:15:53 +0700
Message-ID: <CACsJy8DiTevhSnkkab-kfvpibitoUMHdjC2UdGT244JwLRxqWQ@mail.gmail.com>
References: <2606743.RipZrg6Xoz@pinguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andrey Loskutov <loskutov@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 28 15:16:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgYIA-0000uG-25
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 15:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933482AbbI1NQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 09:16:24 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36799 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbbI1NQX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 09:16:23 -0400
Received: by ioii196 with SMTP id i196so174894798ioi.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+C+O56xD4nyKyBKy9WnlbGZYAgHlyxBWI5tz4NO+ris=;
        b=cH6k663Pb7yskrx51s8x2zYOmGtuE+qS6Oq2RX4zGhdo/FiW/IoCJVoK8VtlEGicmg
         Eiz7SYONDpVtMCmU9MbtXEUE+l57Ov0HZgANegfns7bNCUuaAqvtiA2wJaeoNQnvvS2F
         1PpwcUWTJ8A5ceyvagT3XYb1b8/jL9pkM8hnfKLJLglvhxZcSuoRKG5ezq0NZda5nTiy
         L94+Xwud8VLoRceUbcgEfCEReAa1AS76gm2cVRQi59qIn02GWLSf2jA4jTeR3z7UhXSk
         TkgxwQyi79x0O+6e5SXUxtYLViKGJ5uV6imROWy3RJiWtucx4PeeMzs3eZs41ZTR9uS1
         nJSg==
X-Received: by 10.107.131.134 with SMTP id n6mr18552072ioi.192.1443446183269;
 Mon, 28 Sep 2015 06:16:23 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Mon, 28 Sep 2015 06:15:53 -0700 (PDT)
In-Reply-To: <2606743.RipZrg6Xoz@pinguin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278723>

On Sun, Sep 27, 2015 at 5:01 AM, Andrey Loskutov <loskutov@gmx.de> wrote:
> ...
> Anyway, it would be nice to hear what should be the "right" way to interpret the tables above.
>
> BTW the only official documentation I found about ignore rules:
>
> https://www.kernel.org/pub/software/scm/git/docs/gitignore.html
> http://man7.org/linux/man-pages/man3/fnmatch.3.html
> http://man7.org/linux/man-pages/man7/glob.7.html

This is already answered. I just want to add that C Git has stopped
using system fnmatch for some time (part of the reason is system
fnmatch behaves differently in corner cases). If you don't mind C,
have a look at dowild() in wildmatch.c, or t/t3070-wildmatch.sh for
some corner cases (but your cases aren't there, may be worth adding
too)
--
Duy
