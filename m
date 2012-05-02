From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] create_ref_entry(): move check_refname_format() call
 to callers
Date: Wed, 02 May 2012 17:38:04 +0200
Message-ID: <4FA154DC.1060607@alum.mit.edu>
References: <1335680288-5128-1-git-send-email-mhagger@alum.mit.edu> <20120429115831.GC24254@sigill.intra.peff.net> <4F9EBB6D.3090900@alum.mit.edu> <7vd36pgn0e.fsf@alter.siamese.dyndns.org> <4F9EF60D.8030301@alum.mit.edu> <7vsjfkexh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 17:45:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPbjw-0005sn-35
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 17:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121Ab2EBPpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 11:45:09 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:60530 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754576Ab2EBPpI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 11:45:08 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 May 2012 11:45:08 EDT
X-AuditID: 12074411-b7f596d000000932-f9-4fa154dd9ffa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D2.3B.02354.DD451AF4; Wed,  2 May 2012 11:38:05 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q42Fc46R020244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 May 2012 11:38:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <7vsjfkexh1.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHs3ZKG/QfMmE4uuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bnd/x+zFexnr7i/5xhjA2ML
	WxcjJ4eEgInEz3N9zBC2mMSFe+uB4lwcQgKXGSW2X7zIDuEcY5JYsWMqO0gVr4C2xOVjTxlB
	bBYBVYkj72aDdbMJ6Eos6mlmArFFBcIk+m9vYYKoF5Q4OfMJC4gtIqAmMbHtEJDNwcEsYCQx
	73Q9SFgYqPzZx01Qi9uYJCY0QeziFDCTmNy/hRGi3lri2+4ikDCzgLzE9rdzmCcwCsxCsmEW
	QtUsJFULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6uVmluilppRuYoQEruAOxhkn5Q4x
	CnAwKvHwKj5Y4C/EmlhWXJl7iFGSg0lJlDckaKG/EF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFe
	fhmgHG9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgpcdGKFCgkWp6akV
	aZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aA4jS8GRipIigdorwpIO29xQWIuUBSi9RSjLsfs
	JVuvMgqx5OXnpUqJ80qBFAmAFGWU5sGtgKWpV4ziQB8L82qDVPEAUxzcpFdAS5iAluSbzwNZ
	UpKIkJJqYORr+8LPvtHAbpPZut9/Y8JO6h3g/1RcHsD2yG6S0oZdtw5uLJxer+38TT7ph3aa
	TMwzd/6pWzM2Nfv4zPhQtpJBM77axdriH/c+vzlMG+T8ZtT2f1Z6xG7xoHxDowrz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196836>

On 04/30/2012 11:11 PM, Junio C Hamano wrote:
> Michael Haggerty<mhagger@alum.mit.edu>  writes:
>
>> For example, have all of the following code paths been audited to make
>> sure that they cannot introduce class (3) refnames into a repository
>> (including via symbolic refs with class (3) targets) even in the face
>> of a malicious remote?  Can we (and do we want to) rely on this level
>> of vigilance being sustained in the future?
>
> Auditing is one thing, but perhaps the right solution to that issue is to
> refactor the existing code so that we have only a handful (preferrably
> one) API entry point that is used to create a new ref (not to be confused
> with create_ref_entry(), which is not necessarily about creating a ref)?

Yes, definitely.  And more broadly, I want refs.{c,h} to become the 
*only* mechanism for working with refs.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
