From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH 2/3] home_config_path: allow NULL xdg parameter
Date: Fri, 25 Jul 2014 20:16:20 +0200
Message-ID: <vpqa97x483v.fsf@anie.imag.fr>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
	<1406295891-7316-2-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa97x71p7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:16:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAk2j-0002ZX-5u
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 20:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbaGYSQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 14:16:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51985 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbaGYSQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 14:16:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PIGIbO016651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 20:16:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PIGKBg023018;
	Fri, 25 Jul 2014 20:16:20 +0200
In-Reply-To: <xmqqa97x71p7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 25 Jul 2014 11:06:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 20:16:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PIGIbO016651
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406916981.09846@0AsI1KNgLoKnRSsA8Wzhzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254255>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> This allows a caller to requst the global config file without requesting
>> the XDG one.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> This is actually not needed, but I wrote this for a previous version,
>> and it seems sensible anyway.
>
> I was about to say "Let's not do this until some caller needs it",
> implicitly assuming that we do not let global=NULL to signal that
> the caller is interested only in XDG, but I checked and we do check
> the NULL-ness of global, so it is consistent to do so for xdg.  The
> change makes very good sense.
>
> I wouldn't have had to spend the time to dig, if the log message
> justified it that way, instead of having "actually not needed"
> comment there ;-)
>
> 	home_config_paths(): let the caller ignore xdg path
>
> 	The caller can signal that it is not interested in learning
> 	the location of $HOME/.gitconfig by passing global=NULL, but
> 	there is no way to decline the ptah to the configuration
> 	file based on $XDG_CONFIG_HOME.
>
>         Allow the caller to pass xdg=NULL to signal that it is not
>         interested in the XDG location.

Good point. Applied locally, I'll resend later.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
