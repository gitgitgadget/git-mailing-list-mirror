From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git feature request: Option to force Git to abort a checkout if working directory is dirty (i.e. disregarding the check for conflicts)
Date: Mon, 31 Mar 2014 10:13:20 -0700
Message-ID: <xmqqha6e8f67.fsf@gitster.dls.corp.google.com>
References: <004d01cf49d7$c8b9cd90$5a2d68b0$@jonasbang.dk>
	<xmqqk3bfedqi.fsf@gitster.dls.corp.google.com>
	<002001cf4b44$fe3550c0$fa9ff240$@jonasbang.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Jonas Bang" <email@jonasbang.dk>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:13:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUfm3-0007g9-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 19:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbaCaRNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 13:13:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbaCaRNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 13:13:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D01ED780FD;
	Mon, 31 Mar 2014 13:13:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vunoso/1+L3JzXmxRP7OM0mOX4Q=; b=cNle4c
	cpA2iYT7PkBHz1A+TkPoWXAZyFJVcVu/7X/3L9bh49VZ/jUJ8Z+QvG4+ADN6eWkR
	DbO6QouzOgFIl2V0Ihspi/GfKP/fIK/KlorkPcmu5p5VEzB1ZamtoqQCQ76pLh4/
	aKc69ZMjfCCAIGLgrlHytU0AyeCAbA9//qAeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjXtzlTpBfAgTkYwLNtUIZlIK9gz9Ug/
	fycDq6Hea71164+cKt2XbJyOeNK0FSjqdcsKw+5ZsHfBApuqvyQ/RKGPJuvvN4q7
	bKAzE0nM7YMK/dNTSrhMSxOwde182OtFVtD+kSSRcrtwPhwkQfuUGKMjOgxhSzBM
	L4Lq7OPm4b8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDDCE780FB;
	Mon, 31 Mar 2014 13:13:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23D7B780F9;
	Mon, 31 Mar 2014 13:13:22 -0400 (EDT)
In-Reply-To: <002001cf4b44$fe3550c0$fa9ff240$@jonasbang.dk> (Jonas Bang's
	message of "Sat, 29 Mar 2014 12:49:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C323BDA2-B8F7-11E3-96E1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245494>

"Jonas Bang" <email@jonasbang.dk> writes:

>> For some people it is also a norm to keep files that have been modified from
>> HEAD and/or index without committing for a long time (e.g. earlier, Linus said
>> that the version in Makefile is updated and kept modified in the working tree
>> long before a new release is committed with that change).  The default
>> behaviour would cover their use case so your proposal would not hurt them,
>> but I wonder if there are things you could do to help them as well, perhaps
>> by allowing this new configuration to express something like "local changes in
>> these paths are except from this new check".
>
> Yes, those people would probably use the default 'false' behavior
> as it is already. If they however would like to use e.g. the
> 'true' or 'include-untracked' setting as a configuration variable,
> then they can use the command line option 'false' if they wish to
> do a 'git checkout' even with modified files in the working tree.

So in short, you are saying that "The added code necessary to
implement this feature will not help them in any way, it is just
that we will make sure it does not hurt them".
