From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit <path> scanning entire working tree?
Date: Mon, 16 Feb 2009 23:12:50 -0800
Message-ID: <7vvdr98rkd.fsf@gitster.siamese.dyndns.org>
References: <2729632a0902161458m732af362od59e5f35af5643c3@mail.gmail.com>
 <7vwsbpewkl.fsf@gitster.siamese.dyndns.org>
 <2729632a0902161937o4ac3a1aeg143dda509ba5e384@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 17 08:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZKA7-0002hS-GV
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 08:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbZBQHM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbZBQHM5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:12:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZBQHM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:12:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F25CC99384;
	Tue, 17 Feb 2009 02:12:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0D79099383; Tue,
 17 Feb 2009 02:12:51 -0500 (EST)
In-Reply-To: <2729632a0902161937o4ac3a1aeg143dda509ba5e384@mail.gmail.com>
 (skillzero@gmail.com's message of "Mon, 16 Feb 2009 19:37:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 659DFAD6-FCC2-11DD-A787-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110318>

skillzero@gmail.com writes:

> ... However, it would
> eliminate information (changed/untracked files outside that path), if
> people are relying on that.

People do rely on that information.  Why else we would spend cycles to show
them?

There is a precedence to allow a configuration variable to skip various
computation to help slow systems, e.g. 6c2ce04 (Add argument 'no'
commit/status option -u|--untracked-files, 2008-06-05).
