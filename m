From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/6] Access reference caches only through new function
 get_cached_refs().
Date: Tue, 23 Aug 2011 06:21:55 +0200
Message-ID: <4E532AE3.300@alum.mit.edu>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu> <1313188589-2330-3-git-send-email-mhagger@alum.mit.edu> <7vzkjblk22.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 06:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QviVH-0000uM-MY
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 06:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910Ab1HWEWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 00:22:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35099 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1HWEWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 00:22:14 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BECE41.dip.t-dialin.net [84.190.206.65])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7N4LtWZ015032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Aug 2011 06:21:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vzkjblk22.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179920>

On 08/15/2011 12:12 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> +	if (! submodule)
> 
> (style) lose the SP before "submodule".

Will be fixed in re-roll.

>> -	if (!refs->did_packed || submodule) {
>> +	if (!refs->did_packed) {
>> +		const char *packed_refs_file;
>> +		if (submodule)
>> +			packed_refs_file = git_path_submodule(submodule, "packed-refs");
>> +		else
>> +			packed_refs_file = git_path("packed-refs");
>>  		FILE *f = fopen(packed_refs_file, "r");
> 
> decl-after-statement.

Will be fixed.

On 08/15/2011 12:21 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> +struct cached_refs *create_cached_refs()
>
> struct cached_refs *create_cached_refs(void)

Will be fixed.

Thanks for your feedback.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
