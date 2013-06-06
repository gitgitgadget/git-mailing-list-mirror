From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: bring Wish process to front on Mac
Date: Thu, 06 Jun 2013 11:15:31 -0700
Message-ID: <7vk3m7yukc.fsf@alter.siamese.dyndns.org>
References: <1370506667-24576-1-git-send-email-stefan@haller-berlin.de>
	<CABNJ2G+h3zh+=wLA0KHjUn8TsfhqUK1Kn-1_=6hnXVRJUPhuuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Haller <stefan@haller-berlin.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 20:15:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukeip-0000SN-0i
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 20:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab3FFSPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 14:15:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab3FFSPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 14:15:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB48D25D31;
	Thu,  6 Jun 2013 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=APLHLfw5xN/qleMmChzh2mHJGCk=; b=Qcjg1+
	gyIkfKYCg2AG0U+mxmNSjF3pXY7sZf0qMuGvJc+csj34wejxZau0wTPDWVzuo+OJ
	Hfbz3nC18hHXx5Y3lxDMkhaUl9eNywUDu0je2K0jq5iakfFlBCtB5p27sQranRho
	WGK/x9rNmvqFL1CkxuBADIo7KL6IteU8tgRSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v+7F7tA6clRgQp/9y/PLHhNbBqo8nL8g
	32lNYHDCXSlio9AZDpUVKSwNBNJlDpFRcqbr/7tWQK925zE8+a4+l0VsOXU33bgx
	MNrM7ipN8k7hkqEap/8W/51/KLDWMyjdPnxGFdRYg6KVCzZ6aB9zNbO+59GZv3SH
	2P45X9VirYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1AE425D30;
	Thu,  6 Jun 2013 18:15:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1176725D2B;
	Thu,  6 Jun 2013 18:15:32 +0000 (UTC)
In-Reply-To: <CABNJ2G+h3zh+=wLA0KHjUn8TsfhqUK1Kn-1_=6hnXVRJUPhuuA@mail.gmail.com>
	(Pat Thoyts's message of "Thu, 6 Jun 2013 15:09:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13D7E222-CED5-11E2-A43F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226520>

Pat Thoyts <patthoyts@gmail.com> writes:

> Seems fine to me. I can't test this as I have no access to this
> platform. Possibly you should run this in a catch statement so it can
> ignore any errors and I would tend to use the 'auto_execok' command to
> ensure that osascript actually exists. Something like
>
>   set arg [format {tell application......}]
>   catch {exec {*}[auto_execok osascript] -e $arg [pid]}
>
> but possibly this is guaranteed to exist on all macs which would make
> the above redundant. What I'm thinking is you dont want the app to
> exit just because something goes wrong in this call.

Sounds like a sensible concern; gitk in v1.8.3 has it without catch
so we may see failure reports from OSX users soonish, in which case
both this patch and gitk need to be updated for it.

Stefan (as your name appears in 76bf6ff93e, I am assuming that you
were the OSX-osascript guru in that commit) could you keep an eye on
the list traffic to see if users of latest gitk have issues with
that change, please?

Thanks.
