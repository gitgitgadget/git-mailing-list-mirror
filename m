From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 17/17] fetch_refs(): simplify logic
Date: Sat, 25 Aug 2012 08:37:15 +0200
Message-ID: <5038729B.3000501@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu> <1345709442-16046-18-git-send-email-mhagger@alum.mit.edu> <20120823090740.GF6963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:44:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A6e-0001UO-3H
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab2HYGoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:44:22 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:43600 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732Ab2HYGoU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:44:20 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Aug 2012 02:44:20 EDT
X-AuditID: 1207440d-b7f236d000000943-65-5038729e2d41
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.03.02371.E9278305; Sat, 25 Aug 2012 02:37:18 -0400 (EDT)
Received: from [192.168.69.140] (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6bFOZ011351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:37:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <20120823090740.GF6963@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqDuvyCLA4MIdDouuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BnLXl9iKtjAUrHx9CeWBsbj
	zF2MnBwSAiYSRzY/Z4ewxSQu3FvP1sXIxSEkcJlR4nHneRYI5wyTxLfN+9lAqngFtCUWzp0K
	1s0ioCqx48tBsG42AV2JRT3NTCC2qECIxJpvUxgh6gUlTs58wgJiiwjISnw/vBEszixgLbHi
	9WGwemEBc4lNZ+cyQSxbwygxce0MsCJOASuJOTtPAiU4gBrUJdbPE4LolZfY/nYO8wRGgVlI
	VsxCqJqFpGoBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJDQ5d3B+H+d
	zCFGAQ5GJR7eG2fMA4RYE8uKK3MPMUpyMCmJ8ooVWgQI8SXlp1RmJBZnxBeV5qQWH2KU4GBW
	EuH9zgCU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8N4BGSpYlJqe
	WpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPYeBmnnLS5IzAWKQrSeYtTl
	+Pz05F1GIZa8/LxUKXHe3SBFAiBFGaV5cCtgieoVozjQx8K860CqeIBJDm7SK6AlTEBLyl3N
	QZaUJCKkpBoYWx4s/bTlosOFhkDlHl/VL6H2xvULTT/r71rM7rLDaL1uycfjJxf5SJ8578OQ
	sOJRrNOEwrI8/t8mYVfWtu30fqZd6+oTo2i+Q95X88q1qinK3lOlz564+ct/YcSK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204248>

On 08/23/2012 11:07 AM, Jeff King wrote:
> On Thu, Aug 23, 2012 at 10:10:42AM +0200, mhagger@alum.mit.edu wrote:
> 
>> Subject: Re: [PATCH 17/17] fetch_refs(): simplify logic
>> [...]
>>  static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
> 
> The subject should be "filter_refs", no?

Yes, thanks.  Also thanks for the typo correction in [PATCH 16/17], and
in general for your review of the patch series.  Re-roll to follow shortly.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
