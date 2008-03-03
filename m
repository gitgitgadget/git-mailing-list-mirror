From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 03 Mar 2008 14:14:28 +0100
Message-ID: <vpqskz82bm3.fsf@bauges.imag.fr>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 14:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWAWi-00071H-SY
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 14:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbYCCNPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 08:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYCCNPo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 08:15:44 -0500
Received: from imag.imag.fr ([129.88.30.1]:36322 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbYCCNPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 08:15:43 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m23DEUou015622
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Mar 2008 14:14:30 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JWAUu-0007KE-V6; Mon, 03 Mar 2008 14:14:28 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JWAUu-0007xz-SG; Mon, 03 Mar 2008 14:14:28 +0100
In-Reply-To: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com> (Paolo Ciarrocchi's message of "Mon\, 3 Mar 2008 13\:40\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 03 Mar 2008 14:14:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75926>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> What is still not clear to me is where git is storing
> the objects downloaded during a git fetch operation.

git fetch downloads the objects to the object database, i.e.
.git/objects/, usualy as a pack.

Now, just "having" the objects locally doesn't change much, an object
starts being really interesting if you have a reference (typically, a
branch) pointing to it. "git fetch" will update the remote references
(for example, origin/master), but won't touch the working tree, and
won't do any merge, fast-forward or not, to a local branch. So, most
likely, "git fetch" will be followed by either a merge or a rebase.

-- 
Matthieu
