From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2] pull: add --set-upstream
Date: Tue, 07 Jun 2016 09:06:18 +0200
Message-ID: <vpqeg89bhqt.fsf@anie.imag.fr>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
	<20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org>
	<vpqvb1mgvn5.fsf@anie.imag.fr>
	<xmqqoa7ew319.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 09:06:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAB64-0003nu-DP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 09:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbcFGHGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 03:06:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60992 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbcFGHGY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 03:06:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5776Iud026810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Jun 2016 09:06:18 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5776IPB014091;
	Tue, 7 Jun 2016 09:06:18 +0200
In-Reply-To: <xmqqoa7ew319.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 06 Jun 2016 12:06:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 07 Jun 2016 09:06:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u5776Iud026810
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465887979.07932@jeRelFplnZvrtD6/dZgOPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296608>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> +test_config_unchanged () {
>>> +	git config --list --local >original
>>> +	"$@"
>>> +	git config --list --local >modified
>>> +	test_cmp original modified
>>> +}
>>
>> The test passes if "$@" fails. You should &&-chain the lines here to
>> catch things like crashes or unexpected "exit 1" in git.
>
> That is true, but allowing "$@" failure may be deliberate. 

I don't think so:

+test_expect_success 'pull -u should not work when merging unrelated histories' '
+	git checkout master &&
+	test_config_unchanged test_must_fail git pull -u step_parent master
+'

;-)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
