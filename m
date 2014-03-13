From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: New GSoC microproject ideas
Date: Thu, 13 Mar 2014 18:06:39 +0100
Message-ID: <5321E59F.8020003@alum.mit.edu>
References: <532049A7.6000304@alum.mit.edu> <xmqq1ty7me6a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Fabian <bafain@gmail.com>,
	Quint Guvernator <quintus.public@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:06:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO95k-0001Sf-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 18:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbaCMRGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 13:06:44 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54620 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753950AbaCMRGn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2014 13:06:43 -0400
X-AuditID: 1207440d-f79d86d0000043db-a1-5321e5a21357
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 35.3F.17371.2A5E1235; Thu, 13 Mar 2014 13:06:42 -0400 (EDT)
Received: from [192.168.69.148] (p57A24737.dip0.t-ipconnect.de [87.162.71.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2DH6evH007407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 13 Mar 2014 13:06:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqq1ty7me6a.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqLvoqWKwwdGPohaH5t5jt+i60s1k
	0dB7hdniXXc/swOLx85Zd9k9Ll5S9vi8SS6AOYrbJimxpCw4Mz1P3y6BO+PTnu3sBX/ZKuY0
	lTYwNrF2MXJySAiYSBz69I8FwhaTuHBvPVsXIxeHkMBlRom1U08zQTjnmCQ+tKxgAqniFdCW
	OPOkHaybRUBVorV3ITOIzSagK7GopxmsRlQgWGL15QcsEPWCEidnPgGzRQTUJCa2HQKyOTiY
	Beokfr50AAkLC2hIfL7+CGykkECUxOwf98BsTgFriUnr17GDlEsIiEv0NAaBhJkFdCTe9T1g
	hrDlJba/ncM8gVFwFpJls5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJ
	XmpK6SZGSGDz7mD8v07mEKMAB6MSD6/DYcVgIdbEsuLK3EOMkhxMSqK87I+BQnxJ+SmVGYnF
	GfFFpTmpxYcYJTiYlUR4ZS4D5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIy
	HBxKErzHngA1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiN74YGL8gKR6gvTtB
	2nmLCxJzgaIQracYdTlut/36xCjEkpeflyolzvsQ5HABkKKM0jy4FbA09opRHOhjYd7TIKN4
	gCkQbtIroCVMQEt+BMiDLClJREhJNTAq7f1iWcVX1/LxsfPrF7u8mJmErK3TrzM4zxEX9xM8
	cb/PzEvF/dqHNpNHnMlrd3TkLj7SkOvMca4wlP3j26mpM7YzvytRqLezdukqe/gy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244035>

On 03/12/2014 08:04 PM, Junio C Hamano wrote:
> Here is another, as I seem to have managed to kill another one ;-)
> 
> -- >8 --
> 
> "VAR=VAL command" is sufficient to run 'command' with environment
> variable VAR set to value VAL without affecting the environment of
> the shell itself, but we cannot do the same with a shell function
> (most notably, "test_must_fail"); we have subshell invocations with
> multiple lines like this:
> 
> 	... &&
> 	(
>         	VAR=VAL &&
>                 export VAR &&
>                 test_must_fail git command
> 	) &&
>         ...
> 
> but that could be expressed as
> 
> 	... &&
>         test_must_fail env VAR=VAL git comand &&
> 	...
> 
> Find and shorten such constructs in existing test scripts.

Thanks; I just added it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
