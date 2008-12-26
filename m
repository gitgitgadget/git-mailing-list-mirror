From: Junio C Hamano <gitster@pobox.com>
Subject: Re: getting started, happy with cmd line on windows [Scanned]
Date: Fri, 26 Dec 2008 15:50:15 -0800
Message-ID: <7v4p0qlcnc.fsf@gitster.siamese.dyndns.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D07@ALTMORE-SVR.altmore.local>
 <495508B9.7070103@lsrfire.ath.cx> <gj3of4$pr3$3@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Zorba" <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 27 00:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGMT4-00031q-Cx
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 00:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYLZXuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 18:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbYLZXuX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 18:50:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbYLZXuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 18:50:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DA0F21B274;
	Fri, 26 Dec 2008 18:50:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BED591B272; Fri,
 26 Dec 2008 18:50:17 -0500 (EST)
In-Reply-To: <gj3of4$pr3$3@ger.gmane.org> (cr@altmore.co.uk's message of
 "Fri, 26 Dec 2008 23:13:20 -0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F4AA8BF2-D3A7-11DD-A186-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103963>

"Zorba" <cr@altmore.co.uk> writes:

> Now, I went back and read the manual pages for git-checkout and think I see 
> how to do it....
>
> $ <import code>
> $ git init
> $ git commit
> $ git tag versionA <commitID>
> $ hack hack hack
> ...
> now ready to start coding, want "last known good"
> $ rm *.*
> $ git checkout versionA .
>
> This worked fine when versionA had only files and no dirs - but will it work 
> ok still if versionA is a proper tree ?
> (more of a unix question I suppose - will "." suffice as the path ?) 

Drop "rm *.*".  Instead, probably what you want is

> $ <import code>
> $ git init
> $ git commit

which is a good way to make an initial import.

> $ git tag versionA <commitID>
> $ hack hack hack
> ...

and you futzed with the codebase without any intention of committing;
it is nice to be able to experiment freely.

After you are done experimenting,

$ git reset --hard versionA

if you did not make any commit, or even if you did commit while you were
experimenting, if you do not want these experimental commits at all.

No need for "rm *.*" anywhere.
