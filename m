From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Makefile: abort on shells that do not support ${parameter%word}
 expansion
Date: Tue, 06 Sep 2011 15:09:55 -0500
Message-ID: <urATHUDMxTPsK81dgL16m7pg7qY-SQUV-kFZY47c-P0m2twVUC6nD2h-wYpNL6rcveoTNZdxojcfp9X0SeQjMuV97FzxI40RxrDw6pGEAFg@cipher.nrlssc.navy.mil>
References: <7vbouzxy7g.fsf@alter.siamese.dyndns.org> <RSBDfxxpq50B8raodg0TA26S3QuHAy1YIJsAy6F4U0luolR_nfBc83hs9i2B3xAWjXI-EHymM00@cipher.nrlssc.navy.mil> <7v62l58mp2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com, David Barr <davidbarr@google.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 22:10:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R11yK-0004bF-KG
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 22:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab1IFUKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 16:10:10 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:50245 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753463Ab1IFUKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 16:10:09 -0400
Received: by mail3.nrlssc.navy.mil id p86K9vIa011863; Tue, 6 Sep 2011 15:09:57 -0500
In-Reply-To: <7v62l58mp2.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Sep 2011 20:09:56.0185 (UTC) FILETIME=[F2597C90:01CC6CD0]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180829>

On 09/06/2011 03:01 PM, Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Add an entry to the please_set_SHELL_PATH_to_a_more_modern_shell target
>> which tests whether the shell supports ${parameter%word} expansion.  I
>> assume this one test is enough to indicate whether the shell supports the
>> entire family of prefix and suffix removal syntax:
>>
>>    ${parameter%word}
>>    ${parameter%%word}
>>    ${parameter#word}
>>    ${parameter##word}
>>
>> FreeBSD, for one, has a /bin/sh that, apparently, supports $() notation but
>> not the above prefix/suffix removal notation.
> 
> My reading of the later part of the thread you are basing the above is
> somewhat different from your diagnosis. The funny seems to happen only
> when there is a backslash-quoted glob special inside double-quotes
> (e.g. "${parameter%\?*}") and the same shell does not seem to be choking
> on many prefix/suffix expansion used in other test scripts.

Ah, I didn't read through closely enough to notice that the above
syntax was not also an issue, as was mentioned in the original email.

Sorry for the noise.

-Brandon
