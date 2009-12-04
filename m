From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] Add a command "fix" to rebase --interactive.
Date: Fri, 04 Dec 2009 18:44:15 +0100
Message-ID: <vpqaaxyocr4.fsf@bauges.imag.fr>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
	<6d779d2c244bf5d5b7924cdc5daf66a8186e4bc7.1259934977.git.mhagger@alum.mit.edu>
	<7v638mskmx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:47:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGcFj-0002BJ-UV
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbZLDRrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbZLDRrR
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:47:17 -0500
Received: from imag.imag.fr ([129.88.30.1]:42148 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212AbZLDRrP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:47:15 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nB4HiF3E022105
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 4 Dec 2009 18:44:15 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NGcCV-0004cF-ET; Fri, 04 Dec 2009 18:44:15 +0100
In-Reply-To: <7v638mskmx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 04 Dec 2009 09\:40\:22 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 04 Dec 2009 18:44:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134557>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 0bd3bf7..539413d 100755
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -302,7 +302,7 @@ nth_string () {
>>  
>>  make_squash_message () {
>>  	if test -f "$SQUASH_MSG"; then
>> -		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
>> +		COUNT=$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)\(th\|st\|nd\|rd\) commit message.*:/\1/p" \
>>  			< "$SQUASH_MSG" | sed -ne '$p')+1))
>
> This sed replacement worries me.  I don't have a time to check myself
> today but do we use \(this\|or\|that\) alternates with our sed script
> already elsewhere in the codebase (test scripts do not count)?

It seems we don't:

git$ git grep '\\|' *.sh
git-rebase--interactive.sh:             COUNT=$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)\(th\|st\|nd\|rd\) commit message.*:/\
git$ 

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
