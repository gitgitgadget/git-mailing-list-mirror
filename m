From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: stgit: deleting a branch doesn't seem to work
Date: Tue, 22 Aug 2006 09:34:25 +0100
Message-ID: <tnxd5attbhq.fsf@arm.com>
References: <e7bda7770608211027m298ca361pdd78e164b9a524a5@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 10:34:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFRiV-0001pF-JC
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 10:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWHVIeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 04:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWHVIeb
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 04:34:31 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:23730 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751181AbWHVIea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 04:34:30 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k7M8YRGf009451;
	Tue, 22 Aug 2006 09:34:27 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Tue, 22 Aug 2006 09:34:27 +0100
To: "Torgil Svensson" <torgil.svensson@gmail.com>
In-Reply-To: <e7bda7770608211027m298ca361pdd78e164b9a524a5@mail.gmail.com> (Torgil
 Svensson's message of "Mon, 21 Aug 2006 19:27:02 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 22 Aug 2006 08:34:27.0080 (UTC) FILETIME=[C75FA080:01C6C5C5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25840>

"Torgil Svensson" <torgil.svensson@gmail.com> wrote:
> I have three branches and want my "gst10" to be "master" instead
>
> $ stg branch --delete master
> Deleting branch "master"... done
> $ stg branch -l
> Available branches:
>   s     gst10   |
>         master  |
>>       origin  |
> $ stg branch --delete master
> Deleting branch "master"... done
> $ stg branch -r gst10 master
> stg branch: Branch "master" already exists
>
> Is there something i'm missing in my logic?

It's not actually documented but it looks like the master branch is
not completely deleted by StGIT. If you have StGIT-managed patches in
"master", they are removed but the GIT branch is kept as this is
usually the default branch.

You could do a "git branch -d master" but maybe I should change StGIT
to fully delete the "master" branch as well.

-- 
Catalin
