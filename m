From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 00/42] Use ref transactions for all ref updates
Date: Mon, 05 May 2014 14:57:30 +0200
Message-ID: <53678ABA.4010104@alum.mit.edu>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 19:25:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi0R-0006KZ-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023AbaEEM5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 08:57:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56299 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932214AbaEEM5d (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2014 08:57:33 -0400
X-AuditID: 1207440e-f79c76d000003e2c-80-53678abc28fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 30.6F.15916.CBA87635; Mon,  5 May 2014 08:57:32 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB24B0.dip0.t-ipconnect.de [93.219.36.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s45CvU1m025983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 May 2014 08:57:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1N3TlR5ssOG8oEXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTujb2YfY8Ee7or1h34xNjD2cXYxcnBICJhI3P8W
	1sXICWSKSVy4t56ti5GLQ0jgMqPE3t/ToJxzTBLTOzrZQap4BbQlph+czQhiswioSpw5t5MF
	xGYT0JVY1NPMBDJUVCBI4s9ZRYhyQYmTM5+AlYgI2Emsv7WQGcQWFnCT+H7tPSNIuZCAk8T2
	PxkgYU4BZ4kpr3ezQZwmLtHTGAQSZhbQkXjX94AZwpaX2P52DvMERoFZSBbMQlI2C0nZAkbm
	VYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxgh4cm3g7F9vcwhRgEORiUe3kTm
	9GAh1sSy4srcQ4ySHExKorz3GoBCfEn5KZUZicUZ8UWlOanFhxglOJiVRHiXguR4UxIrq1KL
	8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8CZ1AjYJFqempFWmZOSUIaSYOTpDh
	XFIixal5KalFiaUlGfGgGI0vBkYpSIoHaO9kkHbe4oLEXKAoROspRl2OCw0rWpiEWPLy81Kl
	xHlDQYoEQIoySvPgVsCS0StGcaCPhXmzQap4gIkMbtIroCVMQEu4jMGWlCQipKQaGO3SymQe
	rTi5IUXlGd/znJf8Lf9PdW+q+rZeuPnZpZ17DnKu0V1de3/qjqy5V5rFJnEHHdZrknea0hI2
	tSGLUfS2iJPdD5u6i/M2LlJxa/szjc2h7lBx4Izs1kibrscbpsxUPL6JwYyjuynr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248182>

On 05/01/2014 10:37 PM, Ronnie Sahlberg wrote:
> This patch series is based on next and expands on the transaction API. [...]

Meta-comment:

Ronnie,

It seems like successive versions of this patch series are growing not
only in maturity but also in breadth.  That makes it harder to review them.

I, for one, would prefer that a patch series cover a roughly fixed set
of changes [1], so that all of the patches in a version of the series
are at roughly the same level of maturity.  That way, the whole series
can progress from "is this a good idea?" to "is the implementation
correct?" to "are all the details right?" at roughly the same time, and
then Junio can merge the branch, locking in that bit of progress.  While
this is happening, other series can be making their way through other
stages of the pipeline.

When new patches are added to an old series, then they delay the merge
of the older patches, even if those are ripe.  Plus, it makes it harder
for reviewers to keep track of the maturity level of each patch and to
read off how the older patches have changed.  It makes the patch series
a moving target.

There's no need to re-split this patch series, but please take this wish
into account in the future.

Thanks,
Michael

[1] Of course, if a patch series has to grow to make the *existing*
changes correct, then that's perfectly OK.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
