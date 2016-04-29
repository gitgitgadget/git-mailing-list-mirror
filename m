From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 25/29] refs: resolve symbolic refs first
Date: Fri, 29 Apr 2016 11:51:39 +0200
Message-ID: <57232EAB.3080406@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <a33272db057ac6327cc0c87c002473c89ffcca6b.1461768690.git.mhagger@alum.mit.edu>
 <1461886803.4123.14.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 11:59:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw5Ca-0005WB-NC
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 11:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbcD2J7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 05:59:07 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53194 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751291AbcD2J7G (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 05:59:06 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Apr 2016 05:59:06 EDT
X-AuditID: 1207440e-f07ff700000008c5-32-57232eaed7bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 71.7E.02245.EAE23275; Fri, 29 Apr 2016 05:51:42 -0400 (EDT)
Received: from [192.168.69.130] (p548D6182.dip0.t-ipconnect.de [84.141.97.130])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3T9pd3A018203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 29 Apr 2016 05:51:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1461886803.4123.14.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqLtOTzncYNIfaYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrR3YPHbOusvu8ax3D6PHxUvKHvuXbmPzWPD8PrvH501yAWxR
	3DZJiSVlwZnpefp2CdwZl+/vZi54wFXx/tZNpgbGDo4uRk4OCQETiV+NB5i7GLk4hAS2Mkqs
	nriPEcI5zySxf84vJpAqYQEbicNzTjOD2CIC2hKzj/SwQhRtY5R4ueYlWDuzwDdGic+TfzGC
	VLEJ6Eos6mkG6+YF6pjz/zAriM0ioCrx5OZEMFtUIERi27pvrBA1ghInZz5hAbE5BSwk5t9b
	BjaHWUBd4s+8S8wQtrzE9rdzmCcw8s9C0jILSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn
	5uWlFuka6+VmluilppRuYoSEON8Oxvb1MocYBTgYlXh4Z9xTChdiTSwrrsw9xCjJwaQkyntV
	VzlciC8pP6UyI7E4I76oNCe1+BCjBAezkgjvDy2gHG9KYmVValE+TEqag0VJnFdtibqfkEB6
	YklqdmpqQWoRTFaGg0NJgnczyFDBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UFzG
	FwMjEyTFA7RXRA9kb3FBYi5QFKL1FKOilDhvMchcAZBERmke3FhY4nrFKA70pTBvH0gVDzDp
	wXW/AhrMBDRYYJMiyOCSRISUVAOj4zI2V2PdJuHcZ7OZ5e4LC07cvmMiY7W+5q76R68XLVeX
	SZ6aUbJaljXiSX3Qfn/hjxfV3W69SRHWvnL0/ptfaa8YAqvub7/UozBFz6T9WcDJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292984>

On 04/29/2016 01:40 AM, David Turner wrote:
> On Wed, 2016-04-27 at 18:57 +0200, Michael Haggerty wrote:
> +retry:
> ...
>> +		if (--attempts_remaining > 0)
>> +			goto retry;
> 
> could this be a loop instead of using gotos?

It certainly could. The goto-vs-loop question was debated on the mailing
list when I first added very similar code elsewhere (unfortunately I'm
unable to find a link to that conversation). I was persuaded to change
my loop into gotos, the argument being that the "retry" case is
exceptional and shouldn't be such a dominant part of the function
structure. Plus the goto code is briefer and feels less awkward to me in
this case (that's subjective, of course).

>> +			/*
>> +			 * There is a directory in the way,
>> +			 * but we	 don't know of any references
>> +			 * that it should contain. This might
>> +			 * be a directory that used to contain
>> +			 * references but is now empty. Try to
>> +			 * remove it; otherwise it might cause
>> +			 * trouble when we try to rename the
>> +			 * lockfile into place.
>> +			 */
>> +			strbuf_addf(err, "there is a non-empty directory '%s' "
>> +				          "blocking reference '%s'",
>> +					  ref_file.buf,refname);
>> +			goto error_return;
> 
> We don't actually try to remove anything here, so that comment seems
> wrong?

Thanks, will fix.

Michael
