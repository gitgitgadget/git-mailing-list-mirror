From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to prevent empty git commit --amend
Date: Wed, 14 Jan 2015 11:00:55 +0100
Message-ID: <vpqzj9lfzqg.fsf@anie.imag.fr>
References: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ivo Anjo <ivo.anjo@ist.utl.pt>
X-From: git-owner@vger.kernel.org Wed Jan 14 11:07:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBKrJ-0001H1-17
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 11:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbbANKHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 05:07:22 -0500
Received: from mx2.imag.fr ([129.88.30.17]:59344 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbbANKHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 05:07:20 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t0EA0sZ5015961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Jan 2015 11:00:54 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t0EA0tr8010019;
	Wed, 14 Jan 2015 11:00:55 +0100
In-Reply-To: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
	(Ivo Anjo's message of "Tue, 13 Jan 2015 08:56:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Jan 2015 11:00:54 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t0EA0sZ5015961
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1421834456.2519@k0jOmNUFE4w4sx5PR7FOLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262372>

Ivo Anjo <ivo.anjo@ist.utl.pt> writes:

> Is there a way to prevent a *git commit --amend** with nothing to
> commit from working?
> If not, I would like to suggest that this feature would be very helpful :)

I don't know any way to let Git do the check for you, but 

git diff --staged --quiet || git commit --amend

should do it. You can alias it like

[alias]
	amend = !git diff --staged --quiet || git commit --amend

and then use "git amend".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
