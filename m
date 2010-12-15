From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 11/14] t3032-*.sh: Pass the -b (--binary) option to sed
 on cygwin
Date: Wed, 15 Dec 2010 09:22:31 +0100
Message-ID: <4D087AC7.2090705@viscovery.net>
References: <4D07B8B5.2030409@ramsay1.demon.co.uk> <7vtyigtaxn.fsf@alter.siamese.dyndns.org> <4D07FE91.2090003@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 09:22:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSmdI-0000c8-63
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 09:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab0LOIWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 03:22:38 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54874 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab0LOIWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 03:22:38 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PSmd6-0007mg-25; Wed, 15 Dec 2010 09:22:32 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C7D081660F;
	Wed, 15 Dec 2010 09:22:31 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4D07FE91.2090003@sunshineco.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163742>

Am 12/15/2010 0:32, schrieb Eric Sunshine:
> On 12/14/2010 2:24 PM, Junio C Hamano wrote:
>> Ramsay Jones<ramsay@ramsay1.demon.co.uk>  writes:
>>> The test using the conflict_hunks helper function (test 9) fails
>>> on cygwin, since sed (by default) throws away the CR from CRLF
>>> line endings. This behaviour is undesirable, since the validation
>>> code expects the CRLF line-ending to be present. In order to fix
>>> the problem we pass the -b (--binary) option to sed, using the
>>> SED_OPTIONS variable. We use the SED_STRIPS_CR prerequisite in the
>>> conditional initialisation of SED_OPTIONS.
>>>
>>> Signed-off-by: Ramsay Jones<ramsay@ramsay1.demon.co.uk>
>>> ---
>>>
>>> Note that this test does not fail on MinGW, but I don't
>>> really know why, given commit ca02ad3... ahem ;-)
>>
>> Ahem, indeed.  Why?
> 
> t3032 does indeed fail on MinGW, and was fixed in the msysgit port by [1],
> but was subsequently "lost" when msysgit was rebased onto junio/next [2]
> which did not have that test. Consequently, the fix never made it into the
> mainline git source.

Sorry, but on MinGW, I only need the GREP_OPTIONS part of that fix, but
not the SED_OPTIONS. It's also mysterious for me.

OTOH, the fix in ca02ad3 that applies to t6038, does not work for me as is
because my sed does not understand -b; it needs --nocr. Maybe it is the
sed version that makes the difference?

D:\Src\mingw-git\t>sed --version
GNU sed version 3.02
...

-- Hannes
