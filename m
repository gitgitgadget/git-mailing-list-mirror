From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell: add missing initialization of argv0_path
Date: Thu, 05 May 2011 09:32:48 -0700
Message-ID: <7vmxj19kgf.fsf@alter.siamese.dyndns.org>
References: <62D8CA91-5C11-458E-AADB-D8EC8EB99F09@gmail.com>
 <4DC24A7F.20705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dima Sharov <git.avalakvista@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 05 18:33:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI1UB-0000SZ-Hf
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 18:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab1EEQdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 12:33:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411Ab1EEQdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 12:33:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF3675455;
	Thu,  5 May 2011 12:35:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EvlPaAzT8BrgAMm8zZGht8ORzyM=; b=S+WJYh
	nS/9HLydbAuqShhiWUWvozx/WjDcj4BHkFgGr8gLccXFbqqzGqOcxSbhGJEaBQs2
	U0f+sPR4d71H/5AcuD/JO4dqCe9nBn1DgP8lwn7b7PKEdNHJrXPo2JXVtWYJpb6g
	/1Kv1l6+ikY1Mc2dWRpKU6HImlF+NcjldEVUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=irolW/tPYnSEAbpzvz9H0iJdiTpomo5J
	YZS9FkCyCXyqKfJXk/X14zZV4oSqhO5zt/cycRsAMOwtYrXmXtKV9/Pckfqfbpt9
	QB3zVBGhh/Qe5BNtFZNix/Jky96nyLzTnVACuGLxc7IgJlhnDtuD6DcqUZBcL8Qa
	uxpWwyFmJQY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 923145454;
	Thu,  5 May 2011 12:34:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4EA065453; Thu,  5 May 2011
 12:34:54 -0400 (EDT)
In-Reply-To: <4DC24A7F.20705@viscovery.net> (Johannes Sixt's message of "Thu,
 05 May 2011 08:58:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E5F6824-7735-11E0-B533-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172845>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 5/5/2011 8:40, schrieb Dima Sharov:
>> According to c6dfb39 (remote-curl: add missing initialization of
>> argv0_path, 2009-10-13), stand-alone programs (non-builtins)
>> must call git_extract_argv0_path(argv[0]) in order to help builds
>> that derive the installation prefix at runtime. Without this call,
>> the program segfaults (or raises an assertion failure).
>
> Good catch! I checked PROGRAM_OBJS in Makefile, and shell.c was the only
> one remaining that did not call this function.

Thanks for an Ack; the patch was corrupt but was trivial to fix-up.
Will queue.
