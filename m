From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/5] t/t1304: set the mask ACL that is checked in check_perms_and_acl
Date: Mon, 15 Mar 2010 18:37:27 +0100
Message-ID: <vpqy6ht5vvs.fsf@bauges.imag.fr>
References: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
	<YowxgPZqaOkg2MZzY1CxLzeL4DIwxt_o3RKS9xen-cewKbECZA7OIb7mUaY2TbsVR_rHE5GTeU0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Mar 15 18:37:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrEEf-0006xs-Bv
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179Ab0CORhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:37:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52524 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752707Ab0CORhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:37:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o2FHY3UN003539
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Mar 2010 18:34:03 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NrEEJ-0008WP-9p; Mon, 15 Mar 2010 18:37:27 +0100
In-Reply-To: <YowxgPZqaOkg2MZzY1CxLzeL4DIwxt_o3RKS9xen-cewKbECZA7OIb7mUaY2TbsVR_rHE5GTeU0@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon\, 15 Mar 2010 12\:14\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Mar 2010 18:34:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o2FHY3UN003539
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1269279244.36858@M0TtwI+dB0wJOXC2qUjBPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142235>

Brandon Casey <casey@nrlssc.navy.mil> writes:

>  test_expect_success 'Setup test repo' '
>  	setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx $dirs_to_set &&
> +	setfacl -m m:rwx               $dirs_to_set &&

The patch sounds right, but I don't understand the commit message. You
set m:rwx, and check_perms_and_acl expects mask::r--, so it's not
exactly what check_perms_and_acl checks.

My understanding is that you set the mask here to enforce the validity
of the ACL, but then you may want to just squash this into [PATCH 2/5].

But again, that's bikeshedding, the patch serie looks right to me.
Sorry for not making the test right myself ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
