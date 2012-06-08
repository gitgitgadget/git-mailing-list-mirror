From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Fri, 08 Jun 2012 07:55:34 -0700
Message-ID: <7v8vfxetuh.fsf@alter.siamese.dyndns.org>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vwr3ieo0i.fsf@alter.siamese.dyndns.org>
 <20120608093257.Horde.eeddeHwdC4BP0aqpIrqTaVA@webmail.minatec.grenoble-inp.fr> <vpqfwa618zv.fsf@bauges.imag.fr> <1339147124-ner-3533@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	konglu@minatec.inpg.fr, Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 16:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd0bF-0003Ru-Hn
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757634Ab2FHOzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 10:55:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824Ab2FHOzh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 10:55:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDB5C841B;
	Fri,  8 Jun 2012 10:55:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkM17mC85oV5fWm3dl0GRjggXkU=; b=B2jEpt
	FCFjAk8W9vVSzJhn3uUXBPbaH/MZAJgPaumuXvr02io5eWaSxy4iHCWa/x8xCCTa
	W5sKs7Tsh2ZSBm44s8IcvH6rUFGIdtR3oGjHuxMufmrj0qtNQS0l6NpQExCOixqa
	OK9Yw5Oa5jpnMC8O0mSx7wrPa7VAkGuJJ4cpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=htrSurXIVX9u9jeclK9IyZ494/std1gP
	JvYhrjXjL2CsLewOyXtlA6+hQELNY7/10PpyGJvaFTLs2mwkllRSTflztrpI1s8G
	zfyu71Tp/PsqKLu5LSH6At5wN/jSTYLrWjvWa2piEvmP7qJorY2raUShW9/iML3O
	fDQu+nZPZA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD13A841A;
	Fri,  8 Jun 2012 10:55:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39A1E8419; Fri,  8 Jun 2012
 10:55:36 -0400 (EDT)
In-Reply-To: <1339147124-ner-3533@calvin> (Tomas Carnecky's message of "Fri,
 08 Jun 2012 09:18:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 013D281C-B17A-11E1-9AC9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199499>

Tomas Carnecky <tomas.carnecky@gmail.com> writes:

> On Fri, 08 Jun 2012 10:52:04 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Isn't a more conventional way to do that
>> 
>> sed -e '...' "$1" >"$1".new
>> mv "$1".new "$1"
>> 
>> ?
>
> Is sed -i not portable or what is the reason not to use it?

It is a GNUism so it is not portable (check POSIX.1 before asking),
and that is the reason to avoid it.
