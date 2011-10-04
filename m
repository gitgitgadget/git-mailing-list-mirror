From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] enter_repo: do not modify input
Date: Tue, 04 Oct 2011 13:24:52 -0700
Message-ID: <7vipo4bj3f.fsf@alter.siamese.dyndns.org>
References: <CABURp0rKRb+fZG5erKz08Dz+4d7mjoL842zbcA7uzZ8N5Qtn1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:25:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBXw-0005at-RQ
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933653Ab1JDUYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:24:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933567Ab1JDUYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 16:24:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A54F757E3;
	Tue,  4 Oct 2011 16:24:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yz6ug/cL20588duI0FR+FQcyj/Y=; b=GMir7p
	OQg/RobVKvvwoh5aRtYi6zT7uoZJptX6i51yjGQiXjuKjpkDcIUP3pu0NUUE97dx
	Dnrv0MtxpSIgtQOWs1NkhaDHPogwl6FWIjIGb8GfVqCupk7N41vMqotbLZK09dFA
	Chg/mTlNhVCloSlwzQfVT1xkjPJ43MzXetroM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CutTmmmyoNr3ZdiEFku8I2dYekYmejHh
	AC0pubHR2Wd8tXdyyym4FaeTdToRHifJBE/ScXTjY1mmIGuEjrdqXeuu0TvbBcwb
	7mQIgs8evV/L+orBDoAdIABl9dvzLTWdX1gNlR/ne1Qc+vuRO5c4rTjIxTu/OP2j
	jeE0XnXgqog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C71157E2;
	Tue,  4 Oct 2011 16:24:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C52A57E1; Tue,  4 Oct 2011
 16:24:54 -0400 (EDT)
In-Reply-To: <CABURp0rKRb+fZG5erKz08Dz+4d7mjoL842zbcA7uzZ8N5Qtn1Q@mail.gmail.com> (Phil
 Hord's message of "Tue, 4 Oct 2011 16:02:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB6448DE-EEC6-11E0-9847-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182800>

Phil Hord <phil.hord@gmail.com> writes:

> diff --git a/daemon.c b/daemon.c
> index 4c8346d..9253192 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -108,11 +108,11 @@ static void NORETURN daemon_die(const char *err,
> va_list params)

Corrupt and unappliable patch.

> -		if (path[0] == '~') {
> -			char *newpath = expand_user_path(path);
> +		strncpy(used_path, path, len); used_path[len] = 0 ;

Do not write two statements on a single line; extra SP before ';'.
