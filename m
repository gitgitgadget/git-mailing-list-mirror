From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] status: show the branch name if possible in
 in-progress info
Date: Tue, 05 Feb 2013 08:28:42 -0800
Message-ID: <7vmwviu3lx.fsf@alter.siamese.dyndns.org>
References: <1359471493-32531-1-git-send-email-pclouds@gmail.com>
 <1359870807-22817-1-git-send-email-pclouds@gmail.com>
 <20130205063847.GA3240@elie.Belkin>
 <CACsJy8D_kSrJYagxo1LWt=P8XKj9F9_yAwH3vzQWQOi+yvP8kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:29:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2lOP-0008Pm-Sq
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab3BEQ2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 11:28:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab3BEQ2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 11:28:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5F77BAB1;
	Tue,  5 Feb 2013 11:28:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pjyVxFFKH5CW7fGNrksvsRgKehY=; b=rUJhkn
	p821gN7vnFt5Fh+tSR6tDr05U6AcnIK9P8a6AdxCg4ETMOji3XM2VN+rl4hRJcXB
	p5LUGgQeBaXKStUF3rCYmGR2g0cB9pPwesvO2H1ghCNFdmM+7MyFXOLCBPxwA2HD
	aBt3MCuGBz3n7Pfg2fK9snmgWa2/uf1XfVNJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XGy0NdBO5WjTZfnXN/oMANz86RExNxcJ
	my3IPd4skaVJ/YNWqODCM9ErZUxHJLezxsnpVUzm6d/s3rHkYCg9iY38LiwUhVMA
	OxTGS/ztvG46gqcyPHsRf24U3t3w93exTbNZw427X7zh+YJEykQh83ct4jcsnVGW
	M0K2cDwG6OU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAE95BAAF;
	Tue,  5 Feb 2013 11:28:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18253BAAE; Tue,  5 Feb 2013
 11:28:44 -0500 (EST)
In-Reply-To: <CACsJy8D_kSrJYagxo1LWt=P8XKj9F9_yAwH3vzQWQOi+yvP8kg@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 5 Feb 2013 19:20:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BD06504-6FB1-11E2-8765-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215518>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 5, 2013 at 1:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Missing description.  Stealing from the link you sent:
>>
>>         The typical use-case is starting a rebase, do something else, come back
>>         the day after, run "git status" or make a new commit and wonder what
>>         in the world's going on. Which branch is being rebased is probably the
>>         most useful tidbit to help, but the target may help too.
>>
>>         Ideally, I would have loved to see "rebasing master on origin/master",
>>         but the target ref name is not stored during rebase, so this patch
>>         writes "rebasing master on a78c8c98b" as a half-measure to remind
>>         future users of that potential improvement.
>>
>>         Signed-off-by: <...>
>
> Looking good. Junio, do you need a new patch mail or can you just
> amend the commit message?

I'd like to see you either

 - send a reroll, making it clear it is a reroll, or
 - tell me to amend.

instead of asking which one I would prefer ;-)  One less message I
have to respond to that way.

"commit --amend" done.
