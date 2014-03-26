From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 19/27] refs: Add a concept of a reference transaction
Date: Wed, 26 Mar 2014 22:42:55 +0100
Message-ID: <533349DF.8090004@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu> <1395683820-17304-20-git-send-email-mhagger@alum.mit.edu> <53331ED7.9020004@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:43:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSvbH-0001Kc-ON
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 22:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399AbaCZVnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 17:43:01 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45061 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752126AbaCZVnA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 17:43:00 -0400
X-AuditID: 12074413-f79076d000002d17-19-533349e344f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.44.11543.3E943335; Wed, 26 Mar 2014 17:43:00 -0400 (EDT)
Received: from [192.168.69.148] (p57A25757.dip0.t-ipconnect.de [87.162.87.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2QLguvw001456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 26 Mar 2014 17:42:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <53331ED7.9020004@kitware.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqPvE0zjYYNdVRoud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZj19+Zy+Yz1WxdNU05gbGX+xdjJwcEgImEqdf7mKBsMUkLtxbz9bF
	yMUhJHCZUWLRoy2MEM45JonXrZOYQap4BbQlji7awQhiswioSqzv2g02iU1AV2JRTzMTiC0q
	ECRxeMMpVoh6QYmTM5+AbRABql+1rgFsA7PAGkaJtT+awJqFBXwkmmc+hlo9l1Hi3qqJQNs4
	ODiBtk37WAliSgiIS/Q0BoGUMwvoSLzre8AMYctLbH87h3kCo+AsJOtmISmbhaRsASPzKka5
	xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQeBDewbjrpNwhRgEORiUe3oS7RsFC
	rIllxZW5hxglOZiURHl7HY2DhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwdnsA5XhTEiurUovy
	YVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErz5II2CRanpqRVpmTklCGkmDk6Q4VxS
	IsWpeSmpRYmlJRnxoBiOLwZGMUiKB2jvT7C9xQWJuUBRiNZTjLocG7ataWQSYsnLz0uVEufd
	5Q5UJABSlFGaB7cClvxeMYoDfSzMex9kFA8wccJNegW0hAloCVeVEciSkkSElFQDo++G6ppn
	h+Or7Sx1pESTfsv0zvINsqsMnuZ9OlBL2HSJTd7pVeK3d0+dl2XLYWsQmd/F/S9I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245232>

On 03/26/2014 07:39 PM, Brad King wrote:
> On 03/24/2014 01:56 PM, Michael Haggerty wrote:
>> +void ref_transaction_update(struct ref_transaction *transaction,
>> +			    const char *refname,
>> +			    unsigned char *new_sha1, unsigned char *old_sha1,
>> +			    int flags, int have_old);
> [snip]
>> +void ref_transaction_create(struct ref_transaction *transaction,
>> +			    const char *refname,
>> +			    unsigned char *new_sha1,
>> +			    int flags);
> [snip]
>> +void ref_transaction_delete(struct ref_transaction *transaction,
>> +			    const char *refname,
>> +			    unsigned char *old_sha1,
>> +			    int flags, int have_old);
> 
> Perhaps we also need:
> 
> void ref_transaction_verify(struct ref_transaction *transaction,
> 			    const char *refname,
> 			    unsigned char *old_sha1,
> 			    int flags, int have_old);
> 
> as equivalent to the "verify" command in "update-ref --stdin"?

Yes.  That's already on my todo list for a future batch of patches.  But
first I was going to beef up the ref_update structure to handle verify
actions directly rather than as updates with oldvalue==newvalue,
probably by turning has_old into a flag with HAS_OLD and HAS_NEW bits.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
