From: Nix <nix@esperi.org.uk>
Subject: Re: [PATCH 2/2] Support sizes >=2G in various config options accepting 'g' sizes.
Date: Tue, 06 Sep 2011 11:25:32 +0100
Message-ID: <87liu2j7c3.fsf@spindle.srvr.nix>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
	<1315223155-4218-2-git-send-email-nix@esperi.org.uk>
	<CAGdFq_gFNHq9Cgv4F4Q6VQ=G7odfUJ5pUFWn=OYE-BfXzP=Enw@mail.gmail.com>
	<87ty8rm6th.fsf@spindle.srvr.nix> <20110906074421.GB28490@ecki>
	<87ty8qjaof.fsf@spindle.srvr.nix> <4E65F451.4070900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:25:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0sqm-0004xO-QM
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118Ab1IFKZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:25:48 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:51506 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab1IFKZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:25:47 -0400
Received: from esperi.org.uk (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.4/8.14.3) with ESMTP id p86APWZL012041;
	Tue, 6 Sep 2011 11:25:32 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.14.4/8.12.11/Submit) id p86APWM8013498;
	Tue, 6 Sep 2011 11:25:32 +0100
Emacs: indefensible, reprehensible, and fully extensible.
In-Reply-To: <4E65F451.4070900@viscovery.net> (Johannes Sixt's message of
	"Tue, 06 Sep 2011 12:22:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-DCC-URT-Metrics: spindle 1060; Body=4 Fuz1=4 Fuz2=4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180792>

On 6 Sep 2011, Johannes Sixt verbalised:

> Why so? strtol() can report overflow:

... it can?!

>     ...
>     If the correct value is outside the range of representable values,
> {LONG_MIN}, {LONG_MAX}, {LLONG_MIN}, or {LLONG_MAX} shall be returned
> (according to the sign of the value), and errno set to [ERANGE].

I've been using it for longer than I care to imagine and I've never once
noticed that.

OK, I'll add range checking support then! following which we can detect
config value overflow on the most pathetic platform imaginable, except
that such a platform would probably not bother to set ERANGE properly ;}

Fixed patch following later today ripping out the STRTOMAX renaming and
adding proper range checking.

-- 
NULL && (void)
