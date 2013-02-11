From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:22:22 -0800
Message-ID: <7v4nhjpb69.fsf@alter.siamese.dyndns.org>
References: <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
 <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <CAE_TNi=EG6vziVObJ-a__smeOv7RgZ5R146eonD6M828H7ziNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:22:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4niz-0002nP-GP
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab3BKHW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:22:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677Ab3BKHW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:22:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA658617D;
	Mon, 11 Feb 2013 02:22:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NAo7/c9IGxDDF7KRurjngXL8h0A=; b=vWyc+A
	ZzILMBVnnGTqX9dEj8Klf2MGqZI7DlbjKFmpesawMvjGpyA8zeRcmQ/awVjtoRfF
	o+DreAadBtPAiKAYlEeYhQJYpS7rSCRtivMIfzrxQeotnkbOTv6T4Jf3B8kZU4WH
	kJRgeFMMGiqXx58mGzURaaFyBdojmA7+NUojI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=guQS/Y/KsZGCkg9+TlQ63XVcKKlU6otc
	+3eaNToc2Hfc2BVr7SzJvwvh4oGS9AV0xtzmvLOZc4bev+NBaF6q/Jii02RzavmO
	hQPgK2xO+ZWRyQ6pJBzPWWubKPQBEc9NImMdehxXSE91f/EnB6J7f3k2ynXN0VTF
	5Ul5yY9/vG8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE28E617B;
	Mon, 11 Feb 2013 02:22:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ACF26170; Mon, 11 Feb 2013
 02:22:24 -0500 (EST)
In-Reply-To: <CAE_TNi=EG6vziVObJ-a__smeOv7RgZ5R146eonD6M828H7ziNQ@mail.gmail.com> (Ethan
 Reesor's message of "Mon, 11 Feb 2013 02:15:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7EFAC28-741B-11E2-AE27-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216015>

Ethan Reesor <firelizzard@gmail.com> writes:

>> For those who _do_ want to give customized commands to their users,
>> they can already have "help" script to give a friendly message.  It
>> just felt silly to force sites to create the directory only to
>> refuse an access to the "custom commands" feature, especially when
>> the existence of that directory is a signal that the site may want
>> to give its users an acess to that feature.
>
> Again, would it not be more elegant and powerful to A) have the
> shell-disabled message/hook/etc specified by git-config on some level,
> be it /etc/gitconfig or ~/.gitconfig, and B) have Jonathan's patch
> whereby ~/git-shell-commands/help returning non-zero closes the
> connection?

Isn't that what I have essentially been saying?

For sites that do not want per-user customizable "other commands",
have a single site-wide hook instead of having to create otherwise
empty shell-commands directories for all users.  For users a site
wants to allow customized commands, have the directory and custom
"help" message.  I do not care too deeply if "help" exiting non-zero
caused the connection closed, but I care about not forcing a lot of
effort to customize messages to people who do *not* need
customizability.
