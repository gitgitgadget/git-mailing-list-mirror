From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv4 2/2] git rebase -i: warn about removed commits
Date: Wed, 03 Jun 2015 20:06:16 +0200
Message-ID: <vpqd21c8y5j.fsf@anie.imag.fr>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<vpq1thsbsko.fsf@anie.imag.fr>
	<758899838.77480.1433354006473.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:06:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0D3i-0005pZ-DX
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 20:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbbFCSGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 14:06:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33684 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbbFCSG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 14:06:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t53I6EYl022611
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2015 20:06:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t53I6Gtm011799;
	Wed, 3 Jun 2015 20:06:16 +0200
In-Reply-To: <758899838.77480.1433354006473.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Wed, 3 Jun 2015 19:53:26 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Jun 2015 20:06:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t53I6EYl022611
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433959576.2038@xP/8yH3Af8ZZRw4LTThvxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270715>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> You're using $1 and $2 only to redirect input and output. I would find
>> it more elegant to write todo_list_to_sha_list as a filter, and do the
>> redirection in the call site (to keep the option of using
>> todo_list_to_sha_list in a pipe).
>
> If I understood correctly, then the calling line would look like:
>> todo_list_to_sha_list <"$todo".backup >"$todo".oldsha1
> ?

Yes.

> Should I do the same for the function warn_file ?
> Meaning
>> warn_file <"$todo".miss
> instead of
>> warn_file "$todo".miss

If you do so, then warn_file won't be a good name anymore since you'd be
able to read from a pipe too.

Anyway, it's really a matter of personnal preference. I would keep
warn_file as-is and change todo_list_to_sha_list, but feel free to
ignore this point if you disagree.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
