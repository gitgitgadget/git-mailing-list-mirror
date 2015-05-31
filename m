From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH v4 1/8] for-each-ref: extract helper functions out of grab_single_ref()
Date: Sun, 31 May 2015 22:39:36 +0200
Message-ID: <vpqvbf8jxbr.fsf@anie.imag.fr>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-1-git-send-email-karthik.188@gmail.com>
	<xmqqvbf8abwi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 22:40:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzA1v-0007XJ-SV
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 22:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758398AbbEaUjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 16:39:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47741 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbbEaUjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 16:39:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4VKdYYj008758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 31 May 2015 22:39:34 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4VKdbDS001605;
	Sun, 31 May 2015 22:39:37 +0200
In-Reply-To: <xmqqvbf8abwi.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 31 May 2015 10:34:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 31 May 2015 22:39:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4VKdYYj008758
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433709576.07592@OFSUMjtyhJVySIifBt7i5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270350>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>  /*
>> + * Given a refname, return 1 if the refname matches with one of the patterns
>> + * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
>> + * and so on, else return 0. Supports use of wild characters.
>> + */
>> +static int match_name_as_path(const char **pattern, const char *refname)
>> +{
>
> I wonder why this is not "match_refname", in other words, what the
> significance of "as path" part of the name?

Just match_refname may not carry all the semantics of the function,
which matches a prefix up to the end of string, or up to a / (but you
can't just be a prefix stopping in the middle of a word). To me, the
"_as_path" helped understanding the overall behavior of the function.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
