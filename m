From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Clone to an SSH destination
Date: Mon, 3 Sep 2012 18:24:59 +0530
Message-ID: <CAMK1S_iSbDNc39XjWZLgUJuBg71+A+CHbEq09QG+mntDQrdNxw@mail.gmail.com>
References: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com>
	<20120903154732.5fb50b173fa51db8300624b3@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Hills <Mark.Hills@framestore.com>, git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Sep 03 14:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8WC0-00019G-0v
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 14:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab2ICMzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 08:55:03 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54092 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab2ICMzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 08:55:01 -0400
Received: by lbbgj3 with SMTP id gj3so2453937lbb.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XJIA2kpjAme/17gG8y6+DHNN8/hxP2FXWsZzs57VfwE=;
        b=IyND0cI0KxQJHldkmDSpMm1l0JemFuNVuWPdvP1jjw+Cz7UBmSWxJIQis7WJB8GIYS
         ElDRW65ADUAbRcpeffyzX3dFtoTjeQP4QE8Sm4fh93WyueqS67Czjz8JE71WA2dXTQWu
         eSv6hxIFIwjtLBkpo45l+ErO98V5U+19W6qs7NU2+pYCuc47GrIDZ7aAEUo3dkn5kS0m
         P9KdknrpBJOgqhCKdW3FhlQmpgmQw9jYRr9ZItn6R0IGF5GqRVNuQFJDxdMO703yZslb
         pQ/a9NOuOdPrKMaaEe669qXAelSoaGYU72iyi6vF25YodZc0H6/IspAF/r58imczm+ZO
         4nIQ==
Received: by 10.152.111.200 with SMTP id ik8mr13929686lab.15.1346676899814;
 Mon, 03 Sep 2012 05:54:59 -0700 (PDT)
Received: by 10.112.129.227 with HTTP; Mon, 3 Sep 2012 05:54:59 -0700 (PDT)
In-Reply-To: <20120903154732.5fb50b173fa51db8300624b3@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204689>

On Mon, Sep 3, 2012 at 5:17 PM, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> On Mon, 3 Sep 2012 11:21:43 +0100 (BST)
> Mark Hills <Mark.Hills@framestore.com> wrote:

[snip]

>> This is quite cumbersome; we have a large team of devs who use a
>> simple 'git clone' to an NFS directory, but we wish to retire NFS
>> access.

[snip]

> gitolite kind of implements this ("wild repos") [1], you could look if
> it suits your needs.

The simplest conf to do what you want in gitolite is something like this:

    repo [a-zA-Z0-9]..*
        C   =   @all
        RW+ =   @all

But of course your *user* authentication will probably change quite a
bit, since gitolite runs as one Unix user and merely simulates many
"gitolite users", while in the NFS method each of your devs probably
has a full login to the server.
