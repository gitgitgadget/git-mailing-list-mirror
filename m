From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Wed, 06 Jan 2010 09:55:21 +0100
Message-ID: <4B444FF9.1000004@kdbg.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com> <1262122958-9378-10-git-send-email-gitster@pobox.com> <4B43AE38.9070800@kdbg.org> <7v4on0oxcs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:55:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSRfx-0008Te-Pr
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 09:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab0AFIz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 03:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010Ab0AFIz2
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 03:55:28 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:10124 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754824Ab0AFIz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 03:55:28 -0500
Received: from [77.117.162.206] (77.117.162.206.wireless.dyn.drei.com [77.117.162.206])
	by bsmtp.bon.at (Postfix) with ESMTP id 36C48CDF89;
	Wed,  6 Jan 2010 09:55:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v4on0oxcs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136252>

Junio C Hamano schrieb:
> Johannes Sixt <j6t@kdbg.org> writes:
>> When you simply call ll_merge(), will it obey any merge drivers that
>> are defined in .gitattributes? Do we care about them?
>>
>> I already had an implementation of "rerere forget" before you
>> presented this solution, but it relies on that the user calls
>> "checkout --conflict=merge" first. One reason (besides its simplicity)
>> was that it does not have to care how the merge is computed.
> 
> Doesn't "checkout --conflict=merge" use the same ll_merge() machinery?

It does, without setting up .gitattributes, either (IIUC), which is a bug IMO.

That said, I consider your solution superior because it works without 
depending on conflict markers in the file in the worktree. Nevertheless, 
we should think about whether merge drivers of .gitattributes should be 
obeyed. I think they should: For example, a specialized XML merge driver 
could leave conflicts that are different from those that merge-recursive 
generates.

-- Hannes
