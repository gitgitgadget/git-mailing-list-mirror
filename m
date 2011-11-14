From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Repository data loss in fast-export with a merge of a deleted
 submodule
Date: Mon, 14 Nov 2011 20:51:34 +0100
Message-ID: <4EC17146.3000202@web.de>
References: <4EA9B0B5.6060005@workspacewhiz.com> <4EB2BBB5.3030908@workspacewhiz.com> <4EC12E8B.3050909@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 20:51:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ2ZF-0005OP-4x
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 20:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab1KNTvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 14:51:40 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:58256 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953Ab1KNTvj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 14:51:39 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1C7501A3DF8BC
	for <git@vger.kernel.org>; Mon, 14 Nov 2011 20:51:38 +0100 (CET)
Received: from [192.168.178.43] ([79.247.249.85]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LuMER-1QjSTW0mLH-010x0R; Mon, 14 Nov 2011 20:51:37
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EC12E8B.3050909@workspacewhiz.com>
X-Provags-ID: V02:K0:S4j+zPweTS4exZtxAA0ORMCcBiN6BT/RIK+M0Q+4HNf
 8tyaVAUj0zZBH63Hsde4HS/I0eab4JWOdQ1VP38HUFrYzEy9jp
 ykeqkQUhp7Aaw//tH1jyaGBiH6SS/OYikxp/QvO7okPu8/dfBm
 4Cc0N+rNyBp8MjngjvDsgtTBh4DCreqOtQO6Z20QuWXT5eKT1v
 WGqoCKheg15dgqiHMGhOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185393>

Am 14.11.2011 16:06, schrieb Joshua Jensen:
> ----- Original Message -----
> From: Joshua Jensen
> Date: 11/3/2011 10:05 AM
>> ----- Original Message -----
>> From: Joshua Jensen
>> Date: 10/27/2011 1:27 PM
>>> We had a submodule that we deleted and then added back into the repository at the same location as the former submodule.  When running fast-export, the newly 'added' files for the merge commit are listed and then are followed with a:
>>>
>>> M ... path/to/submodule/file
>>> D path/to/submodule
>>>
>>> On fast-import, the resultant repository becomes corrupt due to the Delete instruction above occurring AFTER the file adds/modifications.  The new repository does not match the old repository where the fast-export was performed.
>>>
>>> I am not familiar with the fast-export code.  Can anyone help out?
>> Okay, I looked into this further, and I came up with a patch that works for me.  Nevertheless, I do not understand exactly what is going on here, so I would like to defer to someone else's patch to fix the issue.
>>
> Hi.
> 
> __This is a genuine data loss problem in Git.__
> 
> I'm confused at the lack of response to this.  I first posted about the issue **2-1/2 weeks ago**, and there have been no responses  Does no one care?

Maybe no one cares, people didn't read the message (or forgot about it)
or they are too busy ... thanks for prodding us again.

While I'm interested in this issue because submodules are affected, I'm
very short on Git time these days and can't investigate this issue
further (and I have no clue about export/import either). I added the last
two people who touched depth_first() in builtin/fast-export.c to the CC,
maybe they can tell us more about your patch to solve this issue (found
in [2]).

> In case no one received the messages, you can find them at [1] and [2].
> 
> -Josh
> 
> [1] http://www.spinics.net/lists/git/msg168295.html
> [2] http://www.spinics.net/lists/git/msg168691.html
