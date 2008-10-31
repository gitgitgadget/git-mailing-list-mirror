From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 22:59:47 +0100
Message-ID: <490B7FD3.8060003@op5.se>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:01:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw23R-000790-4k
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbYJaWAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbYJaWAA
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:00:00 -0400
Received: from mail.op5.se ([193.201.96.20]:48781 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbYJaV77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:59:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A18711B8004D;
	Fri, 31 Oct 2008 22:54:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4Gt0QoPfW1n; Fri, 31 Oct 2008 22:54:37 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id E0B0B1B80048;
	Fri, 31 Oct 2008 22:54:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081031174745.GA4058@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99655>

Pierre Habouzit wrote:
> On Fri, Oct 31, 2008 at 05:07:04PM +0000, Shawn O. Pearce wrote:
>> During the GitTogether we were kicking around the idea of a ground-up
>> implementation of a Git library.  This may be easier than trying
>> to grind down git.git into a library, as we aren't tied to any
>> of the current global state baggage or the current die() based
>> error handling.
>>
>> I've started an _extremely_ rough draft.  The code compiles into a
>> libgit.a but it doesn't even implement what it describes in the API,
>> let alone a working Git implementation.  Really what I'm trying to
>> incite here is some discussion on what the API looks like.
> 
> I know this isn't actually helping a lot to define the real APIs, but we
> should really not repeat current git mistakes and have a really uniform
> APIs, meaning that first we must decide:
>   * proper namespacing (e.g. OBJ_* looks like failure to me, it's a way
>     too common prefix);
> 

As it's the git-lib, all public functions should almost certainly be
prefixed with "git" or "git_". I favor "git_".

>   * proper public "stuff" naming (I e.g. realy like types names -- not
>     struct or enum tags, that I don't really care -- ending with _t as
>     it helps navigating source.
> 

*_t types are reserved by POSIX for future implementations, so that's
a no-go (although I doubt POSIX will ever make types named git_*_t).


Apart from that, please consider reading Ulrich Drepper's musings on
library design at http://people.redhat.com/drepper/goodpractice.pdf

It's pretty short but brings up nearly all the crucial points one really
don't want to forget.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
