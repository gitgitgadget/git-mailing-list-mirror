From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr.c: Use ALLOC_GROW instead of alloc_nr and xrealloc.
Date: Tue, 21 Dec 2010 16:59:39 -0800
Message-ID: <7v1v5a7hc4.fsf@alter.siamese.dyndns.org>
References: <3c6870c390110bd1bf5c5f59a99928afc86cf188.1292978127.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 01:59:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVD3c-00018Y-Bc
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 01:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab0LVA7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 19:59:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab0LVA7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 19:59:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4EBCE3372;
	Tue, 21 Dec 2010 20:00:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O0fLQv5eLl6a3dmujK6dB+ulkOk=; b=kaBFsY
	Ke+eoACz0ygXuoIOK0+u3Yv9I2xBoj7c5zeTzsjEfHTCzp4wzTj6abFkcXPYfjny
	hVbTkMmRTgP0mSP3eeHYMvYQNXiqTs0rN55uZk36Niz047dddbUTCFpR6gtZ+p9B
	pNIN2mMJvNGYkHMIQY2RDeYFctZdJIjtHIXmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODtWXPvumr2f15T7+UmymWXn47HB2vLp
	6oq5/vJxQUfmTk90y31JcXqy9cVUmgXbh0OpJNWK81eihnlYurst71sW1ycqVaZ6
	j/pHxzpEBn5rd3APR32JSwYWfYhWi3XrnP1cWJxKHt2FgZAixEalM2ijcwtSTlj/
	dbmJ/aVcPBQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A5CF3370;
	Tue, 21 Dec 2010 20:00:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 461E3336B; Tue, 21 Dec 2010
 20:00:11 -0500 (EST)
In-Reply-To: <3c6870c390110bd1bf5c5f59a99928afc86cf188.1292978127.git.tfransosi@gmail.com>
 (Thiago Farina's message of "Tue\, 21 Dec 2010 22\:35\:50 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5839142-0D66-11E0-AA4D-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164064>

Instead of trickling these down, can you give a single patch to convert
the remaining ones you have been finding with "git grep -e alloc_nr"?
