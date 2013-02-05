From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug in "git log --graph -p -m" (version 1.7.7.6)
Date: Tue, 05 Feb 2013 22:09:48 +0100
Message-ID: <vpqmwvia2n7.fsf@grenoble-inp.fr>
References: <201302051700.r15H0GXx031004@freeze.ariadne.com>
	<7vtxpqslpm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: worley@alum.mit.edu (Dale R. Worley), git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 22:10:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2pmX-0004EK-7r
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 22:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab3BEVJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 16:09:58 -0500
Received: from mx2.imag.fr ([129.88.30.17]:50039 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640Ab3BEVJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 16:09:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r15L9k9p027281
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Feb 2013 22:09:46 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U2pm1-00036G-33; Tue, 05 Feb 2013 22:09:49 +0100
In-Reply-To: <7vtxpqslpm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2013 09:40:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Feb 2013 22:09:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r15L9k9p027281
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360703388.8892@ZzM4Eobv4CnhNznoLODzWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215541>

Junio C Hamano <gitster@pobox.com> writes:

> worley@alum.mit.edu (Dale R. Worley) writes:
>
>> I have found a situation where "git log" produces (apparently)
>> endless output.  Presumably this is a bug.  Following is a (Linux)
>> script that reliably reproduces the error for me (on Fedora 16):
>
> Wasn't this fixed at v1.8.1.1~13 or is this a different issue?

In any case, I can't reproduce with 1.8.1.2.526.gf51a757: I don't get
undless output. On the other hand, I get a slightly misformatted output:

*   commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 2c1e6a36f4b712e914fac994463da7d0fdb2bc6d)
|\  Merge: 2c1e6a3 33e70e7
| | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
| | Date:   Tue Feb 5 22:05:33 2013 +0100
| | 
| |     Commit S
| | 
| | diff --git a/file b/file
| | index 6bb4d3e..afd2e75 100644
| | --- a/file
| | +++ b/file
| | @@ -1,4 +1,5 @@
| |  1
| |  1a
| |  2
| | +2a
| |  3
| | 
commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 33e70e70c0173d634826b998bdc304f93c0966b8)
| | Merge: 2c1e6a3 33e70e7
| | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
| | Date:   Tue Feb 5 22:05:33 2013 +0100

The second "commit" line (diff with second parent) doesn't have the
"| |" prefix, I don't think this is intentional.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
