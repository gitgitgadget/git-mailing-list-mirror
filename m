From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sun, 09 Jun 2013 16:39:20 -0700
Message-ID: <7v61xmn9av.fsf@alter.siamese.dyndns.org>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	<7vd2rvqgra.fsf@alter.siamese.dyndns.org>
	<CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
	<7vy5ajozuj.fsf@alter.siamese.dyndns.org>
	<CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
	<C30D5684C80641EFAC0F89F00B48A74F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Duy Nguyen" <pclouds@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Stephen Boyd" <bebarino@gmail.com>,
	"Jens Lehmann" <Jens.Lehmann@web.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jun 10 01:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlpCp-0002bf-9l
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab3FIXjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:39:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab3FIXjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:39:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19AF12652B;
	Sun,  9 Jun 2013 23:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MuCYzw2rjsuWYtwF/0n+DFxi1cc=; b=vqRD0d
	2uFY6Awjc9WaU3DpHZrS2Ddb8T2nhGqdnHxC9QTXwuWJM5BGjUfJzW84hhEXwXh+
	U6Y+ov2VwOWhUEJ1pR+yenR1x527W0OmTh+eGiAZ3bN5EvYPbg6l/E7gncNP0e7X
	yjwtn4k2/xqZbab6OOKBypCB0sLuh0HUOv3mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WxHhHAJcyA4UiFn0tFUDgsVikNO/nA23
	/D8M06pywNh1tvSWMc+QvbujSzSSYfEueFlQt69DvHlTAvkaN3/M9zex7ZSGfTEN
	j1+7ZAzoa2e69/Bsk04mLe2XhOA9/+o1l3eV5jJ8Ztv6VadoKu8SeOoM1JBw3Ode
	kMfE4vX5JgA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E2AA2652A;
	Sun,  9 Jun 2013 23:39:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ADEC26529;
	Sun,  9 Jun 2013 23:39:21 +0000 (UTC)
In-Reply-To: <C30D5684C80641EFAC0F89F00B48A74F@PhilipOakley> (Philip Oakley's
	message of "Sun, 9 Jun 2013 23:44:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF626E24-D15D-11E2-8A63-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227216>

"Philip Oakley" <philipoakley@iee.org> writes:

> While folks do use such simplistic names, given that the patch had
> many call sites, I do think Filipe's short name would quickly become
> the accepted test name and not cause any great difficulties.

OK.
