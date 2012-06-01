From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Fri, 01 Jun 2012 09:57:17 -0700
Message-ID: <7vy5o72cnm.fsf@alter.siamese.dyndns.org>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <vpq8vg7jue4.fsf@bauges.imag.fr>
 <20120601132710.Horde.j1U5UHwdC4BPyKcOgc8zbbA@webmail.minatec.grenoble-inp.fr> <CABURp0rm2JKBmrm62uAVj1WSc3BE_LoKoHbjmxvkQhPNgnozpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 18:57:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaVAD-0007lq-DO
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 18:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965553Ab2FAQ5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 12:57:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965516Ab2FAQ5U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 12:57:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AD5688EE;
	Fri,  1 Jun 2012 12:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x47wu8TN3VTBUN/UalFtP7U0WRI=; b=Lny2b0
	+YKeGy8I2vAjtLgS/DWq/7izsNdpdBdMxLNu68fL+q+HTGqLz3MEfE9mktq/HCdr
	NmNletwGUcvtkVmgqF2YFo6qg0cJt9PNQFvFcQk7awQNZDEPMdsTALBzsN+bjhMj
	uNxCAhTzX3HMvrhgXEidPCeiDMhB1tB5DbLmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uklV0fVXLtuv2s+u9kwBXKwpiHGj7uRB
	caZxEQ/kUhfFEy8Y+63RaljzO69msZTaZapIUx21pW5VS9oUue0CvvOqF49Sp+oC
	U8No2dINYJ0OyBKwERyOrYICL7OYMVorMqAGVTQ/sOE8p6ENIotp58WkV2fAolno
	SEeTDwICBs0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F406B88ED;
	Fri,  1 Jun 2012 12:57:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4333688EC; Fri,  1 Jun 2012
 12:57:19 -0400 (EDT)
In-Reply-To: <CABURp0rm2JKBmrm62uAVj1WSc3BE_LoKoHbjmxvkQhPNgnozpA@mail.gmail.com> (Phil
 Hord's message of "Fri, 1 Jun 2012 08:40:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D94D3730-AC0A-11E1-AE1A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199003>

Phil Hord <phil.hord@gmail.com> writes:

>   $ git status --sequencer
>   You have unmerged paths.
>   You are in an am session.
>   You are in the middle of an interactive rebase.
>
>   $ git status --porcelain --sequencer
>   airu
>
> The "--porcelain --sequencer" combination I am imagining here would
> show the status as a script-parseable sequence of single-letter
> indicators telling the status of these same various conditions:
>   u - unmerged paths
>   a - git-am session
>   i - interactive rebase
>   r - rebase
>   c - cherry-pick
>   m - merge
> etc.

Some people seem to think that machine-readable has to mean
unreadable cryptic line noises.  It's a disease.

If you have to write "etc.", you clearly do not know what the
range of possible values of these things will eventually be.

And I do not think it is your fault not to know what we would want
to add in the future.  But it is your fault to choose unreadable
cryptic line noises as an output format.

Just spell them out, and do not mark them for translation.
