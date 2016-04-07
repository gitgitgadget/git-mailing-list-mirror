From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] builtin/am: read mailinfo from file
Date: Thu, 07 Apr 2016 19:36:07 +0200
Message-ID: <vpqinzttj7c.fsf@anie.imag.fr>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:36:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDqv-0001QQ-LI
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757063AbcDGRgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:36:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42304 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756860AbcDGRgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:36:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u37Ha6YL011973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 7 Apr 2016 19:36:06 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u37Ha7qk006172;
	Thu, 7 Apr 2016 19:36:07 +0200
In-Reply-To: <1460042563-32741-4-git-send-email-mst@redhat.com> (Michael S.
	Tsirkin's message of "Thu, 7 Apr 2016 18:23:13 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 07 Apr 2016 19:36:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u37Ha6YL011973
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460655368.14758@BAFJ//PGo6IAVPUKDU96Lw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290939>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> -	strbuf_addbuf(&msg, &mi.log_message);
> +
> +	if (strbuf_read_file(&log_msg,  am_path(state, "msg"), 0) < 0) {
> +		die_errno(_("could not read '%s'"), am_path(state, "msg"));
> +	}

Style: we omit the braces where not needed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
