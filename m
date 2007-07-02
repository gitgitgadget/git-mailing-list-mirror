From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: why does git perpetually complain about include/asm-blackfin/macros.h?
Date: Mon, 2 Jul 2007 16:22:07 +0200
Message-ID: <81b0412b0707020722q25e8eb41t456e7316fe4a7b40@mail.gmail.com>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain>
	 <4688EF9B.8020405@garzik.org>
	 <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com>
	 <4689073D.1020802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Jeff Garzik" <jeff@garzik.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759926AbXGBOWX@vger.kernel.org Mon Jul 02 16:22:48 2007
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759926AbXGBOWX@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Mnc-000554-3f
	for glk-linux-kernel-3@gmane.org; Mon, 02 Jul 2007 16:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759926AbXGBOWX (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 2 Jul 2007 10:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbXGBOWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jul 2007 10:22:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:52366 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbXGBOWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jul 2007 10:22:10 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1265894ugf
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2007 07:22:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IjcwxHTNzl/l2MfVl1zj23yZnWuN2wVInQbPcp+ChnxWWo8BzlNd1RNiqs+qIBBiQjBIHI3zLsQ5Bq1tNFOb17yn5B08k11DOeOgvwgo1tiWDgYdyF5ygTaI+Uq/Hwvp7Y30wuYjsxBKOp6hKfe+3J/hkuJC+QcnLBp+yoWDcmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y2OF42zUt5xrStI/hv1cuq5YzF+/YejO7k8jxM6KqPXyd/o/ZhIraY9u7h2CNUIRbEgHvto9qFDu9H/eFUjQ4oyd+69FICjPsoMTPNPUZTG0HjW5WsbRKiRMzeBfwuuxTu9VvgUipW/By+Z2+Cs5lDFFJAP21rkrRAHQaVy/eVI=
Received: by 10.78.204.7 with SMTP id b7mr2948786hug.1183386128119;
        Mon, 02 Jul 2007 07:22:08 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Mon, 2 Jul 2007 07:22:07 -0700 (PDT)
In-Reply-To: <4689073D.1020802@garzik.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51365>

On 7/2/07, Jeff Garzik <jeff@garzik.org> wrote:
> Jesper Juhl wrote:
> > On 02/07/07, Jeff Garzik <jeff@garzik.org> wrote:
> >> Robert P. J. Day wrote:
> >> >   for the umpteenth time, after doing a pull, i see this:
> >> >
> >> > $ git diff
> >> > diff --git a/include/asm-blackfin/macros.h
> >> b/include/asm-blackfin/macros.h
> >> > deleted file mode 100644
> >> > index e69de29..0000000
> >> > $
> >>
> >> I have the same problem.  git 1.5.0.6 on Fedora Core 5 or 6.
> >>
> >> I even tried a completely fresh clone, but the problem still appears.
> >>
> > I've seen that as well, but in my case doing a
> > $ git reset --hard master
> > fixed it.
>
> Sure.  git checkout -f fixes it too.
>
> But then it reappears the every time I switch branches.
>

Do some of your branches miss the commit by which it was removed?
(It was removed in df30b1171714bbf0e55ffe02138be4b8447e4235)
Than it will reappear every time you switch to a branch which still has
the file.

It is somewhat unclear what "reappear" means, though: do you mean
in your working directory (that's what I explained above) or do you
mean: on the commit pointed by HEAD?

In that second case I can only suspect that all your branches point
at the same commit, which is just before the one the file was removed
in...
