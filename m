From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git feature request: --amend older commit
Date: Fri, 17 Aug 2012 18:33:31 +0200
Message-ID: <502E725B.2040906@alum.mit.edu>
References: <20120817154749.11762.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 18:40:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2PbH-0004UN-Uk
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 18:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758499Ab2HQQki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 12:40:38 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:57276 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758490Ab2HQQkh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2012 12:40:37 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2012 12:40:36 EDT
X-AuditID: 1207440e-b7f036d0000008b5-4f-502e725e1b59
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 11.95.02229.E527E205; Fri, 17 Aug 2012 12:33:34 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7HGXWrE008930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 17 Aug 2012 12:33:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <20120817154749.11762.qmail@science.horizon.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqBtXpBdg0N+sYNF1pZvJ4tSaeYwO
	TB7b585n9vi8SS6AKYrbJimxpCw4Mz1P3y6BO+P+t0bWgu3sFTfPHGRuYPzO2sXIySEhYCLR
	/6mJEcIWk7hwbz1bFyMXh5DAZUaJxT+PMEI4x5kkjk1ZBlbFK6AtsWPOebBuFgFViS9d39lA
	bDYBXYlFPc1MILaoQIjEmm9ToOoFJU7OfMICYosIqElc758HZHNwMAuIS/T/AwsLC5hJzO66
	CNYqJGAjcaP7HTuIzSlgK3FwyyomiHJriW+7i0DCzALyEtvfzmGewCgwC8mCWQhVs5BULWBk
	XsUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokREqR8Oxjb18scYhTgYFTi4Z3o
	oxsgxJpYVlyZe4hRkoNJSZR3dYFegBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3hUfgcp5UxIr
	q1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyGhwcAmvWrb7AKMWSl5+XqiTBm1MItECw
	KDU9tSItM6cEoZSJgxNkEZeUSHFqXkpqUWJpSUY8KHrji4HxC5LiAbrBGKSdt7ggMRcoCtF6
	ilGX4/PTk3cZhcB2SInzqoAUCYAUZZTmwa2ApapXjOJA3wvz+oBU8QDTHNykV0BLmICWrBQB
	ebS4JBEhJdXAaHvrco/Y44TukoUdE8zic++nmLxkmLUzV1czjVnHpmzF1p89Nt1HpXceXMeg
	zHIiT4nlctycCYYTeC49lL9VuGHhmd0sf3m+XXFmsf40oWv5PRvZtbWOWWEdF4UY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203622>

On 08/17/2012 05:47 PM, George Spelvin wrote:
> With git's "commit frequently" style, I often find that I end up with a
> commit that includes a typo in a comment or I forgot one call site when
> updating functions or something.
>
> And it's a few commits later before I notice the simple oops.
>
> This is of course fixable by making a commit, rebase -i HEAD~4 (or whatever),
> and marking the fixup for squashing into the previous commit.
>
> But it would be really handy if there were a one-step command for doing this.
>
> Something like "git commit --fixup HEAD~3", where "git commit --fixup HEAD"
> would be equivalent to "git commit --amend". [...]

Have you tried "git rebase --autosquash"?  It does part of what you are 
asking for and additionally allows multiple fixup commits to be queued 
up and processed in a single rebase.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
