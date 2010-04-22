From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 23:40:09 +0200
Message-ID: <vpq7hnzcgjq.fsf@bauges.imag.fr>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<7vsk6n2n48.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Goswin von Brederlow <goswin-v-b@web.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 23:40:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O548m-0000st-Ao
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 23:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab0DVVkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 17:40:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42499 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab0DVVks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 17:40:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o3MLYpdU007043
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 22 Apr 2010 23:34:51 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O5482-0007G1-2F; Thu, 22 Apr 2010 23:40:10 +0200
In-Reply-To: <7vsk6n2n48.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 22 Apr 2010 14\:28\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 22 Apr 2010 23:34:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o3MLYpdU007043
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1272576892.85943@B+jtDTfr4Aj8TDbxZ4QO2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145567>

Junio C Hamano <gitster@pobox.com> writes:

> Think of this sequence:

There's another case where it would be hard to decide what's "The
Right Thing":

vi existing-file.c # do some changes
vi new-file.c      # create the file
git add new-file.c
git commit

If you take the SVN semantics, the last "git commit" should commit the
changes to existing-file.c. But keeping the current Git semantics, it
doesn't. There are valid reasons why a user can type the above
sequence with today's Git, and changing it would be backward
incompatible, and would make the senario a lot more painfull.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
