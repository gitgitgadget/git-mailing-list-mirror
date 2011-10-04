From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 04 Oct 2011 10:08:23 +0200
Message-ID: <4E8ABEF7.7010003@alum.mit.edu>
References: <4DF6A8B6.9030301@op5.se> <201109301041.13848.mfick@codeaurora.org> <201109301502.30617.mfick@codeaurora.org> <201109301606.31748.mfick@codeaurora.org> <7vwrcola0m.fsf@alter.siamese.dyndns.org> <4E87F462.3000308@alum.mit.edu> <3e4aa1b3-5b14-4446-ac83-cef41c18a11f@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 10:08:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB03S-0005S1-5S
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 10:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab1JDIIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 04:08:42 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41564 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab1JDIIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 04:08:40 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9488ND6026132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Oct 2011 10:08:23 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <3e4aa1b3-5b14-4446-ac83-cef41c18a11f@email.android.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182746>

On 10/03/2011 02:46 AM, Martin Fick wrote:
> Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> I
>> also have some code (not pushed) that adds some intelligence to make
>> the use case
>>
>>    repeat many times:
>>        check if reference exists
>>        add reference
> 
> Would it be possible to separate the two steps into separate loops somehow?  Could it instead look like this:
>  
>>    repeat many times:
>>        check if reference exists
>  
>>    repeat many times:
>>        add reference

Undoubtedly this would be possible.  But I'd rather make the refs code
efficient and general enough that its users don't need to worry about
such things.

> [...] Of course, this would likely require checking for dups
> before running the first loop.

Yes, and this "checking for dups before running the first loop" is
approximately the same work that would have to be done within a smarter
version of the refs code.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
