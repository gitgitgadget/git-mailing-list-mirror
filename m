From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] cpu: add device_add foo-x86_64-cpu support
Date: Thu, 05 Feb 2015 11:29:07 -0800
Message-ID: <xmqqiofgkvi4.fsf@gitster.dls.corp.google.com>
References: <cover.1421214154.git.zhugh.fnst@cn.fujitsu.com>
	<20150205114914.GA10126@stefanha-thinkpad.redhat.com>
	<54D38B73.4060803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
	Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org,
	tangchen@cn.fujitsu.com, chen.fan.fnst@cn.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, imammedo@redhat.com,
	guz.fnst@cn.fujitsu.com, anshul.makkar@profitbricks.com,
	afaerber@suse.de, git@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJS71-0007Dw-NF
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbbBET3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:29:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751482AbbBET3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:29:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95D5235A92;
	Thu,  5 Feb 2015 14:29:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CHk/6Mry4WPr0L0sntu46k1o+4Q=; b=trNvqx
	aayrDj2w3ePf3i8kD6/0B2bmOlVEyYwqsRxiMmsnmOYFB/I4Xtqnp+k8qdfcYnJr
	WjuWk8WraXk1f6/qv8OPB+swmF2zZkUGmvJuPyUfiKrkHkX9thye+YpLSvA8zSMW
	snOS2mGhdYw6shCcaS9XTXpiZYsGA7WixUL04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k+MjXqJPT9IqqmHcIdV7Xv6iJHhqoju4
	tZ18m+7WeMCSX8ekniar61/BFhMRBoP+bxr9bm3oe8PAeAio7TqdIQClGhVbSbFS
	Q7sC7UapRXPXR9TtNim8XhLS4L2bGivFIWNQ6H8UeBSxBErnruogfH+RY8S4+REN
	4tDmOALypak=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8875635A91;
	Thu,  5 Feb 2015 14:29:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D90BD35A90;
	Thu,  5 Feb 2015 14:29:08 -0500 (EST)
In-Reply-To: <54D38B73.4060803@redhat.com> (Eric Blake's message of "Thu, 05
	Feb 2015 08:25:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 417D854C-AD6D-11E4-B407-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263391>

Eric Blake <eblake@redhat.com> writes:

> On 02/05/2015 04:49 AM, Stefan Hajnoczi wrote:
>> On Wed, Jan 14, 2015 at 03:27:23PM +0800, Zhu Guihua wrote:
>>> This series is based on the previous patchset from Chen Fan:
>>> https://lists.nongnu.org/archive/html/qemu-devel/2014-05/msg02360.html
>> 
>> This email has an invalid charset:
>> Content-Type: text/plain; charset="y"
>> 
>> I guess you entered "y" when asked how the message was encoded.
>> 
>> Please don't do that, it means we can only guess at the charset.
>
> In the past, people made a similar problem when 'git send-email' was
> asking if a message was in-reply-to something else (the number of
> messages incorrectly threaded to a message-id of 'y' or 'n' was evidence
> of the poor quality of the question).  git.git commit 51bbccfd1b4a
> corrected that problem.  Sounds like charset encoding is another case
> where the interactive parser should be taught to balk at nonsense
> encoding answers?

I think I answered this in $gmane/263354; care to come up with a
plausible valid_re?  It is inpractical to attempt to cover all valid
charset names, so whatever you do I'd imagine you would want to pass
the confirm_only parameter set to true.
