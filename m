From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 09:53:43 -0700
Message-ID: <7vbo6vbgbs.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-7-git-send-email-gitster@pobox.com>
	<CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
	<7vhagndis4.fsf@alter.siamese.dyndns.org>
	<CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
	<7vy59zbjns.fsf@alter.siamese.dyndns.org>
	<CALkWK0=a40hACGYApN7odrTytDmoRG_00_Q=EuaHuQ_=h8LBkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:53:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrA1X-0002l3-1f
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190Ab3FXQxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:53:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab3FXQxq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:53:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938432A6DB;
	Mon, 24 Jun 2013 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hdrRxGQ5sdBeGlC84bweijkEmio=; b=JoVghA
	1CR3o3KVD46EGsOYEaRY2Xq+HcZwoPH/HPBtslIrhBlg+DuxwtV9LF3okvHO2KQT
	W0XqQw63ieYg8so7VyAP6lY4znW9WBZFv5UP+JisiniEHK9Lq41g2Cx5JMzKsVqG
	KUo2MXVQrv9E2+NRLlPwMgi1AOFJ9THq4bFNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R70Ve6U8vOl4EbxSr/xSSb47ZkoOzRWQ
	mO8vCAHUS7iYK6zBiOYCEtnSzpA1gFM2aoJgu9KDfIy3ST+V3Tat1hvz5mooud2Z
	NASggwKFdkYa26Vtp4QU5F7tG5XNdSSKEu2pcThRS8rVu7CtwYoVVitPcTg0msZj
	Y+r1lPsotxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 882262A6DA;
	Mon, 24 Jun 2013 16:53:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4E492A6D9;
	Mon, 24 Jun 2013 16:53:44 +0000 (UTC)
In-Reply-To: <CALkWK0=a40hACGYApN7odrTytDmoRG_00_Q=EuaHuQ_=h8LBkg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 24 Jun 2013 21:39:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1CDA2C0-DCEE-11E2-A7A5-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228870>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> If the user said "git push" without an explicit request to push to
>> "ram", and if branch.master.pushremote was not set to "ram", and
>> still the command "git push" pushed the branch to "ram", then I
>> would understand what you are worried about, but otherwise I do not
>> see how what you are saying makes sense.
>
> We currently have no system to differentiate between those two cases.

I am not sure what two cases you are talking about?

If you do not set anywhere (like branch.master.pushremote or
remote.pushdefault) to push to "ram", and if you did not say "git
push ram" but just said "git push", we will not push to "ram"
(otherwise it is broken).  So if the push is going to "ram", the
user must have asked us to push there, either via the command line,
or these explicit configuration variables.  And why do you need to
differenciate between the command line "ram" and configured "ram"?
After all, isn't the configuration merely a typesaver?  If you know
often push to "ram", you configure to push there.  If you don't, you
don't.

>> Or are you saying that with push.default set to upstream, only these
>> two forms should be allowed?
>>
>>     $ git push ;# no destination, no refspec
>>     $ git push there ref:spec ;# both explicitly specified
>
> No, no.  What I meant is:
>
>   From the documentation of push.default, I _expect_ upstream to kick
>   in only in the first case.  In the second case, I _know_ that my
>   push.default is inconsequential.

The push.default is meant to be in effect only when there is no
other stronger clue from the user for what to update (e.g. command
line refspec, remote.*.push).  Because branch.*.push weatherbaloon
patch did not have any documentation update, it did not say it is a
yet another way to explicitly configure the push destination branch.
Perhaps that led to your expectation for upstream to kick in.

Of course, that requires, as you earlier pointed out, that the logic
to read from branch.*.push need to be moved out of the push.default
logic (in the weatherbaloon patch) and hosted to do_push() where it
checks if there is remote->pushrefspec[].  If branch.*.push wants to
defeat remote.*.push, then it should be checked before deciding to
use that configured remote.*.push.

> I want properly defined precedence and well-defined overall behavior.

Of course.  There is no sneakiness.

As I already said, I personally do not know what branch.*.push buys
us, and will happy to drop 6/6.  It is merely a weatherbaloon patch.
