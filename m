From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Wed, 07 May 2014 19:54:11 +0200
Message-ID: <vpqlhudqxto.fsf@anie.imag.fr>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
	<1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
	<20140505184441.GS9218@google.com>
	<110110563.544859.1399320654149.JavaMail.zimbra@imag.fr>
	<xmqqppjqg6an.fsf@gitster.dls.corp.google.com>
	<87mweuss7d.fsf@fencepost.gnu.org> <vpqzjiuu4i5.fsf@anie.imag.fr>
	<20140506215516.GA30185@sigill.intra.peff.net>
	<xmqqy4ydbjqm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, David Kastrup <dak@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	d9ba@mailtor.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 19:54:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi633-0003jC-NM
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 19:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbaEGRy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 13:54:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55754 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900AbaEGRyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 13:54:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s47Hs8Nu032139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 May 2014 19:54:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s47HsBRs031460;
	Wed, 7 May 2014 19:54:11 +0200
In-Reply-To: <xmqqy4ydbjqm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 07 May 2014 10:07:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 07 May 2014 19:54:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s47Hs8Nu032139
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400090049.61017@qMk8IL2lTThkhsyDNgbXng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248337>

Junio C Hamano <gitster@pobox.com> writes:

> While I fully agree with the above conclusion, I just noticed that I
> will be irritated enough to eventually set pager.blame myself, after
> running a short "git blame -L1311,+7 git-p4.py", which is one of the
> standard first steps for me to start reading patches submit on the
> list.

Perhaps it deserves a mention in the doc, e.g. squashing this on top of
my patch:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b7f92ac..ebd1676 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -570,7 +570,9 @@ command to `LESS=FRX less -S`. The environment does not set the
 long lines. Similarly, setting `core.pager` to `less -+F` will
 deactivate the `F` option specified by the environment from the
 command-line, deactivating the "quit if one screen" behavior of
-`less`.
+`less`.  One can specifically activate some flags for particular
+commands: for example, setting `pager.blame` to `less -S` enables
+line truncation only for `git blame`.
 +
 Likewise, when the `LV` environment variable is unset, Git sets it
 to `-c`.  You can override this setting by exporting `LV` with

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
