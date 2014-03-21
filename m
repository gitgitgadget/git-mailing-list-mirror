From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Rewrite fsck.c:fsck_commit() replace memcmp() with starts_with()
Date: Fri, 21 Mar 2014 20:01:25 +0100
Message-ID: <vpqk3bngyuy.fsf@anie.imag.fr>
References: <1395419838-25527-1-git-send-email-cengoguzhanunlu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: blacksimit <cengoguzhanunlu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 20:01:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4hQ-0007YU-BW
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 20:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbaCUTBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 15:01:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51750 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291AbaCUTBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 15:01:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2LJ1N7l015926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Mar 2014 20:01:23 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2LJ1PK6008678;
	Fri, 21 Mar 2014 20:01:25 +0100
In-Reply-To: <1395419838-25527-1-git-send-email-cengoguzhanunlu@gmail.com>
	(blacksimit's message of "Fri, 21 Mar 2014 18:37:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 21 Mar 2014 20:01:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2LJ1N7l015926
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396033284.66428@cbpobgFhJltLvTsGCQLCGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244726>

blacksimit <cengoguzhanunlu@gmail.com> writes:


> -
> +    int magic_num;
> +    
> +    magic_num = strlen("tree "); /* magic_num is 5 */
>  	if (!starts_with(buffer, "tree "))

Whitespace damage. It seems you have set your tab-width to something
other than 8, and indented with spaces. Please don't do either.

> +    magic_num = strlen("committer"); /* magic_num is 7 */

Typical example of a counter-productive comment. A good comment usually
explains _why_ the code is as it is, and not _what_ it is doing. C is a
much better lanuage than english to describe algorithm, so if you want
magic_num to become equal to 7, then write "magic_num = 7" in code, not
in a comment.

Here, the reader has to spend time and energy to check the
correspondance between the code and the redundant comment ... and see
than they do not match!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
