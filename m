From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitk: Show patch for initial commit
Date: Mon, 03 Oct 2011 10:44:44 -0700
Message-ID: <7v7h4mgeb7.fsf@alter.siamese.dyndns.org>
References: <20111001190554.GA5854@kennedy.acc.umu.se>
 <4E878016.703@in.waw.pl> <20111003063359.GA11391@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew J??drzejewski-Szmek <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Mon Oct 03 19:44:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAmZQ-0002nG-GS
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 19:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053Ab1JCRos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 13:44:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190Ab1JCRor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 13:44:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D619E5B64;
	Mon,  3 Oct 2011 13:44:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7DOptwyCLTRplAQMTT40Y1blyZQ=; b=Y62bPt
	WkLydVVnxoAtM5aCRzyJC78xWkL3ddVN50/yiUTy4Qu2UABEzQNkR1gr/nkOORQ4
	IQB0SSBVLSpFEmKjm6yJ0HFrxmCF1VwhSNMXjDkwfwxTlgvtZeB6agZr7vUYJR05
	0zypDENmPYC3ydqPadMBGFmE4y6xKDVpsc/k4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhAaNFuw6upbL731LDQD+nS4b/EXqNKF
	PTSlBagH4L8UxWVwGH5vTAmPUkkJe3iNepafyWr+KelsRtphUZFWz5tqJc3Va2h+
	Dyc6IZXRsPSIn2NXa7ySy3e8NZUdZUwaA+wPYAs/zgDMYhYb9fFeqDUez1Fbaglx
	50k2gTev7vk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDDF45B63;
	Mon,  3 Oct 2011 13:44:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60D985B62; Mon,  3 Oct 2011
 13:44:46 -0400 (EDT)
In-Reply-To: <20111003063359.GA11391@kennedy.acc.umu.se> (Marcus Karlsson's
 message of "Mon, 3 Oct 2011 08:33:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6254FA00-EDE7-11E0-9072-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182679>

Marcus Karlsson <mk@acc.umu.se> writes:

>> Also the gitk should be mentioned in the man-page for git-config log.showroot.
>> The current description of this option seems suboptimal because it explains
>> how it used to be, which is not really relevant:
>>   log.showroot
>>     If true, the initial commit will be shown as a big creation event. This is
>>     equivalent to a diff against an empty tree. Tools like git-log(1) or git-
>>     whatchanged(1), which normally hide the root commit will now show it. True by
>>     default.
>> This could be changed to:
>>     If true (the default), the root commit will be shown as a big creation
>>     event --- a diff against an empty tree. This diff can be very large for
>>     a project which was imported into git after some development history.
>>     If log.showroot is false tools like git-log(1), git-whatchanged(1), or
>>     gitk(1) will not display the added files.
>
> I agree, but that feels like something that could be made into a
> separate patch. Or should I include that too?

Please make it a separate patch. A patch to Documentation/config.txt
should go to git.git project, but gitk patch (whose "diff --git" line
should read "diff --git a/gitk b/gitk") should go first to gitk.git
project and then merged to my tree.
