From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 9/9] fetch: allow explicit --refmap to override configuration
Date: Wed, 18 Jun 2014 14:21:25 +0200
Message-ID: <53A18445.8090607@alum.mit.edu>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>	<1401833792-2486-10-git-send-email-gitster@pobox.com>	<538F34E1.6010704@xiplink.com>	<xmqqbnu8tim1.fsf@gitster.dls.corp.google.com>	<539090AD.9040100@xiplink.com> <xmqqy4xbrynr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tanay Abhra <tanayabh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 14:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxErt-0007aa-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 14:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966315AbaFRMV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 08:21:29 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61468 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966305AbaFRMV2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 08:21:28 -0400
X-AuditID: 12074413-f79bc6d000000b9e-4c-53a184483b64
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.18.02974.84481A35; Wed, 18 Jun 2014 08:21:28 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5ICLPHd005148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 08:21:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <xmqqy4xbrynr.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqOvRsjDY4OF7VouuK91MFg29V5gt
	Vs64wWjx68J7ZgcWj52z7rJ7XLyk7PF5k5zHgcuP2QJYorhtkhJLyoIz0/P07RK4M6ZtbGEt
	+C5Q0Tq/k62BcTZvFyMnh4SAicS6xuuMELaYxIV769m6GLk4hAQuM0qsev+GGcI5zyRx4+ZU
	NpAqXgFtiYPrbrCA2CwCqhJXl/0F62YT0JVY1NPMBGKLCgRJzP48jx2iXlDi5MwnYPUiAr4S
	DT2HWUFsZgFLiVNrLoL1CguESJy//htq2SQmibsLvoA1cwpYS5y+fA3I5gA6T1yipzEIoldH
	4l3fA2YIW15i+9s5zBMYBWchWTcLSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma
	6+VmluilppRuYoQEuvAOxl0n5Q4xCnAwKvHw7tizIFiINbGsuDL3EKMkB5OSKK9J08JgIb6k
	/JTKjMTijPii0pzU4kOMEhzMSiK8x4qBcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2amp
	BalFMFkZDg4lCd6GZqBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAMxxcDoxgk
	xQO0txOknbe4IDEXKArReopRUUqcNwskIQCSyCjNgxsLS1+vGMWBvhTmDQOp4gGmPrjuV0CD
	mYAGq0ycBzK4JBEhJdXAOP3c/6V+qY9mvDTYemK2q+6Lc3GT5Ph9Zk1dsXKe6kyP6RW1m77/
	U96y4vb1aS8fGSyorPSeb/SmcxXPzHcFl7k0V1nkz5sfNP+OgsIe7ZeTfop4r1ty 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251982>

On 06/05/2014 08:36 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> I don't have any objection to the option per se.  But I do wonder if there's
>> a need to add yet another knob to git just for completeness.  Has anyone ever
>> needed this?
> 
> It is not a good yardstick, as everybody has survived without it
> since Git's inception.  The right question to ask is: would it help
> new use patterns, or improve existing use patterns?

I agree that this feature is pretty esoteric and probably more cognitive
load than it's worth.  One of your use cases has workarounds shown below.

> Two possible scenarios I can think of offhand are
> 
>  * using an empty refmap to ensure that your "fetch" this time is
>    really ephemeral without affecting the longer-term configured
>    remote-tracking branches

Doesn't specifying an explicit URL get around the refspecs configured
for the remote?  E.g.,

    git fetch $(git config remote.github.url) master

Or if we had a way to temporarily unset multivalued configuration values
(which we may have soon thanks to the GSoC project of Tanay Abhra), one
could use

    git --unset=remote.github.fetch fetch github master

>  * grabbing only a few selected branches out of hundreds, e.g.
> 
>    $ git fetch https://github.com/gitster/git \
>        --refmap=refs/heads/*:refs/remotes/jch/* maint master next +pu
> 
>    instead of having to spell its long-hand
> 
>    $ git fetch https://github.com/gitster/git \
>        refs/heads/maint:refs/remotes/jch/maint \
>        refs/heads/master:refs/remotes/jch/master \
>        refs/heads/next:refs/remotes/jch/next \
>        +refs/heads/pu:refs/remotes/jch/pu

I'm not quite sure what your goal is here, but if you want to fetch some
branches on the fly without setting up a remote, then

    git -c remote.github.fetch='refs/heads/*:refs/remotes/jch/*' \
             fetch https://github.com/gitster/git maint master next +pu

should work, no?

> but there may be more useful scenarios other people can come up
> with ;-).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
