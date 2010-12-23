From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Using overlay filesystem for "other" files idea
Date: Thu, 23 Dec 2010 06:27:49 +0100
Message-ID: <4D12DDD5.4050103@dbservice.com>
References: <AANLkTi=f2MXoWE_Dx_thWb3VXGu-V-9cJAC8F_RzGAg=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Evgeniy Ivanov <lolkaantimat@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 06:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVdkY-0004vO-IB
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 06:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193Ab0LWF1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 00:27:54 -0500
Received: from office.neopsis.com ([78.46.209.98]:55306 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab0LWF1y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 00:27:54 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.058,BAYES_00: -1.665,TOTAL_SCORE: -1.607,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 23 Dec 2010 06:27:50 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTi=f2MXoWE_Dx_thWb3VXGu-V-9cJAC8F_RzGAg=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164120>

  On 12/23/10 12:02 AM, Evgeniy Ivanov wrote:
> Hello,
>
> I got following idea.
>
> If different branches seriously differ and you switch branches, then
> it's more likely you will loose most part of build files (e.g. when
> run build).
Use ccache.
> Also in projects that may have some bugs in build system (e.g. buggy
> makefiles) there is a chance you will not get clean build environment.
> E.g. somebody forgot to add include file as dependency in Makefile ---
> oops, you're in trouble.
Fix your Makefiles. Or run git clean, see below.
> Even without bugs in build system, some temp files are overwritten
> each time you run build for a custom branch.
>
> I think using overlays for other files can help much to solve this
> issue. You can have git repository in regular directory (like now) and
> overlay fs mounted over this repository (for each branch its own
> overlay).
> Another benefit is clearing source tree after build.

git clean -dfx.


Or use two different working trees. See contrib/workdir/git-new-workdir.

tom
