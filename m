From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a separate gitdirs.
Date: Mon, 10 Mar 2014 08:31:41 -0700
Message-ID: <xmqq61nmrrxe.fsf@gitster.dls.corp.google.com>
References: <1394178834.7891.38.camel@Naugrim>
	<BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
	<1394231714.7891.39.camel@Naugrim>
	<xmqqvbvpshqn.fsf@gitster.dls.corp.google.com>
	<1394239852.7891.40.camel@Naugrim>
	<B2A4F350-1F20-4ABA-80A6-CF244DD7FAFD@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Henri GEIST <geist.henri@laposte.net>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:31:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN2BC-0007c4-PS
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 16:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbaCJPbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 11:31:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753452AbaCJPbp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 11:31:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 775DC73B6A;
	Mon, 10 Mar 2014 11:31:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ys3nhI4IlYYy0MStctY0MoyV740=; b=CQkzuR
	yw2NUDknFgZyVlAbUnh2NoFYwuQjl3PhtQSYoafDfJlNqcGiv5YndG+C8eUATTCk
	4UZtJaJ3QZgtN0omwMeGZ6OBx1c86SAAFDXOM/KDhy6n9MqrFchG1xNbhA8cE7FS
	1TUt59OmqnAb0jM++XjCr/3xsE0spmC5RDxr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7TZO2DtCOq2oDg3CrOIro5aXT61zCoF
	ua9MDpdVyU78xVUotGA00IoLwDAfy8IooIz3hxNXWPuiK5ooS/NHrnSWC8isQZ8v
	vhIO17BDWknwUx+O3eR4Xv065OLtlArMqxj9EzqlF6kSkoM2ts4dID94pWu9/0+o
	Dy0zByEnCvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 628EA73B69;
	Mon, 10 Mar 2014 11:31:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B01073B61;
	Mon, 10 Mar 2014 11:31:43 -0400 (EDT)
In-Reply-To: <B2A4F350-1F20-4ABA-80A6-CF244DD7FAFD@kellerfarm.com> (Andrew
	Keller's message of "Sun, 9 Mar 2014 19:24:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 154F7E3A-A869-11E3-A29B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243767>

Andrew Keller <andrew@kellerfarm.com> writes:

> On Mar 7, 2014, at 7:50 PM, Henri GEIST wrote:
> ...
>> To give one of my project to someone else I have copied it on a USB key.
>> By a simple drag and drop with the mouse.
>> And I am quite sure I am not alone doing this way.
>> 
>> I have done those kind of things lot of time without any problem.
>> But that day 'the_project' happened to be a submodule cloned by
>> 'git submodule update' then on the USB key the $GIT_DIR of 'the_project'
>> was missing.
>> 
>> If 'man git-submodule' have made me aware of the particularities of submodules
>> clone I had write in a terminal:
>> 
>> git clone the_project /media/usb/the_project
>> 
>> Or at least I had understand what happened quicker.
>> 
>> I have nothing against also adding something in repository-layout but I am
>> pretty sure normal users never read repository-layout as it is not a command
>> they use. And it is not mentioned in most tutorials.
>
> How about something like this:
>
> "The git directory of a submodule lives inside the git directory of the parent repository instead of within the working directory."
>
> I'm not sure where to put it, though.

This is not limited to submodules.  There are multiple lower-level
mechanisms for a $path/.git to borrow the repository data from
elsewhere outside of $path and a cloned submodule uses only one of
them.  For any such $path, "cp -R $path $otherplace" will result in
an "$otherplace" that does not work as a Git repository in exactly
the same way, whether it happens to be a submodule checkout or not.

That is why I suggested to enhance description on a more general
part of the documentation that covers what a Git repository is.
