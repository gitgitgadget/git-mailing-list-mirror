From: Aaron Laws <dartme18@gmail.com>
Subject: Re: git-svn Rewrites Some Commits, but not All
Date: Thu, 1 May 2014 08:52:46 -0400
Message-ID: <CADu-kvdVcdJk6+5-ELwti5SEJE5cHjTf+2AwMhfmAOFeYWT-sQ@mail.gmail.com>
References: <CADu-kvcXWXAd2iBt+oQOVt5znxLmU0fmJ-tgOaogyfGjS5R0vA@mail.gmail.com>
 <CAA01CsoWw2OxuO7e09u18b9-g8c2aavDNWPDE_TvG33-79nwMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 14:53:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfqUC-0007Sa-JF
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 14:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaEAMxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 08:53:08 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:59030 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaEAMxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 08:53:07 -0400
Received: by mail-qa0-f41.google.com with SMTP id dc16so1163071qab.14
        for <git@vger.kernel.org>; Thu, 01 May 2014 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3vSqsvV+dAUEKgXMyxIHP5+yQV1OOvv0HiVPj3sq+1o=;
        b=WbfiXtTgvRPDOhmUv9N0sZrfHJD1bil4g99TYnUQZlTnVyuUuOz9Yhw6MadbBSFzJw
         P+viqeHhnwbKUqtMECC8llLS/QUCUOqaShCxqJJyUVHG6LCxdMNa4SVV8i7A9Z1/2oXN
         kx1pgdE0xNOcsCLI1s9/h+RCBaEkKui0Z/YfSd8JRL6N6IFZGH9oyZKa3FKcjf+38WtL
         sSuFOcp2FFcLCaBpW75yDs9e628RLysHYQUcd3Lpxt9FGYYxSBv82R0qoy/R3+M4Ft95
         KgG4Byx5HFOzl1IwdRAEUt4uCsIUp1GWeJ+gJxiCfJKG3t3Av5IUwHRcycSvSXGEOdv/
         d+oA==
X-Received: by 10.140.101.99 with SMTP id t90mr11661750qge.115.1398948786330;
 Thu, 01 May 2014 05:53:06 -0700 (PDT)
Received: by 10.140.95.151 with HTTP; Thu, 1 May 2014 05:52:46 -0700 (PDT)
In-Reply-To: <CAA01CsoWw2OxuO7e09u18b9-g8c2aavDNWPDE_TvG33-79nwMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247810>

Ah, I missed that dcommit entails a rebase. I thought it just
complained if one needed to take place, so I always do a rebase
"manually" before dcommit. I agree, and would not want my other refs
moved around if the change is that drastic.

The workaround is not so bad anyway: git reset on the left-behind
refs. Thanks for the replies!

In Christ,
Aaron Laws


On Tue, Apr 29, 2014 at 6:04 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> On Mon, Apr 28, 2014 at 9:26 PM, Aaron Laws <dartme18@gmail.com> wrote:
>> The way I understand it, when `git svn dcommit` is run, new commits
>> are created (A' is created from A adding SVN information), then the
>> current branch is moved to point to A'. Why don't we move any other
>> refs that were pointing to A over to A' ? What would be the point of
>> continuing to point to A? I'm interested in looking into coding this
>> change to git-svn, but I would like to hear some feedback first.
>
> Hi,
>
> I think A' might not always be simply (A + SVN info). I think you can
> dcommit when you're not up to date.  So A' will have a different
> parent than A (will be automatically rebased on top of current branch
> tip). Other refs pointing to A might be used as bookmarks, and moving
> them from A to A' would be a significant change.
>
> --
> Piotr Krukowiecki
