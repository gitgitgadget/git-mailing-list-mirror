From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge conflicts are reported relative to root not cwd
Date: Wed, 13 Apr 2016 15:40:11 -0700
Message-ID: <xmqqvb3li14k.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kbVfk=yAK3UB=H385_YfAtMHZe-gSE=EYVvvcS8jjy08A@mail.gmail.com>
	<xmqq4mb5jhm7.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZSyLZxMXSSv=uDpuA0zTUy6nU4vwEF5f7WLhoRp1hXig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:40:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTSR-0006Qt-Rq
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbcDMWkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:40:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753165AbcDMWkP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:40:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 79DD7129F2;
	Wed, 13 Apr 2016 18:40:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w7fj9lRJ//6/3O6wbPPdECB1Z0Q=; b=jfyumo
	92lLON/rYlLXbfKuSE5J8juvQEPgnNaBap/imw7JMYh6IL3V7mgje1lzOW8SIMJP
	ZAJk1kfgekQjUatrhlWpB1qdvig+Ffax6xvnF+811nsoNvo7JoSjuYm3rLqFA8WT
	znj1DahTk4IrgvycCRq6Iz+8yRsdQC5K1JgAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q2CZkac7CxFEycnE71lyXcSykIN0R87z
	yECESoesy1s10HRim7PFomYB6rxXv3TQ/HtOwGDvFt2/CtUMrn6UoRjcXaiyqpZZ
	jOe04FOSBgIhyicPkLVtD5JLIsZFAry84dVnVEKjgYEhdl4QubhtKfe58TFA/OYR
	Qi6zCkdUOMo=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 72C8A129F0;
	Wed, 13 Apr 2016 18:40:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E28E3129EF;
	Wed, 13 Apr 2016 18:40:12 -0400 (EDT)
In-Reply-To: <CAGZ79kZSyLZxMXSSv=uDpuA0zTUy6nU4vwEF5f7WLhoRp1hXig@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Apr 2016 15:18:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AF698870-01C8-11E6-8B4F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291505>

Stefan Beller <sbeller@google.com> writes:

> * .... What are
>    whole-tree operations?

"git merge" does not let you merge "changes just in my current
directory".  You only merge the whole tree, and you can get
conflicts from all over the tree, not just in your current
directory.
