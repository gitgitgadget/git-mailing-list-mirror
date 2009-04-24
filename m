From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] rev-parse: add --sq-quote to shell quote arguments
Date: Fri, 24 Apr 2009 10:33:09 +0200
Message-ID: <49F17945.8000004@viscovery.net>
References: <20090424062902.3705.44704.chriscool@tuxfamily.org> <7v8wlqii2y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 10:35:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxGsG-0004Yn-U6
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 10:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759146AbZDXIdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 04:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758946AbZDXIdY
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 04:33:24 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:37489 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792AbZDXIdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 04:33:22 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LxGqL-0002Hx-W9; Fri, 24 Apr 2009 10:33:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B727C6C4; Fri, 24 Apr 2009 10:33:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7v8wlqii2y.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117422>

Junio C Hamano schrieb:
> Not very readable.  A better example might be to demonstrate something
> like this:
> 
> 	$ cat >your-git-script.sh <<\EOF
> 	#!/bin/sh
> 	# quote user-supplied arguments
> 	args=$(git rev-parse --sq-quote "$@")
>         # and use it inside a handcrafted command line
>         command="git frotz -n24 $args"
>         eval "$command"
> 	EOF
> 
> 	$ sh your-git-script.sh "a b'c"
> 
> i.e, put stress on how to use it, not on how it works internally.

Hmm, that makes me wonder why we special-case shell-quoting and implement
it in an executable. Why don't we have perl-quoting, C-quoting,
PHP-quoting, $language-of-your-choice quoting, etc, too?

I think we should simply move sq() from git-am to git-sh-setup and use
that in git-bisect.

-- Hannes
