From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Sun, 04 Dec 2011 14:54:10 +0100
Message-ID: <4EDB7B82.8090707@dbservice.com>
References: <CAFE9C7B.2BFEC%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Sun Dec 04 14:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXCWP-00024o-0d
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 14:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab1LDNyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Dec 2011 08:54:20 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:41546 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab1LDNyT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 08:54:19 -0500
Received: by wgbds13 with SMTP id ds13so4804706wgb.1
        for <git@vger.kernel.org>; Sun, 04 Dec 2011 05:54:18 -0800 (PST)
Received: by 10.180.5.234 with SMTP id v10mr8341819wiv.44.1323006858587;
        Sun, 04 Dec 2011 05:54:18 -0800 (PST)
Received: from calvin.local (gw.ptr-62-65-141-13.customer.ch.netstream.com. [62.65.141.13])
        by mx.google.com with ESMTPS id x8sm8416557wix.17.2011.12.04.05.54.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Dec 2011 05:54:17 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111123 Thunderbird/9.0
In-Reply-To: <CAFE9C7B.2BFEC%joshua.redstone@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186267>

On 12/3/11 12:17 AM, Joshua Redstone wrote:
> Hi,
> I have a git repo with about 300k commits,  150k files totaling maybe 7GB.
>   Locally committing a small change - say touching fewer than 300 bytes
> across 4 files - consistently takes over one second, which seems kinda
> slow.  This is using git 1.7.7.4 on a linux 2.6 box.  The time does not
> improve after doing a git-gc (my .git dir has maybe 250 files after a git
> gc).  The same size commit on a brand new repo takes<  10ms.  Any thoughts
> on why committing a small change seems to take a long time on larger repos?
>
> Fwiw, I also tried doing the same test using libgit2 (via the pygit2
> wrapper), and it was ever slower (about 6 seconds to commit the same small
> change).

try git commit --no-status
