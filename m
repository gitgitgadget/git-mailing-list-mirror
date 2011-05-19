From: Ferry Huberts <mailings@hupie.com>
Subject: Re: git & patterns
Date: Thu, 19 May 2011 08:23:46 +0200
Message-ID: <4DD4B772.2050404@hupie.com>
References: <4DD3A402.3040802@hupie.com> <7vsjsbbx7h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 08:23:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMweH-0007F8-NR
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610Ab1ESGXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:23:48 -0400
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:58995 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932363Ab1ESGXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 02:23:48 -0400
Received: from stinkpad.internal.hupie.com (82-197-206-98.dsl.cambrium.nl [82.197.206.98])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 09F9321E69C;
	Thu, 19 May 2011 08:23:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10
In-Reply-To: <7vsjsbbx7h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173932>

On 05/18/2011 09:55 PM, Junio C Hamano wrote:
> Ferry Huberts <mailings@hupie.com> writes:
> 
>> After reading the manual page for git describe it was not clear to me what
>> kind of pattern the --match option should take. Was it to be
>> a shell pattern (to be expected) or a regular expression pattern?
>>
>> So I dug in the code to find fnmatch: shell pattern.
>>
>> Now my question(s):
>>
>> - could the manual page be update to make this explicit please? (plus
>> other manual pages talking about (shell) patterns)
> 
> The general design guideline we have is to use glob for things that look
> like pathnames. Refs, refspecs, ignore and attribute rules are the
> examples of this rule.
> 

Well, to me tags do not look like pathnames at all, they're just
'random' strings. As are branches.
Technically they may be like pathnames because they're projected on to
the filesystem that way, but principally they're not IMHO: it's an
implementation detail.

> We may be lacking this info in our documentation. A patch to add it
> somewhere is very welcome.

Yesterday I already did a quick grep on pattern and glob in the
documentation directory and found that:
- usually patterns are just patterns, without specifying what kind
- when a pattern type is specified it most of the time is a glob pattern
- but sometimes it is called a shell pattern
- and  a few cases speak of a wildcard pattern (I think)

What should it be?
From your comments I gather it should be a glob pattern.
Isn't glob too 'tech speak' or is it acceptable?
If not acceptable, then what? Shell wildcard pattern?

thanks!

-- 
Ferry Huberts
