From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] bisect: replace hardcoded "bad|good" by variables
Date: Tue, 09 Jun 2015 14:39:48 +0200
Message-ID: <vpqtwuh9ht7.fsf@anie.imag.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqtwuhl6s0.fsf@anie.imag.fr>
	<CAP8UFD1mWaXwJwFLcw2f4Qj1v_Ves1UHEH7qkk8yq6WhjLeZGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git <git@vger.kernel.org>, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Christian Couder <chriscool@tuxfamily.org>,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 14:40:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2IpG-0007TI-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 14:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbbFIMkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 08:40:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50291 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214AbbFIMjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 08:39:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t59CdkZk003072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2015 14:39:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t59Cdmng028739;
	Tue, 9 Jun 2015 14:39:48 +0200
In-Reply-To: <CAP8UFD1mWaXwJwFLcw2f4Qj1v_Ves1UHEH7qkk8yq6WhjLeZGQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 9 Jun 2015 10:12:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 09 Jun 2015 14:39:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t59CdkZk003072
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434458389.02221@Ao6bLCQviUf0dCFq9i/S1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271172>

Christian Couder <christian.couder@gmail.com> writes:

> "old/new" is not more generic than "good/bad".

I disagree with this. In any case, we're looking for a pair of commits
where one is a direct parent of the other. So in the end, there's always
the old behavior and the new behavior in the end.

In natural language, I can write "terms good/bad correspond to the
situation where the new behavior is a bug and the old behavior was
correct" and "terms fixed/unfixed correspond to the situation where the
new behavior does not have a bug and the old one does", so I can
describe several pairs of terms with old/new. When looking for a bugfix,
saying "NAME_GOOD=new" seems backward. I would read this as "the good
behavior is to be new", while I would expect "the new behavior is to be
good".

> and as "good/bad" is older and is the default we should keep that in
> the names.

I agree with this part though. If people working with the bisect
codebase (which includes you) are more comfortable with good/bad, that's
a valid reason to keep it.

IOW, I still think old/new is more generic, but that is not a strong
objection and should not block the patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
