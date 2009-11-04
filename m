From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for bare repos
Date: Wed, 04 Nov 2009 20:35:45 +0100
Message-ID: <vpqzl729j72.fsf@bauges.imag.fr>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
	<alpine.DEB.1.00.0911041422170.2788@felix-maschine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5leM-0001KV-4D
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbZKDTf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755091AbZKDTf6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:35:58 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54284 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbZKDTf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:35:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nA4JZ43c015897
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Nov 2009 20:35:07 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N5ldx-0002Yk-BO; Wed, 04 Nov 2009 20:35:45 +0100
In-Reply-To: <alpine.DEB.1.00.0911041422170.2788@felix-maschine> (Johannes Schindelin's message of "Wed\, 4 Nov 2009 14\:25\:33 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Nov 2009 20:35:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nA4JZ43c015897
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1257968107.67639@KpARZhIM5D8rzOuvvzq8Cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132118>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I did not have time yet to investigate, but it seems that there are 
> problems with the permissions of shared bare repositories when activating 
> the reflogs.

I can't think of any, and I just tried launching two

while true; do git pull; date > foo.txt ; git add .; git commit -m "xxx"; git push; done

in parallel, with two different users pushing to a --bare --shared
repository, and it did work well. But I may very well have missed
something.

(and actually, if it causes problem, it's an argument in favor of
defaulting to false when core.shared is true, not when core.bare).


Unless I missed something, I think core.logAllRefUpdates should be
enabled for bare repos.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
