From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 18:42:03 +0100
Message-ID: <200711131842.03622.jnareb@gmail.com>
References: <874pfq9q8s.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com> <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:42:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrzmQ-0001Pk-Iw
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 18:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbXKMRmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 12:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbXKMRmK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 12:42:10 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:20662 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbXKMRmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 12:42:09 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1882636fkz
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=7j+HDOUbo3cBzBIqwEGzfi2CFzKc0W9XA/zxNbU6KS8=;
        b=P/Us7y2rRJTW2dmgJiwNuPtkVJQc64A0ea602t2pUDetmQ1HF+y5faVsfrGnceXNrd1xeNPAr59JhIFfcne37VF0R6Gqx5wbnGrK6yK7E7/7/XoAWYvO0blepeQZgWlb2N4uOXvJbwByt2Gqx2kgElvr0bONrDsWSFx7y2noxfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EPUWq2PINy0QKvP+xYyVBSXdYcSkZcF1GnS6P2Q6+vK9422bqQHsvW1ws2ulE/Fhn76XE7vQz5qkZHBmd/iESay8s3njMNwMy9I1uv5zw9DhH+g0Odw+Cj2GJmZf/WzeOB79KDnKepYVLcPXjhiBE1rY4pFoBEGR7hNVKFHW4bw=
Received: by 10.82.160.19 with SMTP id i19mr15532752bue.1194975727636;
        Tue, 13 Nov 2007 09:42:07 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.125])
        by mx.google.com with ESMTPS id z33sm195276ikz.2007.11.13.09.42.04
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Nov 2007 09:42:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64816>

Steffen Prohaska wrote:
> On Nov 13, 2007, at 5:03 PM, Jakub Narebski wrote:
>> Sergei Organov <osv@javad.com> wrote:

>>> Isn't "git branch -d -r" supposed to do whatever magic is required to
>>> get rid of the remote branch? Currently it seems like a bug  
>>> introduced by addition of wildcards refspecs, right?
>>
>> No, the '-r' part translates 'pu' into 'refs/remotes/origin/pu', and
>> the '-d' option removes branch locally. It is meant I think to remove
>> tracking of branches which were dropped in remote, as I think that
>> wildcard refspec does create new branches, but do not delete dropped
>> branches.
> 
> "git remote prune origin" should be used to clean up stale
> remote-tracking branches.

"git remote prune <name>" deletes _all_ stale tracking branches
under <name>. With "git branch -d -r <branch>" you can delete
_single_ tracking branch.

>> So I'm not sure if it is a bug, misfeature or a feature.
> 
> It doesn't make sense to delete remote-tracking branches
> locally if they are still present at the remote.  The main
> purpose of a remote-tracking branch is to be identical to the
> real remote branch.

True, but it would be nice to have an option to _exclude_ some
branches from fetching (for example 'html' and 'man' branches
of git.git), while still picking up new branches automatically
on fetch.

-- 
Jakub Narebski
Poland
