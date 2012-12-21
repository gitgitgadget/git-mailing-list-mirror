From: "Yngve Nysaeter Pettersen" <yngve@opera.com>
Subject: Re: Opera release Git-splitter, a sub-modularizing tool for Git
Date: Fri, 21 Dec 2012 21:13:59 +0100
Organization: Opera Software ASA
Message-ID: <op.wpontloxvqd7e2@damia.oslo.osa>
References: <op.wpiovoj5qrq7tp@acorna.invalid.invalid>
 <50D454D2.5030403@drmicha.warpmail.net> <op.wpn2xz07vqd7e2@damia.oslo.osa>
 <50D468E6.2090900@drmicha.warpmail.net> <op.wpn9d6xuvqd7e2@damia.oslo.osa>
 <vpqhanf2yny.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Dec 21 21:14:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm8zL-0003Hz-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 21:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876Ab2LUUOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 15:14:18 -0500
Received: from smtp.opera.com ([213.236.208.81]:36423 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729Ab2LUUOR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 15:14:17 -0500
Received: from damia.oslo.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id qBLKE3tF001240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Dec 2012 20:14:04 GMT
In-Reply-To: <vpqhanf2yny.fsf@grenoble-inp.fr>
User-Agent: Opera Mail/11.64 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212009>

On Fri, 21 Dec 2012 16:49:21 +0100, Matthieu Moy  
<Matthieu.Moy@grenoble-inp.fr> wrote:

> "Yngve Nysaeter Pettersen" <yngve@opera.com> writes:
>
>> The split command will create a new repository for all files foo in a
>> folder (path/foo) and their commit history.
>>
>> The replant command reverses that process, re-adding the path prefix
>> for each file. It may be possible to extend that process into one that
>> automatically reintegrates the new commits in the original history,
>> but I never had time to complete that work.
>>
>> I did originally add the "replant" functionality into my version of
>> the git-subtree script, but given the number of commits in the
>> original repository, git-subtree turned out to be inefficient, due to
>> the use of temporary files (tens of thousands of files IIRC).
>>
>> Those problems led to my development of git-splitter in Python
>> (bypassing the problem of temporary files), but just including the
>> functionality I needed, join was not one of those functions.
>
> That still doesn't answer the question: why did you need to write a new
> tool instead of extending git-subtree?

The primary problem with git-subtree was that I ended up with a temporary  
file directory containing 100+K files, which I tracked back to being used  
to manage the commit-to-tree mapping. On Windows, at least, that literally  
slowed down the process to a crawl.

> If one doesn't use "replant", is your tool different from git-subtree?

No, it is not different. However, my tool will use RAM, not diskspace to  
manage information.


-- 
Sincerely,
Yngve N. Pettersen
********************************************************************
Senior Developer		     Email: yngve@opera.com
Opera Software ASA                   http://www.opera.com/
Phone:  +47 96 90 41 51              Fax:    +47 23 69 24 01
********************************************************************
