From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Tue, 06 May 2014 20:49:22 +0200
Message-ID: <vpqzjiuu4i5.fsf@anie.imag.fr>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
	<1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
	<20140505184441.GS9218@google.com>
	<110110563.544859.1399320654149.JavaMail.zimbra@imag.fr>
	<xmqqppjqg6an.fsf@gitster.dls.corp.google.com>
	<87mweuss7d.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	d9ba@mailtor.net, peff@peff.net
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 06 22:17:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhkRM-000361-IF
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 20:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbaEFSuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 14:50:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53814 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbaEFSuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 14:50:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s46InKmZ028593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 May 2014 20:49:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s46InPuE014564;
	Tue, 6 May 2014 20:49:25 +0200
In-Reply-To: <87mweuss7d.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 06 May 2014 20:00:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 May 2014 20:49:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s46InKmZ028593
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400006962.64256@KsrSp+t4X+0Z2BKt0ni5ww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248237>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I still find the output from "git blame" disturbing, though.  The
>> first thing I do in "git blame" output is to scroll to the right in
>> order to identify the the area I am interested in, and this first
>> step is not negatively affected, because the right scrolled output 
>> automatically wraps long lines.
>>
>> But my second step is to scroll back to the left edge to find the
>> commit object name and at that point, the new default output without
>> "S" gets somewhat annoying, because most of the output lines from
>> "git blame" are longer than my window width.
>
> git blame sucks in anything but fullscreen either way.  It would help to
> display _only_ the source code and have the other info as mouse-over,
> but that's not something a pager can do.

Exactly. I personally never use "git blame" outside "git gui blame" for
this reason.

It's possible for a user to set pager.blame to "less -S" to get back to
the previous behavior only for blame.

The idea of having a separate default value for pager.blame (or set
$LESS differently for blame) crossed my mind, but I actually don't like
it, as it would make it harder for a user to fine-tune his configuration
manually (one would have to cancel all the corner-cases that Git would
set by default).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
