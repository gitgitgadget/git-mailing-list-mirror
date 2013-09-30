From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git counterpart to SVN bugtraq properties?
Date: Mon, 30 Sep 2013 11:55:13 -0700
Message-ID: <20130930185513.GS9464@google.com>
References: <51E69612.6020201@syntevo.com>
 <20130717133357.GB2337@serenity.lan>
 <5249ACCB.5090007@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Mon Sep 30 20:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQicu-0006YK-1i
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 20:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab3I3SzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 14:55:18 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45194 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab3I3SzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 14:55:17 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so6322494pab.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TjkYLOgCtAbI72XYucrUUIDVqv/6sJO3xPDkBk5P1hM=;
        b=YZ5FNSY7q4rPuL5/N/9HzoInCjhKQvDySqkgc6YQMS7PnBippv/mHpisw9IxM/7y0G
         7uOCtp2LlgpiKDM6l+kSchGSitFLJOd2Dn20JYh3oDbQbXAwhCBKjL1dfB4T+NzvcaSl
         TpYTW+4US/4hWXXdqyIich1ycHWy8LvMlkSy4Ps26GmIT6oPvmWtljdSNFPmTTShJUGA
         u/AhtcoL+nkAL3+gEnDPxqE6R/gDZMYf/XKVFU1e3cEGAUchVdDGoRpJyJkTfgMI8RTF
         hOGatt9OPXt1rrpqWWyntT0Of4iLngJoOFd0tm9jzxR2UuJmh64JCviGHyfB/pBiM4bG
         zqag==
X-Received: by 10.68.2.166 with SMTP id 6mr4372341pbv.165.1380567317143;
        Mon, 30 Sep 2013 11:55:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ye1sm2929102pab.19.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 11:55:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5249ACCB.5090007@syntevo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235619>

Hi,

Marc Strapetz wrote:
>> On Wed, Jul 17, 2013 at 03:03:14PM +0200, Marc Strapetz wrote:

>>> I'm looking for a specification or guidelines on how a Git client should
>>> integrate with bug tracking systems.
[...]
> Finally, I've created a minimal spec which is sufficient to parse and
> display issue IDs:
>
> https://github.com/mstrap/bugtraq/blob/master/specification.txt

Neat. :)

It reminds me a little of Gerrit's commentlink functionality, though
that tries to solve a different / more generic problem (automatic
linking in commit messages in general, not just to bug trackers):
https://gerrit-review.googlesource.com/Documentation/config-gerrit.html#_a_id_commentlink_a_section_commentlink

Some projects use more than one bug tracker.  For example, a distro
might have its own bug tracking system and also sometimes make commits
that refer to the upstream bug tracker.  I don't think that's
important to necessarily address in the first version of a project
like this, but thought I should mention it to help plans for the
future.

Gerrit keeps its configuration in a file named "project.config" in the
tree associated to the refs/meta/config commit so a single
configuration can be applied to the entire repository.  Which
.gitbugtraq file should take effect in a repository with multiple
branches?

Hope that helps,
Jonathan
