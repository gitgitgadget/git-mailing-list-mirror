From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Fix file name pattern in .gitattributes.
Date: Tue, 24 Feb 2009 09:33:44 -0800
Message-ID: <7vskm3hh8n.fsf@gitster.siamese.dyndns.org>
References: <1235462493-8761-1-git-send-email-j6t@kdbg.org>
 <7vskm4jkbk.fsf@gitster.siamese.dyndns.org> <49A3BD25.3000706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:36:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc1CO-0004oV-QK
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759114AbZBXRdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756424AbZBXRdx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:33:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183AbZBXRdw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 12:33:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9EA219C526;
	Tue, 24 Feb 2009 12:33:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 530289C511; Tue,
 24 Feb 2009 12:33:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C9C25E4-0299-11DE-AC8F-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111319>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> 
>>> The pattern for the *.po files was anchored at the repository's root, but
>>> this would match the files only in the git-gui repository itself, but
>>> not in the version that is subtree-merged into git.git.
>>>
>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>> ---
>>>  .gitattributes |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/.gitattributes b/.gitattributes
>>> index f96112d..c69f4a0 100644
>>> --- a/.gitattributes
>>> +++ b/.gitattributes
>>> @@ -1,3 +1,3 @@
>>>  *           encoding=US-ASCII
>>>  git-gui.sh  encoding=UTF-8
>>> -/po/*.po    encoding=UTF-8
>>> +po/*.po     encoding=UTF-8
>> 
>> Hmm, really?
>
> No, not really. =:{
>
> I observed some strangeness with gitk. But it turned out that this was an
> old development version that got accidentally installed somewhere in $PATH.
>
> Sorry for the noise.

Actually, while I was responding to your message, I looked at
gitattributes documentation and noticed that it does not say anything
about how the "glob" is used to match paths.  The rules applied should be
the same as those from gitignore (except obviously we do not have negated
pattern that gitignore has, because it does not mean "path not matching
this pattern" over there), and it should be documented.
