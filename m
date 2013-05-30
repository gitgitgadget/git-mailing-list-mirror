From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 22/25] string_list_add_refs_by_glob(): add a comment
 about memory management
Date: Thu, 30 May 2013 21:29:16 +0200
Message-ID: <51A7A88C.2020307@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu> <1369472904-12875-23-git-send-email-mhagger@alum.mit.edu> <87ppwaurfy.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 21:29:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui8XO-0006ht-CX
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 21:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758515Ab3E3T3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 15:29:22 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46148 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753162Ab3E3T3V (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 15:29:21 -0400
X-AuditID: 12074412-b7f216d0000008d4-86-51a7a890c17c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id AD.04.02260.098A7A15; Thu, 30 May 2013 15:29:20 -0400 (EDT)
Received: from [192.168.69.140] (p57A24A59.dip0.t-ipconnect.de [87.162.74.89])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4UJTGXD023775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 May 2013 15:29:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <87ppwaurfy.fsf@linux-k42r.v.cablecom.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqDthxfJAgy9fZC26rnQzWTT0XmG2
	mHd3F5PFj5YeZou7l1exO7B6XHr5nc3j9uv5zB7Pevcwely8pOzxeZNcAGsUt01SYklZcGZ6
	nr5dAnfGtOVdLAVT2Sr2njvH2MD4l6WLkZNDQsBEYvLvx1C2mMSFe+vZuhi5OIQELjNK7Hm7
	kwnCOcck8WDmRMYuRg4OXgFtiS/Ts0EaWARUJWY07GYDsdkEdCUW9TQzgdiiAmES75dNZQWx
	eQUEJU7OfMIC0ioioCyxbWENyEhmgSZGidsXVoPVCAukSvz9s4kVYtdKRolJWyeBXcQpYC6x
	c1I32FBmAR2Jd30PmCFseYntb+cwT2AUmIVkxywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxb
	nJyYl5dapGuml5tZopeaUrqJERLkQjsY15+UO8QowMGoxMObkbQ8UIg1say4MvcQoyQHk5Io
	78YFQCG+pPyUyozE4oz4otKc1OJDjBIczEoivEt7gHK8KYmVValF+TApaQ4WJXHen4vV/YQE
	0hNLUrNTUwtSi2CyMhwcShK8UcuBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB
	sRpfDIxWkBQP0N5OkHbe4oLEXKAoROspRl2OGT8mv2MUYsnLz0uVEudNASkSACnKKM2DWwFL
	aa8YxYE+FuZ9vgyoigeYDuEmvQJawgS05Ik12JKSRISUVANjZGfbXcMJ3+pv7HyXYeMrGRRT
	ufr7eeevPgsn+nTU7HS+dEngzAn5GeqJm+ddtuSvaVmm06pguvvPS9WJ37Vm1k9/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226031>

On 05/29/2013 10:21 AM, Thomas Rast wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Since string_list_add_one_ref() adds refname to the string list, but
>> the lifetime of refname is limited, it is important that the
>> string_list passed to string_list_add_one_ref() has strdup_strings
>> set.  Document this fact.
>>
>> All current callers do the right thing.
> [...]
>> +/*
>> + * The list argument must have strdup_strings set on it.
>> + */
>>  void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
>>  {
>>  	if (has_glob_specials(glob)) {
> 
> Maybe add an assert() so that this is bulletproof?

Good idea.  Will be added in v3.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
