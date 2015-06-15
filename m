From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] send-email quote issues
Date: Mon, 15 Jun 2015 13:32:37 +0200
Message-ID: <vpqmw011a22.fsf@anie.imag.fr>
References: <330077615.505681.1434367014434.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 15 13:32:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4SdD-0003ty-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 13:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbbFOLcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 07:32:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59160 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbbFOLcm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 07:32:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5FBWaKM027603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jun 2015 13:32:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5FBWbP9015733;
	Mon, 15 Jun 2015 13:32:37 +0200
In-Reply-To: <330077615.505681.1434367014434.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Mon, 15 Jun 2015 13:16:54 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jun 2015 13:32:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5FBWaKM027603
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434972758.75296@gepAbJ56c1LJjcdJCY3fZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271679>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Currently, git send-email contains a function which splits at commas
> with respect to quotes (parse_address_line introduced by
> 5012699d9840fe34fe0838ea0d529c2f32f76b82).

It seems I had missed this one, but indeed, it should probably be used
instead of split_at_commas in your series.

> It is used to parse user input when there's no recipient specified. I
> would like to use this function to parse --to, --cc and --bcc options,
> but the execution of this function depends on whether the user has the
> Perl library Mail::Address or not. This introduce a change in the
> behaviour:

I would say that using parse_address_line is good for consistancy in Git
anyway. If the behavior of parse_address_line is broken on some
corner-cases, then it should be fixed anyway.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
