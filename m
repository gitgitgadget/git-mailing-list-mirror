From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-new-workdir: Don't fail if the target directory is empty
Date: Wed, 26 Nov 2014 15:16:43 -0800
Message-ID: <xmqqk32ho8mc.fsf@gitster.dls.corp.google.com>
References: <1417034308.23650.51.camel@homebase>
	<xmqq8uixpqyx.fsf@gitster.dls.corp.google.com>
	<1417041115.23650.69.camel@homebase>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: paul@mad-scientist.net
X-From: git-owner@vger.kernel.org Thu Nov 27 00:16:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtlpL-0008QY-IY
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 00:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbaKZXQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 18:16:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753997AbaKZXQp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 18:16:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17CBF21338;
	Wed, 26 Nov 2014 18:16:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uDh6Zxa986qeFjUUSfwx8YpeNxQ=; b=En7d25
	vyUAEF2ty5ARp6D075xQgs5CvsGJbbtf2KUD+3jLGLVVPbK4Ih6zQZEoH76iEuPW
	eUpKFRVLr+pj/Cfj5uLbkM8bLpxgERNChRepnHcu2LFZ7A5mqIVzHXLN4bLsTUem
	ywaHqcdkJg5Yko93koQHE4FexZPA+iC4VJMcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wwp8uA3GIw/Ovn9USmctiKE8igAtnqID
	ggCMUV5z3jrELnQQE+RgTTW+iL5uMKm2vaGcLnG0spEtbIrb+V26c/oQ6teI/M6h
	zYNQ9wg7MF1zlo1N4WIHjFYtwILfdQDndY27TF+WVRhpyVSssA0FS5d4KVyupcui
	JAquNxeTTE4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F0CC21337;
	Wed, 26 Nov 2014 18:16:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8783121335;
	Wed, 26 Nov 2014 18:16:44 -0500 (EST)
In-Reply-To: <1417041115.23650.69.camel@homebase> (Paul Smith's message of
	"Wed, 26 Nov 2014 17:31:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49878C48-75C2-11E4-8446-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260324>

Paul Smith <paul@mad-scientist.net> writes:

> This is what happens for a file:
>
> $ rm -f foo
>
> $ touch foo
>
> $ ./src/git/contrib/workdir/git-new-workdir src/git foo master
> mkdir: cannot create directory ‘foo’: Not a directory
> unable to create new workdir "foo"!

;-)  That comes from mkdir || fail which is indeed sufficient.
