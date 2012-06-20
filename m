From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Wed, 20 Jun 2012 19:51:21 +0200
Message-ID: <vpqa9zxan3a.fsf@bauges.imag.fr>
References: <4FE091FB.7020202@desrt.ca> <87a9zztdxt.fsf@thomas.inf.ethz.ch>
	<7v8vfj17de.fsf@alter.siamese.dyndns.org> <4FE0E493.1010308@desrt.ca>
	<CABURp0p6Hv8=Yg1MNb_DMRM3D2JWZtGNwn_GiOfP_x3MctrJ9A@mail.gmail.com>
	<7vr4t9x51j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Hord <phil.hord@gmail.com>, Ryan Lortie <desrt@desrt.ca>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 19:53:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShP5d-0005T9-FU
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 19:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab2FTRxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 13:53:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45287 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722Ab2FTRxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 13:53:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5KHp1md029853
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2012 19:51:01 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ShP3q-0005WJ-S8; Wed, 20 Jun 2012 19:51:22 +0200
In-Reply-To: <7vr4t9x51j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 20 Jun 2012 10:32:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 20 Jun 2012 19:51:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5KHp1md029853
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340819461.78813@hWBdVcr9yfQL0BumdRtxvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200307>

Junio C Hamano <gitster@pobox.com> writes:

> Requiring starting point and failing without --force will never
> happen, but it could be a possible approach to issue an additional
> advice message under reasonably narrow conditions, namely:
>
>  - The starting point was not given explicitly;
>
>  - It would have DWIMed to "git checkout -t -b it origin/it" when
>    creating the branch (I think you need to check configurations
>    like branch.autosetupmerge and existence of the tracking branch
>    remotes/origin/it); and
>
>  - advice.branchNotTrackingCorrespondingRemote is not set to false.

I like that. Stg like

$ git branch next
Creating local branch next starting from <sha1>.
If you meant to checkout a new branch 'next' to track remote branch
'next' from 'origin', run these commands now:
git branch -d next; git checkout next

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
