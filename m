From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7500-commit.sh: do not call test_set_editor
 unnecessarily, it's confusing
Date: Mon, 29 Dec 2008 01:57:46 -0800
Message-ID: <7vbpuvcnhh.fsf@gitster.siamese.dyndns.org>
References: <1230542658-9758-1-git-send-email-dato@net.com.org.es>
 <7vmyefco11.fsf@gitster.siamese.dyndns.org>
 <20081229095220.GA26942@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Mon Dec 29 10:59:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHEu8-0007UM-F3
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 10:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbYL2J5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 04:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbYL2J5z
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 04:57:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbYL2J5z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 04:57:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D24851B497;
	Mon, 29 Dec 2008 04:57:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4D5551B493; Mon,
 29 Dec 2008 04:57:47 -0500 (EST)
In-Reply-To: <20081229095220.GA26942@chistera.yi.org> (Adeodato
 =?utf-8?Q?Sim=C3=B3's?= message of "Mon, 29 Dec 2008 10:52:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 288F2232-D58F-11DD-9712-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104094>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> * Junio C Hamano [Mon, 29 Dec 2008 01:46:02 -0800]:
> ...
>> That 'zort' came from 1320857 (builtin-commit: fix --signoff, 2007-1=
1-11),
>> and I _think_ it is trying to make sure that presense of "-F -" make=
s the
>> editor not to trigger.
>
> Hm. Well, if that is true, then IMHO it should be in a /separate/ tes=
t
> case, for clarity. Probably in "message from stdin" test from t7501.
>
> That's of course just my opinion, and I'll accept if you prefer to
> maintain it the way it is now. I also volunteer to move it to t7501 i=
f
> that's what you prefer, just let me know.

I underscored _think_ and CC'ed Dscho for a reason.

If "-F -" has a bug, and if you do not define GIT_EDITOR, your test may
not work unattended (i.e. neither succeed nor finish but gets stuck).
Perhaps that is the issue?  I dunno.
