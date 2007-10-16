From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/7] Bisect: factorise "bisect_{bad,good,dunno}" into "bisect_state".
Date: Tue, 16 Oct 2007 08:28:04 +0200
Message-ID: <200710160828.05137.chriscool@tuxfamily.org>
References: <20071014143003.23ae649f.chriscool@tuxfamily.org> <200710150542.17667.chriscool@tuxfamily.org> <Pine.LNX.4.64.0710151338000.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:21:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihfnq-0002dW-My
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759184AbXJPGVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 02:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755177AbXJPGVF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:21:05 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:40597 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbXJPGVE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 02:21:04 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7EC8C1AB2E6;
	Tue, 16 Oct 2007 08:21:01 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6224D1AB2D5;
	Tue, 16 Oct 2007 08:21:01 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0710151338000.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61090>

Hi Dscho,

Le lundi 15 octobre 2007, Johannes Schindelin a =E9crit :
> Hi,
>
> On Mon, 15 Oct 2007, Christian Couder wrote:
> >
> > But the new "bisect_state" takes one more argument, because the fir=
st
> > one must be "good" "bad" or "dunno".
> >
> > So when there is only one argument HEAD is used, and when there are=
 2
> > arguments, $2 is used as the good|bad|dunno rev.
>
> Ah, that explains it!  But do you not need to do "2,bad|2,good|2,dunn=
o"
> in that case?  Or even better: "2,*"?

Perhaps it would be an improvement at least in speed for "2,good"=20
or "2,dunno".

I wanted to keep exactly the same processing as there was before, in ca=
se=20
something like "git bisect good v1.5.3.3..v1.5.3.4" was supported. But =
it=20
seems it doesn't work. I don't know if it's a bug or a feature.

Christian.
