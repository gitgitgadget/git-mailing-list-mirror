From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 3/7] replace_object: add mechanism to replace objects found in "refs/replace/"
Date: Thu, 15 Jan 2009 18:40:12 +0100
Message-ID: <200901151840.12511.chriscool@tuxfamily.org>
References: <20090112184403.ebb99b75.chriscool@tuxfamily.org> <7vd4esf0tv.fsf@gitster.siamese.dyndns.org> <200901151044.45967.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:41:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNWDF-0001A7-PO
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 18:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454AbZAORjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 12:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759294AbZAORjh
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 12:39:37 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:39476 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759284AbZAORjg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 12:39:36 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AD1918183A8;
	Thu, 15 Jan 2009 18:39:29 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 86DCE818A88;
	Thu, 15 Jan 2009 18:39:26 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200901151044.45967.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105860>

Le jeudi 15 janvier 2009, Christian Couder a =E9crit :
> Le mardi 13 janvier 2009, Junio C Hamano a =E9crit :
>
> > Since your paradigm is prepare replacement once at the beginning, n=
ever
> > allowing to update it, I think you can update the table while you l=
ook
> > it up.  E.g. if A->B and B->C exists, and A is asked for, you find =
A->B
> > (to tentatively make cur to point at B) and then you find B->C, and
> > before returning you can rewrite the first mapping to A->C.  Later
> > look-up won't need to dereference the table twice that way.
> >
> > This assumes that there will be small number of replacements, but t=
he
> > same object can be asked for more than once during the process.
>
> If we allow different sets of replace refs, for example A->B
> in "refs/replace/" and B->C in "refs/replace/bisect/", then we cannot
> rewrite as you suggest. We could add A->C in "refs/replace/bisect/", =
so
> that it overcomes A->B and B->C when we bisect, but we would not gain
> much.

Sorry, I just realized I misunderstood what you said. I don't know why =
but I=20
thought you talked about updating the refs. But in fact you are right i=
t=20
should be possible to update the "replace_object" table.

Regards,
Christian.
