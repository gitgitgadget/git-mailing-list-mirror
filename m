From: Matthieu Moy <Matthieu.Moy@Grenoble-inp.fr>
Subject: Re: [PATCH] config: Add documentation for writing config files
Date: Mon, 02 Jun 2014 21:37:43 +0200
Message-ID: <vpq38fnf6go.fsf@anie.imag.fr>
References: <1401715621-3681-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 21:37:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrY3M-00029X-9P
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 21:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbaFBThs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 15:37:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51898 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbaFBThs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 15:37:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s52JbfU3007421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jun 2014 21:37:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s52JbhK6023061;
	Mon, 2 Jun 2014 21:37:43 +0200
In-Reply-To: <1401715621-3681-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 2 Jun 2014 06:27:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Jun 2014 21:37:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s52JbfU3007421
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1402342663.29539@dcstZSGEIYxCoUKrh8iiZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250587>

Tanay Abhra <tanayabh@gmail.com> writes:

> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  Documentation/technical/api-config.txt | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)

Even though the reason to replace a TODO with real stuff is rather
straigthforward, the reader appriates a short commit message (ideally
pointing to the commit introducing the TODO). My first thought reading
the patch was "wtf, is that a patch in the middle of a series, where
does this TODO come from" ;-).

> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> index 230b3a0..df08385 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt
> @@ -137,4 +137,33 @@ int read_file_with_include(const char *file, config_fn_t fn, void *data)
>  Writing Config Files
>  --------------------
>  
> -TODO
> +Git gives multiple entry points in the Config API to write config values to
> +files namely `git_config_set_in_file` and `git_config_set`, which write to
> +a specific config file or to `.git/config` respectively. They both take a
> +key/value pair as parameter.

Sounds good.

> +In the end they both all call `git_config_set_multivar_in_file` which takes
> +four parameters:

Do we really want to document this as part of the config API? i.e. does
a normal user of the API want to know about this? My understanding is
that git_config_set_multivar_in_file is essentially a private function,
and then the best place to document is with comments near the function
definition (it already has such comment).

Your text is easier to understand and more detailed, but I would
personnally prefer improving the in-code comment (possibly just leaving
a mention of git_config_set_multivar_in_file and pointing the reader to
the code for details).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
