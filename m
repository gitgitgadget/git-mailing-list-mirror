From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 10/19] git-submodule.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 16:07:47 +0200
Message-ID: <vpqegzo4k7g.fsf@anie.imag.fr>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
	<1400593832-6510-11-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 16:08:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmki0-0000Om-Ra
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 16:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbaETOH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 10:07:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48313 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456AbaETOH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 10:07:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s4KE7jXj021906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 May 2014 16:07:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4KE7l9Z008947;
	Tue, 20 May 2014 16:07:47 +0200
In-Reply-To: <1400593832-6510-11-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 20 May 2014 06:50:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 20 May 2014 16:07:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4KE7jXj021906
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1401199668.01145@nQpZbRtI4tA7Gl7s3a3KIA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249682>

Elia Pinto <gitter.spiros@gmail.com> writes:

> -			test $status = D -o $status = T && echo "$sm_path" && continue
> +			{
> +			test "$status" = D ||
> +			test "$status" = T
> +			} &&
> +			echo "$sm_path"
> +			&& continue

We usually write the && at the end of the line, hence that would be

echo "$sm_path" &&
continue

(shouldn't block the patch, but you may change if you need to resend)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
