From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 5/6] config: add `git_die_config()` to the config-set API
Date: Mon, 28 Jul 2014 13:14:08 +0200
Message-ID: <vpq8undvipr.fsf@anie.imag.fr>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
	<1406543635-19281-6-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:14:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBisy-0006PU-K0
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 13:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbaG1LO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 07:14:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60634 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbaG1LO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 07:14:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBE6W0009696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2014 13:14:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBE8qC015549;
	Mon, 28 Jul 2014 13:14:08 +0200
In-Reply-To: <1406543635-19281-6-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 28 Jul 2014 03:33:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Jul 2014 13:14:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6SBE6W0009696
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407150848.3236@YocSRdOshtaNKOchu+G9/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254307>

Tanay Abhra <tanayabh@gmail.com> writes:

> +void git_die_config(const char *key)
> +{
> +	const struct string_list *values;
> +	struct key_value_info *kv_info;
> +	values = git_config_get_value_multi(key);
> +	kv_info = values->items[values->nr - 1].util;
> +	if (!kv_info->linenr)
> +		die("unable to parse command-line config");
> +	else
> +		die("bad config file line %d in %s",kv_info->linenr, kv_info->filename);

Missing space after ,.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
