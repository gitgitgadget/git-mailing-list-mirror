From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Wed, 4 May 2016 15:53:26 -0700
Message-ID: <CAGZ79kaUiVLuXvpLPKuZZ55zbQXA3Wt7WP3a_65gBW2Cj-gMoQ@mail.gmail.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
	<20160504074559.GA3077@sigill.intra.peff.net>
	<20160504080047.GA2436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 00:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5fg-00009s-3G
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbcEDWx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 18:53:28 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38907 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200AbcEDWx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:53:27 -0400
Received: by mail-ig0-f182.google.com with SMTP id m9so250969ige.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 15:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=+0YJ/dEmGTi1PJL5QnoGCaqJkzhFcvJ1EkESsPekdZU=;
        b=aeXzhQIbXuZaTv5NI+w+CNXyY7qgTkAhJAdbJBahY7x4fFOjoWUazGuvPvNgBe88mb
         NZFyz3jNM+9et1Uy2K/jVPlZhIAd17SCQ80Zdg7QLaobvLBdetv5hXPhilaf1CNBdYoj
         VjCGQvyori1KlRyENEj+pp3Meovr4aVeaFspZF34q4XVSv0cCkG3wAGVJ9uGo7MtCW79
         MQWKEIJtfucz8fvU0dXq4M3fG/opMfnrzusK4D87V1HdhIe9Us0Up5oBlLPCn6IzgDsl
         5fj8NGV4fIyquzsl01/YEWHi43fk19I88zgdR15hL6bn+NEy11W7+/3pJodA/oy1pXvO
         XmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+0YJ/dEmGTi1PJL5QnoGCaqJkzhFcvJ1EkESsPekdZU=;
        b=Inw/JAmKlOjoowmcamJGdXdjePhyjTwadSOuzExbWEsgYpVNl/rkAYczzHGtE1LrUJ
         g5E/HVcwzLZQS+CKk0+nb/tMIINFubm6F8p6SSTyv7/611aAPMUndoot/AUQzXgDVh6P
         h21LTqneSeFBCh4Ij+t/NXHMmBGRUDHtGVYwzTukaBlvZxbz3JtP3XOj4O3wOhdLdDfg
         DzEdDx69fsn8h5wuENNGllSwyaIcPG1xHx69+7mIufpBeLTJysHgAGUhCR3RwJ4m1dsS
         XJCkdhoAhtuUZ4S8Vsi7I3QV6in4GKU9sdF1eafRL1j/sZjGIWQQLuw+Cy0z9krx5LoW
         j9kw==
X-Gm-Message-State: AOPr4FWlXV2+wEoeYqUs/+DDMZ/8dYJiALm3o5PAMceW/q09rpYdP9Ycvdl1qO4S7hHdSRWbTJM7/jMn50owmqtu
X-Received: by 10.50.29.45 with SMTP id g13mr23884igh.93.1462402406209; Wed,
 04 May 2016 15:53:26 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 4 May 2016 15:53:26 -0700 (PDT)
In-Reply-To: <20160504080047.GA2436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293613>

> I don't think there was any documentation for the _old_ behavior, and
> certainly jk/submodule-c-credential didn't add any. But it probably is
> worth document, maybe as part of "-c"? Care to roll a patch on top?

Sure.

>
> I think we'd actually do it all in one, and that patch looks something
> like the one below (on top of jk/submodule-config-sanitize-fix).

    $ git checkout origin/jk/submodule-config-sanitize-fix
    $ git am p
Applying: submodule: stop sanitizing config options
error: patch failed: builtin/submodule--helper.c:246
error: builtin/submodule--helper.c: patch does not apply
error: patch failed: submodule.c:1131
error: submodule.c: patch does not apply
Patch failed at 0001 submodule: stop sanitizing config options

So if you want some documentation on top of that, where would I base it on?
