From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: on subtree checkout
Date: Sun, 24 Feb 2008 16:59:30 +0100
Message-ID: <vpqve4efiql.fsf@bauges.imag.fr>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>
	<m31w72d63a.fsf@localhost.localdomain>
	<fcaeb9bf0802240712u5bc7173du1fe67c3bcd89d1a4@mail.gmail.com>
	<200802241645.49718.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"git mailing list" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 17:01:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTJIE-00008p-Qy
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 17:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbYBXQAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 11:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbYBXQAy
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 11:00:54 -0500
Received: from imag.imag.fr ([129.88.30.1]:42392 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbYBXQAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 11:00:53 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m1OFxUNn014926
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 24 Feb 2008 16:59:30 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JTJGE-0002q2-7p; Sun, 24 Feb 2008 16:59:30 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JTJGE-0002pE-5b; Sun, 24 Feb 2008 16:59:30 +0100
In-Reply-To: <200802241645.49718.jnareb@gmail.com> (Jakub Narebski's message of "Sun\, 24 Feb 2008 16\:45\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 24 Feb 2008 16:59:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74943>

Jakub Narebski <jnareb@gmail.com> writes:

> Nguyen Thai Ngoc Duy wrote:
>> On Sun, Feb 24, 2008 at 5:03 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>>
>>> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>>>
>>>> I'm going to implement subtree checkout. [...]
>>>
>>>  As far as I can see the problem lies in merging...
>> 
>> Can you elaborate? I'm really noob at merging.
>
> What to do if when merging, or rebasing, there is conflict _outside_
> checked out subtree?

I suppose you have to forbid merges where anything non-trivial happens
outside the tree (i.e. allow it only if the set of renamed or changed
files is disjoint outside the tree, or only if only one of the
branches to merge have changes outside the tree).

That's probably not such a big limitation in practice for the user,
since by definition the user won't modify the files outside its tree,
so he can at least still merge with the branch he branched from.

I can see another problem: partial checkout is really interesting only
if you can do a partial clone ("partial" here in the sense "subtree").
Otherwise, your .git/ still eats your disk space and "clone" still
needs your bandwidth for something you won't use.

-- 
Matthieu
