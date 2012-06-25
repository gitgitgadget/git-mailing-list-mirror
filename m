From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4 v8] config: write to $XDG_CONFIG_HOME/git/config file
 if appropriate
Date: Mon, 25 Jun 2012 11:08:31 -0700
Message-ID: <7v1ul3gt7k.fsf@alter.siamese.dyndns.org>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
 <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340355806-6894-5-git-send-email-Matthieu.Moy@imag.fr>
 <7vwr2zm4bm.fsf@alter.siamese.dyndns.org> <vpq395jj3dt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 25 20:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjDiI-0002az-5D
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 20:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab2FYSIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 14:08:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113Ab2FYSId (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 14:08:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E1C871BB;
	Mon, 25 Jun 2012 14:08:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5zBEMFnAk5L6CNBfNbtL+POilO4=; b=EFZZWC
	9zUUUonSbigjCqddOrGM2wysqME7BQ6vcQ5cgfN3pcIW81CJwXqzfcQ3mwrLfYAC
	YqL8Uasdpsq8Pqcsxc7eGVNIgtn+r0XLS7LzNcVAxDw2a4uMtDa4f3sxf3VEB7jo
	6Gve+Uw/zoRkrsWHMatXSjPNK5cEVvjbVYiFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SAnzI3jj3WMc5YyjRjrJJK6yd+dE6EIX
	mEApvTDCGb+zU0KQ9RdaD/tJ61+3lf0WFpMZA/LCAz+9YFKBNbAJJaEMZJQu++sV
	6agPQO5HGOdyXyXp4sgXwjT3Dt5S87nSidUdYCbqrV0LiAEIYijEXuw3E/S3we8l
	1Pzs/SQcymI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54B9E71BA;
	Mon, 25 Jun 2012 14:08:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFD3971B9; Mon, 25 Jun 2012
 14:08:32 -0400 (EDT)
In-Reply-To: <vpq395jj3dt.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 25 Jun 2012 08:45:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C67C2A64-BEF0-11E1-B2DE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200589>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> We can squash this into PATCH 1:
>
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -209,7 +209,9 @@ $XDG_CONFIG_HOME/git/config::
>         Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
>         or empty, $HOME/.config/git/config will be used. Any single-valued
>         variable set in this file will be overwritten by whatever is in
> -       ~/.gitconfig.
> +       ~/.gitconfig. Support for this file was added after Git
> +       1.7.11, so if you sometimes use older versions of Git, it's a
> +       good idea not to create this file.

Okay.  Thanks.
