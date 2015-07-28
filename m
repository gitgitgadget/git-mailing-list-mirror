From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 01/11] ref-filter: add "%(objectname:size=X)" option
Date: Tue, 28 Jul 2015 10:42:22 +0200
Message-ID: <vpqio941xn5.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:42:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK0TF-0001Ua-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 10:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbbG1Ime (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 04:42:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41076 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbbG1Imb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 04:42:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6S8gLkj008458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 10:42:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6S8gMHp026725;
	Tue, 28 Jul 2015 10:42:22 +0200
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:26:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 28 Jul 2015 10:42:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6S8gLkj008458
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438677744.45415@YBetL0P8EysNnXmedO6Z0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274758>

Karthik Nayak <karthik.188@gmail.com> writes:

> +	if (skip_prefix(name, "objectname:size=", &p)) {
> +		unsigned int size = atoi(p);

You have the same problem as for tag.c: don't use atoi, and make
accurate error checking (absence of value, negative value, non-integer
value).

If you have other higher-priorities task, leave a temporary comment 
/* FIXME: ... */ or /* TODO: ... */ and make sure you have no such
comment when you drop the "RFC" in the subject of your emails.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
