From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: add git apply whitespace expansion tests
Date: Wed, 21 Jan 2015 14:33:38 -0800
Message-ID: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com>
	<CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com>
	<CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com>
	<CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com>
	<CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com>
	<CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com>
	<99579252-EF8A-4DAF-A49D-2AC5627ED9E3@gmail.com>
	<4157F6B0-DDF4-4F71-A09B-EE216537CA89@gmail.com>
	<xmqqbnly1oqo.fsf@gitster.dls.corp.google.com>
	<xmqqzj9iz3gu.fsf_-_@gitster.dls.corp.google.com>
	<102e322e68e78e39a7c227f3f3e102c@74d39fa044aa309eaea14b9f57fe79c>
	<CAPc5daXVk_ROUy7rmzS0aosWvE2wqw8tHZgomHHkay9CZjhbiw@mail.gmail.com>
	<AB9246EB-D720-4A4A-9AB7-4307613C19A3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:33:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE3qX-00068z-WA
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 23:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbbAUWdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 17:33:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752337AbbAUWdx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 17:33:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BA9730554;
	Wed, 21 Jan 2015 17:33:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jzJJlVaioPIrbYgZfysX9D6hYzY=; b=NVlHLt
	Y6CTCKsBs48b1LWa3bJuB21Ze7SrIUf20VeGSmsWnDE5QemVlPA1q51ubXdPP/8R
	XSkhi7J7UKNNexxR976VZvOr6BT5XQSrSMejGlQ7yA44QT/h66uGGJSvkSWEIVgN
	MIMAhRDcLYL4aRUxH/SW1Nnv2+M2JCDEsFR1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L1HmR1qIostpRvZhjTwxW86Va2z/Tu5U
	SoXuBZPc6vfRlKNb4JMA919bcRLmF4+rZ6m9jcaIC0fubkg11BhJGuBMUxmg9r4V
	XHnyhM+uFmt4twFCL6w+I9MJFE1rJBpYxjtRaGuFU/R5XqI+nPdW3vJ/jKTImkBM
	qRYnfPlbHq0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31FCF30553;
	Wed, 21 Jan 2015 17:33:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5019030535;
	Wed, 21 Jan 2015 17:33:39 -0500 (EST)
In-Reply-To: <AB9246EB-D720-4A4A-9AB7-4307613C19A3@gmail.com> (Kyle J. McKay's
	message of "Sun, 18 Jan 2015 19:54:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8BBF06B4-A1BD-11E4-982B-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262775>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> So since I've not been able to get test 2 or 3 to core dump (even
> before 250b3c6c) I tend to believe you are correct in that the code
> thinks (incorrectly) that the result should fit within the buffer.

Thanks; let me steal your tests when I reroll.
