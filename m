From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH] Show modified files in git-ls-files
Date: Fri, 02 Sep 2005 08:17:09 -0400
Message-ID: <431842C5.6060606@didntduck.org>
References: <43179E59.80106@didntduck.org> <tnxzmqvalie.fsf@arm.com> <7v3bonkecp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 14:16:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBATE-0004qV-8O
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 14:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVIBMQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 08:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVIBMQa
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 08:16:30 -0400
Received: from quark.didntduck.org ([69.55.226.66]:64656 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751258AbVIBMQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2005 08:16:29 -0400
Received: from [192.168.1.2] (24-236-201-214.dhcp.aldl.mi.charter.com [24.236.201.214])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j82CGJI10927;
	Fri, 2 Sep 2005 08:16:20 -0400
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bonkecp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8021>

Junio C Hamano wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
> 
> 
>>Brian Gerst <bgerst@didntduck.org> wrote:
>>
>>>Add -m/--modified to show files that have been modified wrt. the index.
>>>
>>>M was already taken so the tag for modifified files is C (changed).
>>
>>I think git-ls-files should be consistent with git-diff-cache where M
>>means modified and U unmerged (but for the former, M is unmerged).
>>
>>StGIT currently uses C to report a merge conflict but I will probably
>>change this since it means copied in git-diff-cache.
> 
> 
> I think that is an excellent suggestion.  It looks to me that
> the tag feature in ls-files needs serious renaming.
> 
>  * an option is called --deleted and the variable to control the
>    output is show_deleted; the tag variable and string is
>    removed and "R".  Probably the tag should be renamed to "D".
> 
>  * before "modified", tag_cached was OK, but probably "known to
>    git" would have been a better name.  I'd vote for just a
>    single space " " as the tag letter; if we want to use printing
>    character, then a single dot ".".  Most of the things are
>    "known to git" anyway so these are visually less
>    distracting.

It should have some character, so the output is parseable by other scripts.

>  * unmerged should be "U" as you say.

I agree that the tags should be renamed.  I just didn't want to break 
other scripts which depend on those tags.

--
					Brian Gerst
