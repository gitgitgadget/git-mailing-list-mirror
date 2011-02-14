From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: future of git-gui as subsytem or submodule, WAS: [PATCH] git-gui:
 document the gui.maxfilesdisplayed variable
Date: Mon, 14 Feb 2011 23:46:47 +0100
Message-ID: <4D59B0D7.5000107@web.de>
References: <20110213125324.GA31986@book.hvoigt.net> <7v39nruk9j.fsf@alter.siamese.dyndns.org> <20110214220318.GD50815@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:47:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp7CW-00022j-OV
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab1BNWrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:47:20 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:54918 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab1BNWrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:47:18 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id 515BA1978E706;
	Mon, 14 Feb 2011 23:46:50 +0100 (CET)
Received: from [93.240.97.210] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pp7By-0003KP-00; Mon, 14 Feb 2011 23:46:50 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110214220318.GD50815@book.hvoigt.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19vFpwM1MvrCb40k8g4vk7ThCInZw1FehWR5Hi8
	++yuxKJph4vRmtuUsdyaBKeDzAqKCTCdjZC76DzSMIG7PxdfuG
	DxFBYQOxo/UmfhI6QwIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166789>

Am 14.02.2011 23:03, schrieb Heiko Voigt:
> On Sun, Feb 13, 2011 at 11:51:04PM -0800, Junio C Hamano wrote:
>> Two opposing thoughts.
>>
>>  1. We can keep git-gui and git proper separate projects, move git-gui
>>     documentation out of git to git-gui, and with clever Makefile trick
>>     include and build git-gui related documentation conditionally only
>>     when git-gui appears part of the git project tree (this anticipates a
>>     future where git-gui is bound to git not with the subtree merge
>>     strategy as we currently do, but as a submodule).
>>
>>  2. Just like the Linux kernel project, we can make each subsystem with
>>     separate maintainers just different repositories of the same git
>>     project with their own focus.  We already do this for git-svn (which I
>>     delegate to Eric Wong by pulling from him) and some parts of contrib/
>>     tree; we have already been halfway there for gitweb/ (which I don't
>>     regularly "pull from", but I mainly act as a patch monkey without
>>     actively managing that part myself).  I don't see why we cannot extend
>>     that model to git-gui and gitk.
> 
> I would vote for 2. Not because I think submodules will not become as easy to
> use so they are ready for that but I think there are mainly two reasons
> for using a submodule
> 
>   A. The submodule contains shared code which is used by multiple projects
> 
>   B. A submodule is used to keep large collection of files seperate from
>      a project because most times they are not needed and would
>      interfere with the project.

C. The subproject is developed by someone else, is not under the
   administrative control of the superproject, and follows a different
   release cycle. (as seen on the Git Wiki ;-)

I don't have strong feelings about this choice, but because of the way
git-gui and gitk are developed at the moment 1) seems more appropriate
right now. But this is Pat's and Paul's call, as they have to agree with
the choice taken and choosing 2) might tie those guis more to a specific
git version than they might be comfortable with. But I'm just guessing
here ...

> There are maybe more but these two do not apply to git-gui and I like
> the way it is currently integrated in one repository with git. It also
> underlines the fact that git-gui is AFAICS the standard and best
> developed gui for git.
> 
> Another plus, if we extend that model to gitk, is that both could start
> sharing code between each other (maybe relocate to the same directory).

That is an advantage of approach 2).

> Although 1. would be a good choice for getting more people involved in
> enhancing submodule support, from a philosophical standpoint, I think 2.
> is the more natural choice.

I don't think "getting more people involved in enhancing submodule
support" is a strong argument here. We should choose that policy
which supports the development culture of the projects in question.
