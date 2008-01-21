From: Mark Junker <mjscod@web.de>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to
 UTF8
Date: Mon, 21 Jan 2008 11:36:55 +0100
Message-ID: <fn1sk4$uh4$1@ger.gmane.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org>	<fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org> <7vve5nzdqx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 11:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGu26-0007HT-CE
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 11:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758778AbYAUKhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 05:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758812AbYAUKhH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 05:37:07 -0500
Received: from main.gmane.org ([80.91.229.2]:51768 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758506AbYAUKhF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 05:37:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JGu1T-0004na-6t
	for git@vger.kernel.org; Mon, 21 Jan 2008 10:36:59 +0000
Received: from 80.146.179.234 ([80.146.179.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 10:36:59 +0000
Received: from mjscod by 80.146.179.234 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 10:36:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80.146.179.234
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
In-Reply-To: <7vve5nzdqx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71256>

Junio C Hamano schrieb:

> I do not know how Macintosh libc implements "struc dirent", but
> this approach does not work in general.

IMHO there is no need that this approach works in general because this 
is a fix for MacOSX systems only. I also use d_namlen which might not be 
available on other systems. But on MacOSX this works as expected.

> yet you can obtain a path component longer than 256 bytes.
> Apparently the library allocates longer d_name[] field than what
> is shown to the user.

This is not a problem either because on MacOSX we get decomposed UTF8 
and we always convert to composed UTF8. This means that the string 
returned from reencode_string will always be smaller than the original 
filename that had to be reencoded.

Regards,
Mark
