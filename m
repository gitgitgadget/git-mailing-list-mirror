From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv5 3/3] status: don't suggest "git rm" or "git add" if not appropriate
Date: Fri, 01 Jun 2012 10:55:10 +0200
Message-ID: <vpqzk8nif81.fsf@bauges.imag.fr>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338477344-15940-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaNdr-0008Ny-7I
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 10:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382Ab2FAIzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 04:55:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57427 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932351Ab2FAIzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 04:55:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q518kgc1030199
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 10:46:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SaNdY-0004Yc-6y; Fri, 01 Jun 2012 10:55:12 +0200
In-Reply-To: <1338477344-15940-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Thu, 31 May 2012 17:15:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 01 Jun 2012 10:46:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q518kgc1030199
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339145206.87059@u/xygYin4X6nTw4ifwd0Tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198962>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

>  	# Unmerged paths:
> -	#   (use "git add/rm <file>..." as appropriate to mark resolution)
> +	#   (use "git add <file>..." to mark resolution)
>  	#
>  	#	both modified:      main.txt
>  	#

This makes me think of another possible improvement (unrelated from this
one). When merging a binary file, one gets

# On branch branch
# Unmerged paths:
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#       both modified:      binary.bin
#

But no conflict markers, as they would make no sense in the file. Then,
it's a real pain to fix if you're not a Git expert. It would help, in
the presence of binary files, to turn that into :

# Unmerged paths:
#   (use "git checkout --ours [-- path]" to checkout your version)
#   (use "git checkout --theirs [-- path]" to checkout the version being merged)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#       both modified:      binary.bin
#

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
