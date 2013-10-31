From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 12:00:21 -0700
Message-ID: <xmqqob655kqi.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
	<CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:00:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbxTp-0000pC-3P
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab3JaTAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:00:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484Ab3JaTAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:00:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B054C929;
	Thu, 31 Oct 2013 15:00:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EQ8VXDfAaltojILNm6AOMBcWNaQ=; b=wcFtXK
	JaztfKXtykOlUhWAfqEmZMOm+rQutApfH1N/ca2LP9K3VQWPX9V4Ip1JLs9Y678/
	VZVBaxT1OkJFoEt0C0Xge1EH1MHzbO68+G4rwUyxTgyBvPbqhkkVSvn64S71GlPm
	/E5bY/9vvTxlK/L1BKQx9kOijLDIlYnuW38dU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cbXC9qBHA3dM3oNOlD4Erj4ZrQv555Lv
	KXwuNMvQhE9b10HW0NB9e6Kb0UP18CALidyXZYgKHOKmfXIEabEiOMWqgH453Yvm
	M6t096mxliWojYApUN14IWBm68CwKO4TKFp3WO7xhJn6vBDKcJPb2hcUf+X7Cv2X
	SWJjYMUtPpA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2EF74C928;
	Thu, 31 Oct 2013 15:00:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 543734C923;
	Thu, 31 Oct 2013 15:00:23 -0400 (EDT)
In-Reply-To: <CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 12:37:24 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B2182652-425E-11E3-BF24-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237158>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Oct 31, 2013 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> --- a/Documentation/git-pull.txt
>>> +++ b/Documentation/git-pull.txt
>>> @@ -39,7 +39,7 @@ Assume the following history exists and the current branch is
>>>  "`master`":
>>>
>>>  ------------
>>> -       A---B---C master on origin
>>> +       A---B---C origin/master
>>>        /
>>>      D---E---F---G master
>>>  ------------
>>
>> This change is wrong; the illustration depicts the distributed world
>> (i.e. a fetch has not happened yet).
>
> That is an irrelevant implementation detail, specially at this high
> level. In the user's mind origin/master means master on origin.

You are wrong.  In the user's mind, origin/master means the commit
that used to be at master on origin, and the point of this
illustration is to make them understand that they live in a
distributed world, where their last observation will go stale over
time.

>
> If you want to be pedantic, this is the "reality":
>
>   ------------
>       D---E---F---G master
>   ------------

You are wrong again.  The "reality" is more like this:

      origin/master in your repository
      |
      v
      A---B---C master at origin
     /
    D---E---F---G master in your repository

if you really want to write origin/master somewhere in this
illustration.
