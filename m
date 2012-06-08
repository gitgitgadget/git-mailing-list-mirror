From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv8 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Fri, 08 Jun 2012 11:29:45 +0200
Message-ID: <20120608112945.Horde.I4abIHwdC4BP0cYJzywVAeA@webmail.minatec.grenoble-inp.fr>
References: <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338927687-29822-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338927687-29822-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vfwa9o3xo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 11:29:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScvVx-0006jt-FN
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 11:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458Ab2FHJ3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 05:29:49 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:35428 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762004Ab2FHJ3s (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 05:29:48 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 2868F1A02F4;
	Fri,  8 Jun 2012 11:29:46 +0200 (CEST)
Received: from wifi-028016.grenet.fr (wifi-028016.grenet.fr [130.190.28.16])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 08 Jun
 2012 11:29:45 +0200
In-Reply-To: <7vfwa9o3xo.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199478>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

> Reading from git_path("HEAD") looked funny, as you may end up
> reading the "ref: refs/heads/master".  Of course that would not
> compare equal to what you would read from "rebase-merge/amend", and
> that may be fine for the purpose of your test, but it still looks
> somewhat funny.  As modern rebase is done on a detached HEAD,
> perhaps it is a good idea to check if the HEAD is detached and
> return false from this function if that is not the case.  I dunno.

On second thoughts, I do not think that checking if HEAD is detached
or not is needed, as the part of the code that includes reading can
only be called during a rebase interactive, in which case the HEAD
can only be detached.
