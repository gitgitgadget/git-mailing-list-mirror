From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 3/4] log --count: added test
Date: Fri, 03 Jul 2015 11:54:44 +0200
Message-ID: <vpqpp491s7v.fsf@anie.imag.fr>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-4-git-send-email-lawrencesiebert@gmail.com>
	<vpqwpyh4rup.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	gitster@pobox.com
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 11:55:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAxgX-0001z9-L0
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 11:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbbGCJzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 05:55:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38959 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673AbbGCJy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 05:54:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t639shXd017130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2015 11:54:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t639siLe026318;
	Fri, 3 Jul 2015 11:54:44 +0200
In-Reply-To: <vpqwpyh4rup.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	03 Jul 2015 09:34:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Jul 2015 11:54:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t639shXd017130
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436522088.38962@OyJqWPa3d19Aow6UWCwb2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273290>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Also, some revision-limiting options can reduce the count like
>
> git log --grep whatever

OK, --grep seems to work, but -S and -G do not:

$ ./bin-wrappers/git log -Sfoo --count
40012
$ ./bin-wrappers/git log -Sfoo --oneline | wc -l
925
$ ./bin-wrappers/git log --count                 
40012

See 251df09 (log: fix --max-count when used together with -S or -G,
2011-03-09) for a start of an explanation.

If implementing a proper count is too hard, one option is to forbid
--count -S and --count -G to avoid confusion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
