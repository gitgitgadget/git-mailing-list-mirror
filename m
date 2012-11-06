From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Tue, 06 Nov 2012 07:39:23 +0100
Message-ID: <5098B09B.7060501@viscovery.net>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com> <5097C190.80406@drmicha.warpmail.net> <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com> <5097CFCB.7090506@drmicha.warpmail.net> <CAMPhdO-Z3E352KbTvnrxJqCecAUGfHCwOoFRUKzObh35uLnrSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 07:39:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVcpH-0001kl-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 07:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab2KFGja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 01:39:30 -0500
Received: from so.liwest.at ([212.33.55.23]:11434 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277Ab2KFGj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 01:39:28 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TVcom-0001RC-Nf; Tue, 06 Nov 2012 07:39:25 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 63EB31660F;
	Tue,  6 Nov 2012 07:39:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CAMPhdO-Z3E352KbTvnrxJqCecAUGfHCwOoFRUKzObh35uLnrSw@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209098>

Am 11/6/2012 1:58, schrieb Eric Miao:
> On Mon, Nov 5, 2012 at 10:40 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Eric Miao venit, vidit, dixit 05.11.2012 15:12:
>>> The problem is, most cases we have no idea of the base rev1, and commit rev2
>>> which it's leading up to. E.g. for a single patch which is between
>>> commit rev1..rev2,
>>> how do we find out rev1 and rev2.
> 
> E.g. when we merged a series of patches:
> 
>   [PATCH 00/08]
>   [PATCH 01/08]
>   ...
>   [PATCH 08/08]
> 
> How do we know this whole series after merged when only one of these
> commits are known?

You can use git name-rev. For example:

$ git name-rev 9284bdae3
9284bdae3 remotes/origin/pu~2^2~7

This tell you that the series was merged two commits before origin/pu, and
then it is the 7th from the tip of the series. Now you can

$ git log origin/pu~2^..origin/pu~2^2

to see the whole series.

-- Hannes
