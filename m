From: Junio C Hamano <gitster@pobox.com>
Subject: Re: allowing aliases to override builtins to support default options
Date: Fri, 06 Mar 2009 15:22:36 -0800
Message-ID: <7vhc26qls3.fsf@gitster.siamese.dyndns.org>
References: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 00:24:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfjOm-0003aS-KJ
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 00:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbZCFXWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 18:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbZCFXWo
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 18:22:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbZCFXWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 18:22:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ABD5A9F761;
	Fri,  6 Mar 2009 18:22:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9F75E9F760; Fri,
  6 Mar 2009 18:22:38 -0500 (EST)
In-Reply-To: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>
 (Jay Soffian's message of "Fri, 6 Mar 2009 17:30:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B09F4D96-0AA5-11DE-88EE-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112493>

Jay Soffian <jaysoffian@gmail.com> writes:

> Currently git does not allow aliases to override builtins. I
> understand the reasoning behind this, but I wonder if it's overly
> conservative.

It is not.

> Most shells support overriding commands with aliases, and I'm not sure
> why git needs to be more conservative than the shell.

Because sane shells do not expand aliases when used in a script, and gives
a handy way to defeat the alias even from the command line.

    $ alias ls='ls -aF'
    $ echo ls >script
    $ chmod +x script

and compare:

    $ ./script
    $ ls
    $ /bin/ls
