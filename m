From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/10] object_id part 2
Date: Mon, 03 Aug 2015 01:33:56 +0200
Message-ID: <55BEA8E4.7040902@alum.mit.edu>
References: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?B?eQ==?= 
	<pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 01:34:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZM2lp-0006o7-BG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 01:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbbHBXeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 19:34:01 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42938 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751584AbbHBXeA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Aug 2015 19:34:00 -0400
X-AuditID: 12074414-f794f6d000007852-13-55bea8e7cbed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 58.C3.30802.7E8AEB55; Sun,  2 Aug 2015 19:33:59 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB03A9.dip0.t-ipconnect.de [93.219.3.169])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t72NXvU0023144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 2 Aug 2015 19:33:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqPt8xb5Qg1V32S26rnQzWXRPecto
	8aOlh9mibeYPJgcWj+U3/zJ57Jx1l93jWe8eRo/Pm+QCWKK4bZISS8qCM9Pz9O0SuDNePzjI
	VrCFu2LbiiPMDYwTObsYOTkkBEwkNr25wQ5hi0lcuLeeDcQWErjMKLGrlauLkQvIPssksbVr
	MiNIgldAW2L2pq9MIDaLgKrEm29/wWw2AV2JRT3NQDYHh6hAkMTrl7kQ5YISJ2c+YQGxRQS8
	JOY/msEKYjMLVEv8u/YVbJewgJ7Egv9bGSH2+kpcXb0UzOYU8JPY9OwbO8hIZgF1ifXzhCBa
	5SWat85mnsAoMAvJhlkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZopea
	UrqJERLKIjsYj5yUO8QowMGoxMP7YcG+UCHWxLLiytxDjJIcTEqivPOrgUJ8SfkplRmJxRnx
	RaU5qcWHGCU4mJVEeC+mA+V4UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4
	lCR4Hy4HahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxWh8MTBKQVI8QHuzV4Ds
	LS5IzAWKQrSeYlSUEud9BjJXACSRUZoHNxaWoF4xigN9Kcz7EqSKB5jc4LpfAQ1mAhp8OWMP
	yOCSRISUVAMj9/HNNYnPHV1eP3JbcOrU0hk3Ji8KNp51d11x6hve7A9TVijM4V6r/Vjt1osW
	b8MO0T3XtA5mM3qYp4fU7FO7YxCTbNfrNSezcwkjW6/88eoDFeF2B5tEjabeyV/p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275153>

On 06/14/2015 12:16 AM, brian m. carlson wrote:
> This is another series of conversions to struct object_id.
> 
> This series converts more of the refs code and struct object to use
> struct object_id.  It introduces an additional helper function,
> has_object_file, which is the equivalent of has_sha1_file.  The name was
> chosen to be slightly more logical than has_oid_file, although it can be
> changed if desired.
> 
> The next-to-last patch in this series is the conversion of struct object
> to use struct object_id.  This is a necessarily large patch because of
> the large number of places this code is used.  That patch will most
> likely be too large to make it through to the list, so this series is
> available in the object-id-part2 branch from:

FWIW I've skimmed patches 01-08 inclusive and nothing jumped out at me.

Brian, what was your experience when writing these patches? Did they
tend to work as soon as they compiled without errors (i.e., not super
risky) or did you often have test suite failures that you had to go back
and fix (i.e., risky)? If the latter, what kinds of code patterns tended
to be problematic? Your answers might help reviewers decide how much
diligence is needed when reviewing these patches and what kind of
changes to inspect extra carefully. Because doing a thorough review of
all of the patches would be quite a bit of work.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
