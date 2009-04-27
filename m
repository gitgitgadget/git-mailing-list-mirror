From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [spurious parallel build bug] make -j fails with: "mv: mv:
 cannot stat `perl.mak': No such file or directory"
Date: Mon, 27 Apr 2009 10:01:35 -0700
Message-ID: <7vk5563ua8.fsf@gitster.siamese.dyndns.org>
References: <20090427094843.GA5849@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Apr 27 19:02:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyUDn-0002zB-L9
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 19:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbZD0RBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 13:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbZD0RBp
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 13:01:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZD0RBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 13:01:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C896412F0A;
	Mon, 27 Apr 2009 13:01:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4220912F08; Mon,
 27 Apr 2009 13:01:41 -0400 (EDT)
In-Reply-To: <20090427094843.GA5849@elte.hu> (Ingo Molnar's message of "Mon,
 27 Apr 2009 11:48:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15C05F6A-334D-11DE-90A7-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117694>

Ingo Molnar <mingo@elte.hu> writes:

> I got this when i built v1.6.3-rc3 for the first time:
>
> $ make -j
> [...]
>     CC builtin-annotate.o
>     CC builtin-apply.o
>     CC builtin-archive.o
>     CC builtin-bisect--helper.o
> mv: mv: cannot stat `perl.mak': No such file or directory
> mv: cannot stat `perl.mak': No such file or directory
>     CC builtin-blame.o
> mv: cannot stat `perl.mak': No such file or directory
> mv: cannot stat `perl.mak': No such file or directory
> cannot stat `perl.mak': No such file or directory
>
> a plain 'make' worked.
>
> Interestingly, a second attempt to reproduce it after a 'make clean' 
> failed to trigger the bug. So it's either timing sensitive or 
> there's some other weirdness that caused this.

I've seen this a few times on the master machine at k.org but haven't seen
it elsewhere, perhaps because I do not have an access to 8-way parallelism
anywhere else.
