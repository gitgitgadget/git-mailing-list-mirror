From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status merge: guarentee space between msg and path
Date: Wed, 12 Mar 2014 11:39:22 -0700
Message-ID: <xmqqeh27mfc5.fsf@gitster.dls.corp.google.com>
References: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<xmqqeh28pkuu.fsf@gitster.dls.corp.google.com>
	<531F706C.1080901@savoirfairelinux.com>
	<xmqqwqg0o518.fsf@gitster.dls.corp.google.com>
	<CACsJy8DvBVxtP_+qbcxL0J8D3iokGeMVW0jxFtZD=Jk_A=mwQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sandy Carter <sandy.carter@savoirfairelinux.com>
To: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 19:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNo3y-00048D-5l
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080AbaCLSj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:39:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883AbaCLSj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:39:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B917304E;
	Wed, 12 Mar 2014 14:39:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8le4D9VPnCzzBTyQ+519dm9g7zc=; b=KU77xr
	yhn6XljzRvdCKmzOLDysdhhOkxq/hT/VaKWBvtuPRtCuXbzn0pfzIVJOMJ9TPDsq
	hS2styfwyBG+y9WJLvoMN8xkEiFo22+HGIFTwvjCpn6CDT5Un3UrbQ/QxLYPmQDS
	XAm2mGAcXNo7IAPcb+i5VVpkVTL1DoGR3ILmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UlO+v9b12a8cxQWr+0heqPDNFXmdYknw
	rGbLJrQCvzvVvWyZfBFN72fv7OBL+m0SXTySYU4smQE+hS8Q4fCfbh+bT9aE+VQv
	q/eR54KvFFIxT4UKc24JMfxD5znjMwaW4rRPyOZwZ3VRWTG98mSjWA5iG3BNcvTT
	toaZ1EulIeg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A88E7304D;
	Wed, 12 Mar 2014 14:39:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAE8B7304B;
	Wed, 12 Mar 2014 14:39:24 -0400 (EDT)
In-Reply-To: <CACsJy8DvBVxtP_+qbcxL0J8D3iokGeMVW0jxFtZD=Jk_A=mwQg@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 12 Mar 2014 06:33:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2731A76-AA15-11E3-A936-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243959>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Mar 12, 2014 at 3:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Sandy Carter <sandy.carter@savoirfairelinux.com> writes:
>>
>>> 3651e45c takes the colon out of the control of the translators.
>>
>> That is a separate bug we would need to address, then.  Duy Cc'ed.
>
> We went through this before
>
> http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/1109239/focus=239560
>
> If the colon needs language specific treatment then it should be part
> of the translatable strings.

OK.  So we should resurrect $gmane/239537 and adjust the codepath
that was touched by 3651e45c to move the colon into translatable
string?

What other places do we assume that colons are to immediately follow
whatever human-readable text used as a label/heading, I wonder...
