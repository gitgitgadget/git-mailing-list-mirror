From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/14] register_tempfile(): new function to handle an
 existing temporary file
Date: Mon, 10 Aug 2015 05:40:11 +0200
Message-ID: <55C81D1B.8040704@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>	<d0507ec9bdc63b9532bbb348e4505d311ef3c5dc.1433751986.git.mhagger@alum.mit.edu> <xmqqioavla74.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 05:40:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOdwp-0001sv-Dl
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 05:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbbHJDkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 23:40:21 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61571 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752312AbbHJDkV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2015 23:40:21 -0400
X-AuditID: 1207440e-f79516d0000012b3-f5-55c81d1d0ca4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 66.C6.04787.D1D18C55; Sun,  9 Aug 2015 23:40:13 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A3eB3m006958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 9 Aug 2015 23:40:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqioavla74.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1JWVPRFq0P2Bw6LrSjeTRUPvFWaL
	Hy09zA7MHs969zB6XLyk7PF5k1wAcxS3TVJiSVlwZnqevl0Cd8bKLxIFbzkqujs+sjYwdrB3
	MXJySAiYSOxtvMgMYYtJXLi3nq2LkYtDSOAyo8Sp1Q+gnHNMEl9mPwHr4BXQllh/+TVQgoOD
	RUBV4uJEQZAwm4CuxKKeZiaQsKhAkMTrl7kQ1YISJ2c+YQGxRQTUJCa2HWIBKWEWMJKYd7oe
	JCwskCzR/GspI8SmrYwSjQcXsIEkOAWsJeZ9eswKYjML6EnsuP4LypaXaN46m3kCo8AsJCtm
	ISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdY73czBK91JTSTYyQsOXbwdi+XuYQ
	owAHoxIP74zNx0OFWBPLiitzDzFKcjApifJaCp4IFeJLyk+pzEgszogvKs1JLT7EKMHBrCTC
	63cWqJw3JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMHbIA00VLAoNT21
	Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UpfHFwDgFSfEA7ZUGaectLkjMBYpCtJ5iVJQS
	5z0IkhAASWSU5sGNhSWjV4ziQF8K834AqeIBJjK47ldAg5mABoeHHQEZXJKIkJJqYLTg1OT8
	u97pysHT6w9wGVU9ctqx7VtrjrFS6asFq95z3evsyNdQtWM0ustSUfT73K0H/05HaFTMWDdz
	w3eTexLciQnnLhbYq7/ZNYsn6rfDStcZ/Dkv/grEp0XuerA+5bYL5/1T76dzVUef 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275561>

On 06/10/2015 07:55 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Allow an existing file to be registered with the tempfile-handling
>> infrastructure; in particular, arrange for it to be deleted on program
>> exit.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> Hmph.  Where does such a tempfile that is not on list come from?

You saw the answer to your question later in the patch series, but for
the benefit of other readers:

This function will be useful to manage the lifetime of a file whose
creation is not as simple as open(); for example, if the file has to
itself be created using the lockfile API, or if it is not a regular file
(e.g., a socket). I will explain this better in the commit message in v2.

> [...] Also I cannot
> tell which one of register_tempfile() and register_tempfile_object()
> I should be calling when updating the implementation of this API
> from their names.

Good point. I will rename the latter to prepare_tempfile_object() and
add a docstring.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
