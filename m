From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 11:19:17 -0700
Message-ID: <7vfvw79xsq.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-7-git-send-email-gitster@pobox.com>
	<CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
	<7vhagndis4.fsf@alter.siamese.dyndns.org>
	<CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
	<7vy59zbjns.fsf@alter.siamese.dyndns.org>
	<CALkWK0=a40hACGYApN7odrTytDmoRG_00_Q=EuaHuQ_=h8LBkg@mail.gmail.com>
	<7vbo6vbgbs.fsf@alter.siamese.dyndns.org>
	<CALkWK0nv7On34g-zE5uHAH69TT-KcEt8z-LxhveNp1b4b+NHsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:19:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBMK-0003i3-R8
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab3FXSTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:19:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab3FXSTU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:19:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA4182B6E7;
	Mon, 24 Jun 2013 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ZXnfyURT586xkUk6kocFNfo84k=; b=vfaBV5
	LJxAvQs24rVgFhK5sYGL6RY5HkJ5q/OdFXX57d0zry9I6xCLCWpOHt7QB9YCyJ6B
	daZKZB+r7kK5Y6GgDMkFNb+9TvGli1mUCOhxURcc+CPJibRLD1ifrpjVtMJ59G96
	RKsSYArcJIwXNGE38+WxQtx1LK8c5pY79k0co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NKp8WXb1CIGpuiX4IlWSzxvBZipgy33B
	UFPtTpUEcZA9QqhrKXAqbsyLRe4QFgw3E3QLoEQVCkDaJrERmkTavhIKT/vsZH5k
	VEFXQ6ki7FkNWJ4SwZceEctCcc6LmyXjEewkn440Hmz51Hw+2xcZqrXAIa1F+3Bg
	ik0KKxSiTCs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E21492B6E6;
	Mon, 24 Jun 2013 18:19:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EA932B6E3;
	Mon, 24 Jun 2013 18:19:19 +0000 (UTC)
In-Reply-To: <CALkWK0nv7On34g-zE5uHAH69TT-KcEt8z-LxhveNp1b4b+NHsg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 24 Jun 2013 22:43:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 962C20F2-DCFA-11E2-81A7-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228888>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I'm not saying that we need to differentiate between configuration
> variables and CLI options; what I _am_ saying is that we need to think
> twice about moving a CLI option to a configuration variable, precisely
> because we do not differentiate between the two cases.

With remote.pushdefault, I think the ship has long sailed.
