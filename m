From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] Testing: XDG config files: Use "$HOME" and "$XDG_CONFIG_HOME" explicitly
Date: Tue, 17 Jul 2012 20:19:16 +0200
Message-ID: <vpqehoap7x7.fsf@bauges.imag.fr>
References: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
	<e118f47351094d4fb45dd34bc08b9e9b-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 20:19:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrCMv-0007Ol-7j
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 20:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab2GQST2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 14:19:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56190 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259Ab2GQST1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 14:19:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6HIHOog032274
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2012 20:17:24 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrCMe-00020o-Vl; Tue, 17 Jul 2012 20:19:17 +0200
In-Reply-To: <e118f47351094d4fb45dd34bc08b9e9b-mfwitten@gmail.com> (Michael
	Witten's message of "Tue, 17 Jul 2012 16:41:21 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 17 Jul 2012 20:17:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6HIHOog032274
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343153848.13472@0i/h1ykelAXMlahKb7y2Mg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201616>

Michael Witten <mfwitten@gmail.com> writes:

> The tests in:
>
>   t/t1306-xdg-files.sh
>
> relied on brittle conventions:
>
>   * "$HOME" and "$XDG_CONFIG_HOME" having certain values.
>
>   * The testing commands having a certain current working
>     directory;

Other tests (t1305-config-include.sh at least) use the fact that the
tests are ran in $HOME. I'm not sure if we want to change that.

About XDG_CONFIG_HOME, the tests were just assuming it was unset.

> +GIT_CONFIG_DIR=$XDG_CONFIG_HOME/git

As I said in my earlier message, I'd rather test the default value
($HOME/.config/git) than the particular case whe $XDG_CONFIG_HOME is
set.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
