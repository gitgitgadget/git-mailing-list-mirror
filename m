From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Tests for some submodule corner cases.
Date: Tue, 31 May 2011 23:26:39 +0200
Message-ID: <4DE55D0F.1020905@web.de>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de> <4DE55857.3090706@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue May 31 23:27:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRWTa-0004HT-NY
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 23:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621Ab1EaV1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 17:27:42 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:60827 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932529Ab1EaV1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 17:27:41 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id 846641A0CE334;
	Tue, 31 May 2011 23:26:39 +0200 (CEST)
Received: from [93.240.123.160] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QRWSV-0002Yh-00; Tue, 31 May 2011 23:26:39 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DE55857.3090706@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+XZ8PxRXF2/E9yoXzbjGZ4KjZmMFYmbBQgTx1t
	i3tmger1D2+xTR0ZtFQNtQpfB/tbVg6oXWuWdoK30PkvybrPQm
	S4IQ86mVEVBJGpmgywSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174830>

Am 31.05.2011 23:06, schrieb Marc Branchaud:
> On 11-05-31 03:30 PM, Jens Lehmann wrote:
>> Am 30.05.2011 23:51, schrieb Marc Branchaud:
>>> Patch 2 exposes an anomaly in "submodule status", which reports that a
>>> submodule is OK even though it has deleted files.  "git status" inside
>>> the submodule (and in the super-repo) both identify any deleted files, but
>>> "submodule status" doesn't prefix the submodule's HEAD SHA-ID with a "+".
>>
>> That is documented behavior. "git submodule status" only cares about the
>> commit recorded in the superproject vs the HEAD in the submodule, work
>> tree modifications are never shown by it.
>>
>> But try a "git status" in the superproject, that will give you the following
>> output:
>> #	modified:   init (modified content)
> 
> I understand.  My apologies for not reading the man page closely enough.

No problem, maybe that's just an indication that a reference to "git status"
being more capable of telling what is going on inside a submodule is missing
to the man page for "git submodule status".

> I know there's been a lot of recent work on making "git status"
> submodule-friendly, but would there be any interest in having another prefix
> for submodule status to cover this case?  Maybe ! could indicate that the
> submodule's HEAD is correct, but the working directory doesn't match it exactly.

I'd rather leave "git submodule status" as it is and incorporate this kind
of functionality into core git (for "submodule status" it already arrived there
in 1.7.0/1.7.1, so that part is finished ;-). I hope making the "git submodule"
script mostly obsolete in the long run and would want to avoid teaching it new
stuff already covered by core git.
