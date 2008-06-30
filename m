From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Don't cut off last character of commit descriptions.
Date: Mon, 30 Jun 2008 12:55:06 +0200
Message-ID: <87k5g7fb05.fsf@lysator.liu.se>
References: <m2abh3z14f.fsf@nschum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Nikolaj Schumacher <n_schumacher@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 12:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDH3G-0000Qj-V8
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 12:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbYF3KzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 06:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754706AbYF3KzJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 06:55:09 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:59172 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbYF3KzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 06:55:08 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jun 2008 06:55:08 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 46F16200B6D7;
	Mon, 30 Jun 2008 12:55:07 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27794-01-59; Mon, 30 Jun 2008 12:55:06 +0200 (CEST)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E7E67200B097;
	Mon, 30 Jun 2008 12:55:06 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 7EA26E48013; Mon, 30 Jun 2008 12:55:06 +0200 (CEST)
In-Reply-To: <m2abh3z14f.fsf@nschum.de> (Nikolaj Schumacher's message of "Mon\, 30 Jun 2008 12\:08\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86903>

Nikolaj Schumacher <n_schumacher@web.de> writes:

> From d485d9c86cba49671b74c7c1571a6ad7ec6d09b6 Mon Sep 17 00:00:00 200=
1
> From: Nikolaj Schumacher <git@nschum.de>
> Date: Mon, 30 Jun 2008 12:06:01 +0200
> Subject: [PATCH] Don't cut off last character of commit descriptions.
>
> ---
>  contrib/emacs/git-blame.el |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
> index 9f92cd2..4fa70c5 100644
> --- a/contrib/emacs/git-blame.el
> +++ b/contrib/emacs/git-blame.el
> @@ -381,7 +381,7 @@ See also function `git-blame-mode'."
>                    "log" "-1"
>  		  (concat "--pretty=3D" git-blame-log-oneline-format)
>                    hash)
> -    (buffer-substring (point-min) (1- (point-max)))))
> +    (buffer-substring (point-min) (point-max))))
> =20
>  (defvar git-blame-last-identification nil)
>  (make-variable-buffer-local 'git-blame-last-identification)

Yes, this should have been part of
24a2293ad35d567530048f0d2b0d11e0012af26d git-blame.el: show the when,
who and what in the minibuffer. that changed from using
--pretty=3Doneline to --pretty=3Dformat:... without terminating newline=
=2E

--=20
David K=C3=A5gedal
