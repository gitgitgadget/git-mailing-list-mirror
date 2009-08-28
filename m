From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How does git follow branch history across a merge commit?
Date: Fri, 28 Aug 2009 16:32:52 -0700
Message-ID: <7vmy5jbjkr.fsf@alter.siamese.dyndns.org>
References: <8363c75zug.fsf@torus.sehlabs.com>
 <7vskfbcy9n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Steven E. Harris" <seh@panix.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 01:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhAwM-0004iM-NW
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 01:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbZH1Xc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 19:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbZH1Xc6
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 19:32:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZH1Xc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 19:32:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CC061C365;
	Fri, 28 Aug 2009 19:32:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CLUDWbR1fzDySjJxkS2Bhy8vuEU=; b=SKQZKV
	6F5Kq/RgHqqUaC6RUCFRtBGelgdq4SdSMBgsfusNy6FCMSpahEmtEngNng0m0MTp
	cPfIKFuI2MWz6uWcldaKJxqXCWReqEYuZgPvgeZl7CXIHs/ayhW1ahUKdC0XcDUK
	ATzRjG2gLtOI0m3lVQNqUuXePvhfO0IxVNCiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MQDxj+0LdOW9RoLpYj/osGbXEXFrok6L
	hmtL288+5UpcUl623bJLzupRIEMxv6Rly1PHA8yUBVslhQxG9E3K8DgEF7Kw1EIs
	cx97BVU4h6/n4z6x1McdY1YoAWZ+CmIHpjerpMsxPy7Je9NMHwsANSrgEFrN6pa6
	MBMpOi7ryb0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF931C364;
	Fri, 28 Aug 2009 19:32:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 776B61C363; Fri, 28 Aug
 2009 19:32:53 -0400 (EDT)
In-Reply-To: <7vskfbcy9n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 28 Aug 2009 16\:30\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1DC1AC34-942B-11DE-9C4D-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127363>

Junio C Hamano <gitster@pobox.com> writes:

> "Steven E. Harris" <seh@panix.com> writes:
>
>> Was it just luck that "HEAD^" referred to the predecessor that came from
>> branch "master" rather than branch "competition"?
>
> Yes, if you want the second parent you would say HEAD^2.

Ahh, I misread your question.  No, it is not luck.  If you merge
competition into your master, the resulting commit will have your master
as its first parent.  If check out competition and merge master in your
example, the resulting merge will have compatition as the first parent.
