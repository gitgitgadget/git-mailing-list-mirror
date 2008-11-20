From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 09:38:28 +0100
Message-ID: <49252204.2070906@op5.se>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <C33ABF98-2E52-4928-BF79-CB3B6A8460DB@feinheit.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Roger Leigh <rleigh@codelibre.net>, git@vger.kernel.org
To: Matthias Kestenholz <mk@feinheit.ch>
X-From: git-owner@vger.kernel.org Thu Nov 20 09:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L354i-0003E0-0l
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 09:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYKTIi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 03:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbYKTIi2
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 03:38:28 -0500
Received: from mail.op5.se ([193.201.96.20]:51124 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbYKTIi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 03:38:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 83EF024B000B;
	Thu, 20 Nov 2008 09:33:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7+qZzRoxh-MD; Thu, 20 Nov 2008 09:33:30 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 5F0551B8006F;
	Thu, 20 Nov 2008 09:33:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <C33ABF98-2E52-4928-BF79-CB3B6A8460DB@feinheit.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101391>

Matthias Kestenholz wrote:
> Hi,
> 
> On 19.11.2008, at 12:37, Roger Leigh wrote:
> 
>> Hi folks,
>>
>> I'm using git to store some generated files, as well as their sources.
>> (This is in the context of Debian package development, where entire
>> upstream release tarballs are injected into an upstream branch, with
>> Debian releases merging the upstream branch, and adding the Debian
>> packaging files.)
>>
>> The upstream release tarballs contains files such as
>> - yacc/lex code, and the corresponding generated sources
>> - Docbook/XML code, and corresponding HTML/PDF documentation
>>
>> These are provided by upstream so that end users don't need these tools
>> installed (particularly docbook, since the toolchain is so flaky on
>> different systems).  However, the fact that git isn't storing the
>> mtime of the files confuses make, so it then tries to regenerate these
>> (already up-to-date) files, and fails in the process since the tools
>> aren't available.
>>
>> Would it be possible for git to store the mtime of files in the tree?
>>
> 
> This subject comes up from time to time, but the answer always
> stays the same: No. The trees are purely defined by their content, and
> that's by design.
> 
> If you do not want to regenerate files that are already up-to-date,
> you need multiple checkouts of the same repository.
> 

Or a make-rule that touches the files you know are up to date. Since you
control the build environment, that's probably the simplest solution.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
