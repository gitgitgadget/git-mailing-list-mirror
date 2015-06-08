From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 6/9] for-each-ref: add '--merged' and '--no-merged' options
Date: Mon, 08 Jun 2015 19:53:38 +0200
Message-ID: <vpq8ubursrh.fsf@anie.imag.fr>
References: <5573520A.90603@gmail.com>
	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>
	<1433621052-5588-6-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:53:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z21F7-0007yG-VJ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbbFHRxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:53:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56167 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbbFHRxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:53:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t58Hra7a023382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 19:53:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58Hrc0x010087;
	Mon, 8 Jun 2015 19:53:38 +0200
In-Reply-To: <1433621052-5588-6-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 7 Jun 2015 01:34:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Jun 2015 19:53:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58Hra7a023382
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434390820.38608@sluUuEeiba3LzIbQ8mML3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271096>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add the '--merged' and '--no-merged' options provided by 'ref-filter'.
> The '--merged' option lets the user to only list refs merged into the
> named commit. The '--no-merged' option lets the user to only list refs
> not merged into the named commit.
>
> Add documentation for the same.

This also requires some tests. The algorithmic part will be validated by
'git tag --merged' using this library, but you need to check the
codepath from the command-line to the lib in for-each-ref.

> @@ -38,6 +39,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  		OPT_CALLBACK(0, "points-at", &ref_cbdata.filter.points_at,
>  			     N_("object"), N_("print only tags of the object"),
>  			     parse_opt_points_at),
> +		OPT_MERGED(&ref_cbdata.filter, N_("print only merged refs")),
> +		OPT_NO_MERGED(&ref_cbdata.filter, N_("print only not merged refs")),

I'd spell that "only refs that are not merged".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
