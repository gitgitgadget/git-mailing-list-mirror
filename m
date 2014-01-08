From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] merge: make merge state available to prepare-commit-msg hook
Date: Wed, 08 Jan 2014 22:30:31 +0100
Message-ID: <vpqtxdenoug.fsf@anie.imag.fr>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
	<DA9E6645-82DC-4714-845F-423726F96A40@yaauie.com>
	<vpqr48ip7bm.fsf@anie.imag.fr>
	<B19C65C1-C2D9-486F-AEA7-1497A3B5C5B4@yaauie.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ryan Biesemeyer <ryan@yaauie.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 22:31:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W10ii-0007X2-Rt
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 22:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850AbaAHVbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 16:31:22 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57860 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563AbaAHVbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 16:31:20 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s08LUTVP000683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Jan 2014 22:30:29 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id s08LUVnY030040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jan 2014 22:30:32 +0100
In-Reply-To: <B19C65C1-C2D9-486F-AEA7-1497A3B5C5B4@yaauie.com> (Ryan
	Biesemeyer's message of "Wed, 8 Jan 2014 20:21:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 08 Jan 2014 22:30:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s08LUTVP000683
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1389821434.51761@KVKNtUxApT13FsqOyYfsRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240227>

Ryan Biesemeyer <ryan@yaauie.com> writes:

> In this case it was not immediately clear to me how to add cleanup to an existing
> test that dirtied the state of the test repository by leaving behind an in-progress
> merge.

Jonathan's answer is an option. Another one is

test_expect_success 'cleanup' '
	git reset ...
'

So if the cleanup goes wrong, one can notice.

> I'm new to the mailing-list patch submission process; how would I go
> about adding it?

You can apply my patch with "git am" in your tree (or at worse, do it by
hand and steal authorship, I don't mind for a 2 characters patch ;-) ),
fix your patch to add the missing &&, and then resend with stg like "git
send-email -v2 --in-reply-to=<old-msg-id>"

> Submit the cover-letter & patches again?

Definitely submit patches again. Usually, the cover letter for a resend
emphasizes on changes compared to previous version.

> Squash your commit into the relevant one of mine?

Preferably not, as my fix is unrelated from yours (mine can come before,
as a cleanup).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
