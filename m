From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Output from git diff-tree (documentation)
Date: Mon, 27 Jul 2009 14:03:27 -0700
Message-ID: <7vbpn5g7og.fsf@alter.siamese.dyndns.org>
References: <87hbwxaolw.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Jul 27 23:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVXMM-00009M-N9
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 23:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbZG0VDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2009 17:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbZG0VDg
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 17:03:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZG0VDg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 17:03:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2AEE8132E0;
	Mon, 27 Jul 2009 17:03:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F0D5132DD; Mon, 27 Jul 2009
 17:03:31 -0400 (EDT)
In-Reply-To: <87hbwxaolw.fsf@krank.kagedal.org> ("David =?utf-8?Q?K=C3=A5g?=
 =?utf-8?Q?edal=22's?= message of "Mon\, 27 Jul 2009 21\:54\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F35D725A-7AF0-11DE-8085-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> The "git diff-tree HEAD" command (with the default raw output) starts
> by printing a hash, which seems to be the hash for the commit (HEAD i=
n
> this case).

That was because "git diff-tree" was the historical workhorse of "git
log".  The latter literally was "rev-list HEAD | git diff-tree --stdin"=
=2E

Giving a commit on the command line and giving one from the stdin was m=
ade
consistent.  IOW, "rev-list HEAD | xargs -n1 git diff-tree" would give =
you
a similar output.
