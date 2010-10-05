From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: cvs importing a forked project
Date: Tue, 5 Oct 2010 19:20:18 +0000
Message-ID: <AANLkTimnvAXAiE=03E3VdXSeP3pQBa8UTH548vEWsYsG@mail.gmail.com>
References: <AANLkTimvaH4UYzmL9eS1Yq7WNaS+jPRfkajKPP=hjZWV@mail.gmail.com>
	<Ci4laGuWQaUrmZdwH9nojZ77bfNScQVKlCGXCSR6hP816oyKCfkncQ@cipher.nrlssc.navy.mil>
	<AANLkTi=DRWeJc5gW0Rio9NZh5a02FQtdd9TeEzOkBimr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 21:20:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3D3q-000118-72
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 21:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab0JETUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 15:20:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41076 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0JETUT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 15:20:19 -0400
Received: by iwn5 with SMTP id 5so8680453iwn.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qoHw1xCvFozzFRTXKX58wwYwnRgcfhGSHuI3vPfi93k=;
        b=ixYUEjKoKCCTdc2/Sih7GQWpGeS/fTsgga6SX0uB9ax217lYsWw47L+MWqK7FGdoRJ
         eZuPOoNknGQGqC2jJdkILZ5PxsfKin0GRzwspUYhOw/XQMv3HYSR/RPkkFQKnpwgu37U
         ZK50o7MF9OFgg+vCM56VIhkgU+69sVJpK2cRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T2ecFg9PXqaVvcosBY7OontloTiOlErPygvL1i0+KcpDBayWKaekIqd/lRCHazQ2+2
         4oB+hHmjp+p/2PEku5WQk+a85FEtULICcGRxuOYz923ee2Hibx7eQq1SVZKKHB/LmXQv
         aPl6gvLlS4EpEBAmjV9HlBj7j2Rz71DD6nk8o=
Received: by 10.231.161.68 with SMTP id q4mr12648657ibx.79.1286306418161; Tue,
 05 Oct 2010 12:20:18 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 5 Oct 2010 12:20:18 -0700 (PDT)
In-Reply-To: <AANLkTi=DRWeJc5gW0Rio9NZh5a02FQtdd9TeEzOkBimr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158226>

On Tue, Oct 5, 2010 at 18:38, Eric Frederich <eric.frederich@gmail.com>=
 wrote:
> Interesting. =C2=A0Looks easy to use except I can't figure out how to=
 get
> the two projects imported to the same git project.
>
> If I run the following...
>
> $ git cvsimport -C myproject -d /some/vault projects/foo_old
> $ git cvsimport -C myproject -d /some/vault projects/foo_new

Either switch to a new parentless branch between the two (I don't know
cvsimport), or import them in two distinct git repositories. Then when
that's finished do:

    git init the-merge &&
    cd the-merge &&
    git remote add ~/cvs-repo-1 &&
    git remote add ~/cvs-repo-2 &&
    git remote update

And you'll have all those commits / branches / tags from both of them
to work with.
