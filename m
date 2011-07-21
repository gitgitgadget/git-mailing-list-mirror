From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Move git-dir for submodules
Date: Thu, 21 Jul 2011 16:47:41 -0700
Message-ID: <7vmxg7yz4y.fsf@alter.siamese.dyndns.org>
References: <1311267139-14658-1-git-send-email-iveqy@iveqy.com>
 <7vhb6f1ipp.fsf@alter.siamese.dyndns.org> <4E289CDA.20209@cisco.com>
 <4E289F42.4040708@cisco.com> <7vr55jyzlb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de, hvoigt@hvoigt.net
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 01:47:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk2yF-0005eH-0m
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 01:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab1GUXrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 19:47:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab1GUXro (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 19:47:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BECEA4976;
	Thu, 21 Jul 2011 19:47:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mkh56Rov1b5yEttKewrMu980gtY=; b=pyr3ju
	ljZPSS1StjWd88zlFTWfw+8pYJOyASoZ0TJWymo5mVUmvnCFHEv/7HYAEioZ2iiY
	fQYX/3n1uHVyBRU4P3CUbr2LziHkSrwwo1BTxR7/wtqBLUSsj+ZVr1WgUZLgHF10
	iL1e/SXs/z0c8sDyhvAzzJ8wX676tBWjs1oUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wxgX2MTSPtyEYzxN5dyjksB25kFwbfHk
	K72A2jrpLTh18PY+cKYyHZhq9EUw6EgpiQ/JY8jgfwF2m4mfi1aS1XA3eQ23bsKh
	Rermi7W8fgp38aiQbr7CwsISBEDDXn2kqk9GJBVzWcb84CtNGgvbb2O8BKRHUyIR
	bVHDlcdG3p4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6CD94975;
	Thu, 21 Jul 2011 19:47:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B2184974; Thu, 21 Jul 2011
 19:47:43 -0400 (EDT)
In-Reply-To: <7vr55jyzlb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Jul 2011 16:37:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3D070AC-B3F3-11E0-93F6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177632>

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <hordp@cisco.com> writes:
>
>> Now that you mention it, what happens if the submodule name changes in
>> the history?  What happens if the submodule URL (and possibly the entire
>> submodule contents) changes in the history?
>
> The original idea (dating back before "git submodule" was written, but
> only when "gitlink" was added to the index and the tree objects) was to
> identify the submodule by name and refer to the same logical entity with
> the same name, so that no matter where in the superproject's working tree
> hierarchy you change your mind to bind a particular submodule (say, "the
> Linux kernel upstream source") at (i.e. "path"), or from which mirror of
> the kernel repository you recommend your downstream to clone it from
> (i.e. "url" in .gitmodules).

Sorry for an incomplete sentence.  "No matter...." above should conclude
with "you know you are talking about the same module that retains the
identity of its .git metadata directory."
