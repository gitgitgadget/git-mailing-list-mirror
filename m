From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Fri, 17 May 2013 10:09:58 -0700
Message-ID: <7vzjvtzg61.fsf@alter.siamese.dyndns.org>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<CABLWAfStOZvKZzsCqb+UiedA7Ra-ermyRJVAeocBE=RdXL8B2w@mail.gmail.com>
	<CAMP44s3zXLwHu0OhLKsoerHaoBGMf66hNJ=hvOiUVAe4+=hDiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sandor Bodo-Merle <sbodomerle@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:10:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOAS-0003o6-WB
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946Ab3EQRKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:10:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588Ab3EQRKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:10:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E3CC1F771;
	Fri, 17 May 2013 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ygb8c1YUYupYmLc2xW2a9YqeNbA=; b=LoitQd
	C94Mj4m7avJHsA9I1ndF/+nMxNtsqM+PXwQ2RCveDdzEG7tdZquHMmZ0bqxeuiyz
	t1oHaMd36nT2nATNL/ejj49O+DAPiTXAccymVwU5qEn3Y7eKeYZRbwWziG7jms/H
	NHaa3uMMw4Zf1DIuwgQ2b3pdd4N9MIVYLZXu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SrqhBZD0cdzPv7pXgHX7SqgzxkeJ2z9V
	NQlkV9aZiKFapejEQv4Z+haSNc6swqWruALx1iEEwM914QgHTeaOtC/pC1fHofdM
	RkRAkkqPwRUGadRXeUYyJ6kchEAx9eVTt/2fU39vGZmWAG40/vhDhbNXsU77O89a
	PkG/M6ZA+pc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EED71F76F;
	Fri, 17 May 2013 17:10:00 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88A271F76E;
	Fri, 17 May 2013 17:09:59 +0000 (UTC)
In-Reply-To: <CAMP44s3zXLwHu0OhLKsoerHaoBGMf66hNJ=hvOiUVAe4+=hDiA@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 17 May 2013 05:33:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B0697D2-BF14-11E2-A3D3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224708>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, May 17, 2013 at 5:02 AM, Sandor Bodo-Merle <sbodomerle@gmail.com> wrote:
>
>> apparently this breaks my existing clone of the bugzilla repository, where i
>> have branches cloned with versions of remote-bzr prior 1.8.2 and after. The
>> erro iget is:
>>
>> Fetching origin
>> Traceback (most recent call last):
>>   File "/home/bms/bin/git-remote-bzr", line 956, in <module>
>>     sys.exit(main(sys.argv))
>>   File "/home/bms/bin/git-remote-bzr", line 928, in main
>>     repo = get_repo(url, alias)
>>   File "/home/bms/bin/git-remote-bzr", line 844, in get_repo
>>     bdir.destroy_repository()
>>   File "/usr/lib/python2.7/dist-packages/bzrlib/bzrdir.py", line 900, in
>> destroy_repository
>>     raise errors.NoRepositoryPresent(self)
>> bzrlib.errors.NoRepositoryPresent: No repository present:
>> "file:///home/bms/workspace/bugzilla/.git/bzr/origin/clone/"
>> error: Could not fetch origin
>>
>>
>> The following small patch seems to fix my regression:
>
> The patch is fine by me, in fact, I already had that patch, but
> somehow could not trigger the exception, so I removed it.

Is it merely "fine", or needed for 1.8.3?  I am guessing it is the
latter but making a final double-check, as I'll be stopping to pick
up patches from the list in order to start today's integration run
(that includes tagging 1.8.3-rc3).

Thanks.
