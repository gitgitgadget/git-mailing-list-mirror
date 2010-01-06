From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 05 Jan 2010 17:04:47 -0800
Message-ID: <7vbph8oxg0.fsf@alter.siamese.dyndns.org>
References: <4B3F6742.6060402@web.de>
 <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
 <4B421F90.4090402@web.de>
 <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
 <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
 <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
 <4B439A86.3020500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:05:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKKq-0006I5-9q
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab0AFBFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180Ab0AFBFK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:05:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab0AFBFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:05:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED406AD49E;
	Tue,  5 Jan 2010 20:05:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8MBCiO5FGaxwDNQ4z0/isSBV9F0=; b=V7WKomB68SbjhTTw9k5vV1L
	KtYZWB3G7w0qQx0oeZeFtznNGXcqV6cJtNpHBnNpjdL9R55oibqHFu17PX0nm6G8
	1Mb1tH3jJf15a53EIiLbWhd3+beYbe+dJ5lryjHERxEiZjl3hAVKo6CTu5TCAfYN
	YWinDfVJVpmKCuNQUoxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GtwDmWl+vY3+Na96H+CEAa2COjMvzhBG+yJa1qfAcQMlJnU6N
	KukyQsUNNjxxONnRPKy98LdHBoqZ8t9v9Gx/12RHy9GJo9rVzTuyF5cn8ypwogZx
	h5DD7VsXk7t2E/yhCktMKjveZRa/UrxJ78jHGAbAooAn55U2vj4Aewl9Os=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69FDDAD49D;
	Tue,  5 Jan 2010 20:05:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 56C95AD49C; Tue,  5 Jan 2010
 20:04:49 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 838F07E2-FA5F-11DE-B62C-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136228>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 05.01.2010 19:31, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>   b) new unignored files
>>>      IMO these files should show up too (the superproject doesn't show
>>>      ignored files, the submodule state shouldn't do that either). But
>>>      OTOH i don't see a possibility for loss of data when this state is
>>>      not shown.
>> 
>> I don't know if we are talking about the same scenario.  What I had in
>> mind was:
>> 
>>     cd sub
>>     edit new-file
>>     tests ok and be happy
>>     git commit
>>     cd ..
>>     git status
>>     git commit
>> 
>> forgetting that only you have sub/new-file in the world.  It is not loss
>> of data, but still bad.  Forgetting to add a new-file and committing in a
>> project without submodule doesn't lose data, but the resulting commit will
>> be seen as broken by other people.
>
> I'm not quite sure, i was rather thinking about something like this:
>
>     cd sub
>     edit new-file
>     cd ..
>     <use sub/new-file here, test ok and be happy>
>     git status
>     git commit
>     git push
>
> git status won't show you that sub has any new files and so you won't be
> reminded that you still have to add, commit and push it in the submodule
> before you should even commit, let alone push in the superproject.
>
> It is a possible breakage for other people if sub/new-file stays unnoticed.
> That's IMO a good point for showing these files too.

Yeah, your "i don't see a possibility for lost of data when this state is
not shown" confused me into thinking as if you were saying it is not _too_
bad if we didn't show the information.

After all we _were_ in agreement.  We both think the user should be told
about untracked files in submodule directory when inspecting the status to
make a commit in the superproject.
