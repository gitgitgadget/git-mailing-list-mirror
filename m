From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v6] Add a remote helper to interact with mediawiki (fetch
 & push)
Date: Wed, 31 Aug 2011 19:03:54 +0200
Message-ID: <CAGdFq_gu=SyjUnUS1bcjPrcPPtKVt+UjDBvBmZqosk+OuDFDHw@mail.gmail.com>
References: <1314381329-8989-1-git-send-email-Matthieu.Moy@imag.fr> <1314809708-8177-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?Q?Sylvain_Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 31 19:04:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyoDQ-0002ZY-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 19:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150Ab1HaREf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 13:04:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51725 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab1HaREe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2011 13:04:34 -0400
Received: by vws1 with SMTP id 1so709913vws.19
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7mbjOZl2Q1g9nPDxenOws8tHFlfhcw656WizJaPi/MA=;
        b=J7PJY4ZwtI4fRql98qgyCafxw4mh1bbTVzVuztmNA/OPHbsEjF9QIcDx1CjndB6FEB
         Ao0XN/7XpzmZyIif5Oir8KyMPhrZ/Fil6AIpiO2ykSb1rxaqavdtjcgGbaCsQ8adr5Qi
         Ev9IxIqDfd6GwaDfaNan2W6X6VhmLSuE8iHU0=
Received: by 10.52.22.83 with SMTP id b19mr669008vdf.33.1314810274117; Wed, 31
 Aug 2011 10:04:34 -0700 (PDT)
Received: by 10.52.161.201 with HTTP; Wed, 31 Aug 2011 10:03:54 -0700 (PDT)
In-Reply-To: <1314809708-8177-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180495>

Heya,

2011/8/31 Matthieu Moy <Matthieu.Moy@imag.fr>:
> So, after understanding better how import works, here's an updated
> patch that gets rid of the hacky workaround to terminate and send the
> "done" command at the right time.

So what do you think of the way the protocol works now? Do you agree
that (modulo lacking docs) it is better than previously?

> Actually, push had the same problem but it just went unnoticed (the
> remote has just one branch, so it's silly to try to push multiple
> branches at the same time ...). This version handles push more
> cleanly, giving accurate error message in cases like
>
> =C2=A0git push origin :master
> =C2=A0git push origin foo bar master
>
> or perhaps more commonly
>
> =C2=A0git push --all
>
> in a repository with branches other than master.

My perl skills are minimal, but I'm curious how/where you implemented
this? Is this something that we can port to remote-testgit to document
the CPB on handling such things?




--=20
Cheers,

Sverre Rabbelier
