From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/18] receive-pack: do not reuse old_sha1[] to other things
Date: Tue, 19 Aug 2014 15:32:18 -0700
Message-ID: <xmqq4mx8un4d.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:32:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrxB-0001LK-Od
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbaHSWca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:32:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62102 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbaHSWc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:32:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1461533A7B;
	Tue, 19 Aug 2014 18:32:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ETNE1+ganN0//dEEDjIKmwGaoJs=; b=sRAu1q
	PoycPJ6ISklPs0n/Mp8NWeOhmb6yz/Wv0yElpGaPv8UgA1iZdwZCZTagUeuak7va
	8sMfeOiWq3LvwlnrzJfcDoCo9hdQ4ysA622/EcsNGDSz9aNNj2Zj3qk2E28cb5tc
	rpmhxKOhSo4WLrT2XrtCoazLkjAxRJ6Rtkh5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ShuoQFyqfPRf7khT4RkgnKW+W5fmZKCH
	8i1gCswdwbR2aVEHRNpd086H5YapYB2Hv7UOMn9KeeJ+ilN+tFevLfXhXPeVuYjp
	6uRo5bXaH9Rw+oRLc33bny6oH4WfCfS8UmJ4ra9vFRAesYoJyWmJ+gt12bmI/Bdn
	GBWj9LlM0zw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A34533A7A;
	Tue, 19 Aug 2014 18:32:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1C33033A67;
	Tue, 19 Aug 2014 18:32:20 -0400 (EDT)
In-Reply-To: <1408485987-3590-4-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Tue, 19 Aug 2014 15:06:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE806130-27F0-11E4-AEF4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255542>

Junio C Hamano <gitster@pobox.com> writes:

> This piece of code reads object names of shallow boundaries,
> not old_sha1[].
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I should double the subject line and say "do not reuse ... for other
things".
