From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Short "git commit $file" syntax fails in the face of a resolved
    conflict
Date: Thu, 22 Jan 2009 08:28:44 +0100
Message-ID: <4978202C.3090703@viscovery.net>
References: <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>	 <49779521.9040208@drmicha.warpmail.net> <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Nathan Yergler <nathan@creativecommons.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 08:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPu12-0006je-Ff
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 08:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbZAVH2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 02:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbZAVH2t
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 02:28:49 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:6058 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421AbZAVH2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 02:28:49 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LPtzY-0006Iy-LN; Thu, 22 Jan 2009 08:28:44 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5F7836C4; Thu, 22 Jan 2009 08:28:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106730>

Please don't top-post.

Nathan Yergler schrieb:
> Can you elaborate on why doing -i automatically is a bad idea in this
> case?  [It may really be, I don't pretend to have enough knowledge
> about git's internals to make a reasoned argument.]  This was
> unexpected behavior for me as I'd always experienced "git add path &&
> git commit" and "git commit path" as being equivalent and so I assumed
> they would work equivalently in this situation.

They are not equivalent. 'git add path && git commit' commits changes to
path *in addition* to what is already staged before you run this command
sequence. But 'git commit path' commits *only* changes to path, leaving
other changes that might be staged uncommitted.

It may become obvious why the latter behavior is unwanted if a merge is in
progress: The merge left changes (and conflicts) in the index; but with
'git commit path' you say that you are not interested in what the index has.

-- Hannes
