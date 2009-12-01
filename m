From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 14:17:54 +0100
Message-ID: <4B151782.8050309@viscovery.net>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com> <4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com> <4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com> <4B14E934.9090304@viscovery.net> <4B150747.2030900@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 14:18:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFScF-0004mm-Ie
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 14:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbZLANRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 08:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbZLANRv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 08:17:51 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32843 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbZLANRv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 08:17:51 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NFSc7-0007IS-Mh; Tue, 01 Dec 2009 14:17:55 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 427241660F;
	Tue,  1 Dec 2009 14:17:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B150747.2030900@syntevo.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134202>

Thomas Singer schrieb:
> I'm quite surprised, that -- as I
> understand you -- msys-Git (or Git at all?) is not able to handle all
> characters (aka unicode) at the same time. I expected it would be better
> than older tools, e.g. SVN.

This has been discussed at length here and in the msysgit mailing list.
Git expects that the file system returns file names with the same byte
sequence that git used to create a file. On Windows, this works only as
long as you do not switch the codepage.

> BTW, we are invoking the Git executable from Java. Is there automatically a
> console "around" Git?

I don't think so. In this case, the codepage that Java has set up will
apply. I guess that Java doesn't mess with the codepage at all, and then
on German Windows git would operate in cp1252.

> Should we invoke a shell-script (which sets the
> console's code page) instead of the Git executable directly?

I don't think that is necessary.

-- Hannes
