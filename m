From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: git status internals and line endings
Date: Fri, 13 Nov 2009 09:08:52 +0100
Message-ID: <4AFD1414.6030907@syntevo.com>
References: <4AFC70CE.5020106@syntevo.com> <20091113001547.GB28836@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 09:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8rDJ-000629-H8
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 09:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbZKMIIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 03:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbZKMIIu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 03:08:50 -0500
Received: from syntevo.com ([85.214.39.145]:39610 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115AbZKMIIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 03:08:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 4ECEA37C9B4
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091113001547.GB28836@sigill.intra.peff.net>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132820>

> Sounds like the core.autocrlf setting (see "git help config"), which I
> believe is set by default on Windows.

I have checked both $GIT_DIR/config and ~/.gitconfig and autocrlf has
not been set. I have then set autocrlf = false for the Windows
repository and still the file didn't show up as modified. On Linux, I've
added autocrlf = true (resp. autocrlf = input) for the repository and
still the file shows up as modified. Not that I don't like this
behavior, but I don't understand it :) Windows Git version is 1.6.5.1,
Linux version is 1.6.3.3.

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com





Jeff King wrote:
> On Thu, Nov 12, 2009 at 09:32:14PM +0100, Marc Strapetz wrote:
> 
>> On Linux, file1 and file3 are reported as modified -- as I would expect.
>> The surprise is on Windows: here only file1 is reported as modified. Why
>> not file3? Btw, 'git hash-object file3' reports the same SHA as for the
>> LF-only content in the repository (not so on Linux, as expected).
>>
>> Is this some special handling on Windows (and possibly on Mac OS)? In
>> this case, can someone please point me to the corresponding code part?
>> Thanks for any comments regarding this topic.
> 
> Sounds like the core.autocrlf setting (see "git help config"), which I
> believe is set by default on Windows.
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
