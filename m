From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Tidy up some rev-list-related stuff
Date: Thu, 9 Jun 2005 11:06:46 +1000
Message-ID: <2cfc4032050608180650e5ef12@mail.gmail.com>
References: <20050608205943.GO982@pasky.ji.cz>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 03:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgBTB-0005cs-AL
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 03:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVFIBIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 21:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFIBIF
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 21:08:05 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:42601 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262210AbVFIBGy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 21:06:54 -0400
Received: by rproxy.gmail.com with SMTP id i8so501640rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 18:06:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uNSc1ELbw3AJ8cCSUuv36s4of2SguEkf+fyG7PqQKR/iUaoT1hYE/HEjePLv7Kjv4AJiyeXvXSRKHA71Oe3pciYEs4HV1e90dmMZNBmAXg4L72u/t+VvQcNWRXmcZwlE1T6yc9mGLf6rGBPHBwFm5RTXcw+rwo6KvGCeTkpl/gk=
Received: by 10.38.208.51 with SMTP id f51mr54349rng;
        Wed, 08 Jun 2005 18:06:46 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 8 Jun 2005 18:06:46 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050608205943.GO982@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/9/05, Petr Baudis <pasky@ucw.cz> wrote:
> This patch tidies up the git-rev-list documentation and epoch.c, which
> are in severe clash with the unwritten coding style now, and quite
> unreadable.
> 
> The patch mostly wraps lines before or on the 80th column, removes
> plenty of superfluous empty lines and changes comments from // to /* */.
> 
> Signed-off-by: Petr Baudis <pasky@ucw.cz>
> 
> ---
> 
> Jon, since this is your stuff, could you ack the patch, please?
> Thanks.
> 
> I'm sorry to send patches like this, but I think the files are really
> ugly as of now, and not very readable. This should be a definite
> improvement in this regard, I hope.
> 

Ack'd and tested.

Hey, no problem. I'll never learn unless someone corrects me. It does
make my next patch slightly tedious since I'll have to manually
reapply it, but hey, I am the new kid on the block, so kick dirt in my
face :-)

>From your patch I infer the following coding style rules:

Lines to wrap at column 80
One statement blocks should not include braces
Comment blocks should always be /* */ rather than //
Declarations should always be up the top of a block - never close to first use
No whitespace at top and bottom of blocks.
All indentation should use tabs and only tabs, set at tab stops of 8 apart.

Question: is // ever allowed?

Presumably, when in doubt should I use the kernel's CodingStyle
document as the default reference.

Speaking of which, I can't emacs to indent properly even when I use
this suggestion from that document:

    (defun linux-c-mode ()
      "C mode with adjusted defaults for use with the Linux kernel."
      (interactive)
      (c-mode)
      (c-set-style "K&R")
      (setq tab-width 8)
      (setq indent-tabs-mode t)
      (setq c-basic-offset 8))

    This will define the M-x linux-c-mode command.  When hacking on a
    module, if you put the string -*- linux-c -*- somewhere on the first
    two lines, this mode will be automatically invoked. Also, you may want
    to add

    (setq auto-mode-alist (cons '("/home/jon/.*/.*\\.[ch]$" . linux-c-mode)
                            auto-mode-alist))

It doesn't work when I execute linux-c-mode from the emacs command line either.

Any ideas at all what I am doing wrong? [ Apart from the ever so
constructive suggestion to use vi or vim - please! ]

jon.
