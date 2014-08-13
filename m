From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/4] ll-merge.c: refactor `read_merge_config()` to use `git_config_string()`
Date: Wed, 13 Aug 2014 15:07:43 +0200
Message-ID: <vpq8umstu5c.fsf@anie.imag.fr>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
	<1407918122-29973-2-git-send-email-tanayabh@gmail.com>
	<vpqfvh0vd4a.fsf@anie.imag.fr> <53EB5D58.7000300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 15:07:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHYHT-0004GF-JH
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 15:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbaHMNHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 09:07:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59722 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbaHMNHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 09:07:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7DD7gqD010537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2014 15:07:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7DD7hfK024336;
	Wed, 13 Aug 2014 15:07:43 +0200
In-Reply-To: <53EB5D58.7000300@gmail.com> (Tanay Abhra's message of "Wed, 13
	Aug 2014 18:13:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Aug 2014 15:07:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7DD7gqD010537
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408540067.42321@TC0ml4ZpjjI2E02jgQSFfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255208>

Tanay Abhra <tanayabh@gmail.com> writes:

> There is one slight behavior change, previously "merge.default"
> silently ignored a NULL value and didn't raise any error. But,
> in the same function, all other values raise an error on a NULL
> value. So to conform with other call sites in Git, a NULL value
> for "merge.default" raises an error.

Good, thanks.

> We cannot easily use the new config-set API here, because
> much of the function is dedicated to processing
> "merge.<name>.variable" which does not easily translate to
> the new API. If it were for variables like,
> "merge.summary", "merge.tool", and "merge.verbosity", we
> could use the new API.

I think this would deserve to be in the commit message, but I'm fine
with keeping it here too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
