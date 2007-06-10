From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Sun, 10 Jun 2007 14:30:58 +0200
Message-ID: <8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <11814251322779-git-send-email-hjemli@gmail.com>
	 <20070610002802.GD31707@planck.djpig.de>
	 <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
	 <20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jun 10 14:31:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxMZR-0001ST-47
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 14:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbXFJMbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 08:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbXFJMbA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 08:31:00 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:42081 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbXFJMa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 08:30:59 -0400
Received: by py-out-1112.google.com with SMTP id a29so2126644pyi
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 05:30:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZQSjrgAGeQWKlj7WlnO5pJ4CNhfaylhHpIb2sqlLXDN9DppmxW5ST6pZmLWRvvw7bPYEWi197lnDQCWOw0c/iVmkKH/CKUgRh6S9q2L2wkdABASQGWUFz+fVZ9PuZrUpgLEzBPGd67OvaaEkgmda22ZoU++xhreooig4/Stt6SY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q1ckU/lBnwCsOvLZaZsjXPztz743yL/Hsh8r+3bIJIabBIl5yAcC1lBSpbHQkgxXAgDnxv9Hpr0CKY/ExEe4HJHic5ImIPsBshJ3JVYKYeCwQ3WrOpfzXVcSfNJFifzupTcSCq+u2ULzgRj3ikPMhQvufTRJop8nTYBKbevg2hI=
Received: by 10.114.13.1 with SMTP id 1mr4368607wam.1181478658350;
        Sun, 10 Jun 2007 05:30:58 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sun, 10 Jun 2007 05:30:58 -0700 (PDT)
In-Reply-To: <20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49720>

On 6/10/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Sun, Jun 10, 2007 at 10:58:29AM +0200, Lars Hjemli wrote:
> > On 6/10/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> > >> +Each submodule can contain the following keys.
> > >> +
> > >> +module.$name.path::
> > >> +     Define a path, relative to the top-level directory of the git
> > >> +     working tree, where the submodule is expected to be checked out.
> > >> +
> > >> +module.$name.url::
> > >> +     Define a url from where the submodule repository can be cloned.
> > >
> > >For .path a "Defaults to name of submodule" probably wouldn't hurt.
> >
> > True. But there might be some issues with this rule, so I'll leave it
> > as is for now.
>
> And what might those issues be?

There's been some discussion about allowing a default value for path, see
  http://comments.gmane.org/gmane.comp.version-control.git/49620

>
> How about adding something like
>
>         For a given path relative to the top-level directory of the
>         git working tree, the logical name of the submodule at that
>         path (if any) is the submodule <name> with a module.<name>.path
>         value equal to that path, or, if no such submodule exists, the
>         submodule <path>.  It is an error for different submodules to have
>         identical path values.
>
> For uniformity, you may also want to specify that a path value
> must (or must not) end with a slash.

Nice suggestions, I'll try to come up with a new patch later today

> Other than that, I like it.

Thanks :)

> It doesn't have the extensions proposed by Linus, but it seems
> to be forward compatible with them.

I'm trying to take baby-steps with the submodule support, so the
module/submodule extension Linus talked about would possibly come at a
later stage.

Hmm, maybe I should just rename [module] to [submodule] right now? It
would be better forward compatible with the proposed extension, it
would 'harmonize' the section names used in .gitmodules and
.git/config, and it would offer a clean break from what's currently
supported in 'master'.

--
larsh
