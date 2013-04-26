From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Zile as git core editor?
Date: Fri, 26 Apr 2013 10:00:44 -0700
Message-ID: <7vtxmtxm4j.fsf@alter.siamese.dyndns.org>
References: <877gjp91w5.fsf@gmail.com>
	<CALUzUxpZ9=8aVEMBfFUH2hN5ZkwzKVX31J79MVzkCEGRX++LPw@mail.gmail.com>
	<87txmt7km9.fsf@gmail.com> <vpqppxhfz3i.fsf@grenoble-inp.fr>
	<87ppxh6zru.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thorsten Jolitz <tjolitz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 19:00:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVm0x-0004ax-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 19:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293Ab3DZRAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 13:00:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755251Ab3DZRAq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 13:00:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B56D1AD08;
	Fri, 26 Apr 2013 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8AFTEdnKZTvy+vmH6/gfsQjTUZw=; b=XB3kkI
	S0u1bC8DbOr2kGcDCn5Lalx6hNo5NENk7Z+pHsb4DJZAed9nEJ1Pnbe/TktodqZh
	PQvluFabItBz292Rqmr03o76FGzHML7Md1hEsx28DQiUyl8MCxM+tuRQqVoq7RXU
	No4HVRgCjlCBQUARhOp+imrB7KG5eSnI7pssY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xDi45Ms7OkrIvkA0fq8PUGxeaOrysgWH
	RnbsJLYMNZQtJB/wlkmM/JvRnDrjaPo3EQn3NHHdVX6eQQ0yZCcYvck6QAdeqArc
	luEL73Ycbi6rF8dEyqAR716VhlDpvYFyRFeha3yCYkr2mmHTVESQWTCO6vcB/Pjv
	CknU+20BhCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D87D1AD07;
	Fri, 26 Apr 2013 17:00:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E224C1AD05;
	Fri, 26 Apr 2013 17:00:45 +0000 (UTC)
In-Reply-To: <87ppxh6zru.fsf@gmail.com> (Thorsten Jolitz's message of "Fri, 26
	Apr 2013 18:08:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D65BA5D0-AE92-11E2-991A-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222541>

Thorsten Jolitz <tjolitz@gmail.com> writes:

>  ... I think what I really would like to
>  have it that, when I use GNU Emacs Magit and enter a git command 
>
> ,-----------------------------
> | Run git like this: <command>
> `-----------------------------
>
> that calls an editor (e.g. commit --amend), the running Emacs instance
> is (re)used and a new buffer is opened for editing (instead of starting
> another Emacs instance).

Hmph, isn't that what "emacsclient" is for?  I have these

	(setenv "PAGER" "cat")
	(setenv "EDITOR" "emacsclient")
	(server-start)

somewhere in my ~/.emacs to make commands in "M-x compile" behave.
