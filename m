From: Christof =?iso-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: refactoring in GIT
Date: Tue, 28 Jun 2011 17:59:37 +0200 (CEST)
Message-ID: <1a25cfcef173d20a259950d6829b2611.squirrel@mail.localhost.li>
References: <loom.20110628T151105-908@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "eugene" <eugene@oggtrading.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 18:23:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbb4Z-00080I-Rz
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 18:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167Ab1F1QBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 12:01:21 -0400
Received: from vserver.localhost.li ([85.214.46.152]:52240 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114Ab1F1P7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 11:59:41 -0400
Received: from localhost ([127.0.0.1]:60491 helo=mail.localhost.li)
	by mail.localhost.li with esmtp (Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1QbahN-00026f-ER; Tue, 28 Jun 2011 17:59:38 +0200
Received: from 194.39.218.10
        (SquirrelMail authenticated user mail@christof-krueger.de)
        by mail.localhost.li with HTTP;
        Tue, 28 Jun 2011 17:59:37 +0200 (CEST)
In-Reply-To: <loom.20110628T151105-908@post.gmane.org>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176406>

Hi Eugene

> #1. I want to refactor class A into few classes B,C,D. How should I check
> them
> in and mark class A inactive so that development on A stops? Note, I do
> need A
> stay in repository for backward compt. with prior code releases.
Well, if you really need to keep that file, how about a huge comment at
the beginning of the file?  Or move its content somewhere else and
#include it from the original file.
Git really can't help you here. This is a communication issue within your
project.  Resulting from its distributed design git does not have a global
"lock" feature that could be misused for that matter.

> #2. [related question] What if another developer already had A in his
> local
> repository, made changes and wants to commit after me. I just made A
> obsolete.
> Does he have drop his changes and take B,C,D from me and/or merge?
Git can't help you here either.
If your changes don't conflict with their changes, they won't notice if
they do not examine your changes. This again is a
communication/coordination issue, not a git one. However, if you had moved
"A" away or changed every line, the other developers would get a conflict
when trying to pull your stuff.

Further, git obviously won't automatically refactor other developers code
to match your changes. Depending on the complexity of your refactoring,
you might be able to play around with patches manually.

The least thing you can do is to inform the other developers about your
changes and apologize for not telling them that you planned to make A
obsolete in advance ;)
