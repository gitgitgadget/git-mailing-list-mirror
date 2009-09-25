From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How does gitosis know who the key belongs to
Date: Fri, 25 Sep 2009 10:20:23 +0200
Message-ID: <vpqhburigfs.fsf@olympe.imag.fr>
References: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com>
	<20090924172610.GA31309@book.hvoigt.net>
	<vpqskeckuto.fsf@bauges.imag.fr>
	<26ae428a0909242310r259ccf5eya7c95b8f43fc5c23@mail.gmail.com>
	<26ae428a0909242315x3cf1aafcue004a73f5c471450@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 25 10:21:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr63A-0001W8-JW
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 10:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbZIYIU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 04:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbZIYIU6
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 04:20:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52684 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbZIYIU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 04:20:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8P8HAqr025012
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 Sep 2009 10:17:10 +0200
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mr62R-00077j-OO; Fri, 25 Sep 2009 10:20:23 +0200
Received: from moy by olympe.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mr62R-0007mJ-Mn; Fri, 25 Sep 2009 10:20:23 +0200
In-Reply-To: <26ae428a0909242315x3cf1aafcue004a73f5c471450@mail.gmail.com> (Howard Miller's message of "Fri\, 25 Sep 2009 07\:15\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Sep 2009 10:17:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8P8HAqr025012
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254471432.2598@1CRnlxfqm/zcY8Sj3AtBUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129068>

Howard Miller <howard@e-learndesign.co.uk> writes:

> Ahh... just read Heiko's post properly and actually looked at the
> authorized_keys file. This is now starting to make some sense. So the
> name in config has to match that sent to gitosis-server presumably. I
> still don't quite see the cause and effect. If I don't like being
> howard@x.y.z and would rather be just 'howard' what can I change? It
> tells me not to edit that file!

If you're confused with "name", then just think about "filename
holding the key".

If you want to name yourself "howard", then put your key in
keydir/howard and then use "howard" in the config file. gitosis will
add the relevant

command="gitosis-server howard" ssh-whatever <your-key-here> <irrelevant-comment>

to the ~git/.ssh/auhtorized_keys file.

You chose your "name" by chosing the filename, then you use this name
in the config file, and then gitosis does the job.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
