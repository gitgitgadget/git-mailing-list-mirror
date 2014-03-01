From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: RFC GSoC idea: new "git config" features
Date: Sat, 01 Mar 2014 12:01:44 +0100
Message-ID: <vpq38j2tc6f.fsf@anie.imag.fr>
References: <53108650.2020708@alum.mit.edu>
	<xmqqwqgft3bj.fsf@gitster.dls.corp.google.com>
	<53112794.2070007@alum.mit.edu>
	<20140301075247.GF20397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 12:02:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJhgS-0007j5-LU
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 12:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbaCALCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 06:02:16 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47475 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbaCALCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 06:02:16 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s21B1i8H017219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 1 Mar 2014 12:01:44 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s21B1iNL030899;
	Sat, 1 Mar 2014 12:01:44 +0100
In-Reply-To: <20140301075247.GF20397@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 1 Mar 2014 02:52:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 01 Mar 2014 12:01:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s21B1i8H017219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394276510.79504@qBKtYnvs0m47hQDKCSkCjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243058>

Jeff King <peff@peff.net> writes:

> If we had the keys in-memory, we could reverse this: config code asks
> for keys it cares about, and we can do an optimized lookup (binary
> search, hash, etc).

I'm actually dreaming of a system where a configuration variable could
be "declared" in Git's source code, with associated type (list/single
value, boolean/string/path/...), default value and documentation (and
then Documentation/config.txt could become a generated file). One could
imagine a lot of possibilities like

$ git config --describe <some-variable>
Type: boolean
Default value: true
Description: ...

Somehow, do for config variables what has been done for command-line
option parsing.

Migrating the whole code to such system would take time, but creating
the system and applying it to a few examples might be feasible as a GSoC
project.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
