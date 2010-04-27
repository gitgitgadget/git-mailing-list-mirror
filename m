From: Andreas Ericsson <ae@op5.se>
Subject: Re: Metadata and checkin file date
Date: Tue, 27 Apr 2010 11:22:55 +0200
Message-ID: <4BD6ACEF.1040909@op5.se>
References: <alpine.LFD.2.00.1004270719320.17234@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 11:23:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6h0p-0000F3-31
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 11:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab0D0JXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 05:23:10 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:51891 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754024Ab0D0JXJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 05:23:09 -0400
Received: from source ([209.85.221.182]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS9as9S32clQmVTEdLL5N+ox+sgWYZMEJ@postini.com; Tue, 27 Apr 2010 02:23:08 PDT
Received: by mail-qy0-f182.google.com with SMTP id 12so4722397qyk.21
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 02:23:01 -0700 (PDT)
Received: by 10.224.62.209 with SMTP id y17mr1691194qah.281.1272360181020;
        Tue, 27 Apr 2010 02:23:01 -0700 (PDT)
Received: from clix.int.op5.se ([72.14.241.8])
        by mx.google.com with ESMTPS id 23sm2810780qyk.3.2010.04.27.02.22.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 02:22:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <alpine.LFD.2.00.1004270719320.17234@bbs.intern>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145889>

On 04/27/2010 07:23 AM, Gerhard Wiesinger wrote:
> Hello,
> 
> I'm new to git and I'm looking for the following features:
> 1.) Metadata for
> a.) directory versioning (e.g. add/rm, mv)

If you're talking about empty directories, that feature doesn't
exist and I can't imagine why you'd want it to. If you'd care to
explain why you want it, I'm sure we can find a different way of
achieving your goal.

> b.) rights (basic: chmod, chow, chgrp, extended: extended attributes 
> like ACLs and selinux), necessary for versioning e.g. /etc

Sounds like you want a backup-program. Some projects have been
aimed towards this goal already. I'm sure google can provide
more information. AFAIR, most of them work with two hook-scripts
that update a regular file with the meta-data of all tracked
files. This makes committing and checking out slower than it
would otherwise be, but since it's doing more I suppose that's
to be expected.

Adding it to core git would mean re-designing git's basic data
model, which is obviously not something we're about to do on
a whim.

> 2.) Original file dates (checkin date) on clone and pull (and not 
> checkout date)
> 

I expect the solutions that work for 1b will also have this
"feature", or that it will be easy to patch for it. For a
source code management system though, this is a very bad
idea indeed since it messes with the fundamental rules of
building; A changed file must be rebuilt.

Seeing as this would also require a major change in git's
data model, this is another of those changes that I doubt
will be supported in the git core in the foreseeable future.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
