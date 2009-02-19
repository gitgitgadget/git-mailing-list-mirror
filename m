From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Thu, 19 Feb 2009 06:26:35 +0100
Message-ID: <200902190626.36163.chriscool@tuxfamily.org>
References: <20090217060944.488184b0.chriscool@tuxfamily.org> <7vljs58qul.fsf@gitster.siamese.dyndns.org> <200902190616.18747.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Tapsell <johnflux@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 06:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La1St-0007ue-6L
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 06:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbZBSF1U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 00:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbZBSF1U
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 00:27:20 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:47482 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbZBSF1T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 00:27:19 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 7058C4C80D0;
	Thu, 19 Feb 2009 06:27:09 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 831564C8092;
	Thu, 19 Feb 2009 06:27:07 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200902190616.18747.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110628>

Le jeudi 19 f=E9vrier 2009, Christian Couder a =E9crit :
> So the improved algorithm could be something like:
>
> static int estimate_bisect_steps(int all)
> {
> 	int n, x, e;
> 	float p;

Oops, the line above is not needed.

> 	if (all < 3)
> 		return 0;
>
> 	n =3D log2(all);
> 	e =3D exp2(n);
> 	x =3D all - e;
>
> 	return (e < 3 * x) ? n : n - 1 ;
> }
