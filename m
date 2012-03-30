From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-commit.txt: clarify -t requires editing message
Date: Thu, 29 Mar 2012 20:52:51 -0700
Message-ID: <7vr4waoics.fsf@alter.siamese.dyndns.org>
References: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com>
 <1333062296-27823-1-git-send-email-haircut@gmail.com>
 <7vboneq1vs.fsf@alter.siamese.dyndns.org> <4F75236C.4050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ivan Heffner <iheffner@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 05:53:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDStX-000499-5e
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 05:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760455Ab2C3Dwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 23:52:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759808Ab2C3Dwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 23:52:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 340FA6344;
	Thu, 29 Mar 2012 23:52:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vXTeoAnYJahBLHHOpxVT2W3a/ms=; b=mah+Uu
	y1g87hj6cwn598UdX/hki23Kz0eWoRsiUrQ5f2c3TW5hmM6Y0C0PZ7SIgiZX/Fyt
	L7WQKRj4ISWbsi4H7yusHlKx7bzLSSlohWcqBNDxzlkDo042OeysSJxw+QN2fVnX
	40xvFwTuxcmqawU6TbusO38ZMaKh3kVUIMPU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KEyFM1C6agoaDM0d7ouIzWsMeDhGqPgU
	BRcF5CjiPRvmEAvyUFFVGXf7lzZTKPIW5UOzPArhYdXw982L/jzxfketu7//mYjz
	OjNdaty6L0GLylvj1bkljl7WQyU17vot/76Al7JR6Y3x5DHZ/J6WhJvcsVjxCQ1Y
	VaZCVgjt2SI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 295356343;
	Thu, 29 Mar 2012 23:52:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 827AE6342; Thu, 29 Mar 2012
 23:52:52 -0400 (EDT)
In-Reply-To: <4F75236C.4050703@gmail.com> (Adam Monsen's message of "Thu, 29
 Mar 2012 20:07:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D34B3CA4-7A1B-11E1-BF4A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194321>

Adam Monsen <haircut@gmail.com> writes:

> ~~~
> Use the contents of the given file as the initial version of the
> commit message. Think of this initial version as a mandatory
> fillable form. The editor is invoked so you can fill in the form. If
> you do not fill in the form (if you make no changes), the message is
> considered empty and the commit is aborted. If a message is
> specified using the `-m` or `-F` options, this option has no effect.
> This overrides the `commit.template` configuration variable.
> ~~~
>
> Thoughts?

You still say "the message is considered empty and" but I think it
probably reads better without it.  Strictly speaking, it is not a
"mandatory fillable form", but whatever text you put in the template is
advisory to the users.  For example, if your project wants its contributor
to always refer to a bug id in its issue tracker, it may want to give a
customized "template", instead of the plain "template" we give to the
users that begins with:

	~~~~~~~~

        # Please enter the commit message for your changes. Lines starting
        # with '#' will be ignored, and an empty message aborts the commit.
	~~~~~~~~

to guide them what to write in the log and how to explain your change,
e.g. something like:

	~~~~~~~~
	<<one line summary your change here>>

	# explain the problem your change tries to solve in the first
        # paragraph

	# describe the approach your solution takes to solve it in the
        # second and subsequent paragraphs

	# Please write issue tracker ID at the end, if available
	Frotz-Bug-Id: XXXXXX

        # Always sign-off your commit
        Signed-off-by: XXXXXX
	~~~~~~~~
