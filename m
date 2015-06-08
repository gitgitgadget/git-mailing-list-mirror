From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH v5 03/10] for-each-ref: rename 'refinfo' to 'ref_array_item'
Date: Mon, 08 Jun 2015 16:42:11 +0200
Message-ID: <vpq4mmi8doc.fsf@anie.imag.fr>
References: <55729B78.1070207@gmail.com>
	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>
	<1433574581-23980-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 16:42:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1yFp-0006oh-2O
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 16:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbbFHOmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 10:42:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51443 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbbFHOmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 10:42:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t58Eg95o024293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 16:42:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58EgBI3006423;
	Mon, 8 Jun 2015 16:42:11 +0200
In-Reply-To: <1433574581-23980-3-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 6 Jun 2015 12:39:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Jun 2015 16:42:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58Eg95o024293
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434379330.21246@NST5EcFaHbo3225/TF+uAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271037>

Karthik Nayak <karthik.188@gmail.com> writes:

> Make 'symref' a non const char pointer, so that the compiler doesn't
> throw an error when we try to free the memory allocated to it.

Casting to non-cost when calling free() is a common pattern. I think it
would make more sense to cast at free() time and keep the member const.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
