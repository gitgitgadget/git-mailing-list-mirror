From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to check out the repository at a particular point in time
Date: Tue, 23 Aug 2011 18:09:25 +0200
Message-ID: <vpqliuk85ze.fsf@bauges.imag.fr>
References: <201108221525.32982.trast@student.ethz.ch>
	<1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
	<CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
	<20110823160525.GB3545@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Witten <mfwitten@gmail.com>, rdiezmail-temp2@yahoo.de,
	Thomas Rast <trast@student.ethz.ch>, in-git-vger@baka.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 18:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvtXy-0003jD-L4
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 18:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab1HWQJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 12:09:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34849 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab1HWQJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 12:09:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7NG9BR4013998
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Aug 2011 18:09:11 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QvtXa-0001U1-EL; Tue, 23 Aug 2011 18:09:26 +0200
In-Reply-To: <20110823160525.GB3545@elie.gateway.2wire.net> (Jonathan Nieder's
	message of "Tue, 23 Aug 2011 11:05:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Aug 2011 18:09:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7NG9BR4013998
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1314720551.63555@h/cz1MdpOwavlKaCfYi0Tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179944>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michael Witten wrote:
>> On Mon, Aug 22, 2011 at 15:18, R. Diez <rdiezmail-temp2@yahoo.de> wrote:
>
>>> I still don't quite understand how git works, but let me
>>> risk a naive statement here. If "a-b-c-M" were 'master',
>>> and "d-e-f" were 'new-feature', then on April 1st the
>>> current version on 'master' is 'b', because I merged the
>>> 'new-feature' branch at a later point in time. Does that
>>> make sense?
>>
>> O! for the love all that is Holy!
>
> Wait, what's wrong with what R. Diez said?  It's exactly what
> --first-parent gives you.

Not really. Suppose, on April 1st, I have

A--B--C <-master
    \
     D--E <-new-feature

Then, I merge from upstream

A--B-----C <-master
    \     \
     D--E--F <-new-feature

and then I push to master, or master fast-forward-pulls from me:

A--B-----C
    \     \
     D--E--F <-new-feature, master

Then, what used to be in master on April 1st is C, but --first-parent
will give you E instead.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
