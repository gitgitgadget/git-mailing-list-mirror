From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout/branch needs some extra safety around the --track
 option
Date: Tue, 15 Feb 2011 12:04:32 -0800
Message-ID: <7vfwrpnjxr.fsf@alter.siamese.dyndns.org>
References: <201102151852.03881.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 21:04:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpR8k-0002Jq-2v
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 21:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab1BOUEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 15:04:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab1BOUEo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 15:04:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51DC638CA;
	Tue, 15 Feb 2011 15:05:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LF8fjm4UzswQAVa0/8pH6h0VphM=; b=eEfhjB
	EiA0FMh+EASeKXXuk0VNA8tfH3UzJyT3TX2MuKHEGtbpTG5fCydIEOmdYj+6NXNe
	nWmr1gIyLhQz9sDjAA0uWl+J1mej0GF1vvIt2MauByAwF1Ekd95u6xzqihCo3Is5
	JDBBJMq7R7T0j7FFic6N1ENnE3OSr8yDCXNL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LsKihOkOBSi2U+KZDa9JdjgA2LYx7E+B
	mh+IOcEdREWZRWh3dcdCaMb5cyWm0WilJJvQaKNI4mf4DET4h6+OrW2q/GAW51d8
	KU3XeowYP3DG4xFUnG/YJ33kILy39SEIGESXJw2EFGoFaHLgYV1KPLCZcQFAIQwU
	bSJMkMd31ko=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3090F38C9;
	Tue, 15 Feb 2011 15:05:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5C68538C5; Tue, 15 Feb 2011
 15:05:45 -0500 (EST)
In-Reply-To: <201102151852.03881.johan@herland.net> (Johan Herland's message
 of "Tue\, 15 Feb 2011 18\:52\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAEB4EC6-393E-11E0-A1C7-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166872>

Johan Herland <johan@herland.net> writes:

> 1. When given "--track", branch/checkout should verify that the tracked 
> branch is indeed a branch (preferably a remote branch, although I guess 
> tracking a local branch can make sense in some situations). At least, 
> it should deny tracking a _tag_. Tracking a tag simply does not make 
> sense at all (unless you expect the tag to move, in which case it 
> should be a branch and not a tag).

Sensible, I think.
