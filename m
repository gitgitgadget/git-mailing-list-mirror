From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-bisect.sh: don't accidentally override existing branch "bisect"
Date: Thu, 1 May 2008 14:27:22 +0200
Message-ID: <200805011427.22901.chriscool@tuxfamily.org>
References: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org> <200804302330.18354.chriscool@tuxfamily.org> <cac9e4380805010515h783dcf74h39fcc522c78885d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Richard Quirk" <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 14:23:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrXob-0000sI-LU
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 14:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbYEAMWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 08:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYEAMWW
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 08:22:22 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:38366 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbYEAMWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 08:22:22 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1A2AE1AB310;
	Thu,  1 May 2008 14:22:21 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id EAAD91AB2F7;
	Thu,  1 May 2008 14:22:20 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <cac9e4380805010515h783dcf74h39fcc522c78885d3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80907>

Le jeudi 1 mai 2008, Richard Quirk a =E9crit :
> On Wed, Apr 30, 2008 at 11:30 PM, Christian Couder
>
> <chriscool@tuxfamily.org> wrote:
> >  Minor nitpick: you may use:
> >
> >  git show-ref -q {new-,}bisect
> >
> >  instead of:
> >
> >
> >  git show-ref bisect > /dev/null ||
> >         git show-ref new-bisect > /dev/null
>
> Careful with that - it's a bashism and would fail if /bin/sh is dash.
> ie it would say that a branch called literally "{new-,}bisect" does
> not exist, even if new-bisect and bisect do.

You are right. Thanks.
So what about a plain:

git show-ref -q bisect new-bisect

Regards,
Christian.
