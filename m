From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/7] Tying loose ends on grep-pcre
Date: Thu, 11 Oct 2012 09:08:35 +0200
Message-ID: <50767073.50800@alum.mit.edu>
References: <1349855714-17008-1-git-send-email-gitster@pobox.com> <5075919F.5030306@alum.mit.edu> <7vlifeclrh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 09:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMCsy-0000oJ-RZ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 09:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab2JKHIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 03:08:38 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:62690 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755095Ab2JKHIh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 03:08:37 -0400
X-AuditID: 1207440c-b7f616d00000270b-ad-507670743abe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.19.09995.47076705; Thu, 11 Oct 2012 03:08:36 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9B78Z6e007225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Oct 2012 03:08:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7vlifeclrh.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqFtSUBZg8GafhUXXlW4mi4beK8wO
	TB4XLyl7fN4kF8AUxW2TlFhSFpyZnqdvl8Cdse7oJeaCf5wVX09PY25gnMTRxcjBISFgIvH+
	eEwXIyeQKSZx4d56ti5GLg4hgcuMEs+enmWGcI4zSXTtPcgMUsUroCkx4dMNdhCbRUBVYsKm
	dywgNpuArsSinmYmEFtUIEzi3a+jrBD1ghInZz4BqxERUJOY2HaIBWQxs4C4RP8/sLCwgKXE
	mhnvWCF2dTNK9DZ0gfVyCphJ3Lv3kA3EZhbQkXjX94AZwpaX2P52DvMERoFZSFbMQlI2C0nZ
	AkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxghYcqzg/HbOplDjAIcjEo8
	vAu2lwYIsSaWFVfmHmKU5GBSEuWdlFcWIMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd3YSUI43
	JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMHLDIxHIcGi1PTUirTMnBKE
	NBMHJ8hwLimR4tS8lNSixNKSjHhQpMYXA2MVJMUDtPdTPsje4oLEXKAoROspRl2Oj43zHjIK
	seTl56VKifNeBykSACnKKM2DWwFLSq8YxYE+FuY9DVLFA0xocJNeAS1hAloiM6kEZElJIkJK
	qoHRLW3i+fIJsyIDBY2/8vj1rWh4ttJE08vBXJwhxPLqNdbDxvdTI+999sq+dDmG/fhN++tz
	DBs2P7153d1vx82vic+4JC5smS5h2ePHqSm3gC+kdbrCpgePW+ZJeUocqNHxmr6D 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207467>

On 10/10/2012 06:52 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>> The last one teaches "git log" family to honor the "grep.*"
>>> configuration variables, e.g. "grep.patterntype", so that you can
>>> say "git -c grep.patterntype=perl log --grep='(?:pcre)'".
>>
>> Maybe this has been discussed already, but it seems to me that adding a
>> persistent setting that affects how "git log --grep" interprets the
>> pattern argument could break some scripts that assume that the "old"
>> interpretation is always used.  Shouldn't this at least be documented as
>> a backwards incompatibility?
> 
> If somebody scripts around "log" with hardcoded query "--grep=..."
> strings, they can force a particular variant from such a command
> line at the same time.  But as always, responsibility of doing so is
> on the person who writes such a script; "log" being a Porcelain, we
> value ease-of-use in interactive case more than cast-in-stone
> interface stability like we do for plumbing commands.
> 
> And that is exactly why the series avoids changing the behaviour for
> the "rev-list" plumbing.

OK, you've convinced me.  Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
