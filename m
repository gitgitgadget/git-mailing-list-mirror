From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:28:44 -0800
Message-ID: <7vzjzbnwb7.fsf@alter.siamese.dyndns.org>
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
 <7v4nhjpb69.fsf@alter.siamese.dyndns.org>
 <CAE_TNin+WcPodGfXKQuzBVujK7Yx3iCUR2rqgoc20WgwhJSR4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:29:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4np7-0005al-UC
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab3BKH2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:28:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595Ab3BKH2q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:28:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E976328;
	Mon, 11 Feb 2013 02:28:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnAMXPrDeBOGlemhuWXdB5b9U4Y=; b=YplK7N
	gG5jgv1/8XnMfzvJ5A+gQyNO8rDUysJfMo9ti8fyoHhRAYhx1pDi478UpT8ftgkT
	44n+AAa3I5D/eVRwseugIBw/yIwkN/vLpOtu+D8kXK9x74Nyrjn7eM2TxqmMsQ0a
	RSdIG6hSXzSAf5CM+g62l8AXIvKyxL4NOBpxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rwC4uLVQTdrW7eKvjTKiPdYsNIiVEu5c
	kkBW4PTwfouwF+28R54dL5LBcqXlJX3jIfcxFP9kIoXFCd+FLZqTsqGy7sa7pu6N
	teTuJoJgr2vcHRi1GszgLagVeoyKpvDK+hwLX5uSntxuUuCklmfaVc2Ys+kzcdGy
	MTK1ogSEUT4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4DCC6327;
	Mon, 11 Feb 2013 02:28:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 675A66325; Mon, 11 Feb 2013
 02:28:45 -0500 (EST)
In-Reply-To: <CAE_TNin+WcPodGfXKQuzBVujK7Yx3iCUR2rqgoc20WgwhJSR4g@mail.gmail.com> (Ethan
 Reesor's message of "Mon, 11 Feb 2013 02:26:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB312782-741C-11E2-803F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216017>

Ethan Reesor <firelizzard@gmail.com> writes:

> On Mon, Feb 11, 2013 at 2:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ethan Reesor <firelizzard@gmail.com> writes:
>>> Again, would it not be more elegant and powerful to A) have the
>>> shell-disabled message/hook/etc specified by git-config on some level,
>>> be it /etc/gitconfig or ~/.gitconfig, and B) have Jonathan's patch
>>> whereby ~/git-shell-commands/help returning non-zero closes the
>>> connection?
>>
>> Isn't that what I have essentially been saying?
>
> That is what you've been saying. I reiterated because I like the idea
> of having it managed via git config.

Yes, and I've been ignoring the "git config".  I do not think it
gives enough customizability Jonathan's example of listing user
owned repositories, for example.  Having a config variable in
/etc/gitconfig that points at a random script on the filesystem does
not buy us much over an approach to have a global hook at a known
place on the filesystem, no?
