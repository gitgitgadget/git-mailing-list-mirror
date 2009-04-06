From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-{diff,merge} refactor round 2
Date: Sun, 05 Apr 2009 17:33:55 -0700
Message-ID: <7vocvaoc24.fsf@gitster.siamese.dyndns.org>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <7vzlevv3fy.fsf@gitster.siamese.dyndns.org> <20090405211533.GA1393@gmail.com>
 <200904060015.17145.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, Johannes.Schindelin@gmx.de,
	charles@hashpling.org, git@vger.kernel.org,
	msysgit@googlegroups.com
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Apr 06 02:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqcoO-0007A9-S9
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 02:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbZDFAeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 20:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbZDFAeJ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 20:34:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbZDFAeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 20:34:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E3773A8433;
	Sun,  5 Apr 2009 20:34:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BAEC9A8432; Sun,
  5 Apr 2009 20:33:56 -0400 (EDT)
In-Reply-To: <200904060015.17145.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Mon, 6 Apr 2009 00:15:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A2048882-2242-11DE-BB57-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115747>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> David Aguilar, 05.04.2009:
> ...
>> 1. Base it on the current master, completely throwing away
>> the existing da/difftool branch.  That would include throwing
>> away the commit that's in next if we really want to be clean
>> about the history.  In the process, move Markus' mergetool
>> fixes for windows to the top so that they can be applied
>> independently if necessary.  This series would then depend
>> on them.
>
> This is my favourite, too.

Ok.  You two forgot another obvious option of not doing anything, but
since both of you seem to be Ok with the rewrite, let's take that
approach.  It is easy to revert the one premature merge out of next and
then merge the cleaned-up version.

> Yes, some squashing would be nice. Similar commit messages are confusing
> when reading the history.

Agreed.
