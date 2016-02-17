From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] rebase: turn git-rebase--*.sh into separate programs
Date: Wed, 17 Feb 2016 15:05:18 +0100
Message-ID: <vpqa8mzjuu9.fsf@anie.imag.fr>
References: <vpqio1nsk0q.fsf@anie.imag.fr>
	<1455716201-29784-1-git-send-email-pclouds@gmail.com>
	<1455716201-29784-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sbeller@google.com, peff@peff.net,
	christian.couder@gmail.com, Johannes.Schindelin@gmx.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 15:05:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW2jT-00070V-B7
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 15:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423212AbcBQOF2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2016 09:05:28 -0500
Received: from mx2.imag.fr ([129.88.30.17]:33156 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423147AbcBQOF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 09:05:27 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1HE5HxJ031829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 17 Feb 2016 15:05:17 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1HE5JWu029142;
	Wed, 17 Feb 2016 15:05:19 +0100
In-Reply-To: <1455716201-29784-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 17
 Feb 2016 20:36:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 17 Feb 2016 15:05:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1HE5HxJ031829
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456322718.84796@5iLR0lVQSkszDMDpJSAx/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286504>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +	git_quiet=3D$GIT_QUIET
> +	git_reflog_action=3D$GIT_REFLOG_ACTION
> +	export GIT_PAGER
> +	# these are for write_basic_state()
> +	export allow_rerere_autoupdate gpg_sign_opt head_name onto
> +	export orig_head state_dir strategy strategy_opts verbose
> +	# common variables
> +	export action git_reflog_action git_quiet keep_empty
> +	export rebase_root restrict_revision revisions upstream
> +	# git-rebase--am specific
> +	export git_am_opt
> +	# git-rebase--interactive specific
> +	export autosquash cmd force_rebase onto_name preserve_merges
> +	export squash_onto switch_to
> +
> +	exec git-rebase--$type

This is a good first step, but we may later want to turn these
environment variables into command-line options for the helpers. Or not=
=2E

On overall, the series looks good to me, but I don't have time for a
detailed review.

Thanks,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
