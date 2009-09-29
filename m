From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-diff/git-diff-files: Turn off copy-detection?
Date: Tue, 29 Sep 2009 15:40:07 +0200
Message-ID: <4AC20E37.3090204@viscovery.net>
References: <4AC20286.6020108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 15:40:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MscwF-0000XB-VU
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 15:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbZI2NkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 09:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbZI2NkI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 09:40:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:64085 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbZI2NkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 09:40:07 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mscw4-0005I6-D0; Tue, 29 Sep 2009 15:40:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 22FD8BC81; Tue, 29 Sep 2009 15:40:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AC20286.6020108@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129300>

Marius Storm-Olsen schrieb:
> I'm trying to diff the header files between two version of a repo, to do
> an ABI review, but get too many diffs from 'similar copy', which makes
> the review hard. These are generally unrelated files, but due to large
> copyright header, and spaces, the actual changes are not large enough to
> be detected as new files. I'd therefore like to turn off copy detection
> completely, or at least set some kind of threshold before a file is
> considered a copy in the diff.
> 
> Doing a 'git diff origin/4.5..origin/4.6 -- src/corelib' gives me this
> excerpt:
> 
> diff --git origin/4.5/src/corelib/tools/qtimeline.h
> origin/4.6/src/corelib/animation/qabstractanimation.h
> similarity index 58%
> ...

You must have the config variable diff.renames set. But I would not expect
that this setting applies to 'git diff-files', only to 'git diff'.

You can also try 'git diff -C99 -M99' if you don't want to unset the
config variable.

-- Hannes
