From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] diff-index: careful when inspecting work tree items
Date: Mon, 31 Mar 2008 05:47:15 +0200
Message-ID: <200803310547.16053.chriscool@tuxfamily.org>
References: <200803290813.08419.chriscool@tuxfamily.org> <7vprtbu45f.fsf@gitster.siamese.dyndns.org> <7v7ifjsi2h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 05:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgAuj-0001eY-Th
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 05:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbYCaDlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 23:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbYCaDlr
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 23:41:47 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:50165 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbYCaDlq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Mar 2008 23:41:46 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 009C81AB2B6;
	Mon, 31 Mar 2008 05:41:45 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DC9421AB2AA;
	Mon, 31 Mar 2008 05:41:44 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7v7ifjsi2h.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78549>

Le lundi 31 mars 2008, Junio C Hamano a =E9crit :
> Junio C Hamano <gitster@pobox.com> writes:
> > diff --git a/diff-lib.c b/diff-lib.c
> > index 52dbac3..a8e107a 100644
> > --- a/diff-lib.c
> > +++ b/diff-lib.c
> > ...
> > @@ -489,8 +516,11 @@ static int get_stat_data(struct cache_entry *c=
e,
> >  	if (!cached) {
> >  		int changed;
> >  		struct stat st;
> > -		if (lstat(ce->name, &st) < 0) {
> > -			if (errno =3D=3D ENOENT && match_missing) {
> > +		changed =3D check_work_tree_entity(ce, &st, NULL);
>
> This "NULL" should be "cbdata->symcache".

Tested-by: Christian Couder <chriscool@tuxfamily.org>

Your patch series works fine for me.

Thanks,
Christian.
