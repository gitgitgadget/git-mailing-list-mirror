From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Tue, 12 Nov 2013 09:08:02 -0800
Message-ID: <xmqqtxfhim4t.fsf@gitster.dls.corp.google.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
	<CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
	<5281DB46.2010004@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 18:08:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgHRm-0001bm-KP
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 18:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab3KLRIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 12:08:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776Ab3KLRII (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 12:08:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11E63503F2;
	Tue, 12 Nov 2013 12:08:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xp5squoWqiTwJn22nSuztGAfxaA=; b=xNMdN0
	ripNDW/Re/bDxV3bYDR0yVmGfjr9ufghKSZz6vYC2xjSu2qWJW51LiTM7EDiUHVu
	HwoFkpUfHhNSGydwrizNDRvTPM0J4rON0pd57U2OsjTOV3/3D5m+BLrl8U+NXvoB
	LmV11Tsfm/WylC8fG5YMVVgF6jD0LlwC2yYtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=geu0QE7qCYAJMLEqPcwAPhj/8C6Suw18
	UHnekTK13+0y0RyyQgektatq9shcD4AVp0iXOf8sNBTp26GnUQ1ibYqgkx7CwuAI
	gVjolQLUiv9vk9X5pJpj/5rnEClNUi341Yb6SRAtxBZnJcT3wXVHtYngP0IfPOxg
	heQYmdxQxMw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0032E503F1;
	Tue, 12 Nov 2013 12:08:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58822503EE;
	Tue, 12 Nov 2013 12:08:05 -0500 (EST)
In-Reply-To: <5281DB46.2010004@bbn.com> (Richard Hansen's message of "Tue, 12
	Nov 2013 02:39:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FEE69114-4BBC-11E3-A25B-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237719>

Richard Hansen <rhansen@bbn.com> writes:

>>> I thought that the discussion agreed this option should not be
>>> called --refspec but something like --refmap?
>> 
>> I don't know what you agreed to,
>
> http://article.gmane.org/gmane.comp.version-control.git/237473

Yup, that was what I had in mind.

>> but I didn't agree to anything.
>
> Based on your silence I too thought that you had agreed.

Careful.  Silence does not mean agreement, at least around here.  It
may be just the person was busy and hasn't got around to it, was not
paying attention and missed the discussion, or was not as interested
in the topic as his/her other activities.

That, especially the last possibility among the three example
reasons above, was why I said "the discussion agreed", not "you
agreed".

>> What you pass to this option is a refspec, so it makes sense to name
>> the option --refspec.
>
> As discussed in that thread, it's not really the same thing as a refspec
> used in push or fetch.  In those commands, the refspec specifies two
> separable things:  what to transfer, and how to translate refs names
> between the remote and local repositories.  IIUC, the fast-export
> --refspec argument only specifies how to translate ref names, not what
> gets transferred.
>
> If my understanding is correct, then I agree with Junio and Peff that
> --refmap is a better name.

I know from one of the tests that the option Felipe added is
implemented in such a way that allows:

    git fast-export --option refs/heads/master:refs/heads/next master

to rename the destination, but I didn't check, when I wrote the
message to envision how a similar mechanism could be used to enhance
push/fetch in the future, if it can be actually used as a mapping

    git fast-export --option refs/heads/*:refs/remotes/mine/* master

Being able to do so was the only reason why I agree with the patch
in question (not my toy patch, but [6/10] that started this thread)
that it is a good idea in the longer term, as the other approach I
suggested to teach revision command line parser to optionally take
refspecs as if they specify LHS of the colon as object name with
rev_cmdline annotations would not work well for such a purpose.

Thanks.
