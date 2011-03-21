From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Mon, 21 Mar 2011 21:53:27 +0100
Message-ID: <4D87BAC7.4010505@web.de>
References: <4D81C1AA.5010008@morey-chaisemartin.com> <7v1v254ma7.fsf@alter.siamese.dyndns.org> <7vhbb1320t.fsf@alter.siamese.dyndns.org> <4D870FAB.4050307@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: devel-git@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Mon Mar 21 21:53:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1m6d-0007h1-2i
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab1CUUxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 16:53:35 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40114 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab1CUUxd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:53:33 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6B34B18A3A3E6;
	Mon, 21 Mar 2011 21:53:27 +0100 (CET)
Received: from [93.240.120.88] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q1m6R-0005fX-00; Mon, 21 Mar 2011 21:53:27 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D870FAB.4050307@morey-chaisemartin.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19Bz3JfGzCLp871FSgE+D8WBUjsb0yucfmqWOJY
	QrT/GTGJBiNn9YTInZnGMOlApbYnO3bQ/NVlTlXoVgQkBr3N7q
	KPzaI2MEREfMpzywjsng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169669>

Am 21.03.2011 09:43, schrieb Nicolas Morey-Chaisemartin:
> I agree that the actual behavior of status is definitely wrong and it should be changed.

Yup.

> But I think there needs to be a simple way for a user to know whats happening to a conflicted submodule.
> When merging a file, editing the conflicting area in the code is often enough.
> For a submodule, I think the user needs an easy access to which branch used what SHA1.

You can see the sha1s using "git diff":

diff --cc submod
index bd4cfe7,7128fbd..0000000
--- a/submod
+++ b/submod

(But the sha1s don't tell you much about what differing commits you
have in the submodule branches, which would be really helpful for
deciding how to solve the merge conflict. Unfortunately "git diff
--submodule" doesn't work for merge conflicts yet, another issue on
my ToDo-list ...)

> Git submodule status is probably not the right place to do that.

I agree.

> git ls-files --stage allows that but it's not part of the standard porcelain commands...

And it shows you three sha1s, one of them being the current state of
the submodule. Me thinks the output of "git diff" is easier to digest.

> I'll check/test the patch you proposed as soon as possible and repost it if it's allright !

Cool!
