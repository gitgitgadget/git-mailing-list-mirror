From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] resolve_gitlink_packed_ref(): fix mismerge
Date: Mon, 17 Oct 2011 16:14:30 -0700
Message-ID: <7vipnnjjmx.fsf@alter.siamese.dyndns.org>
References: <4E9B1E32.7030101@gmail.com>
 <7vfwispi8u.fsf@alter.siamese.dyndns.org> <4E9B8719.1090203@gmail.com>
 <4E9BA39B.709@alum.mit.edu> <4E9BFE66.5070906@gmail.com>
 <4E9C2F3C.7080405@alum.mit.edu> <7v4nz7o7mg.fsf@alter.siamese.dyndns.org>
 <7vbotfmpbh.fsf_-_@alter.siamese.dyndns.org> <4E9CA853.10107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 01:14:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFwOG-0005qU-3b
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 01:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab1JQXOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 19:14:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453Ab1JQXOf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 19:14:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4996F509D;
	Mon, 17 Oct 2011 19:14:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uAKGZOKVPGjqM9XjAZ9uaKyCQ50=; b=oQcdBS
	f5ZjjTqj3nqFdeKxLryOWMV3ZVy83MAUkG3cTWlBXNNUYEkElmcnA9HqQnVAaZVz
	usrOrAd1+2Twbrl0jKXDhLpbgEKdcG0YyFdnfFs1hnZ90zDDlWxq+s4ikCZDBT6u
	l3ymnrOiCT03i80nIO4EcYpFYAjVtT7aTYlpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rmvTIcKp83Toi3u/kpUv9WyzGhS/LjBf
	wr8DMJaKi//oj6uMORRIDFBZ0aBKoVX1LZfRtRcV1ZT1kjNJvl3VjcMNeLFpZ7oI
	RlI5w9+1wazLdEp+GmqzAeoJMyc+Azdh3y4YsavLeLfHTVlkEDTUy48gExxtRm31
	GqK4n30zW2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40391509C;
	Mon, 17 Oct 2011 19:14:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7230509B; Mon, 17 Oct 2011
 19:14:31 -0400 (EDT)
In-Reply-To: <4E9CA853.10107@gmail.com> (Mark Levedahl's message of "Mon, 17
 Oct 2011 18:12:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C524EF30-F915-11E0-BCFF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183841>

Mark Levedahl <mlevedahl@gmail.com> writes:

> On 10/17/2011 02:43 PM, Junio C Hamano wrote:
>> 2c5c66b (Merge branch 'jp/get-ref-dir-unsorted', 2011-10-10) merged a
>> topic that forked from the mainline before a new helper function
>> get_packed_refs() refactored code to read packed-refs file. The merge made
>> the call to the helper function with an incorrect argument. The parameter
>> to the function has to be a path to the submodule.
>>
>> Fix the mismerge.
>>
>> Helped-by: Mark Levedahl<mlevedahl@gmail.com>
>> Helped-by: Michael Haggerty<mhagger@alum.mit.edu>
>> Signed-off-by: Junio C Hamano<gitster@pobox.com>
>> ---
>>
> Thank you, this fixes the problem for me.

Thanks for a quick bug report and helping with the test.
