From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: repository corruption when pushing commits to a repository running 'git gc --prune='
Date: Wed, 14 Oct 2015 20:40:02 +0200
Message-ID: <vpqmvvl8fb1.fsf@grenoble-inp.fr>
References: <561E5C5B.3090207@alcatel-lucent.com>
	<vpq4mhtbjma.fsf@grenoble-inp.fr>
	<xmqqoag18i6w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Smets <jan.smets@alcatel-lucent.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:40:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmQyK-0001iD-0d
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 20:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbbJNSkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 14:40:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59121 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384AbbJNSkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 14:40:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EIdxU3023149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 14 Oct 2015 20:40:00 +0200
Received: from anie (ensi-vpn-233.imag.fr [129.88.57.233])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EIe2iX001853;
	Wed, 14 Oct 2015 20:40:02 +0200
In-Reply-To: <xmqqoag18i6w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 14 Oct 2015 10:37:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Oct 2015 20:40:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9EIdxU3023149
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445452803.69223@h/G2cjQViEIqnrwTIWd0zg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279585>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 5223498..fa15104 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -63,8 +63,11 @@ automatic consolidation of packs.
>  --prune=<date>::
>  	Prune loose objects older than date (default is 2 weeks ago,
>  	overridable by the config variable `gc.pruneExpire`).
> -	--prune=all prunes loose objects regardless of their age.
> -	--prune is on by default.
> +	--prune=all prunes loose objects regardless of their age (do
> +	not use --prune=all unless you know exactly what you are doing.
> +	Unless the repository is quiescent, you will lose newly created
> +	objects that haven't been anchored with the refs and end up
> +	corrupting your repository).  --prune is on by default.

Looks good to me. I think the same should be added to git-prune.txt
under --expire.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
