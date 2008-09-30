From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How Blobs Work ( Blobs Vs. Deltas)
Date: Tue, 30 Sep 2008 17:29:08 +0200
Message-ID: <48E245C4.7030003@viscovery.net>
References: <16946e800809300814v134a42dft37becdbd8aa7669a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Feanil Patel <feanil@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 17:30:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkhB8-0000kU-6m
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 17:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbYI3P3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 11:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYI3P3M
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 11:29:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35475 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbYI3P3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 11:29:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kkh9w-00072y-E6; Tue, 30 Sep 2008 17:29:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2D8E84FB; Tue, 30 Sep 2008 17:29:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <16946e800809300814v134a42dft37becdbd8aa7669a@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97128>

Feanil Patel schrieb:
> I was reading about git objects on The Git
> Book(http://book.git-scm.com/1_the_git_object_model.html) which was
> posted on the mailing list a while back and I was wondering something
> about blobs and how files are stored in any particular version.  If
> file A is changed from version one to version two there are two
> different blobs that exist for the two versions of the file, is that
> correct?  The Book was saying Git does not use delta storage so does
> this mean that there are two almost identical copies of the file with
> the difference being the change that was put in from version one to
> version two?

At the conceptual level, yes. An entire file (== blob) is the smallest
unit that you can address. Even git's internals do not work with smaller
units.

But there is, of course, a mechanism that stores the database in a more
compact format, the so-called pack files, that basically store differences
between files as much as possible.

-- Hannes
