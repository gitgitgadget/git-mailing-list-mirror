From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Sat, 24 Jul 2010 16:00:54 +0200
Message-ID: <20100724140054.GB13067@vidovic>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
 <20100724110239.GA13067@vidovic>
 <20100724125408.GA17481@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 16:01:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcfHw-0007zw-Tz
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 16:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352Ab0GXOA7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 10:00:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58885 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab0GXOA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 10:00:58 -0400
Received: by wwj40 with SMTP id 40so5554922wwj.1
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 07:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eCRRrEg6bHQ4hbb51coPZqRGkScAowgua8w0/GeVy68=;
        b=UHFALx9EwCONrM5JhyIf31w66C1++8mqna4rf21MviN8P1zvof1DbZsb8Tzriu/HxH
         mvt47VbB/xWew4mJZVQbobbYUUC67mcDF3yoHiktWGN71MczFsPZUZgfComdJDklKNFn
         YAuvrpBcpNDKZ03AtgBIKbsf/bkietE8Jcu7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mwESkPOzEmrggpi8zCLqADoEoZcG6VkIagE1nQ5hjB/4JGubUTkcDPSr0hj/6NBLFR
         RpstmrVumDittYbVg/Dr+FGOwGSL2fHPcPLlYMKPrj/e/EutdQr4jkl7ykyNbrQ96hh/
         oMYt4tsPbNo9VDXT5/o3bE6pnB+tNlDmQ3kg4=
Received: by 10.227.138.145 with SMTP id a17mr4854658wbu.145.1279980057219;
        Sat, 24 Jul 2010 07:00:57 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id a1sm1190049wbb.20.2010.07.24.07.00.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 07:00:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724125408.GA17481@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151629>

The 24/07/10, Jonathan Nieder wrote:
> Nicolas Sebrecht wrote:
>=20
> > What is the issue with the current status?
>=20
> Here is one:
>=20
>  $ git log --oneline -SListbox.font -- gitk-git/gitk
>  $ git log --oneline --follow -SListbox.font -- gitk-git/gitk
>  62ba514 Move gitk to its own subdirectory
>  $ git log --oneline -SListbox.font -- gitk-git/gitk gitk
>  207ad7b gitk: Set the font for all listbox widgets
>  $

I'm sorry, I don't get your point here.

> > Going this way, why would we want gitk and git-gui as submodules at=
 all?
>=20
> If we want to stop distributing them completely (though I am not
> convinced that would be a good idea), then submodules would be a
> good stopping point along the way to avoid changing the world too
> much at a time.

It depends on why we would want to split gitk and git-gui from git. If
it's a packaging issue only (especially for distribution maintainers),
going by the "submodule" step looks more like adding a non-valuable
extra step in the "splitting packages" mainstream.

Changing the world once seems better than twice.

> git archive hasn=E2=80=99t learned to do recursive archive yet; I thi=
nk
> the last murmurs of that topic were [1] and [2],

I understand gitk and git-gui are in the Git repository mostly for
historical reason. I don't want to hurt someone here but I still don't
see what both have so special against other porcelain tools not in
git.git.

>                                                  though it would
> be simple enough to use "git archive" more than once together
> with "tar rf" to take care of it by hand in this case.

So, doing a tar archive of them all (with or whitout submodules) is not
such an issue.

--=20
Nicolas Sebrecht
