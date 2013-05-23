From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/17] cmd_diff(): use an object_array for holding trees
Date: Thu, 23 May 2013 09:21:21 +0200
Message-ID: <519DC371.7090109@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu> <1368995232-11042-6-git-send-email-mhagger@alum.mit.edu> <7v4ndwp7ed.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 09:21:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfPq5-000673-65
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 09:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab3EWHVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 03:21:25 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:44808 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751865Ab3EWHVY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 03:21:24 -0400
X-AuditID: 12074413-b7f226d000000902-80-519dc374d6d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F1.BB.02306.473CD915; Thu, 23 May 2013 03:21:24 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4N7LMsS007495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 May 2013 03:21:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7v4ndwp7ed.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqFtyeG6gwbaDLBZdV7qZLBp6rzBb
	zLu7i8niR0sPswOLx6WX39k8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujG0Xt7EX
	rGKtWPX4JmMD4wKWLkZODgkBE4lJ049C2WISF+6tZ+ti5OIQErjMKDH172JmkISQwDUmiftT
	C0FsXgFtieNvTrGB2CwCqhIbD1xkB7HZBHQlFvU0M4HYogJhEu+XTWWFqBeUODnzCdgCEQE1
	iYlth8BsZoE4iZ2dq8DqhQV8JH5daGWCWLycUeJg50awxZwCZhJ9l+8yQjToSLzre8AMYctL
	bH87h3kCo8AsJDtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTS
	TYyQgBbewbjrpNwhRgEORiUe3gM35gQKsSaWFVfmHmKU5GBSEuV1OTg3UIgvKT+lMiOxOCO+
	qDQntfgQowQHs5II7+YeoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoND
	SYK35RBQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoVuOLgdEKkuIB2tsD0s5b
	XJCYCxSFaD3FaMyx+fzkd4wcM34ASSGWvPy8VClx3hqQUgGQ0ozSPLhFsFT2ilEc6G9h3i6Q
	Kh5gGoSb9wpoFRPQqqWn5oCsKklESEk1MDowXD99+F5ceP2Da/zK3RrXt2Yv/fVln4hqVEWU
	5IrdDscONDx89HSe4a+NqgwpO/5kHea7vGvyY6VX4vMVKljTnFe0d9YutTvMpHZ4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225221>

On 05/21/2013 07:30 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Change cmd_diff() to use a (struct object_array) for holding the trees
>> that it accumulates, rather than rolling its own equivalent.
>>
> 
> A significant detail missing here is that this lifts the hardcoded
> 100 tree limit in combined diff but that does not matter in
> practice, I would suppose ;-).

I'll note it anyway in v2 of the patch series.

Thanks for all of your comments.  I will send a re-roll after I hear
back from you regarding patches 08, 09, and 10.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
