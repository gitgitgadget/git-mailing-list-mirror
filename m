From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: question about COMMIT_EDITMSG crlf
Date: Wed, 14 Jan 2009 08:18:38 +0100
Message-ID: <496D91CE.1000504@viscovery.net>
References: <1976ea660901132117l7947157fw2922465a9b3945dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 08:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN02m-0004U5-Es
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 08:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbZANHSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 02:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZANHSk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 02:18:40 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:52589 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbZANHSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 02:18:40 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LN01O-00010j-LY; Wed, 14 Jan 2009 08:18:38 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 63F86A865; Wed, 14 Jan 2009 08:18:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1976ea660901132117l7947157fw2922465a9b3945dc@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105594>

Frank Li schrieb:
> I want to use notepad replace default vim at commit message editor.
> git commit will create COMMIT_EDITMSG at .git directory. This file is
> unix text mode.
> Is there any config change it to windows text mode?

No, there isn't. But perhaps you can use WordPad instead of Notepad? There
are reports that this worked.

You could also write a wrapper script that transforms the file before it
calls Notepad on it (untested):

   #!/bin/bash
   sed -e $'s/\r?$/\r/' < "$1" > .git/tmp$$ &&
   mv .git/tmp$$ "$1" &&
   notepad "$1"

I think git commit removes the trailing CRs automatically, so they don't
end up in the commit message.

-- Hannes
