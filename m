From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sha-1 check in rev-list --verify-objects redundant?
Date: Sun, 26 Feb 2012 01:11:52 -0800
Message-ID: <7v8vjqez6v.fsf@alter.siamese.dyndns.org>
References: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com>
 <7vk43af14m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 10:12:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1a9i-0004RR-TS
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 10:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab2BZJL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 04:11:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab2BZJLy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 04:11:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C992499F;
	Sun, 26 Feb 2012 04:11:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=35Y0N+pkflzlRP3FeQIfCiYN0ow=; b=VRzcb9
	zONAXQUiuNQPe41yGzXHsSyyYM+woVsCd/Xxz7tZKsyyzQbyCV6zaoLdc8Mce3F0
	z7/ACdgJIUi09xX0L0JxPjQJqZYq6CVf20ckjzx/Mk8CDnwCKuLAf8hdnNMr5D4I
	eEt7I24EAv+TgDeDdWfokEioT5trb05dvyugM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xVlhC5xCOaUK8xMp9gvh37x2wyC8ChwL
	TOgQbe5U24W7JO0C5xjOT4HplPjXo35aVkbkgLVz+qNNxNfM3sOr/oZOrGdqN12v
	DCA20a3Q79UOZ0GwSuwvu+T3WyQQHIk/gcD6TheUFcXbUaAOn6jahqRtmvcKsHVB
	K6cDZvyGWdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5452E499E;
	Sun, 26 Feb 2012 04:11:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD7D6499D; Sun, 26 Feb 2012
 04:11:53 -0500 (EST)
In-Reply-To: <7vk43af14m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 26 Feb 2012 00:30:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECCF121C-6059-11E1-BA30-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191558>

Junio C Hamano <gitster@pobox.com> writes:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> ... I wonder if this is a
>> redundant check. --verify-objects is called to verify new packs.
>
> I do not think --verify-objects does not have anything to do with
> verifying the integrity of packs, whether new or old.

A typo/grammo that should be obvious from the context, sorry.  The above
should be "I do not think --verify-objects has anything to do with ..."
