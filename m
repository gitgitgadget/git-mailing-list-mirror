From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive
 pruning
Date: Fri, 29 Apr 2016 16:29:03 +0200
Message-ID: <57236FAF.7050201@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
 <xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
 <1461788637.11504.3.camel@twopensource.com>
 <xmqqh9em93xo.fsf@gitster.mtv.corp.google.com>
 <xmqqvb327nyz.fsf@gitster.mtv.corp.google.com>
 <5723059C.5080406@alum.mit.edu>
 <xmqqzisc24en.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 16:29:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9QC-0007P7-VC
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbcD2O3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 10:29:23 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48479 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753588AbcD2O3V (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 10:29:21 -0400
X-AuditID: 12074414-62bff700000008e6-d8-57236fb28641
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 69.26.02278.2BF63275; Fri, 29 Apr 2016 10:29:06 -0400 (EDT)
Received: from [192.168.69.130] (p548D6182.dip0.t-ipconnect.de [84.141.97.130])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3TET3FE031875
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 29 Apr 2016 10:29:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqzisc24en.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqLspXznc4N0UOYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrR3YPHbOusvu8ax3D6PHxUvKHvuXbmPzWPD8PrvH501yAWxR
	3DZJiSVlwZnpefp2CdwZTxY1sRXcYKpYv62LtYFxClMXIyeHhICJxNOdq4FsLg4hga2MEuf6
	j7JAOOeZJCY2nWcBqRIWCJT4+ekTG4gtIqAmMbHtEFTRHGaJY+susYE4zAL3GSXm/u9iBali
	E9CVWNTTDLaDV0Bb4s+lo8wgNouAqsTWycfBJokKhEhsW/eNFaJGUOLkzCdg2zgFrCVm3WoG
	q2cW0JPYcf0XK4QtL7H97RzmCYz8s5C0zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5
	ealFuhZ6uZkleqkppZsYISEusoPxyEm5Q4wCHIxKPLwz7imFC7EmlhVX5h5ilORgUhLlvaqr
	HC7El5SfUpmRWJwRX1Sak1p8iFGCg1lJhPdmDlCONyWxsiq1KB8mJc3BoiTO+22xup+QQHpi
	SWp2ampBahFMVoaDQ0mCNzMPqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFJfx
	xcDIBEnxAO29ALa3uCAxFygK0XqKUZdjwY/ba5mEWPLy81KlxHmdQHYIgBRllObBrYAltFeM
	4kAfC/Mmg1TxAJMh3KRXQEuYgJYIbFIEWVKSiJCSamDUSn++jmPbjcfz7/5Zs7b3hd//dUm3
	rla9k+oTyLv8rkWgnv/XbPbMt//+6q/pSAg9mbPqRZmfDY/J6/jjhcdlvlXazeT6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293005>

On 04/29/2016 10:41 AM, Junio C Hamano wrote:
> [...Long, thoughtful comments omitted...]
> So perhaps your original might be the best version
> among those that have been discussed in this thread.

Very well. I'll also add a comment near the definition of REF_ISPRUNING
that it must only be used together with REF_NODEREF.

Michael
