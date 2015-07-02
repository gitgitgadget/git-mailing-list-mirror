From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/4] status: give more information during rebase -i
Date: Thu, 02 Jul 2015 10:10:32 +0200
Message-ID: <vpqpp4bdlon.fsf@anie.imag.fr>
References: <vpq7fqkz48f.fsf@anie.imag.fr>
	<1435739433-18853-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
	<vpqk2ujoadw.fsf@anie.imag.fr>
	<xmqqr3or7et9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 10:15:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAZe7-0006BA-TP
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 10:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbbGBIKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 04:10:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36834 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbbGBIKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 04:10:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t628AVAF012384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2015 10:10:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t628AWiw002007;
	Thu, 2 Jul 2015 10:10:32 +0200
In-Reply-To: <xmqqr3or7et9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jul 2015 14:23:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 Jul 2015 10:10:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t628AVAF012384
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436429435.40726@r8B/wgOMcC9CI/yJhLV+vA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273217>

Junio C Hamano <gitster@pobox.com> writes:

> In any case, I wouldn't have much time during the remainder of the
> day to requeue and/or comment; please check what I push out on 'pu'.

BTW, I do agree with this hunk:

@@ -1068,18 +1064,20 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 static void read_rebase_todolist(const char *fname, struct string_list *lines)
 {
        struct strbuf line = STRBUF_INIT;
-       FILE *f = fopen(git_path(fname), "r");
+       FILE *f = fopen(git_path("%s", fname), "r");
 
        if (!f)
-               die_errno("Could not open file %s for reading", git_path(fname));
+               die_errno("Could not open file %s for reading",
+                         git_path("%s", fname));

Let me know if you want me to resend. In any case, I'm fine with your
"SQUASH ??" version even though I prefer mine (cf. other message).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
