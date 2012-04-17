From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Do not use SHELL_PATH from build system in prepare_shell_cmd on Windows
Date: Tue, 17 Apr 2012 09:45:50 -0400
Message-ID: <1334670128-sup-4966@pinkfloyd.chass.utoronto.ca>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org> <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca> <4F8D15B9.70803@viscovery.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: peff <peff@peff.net>, jrnieder <jrnieder@gmail.com>,
	gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 15:46:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK8jJ-0001XY-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 15:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370Ab2DQNp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 09:45:56 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:33209 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312Ab2DQNpz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 09:45:55 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:34978 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SK8j8-0002MZ-2F; Tue, 17 Apr 2012 09:45:50 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SK8j8-0006qi-19; Tue, 17 Apr 2012 09:45:50 -0400
In-reply-to: <4F8D15B9.70803@viscovery.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195758>

Excerpts from Johannes Sixt's message of Tue Apr 17 03:03:21 -0400 2012:

Hi Hannes,

> The recent change to use SHELL_PATH instead of "sh" to spawn shell
> commands is not suited for Windows:

Ah yes, I can see how that would be undesirable on Windows.


> +#ifndef WIN32
>          nargv[nargc++] = SHELL_PATH;
> +#else
> +        nargv[nargc++] = "sh";
> +#endif
>          nargv[nargc++] = "-c";

A minor style question: Would this conditional code not be better if
it were up where the fallback SHELL_PATH is set?  That would leave
this code block #ifdef free while still avoiding the breakage on
Windows.

Admittedly, it's a very minor point and possibly entirely a personal
preference.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
