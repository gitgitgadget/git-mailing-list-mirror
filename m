From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Thu, 12 Apr 2012 10:40:26 -0700
Message-ID: <7vr4vs6e7p.fsf@alter.siamese.dyndns.org>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
 <7vobr4236g.fsf@alter.siamese.dyndns.org>
 <CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
 <fd7f09d9f7ad4ce2a32e850c0f21cc4c-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 19:40:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIO0Z-0004sP-DC
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 19:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234Ab2DLRka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 13:40:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757838Ab2DLRk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 13:40:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C7C16582;
	Thu, 12 Apr 2012 13:40:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aOSSo3GPwTDGfgxbhxSZTtbw1qE=; b=wBX3F7
	x0FoEIhpTwGVd29TfTv1Egs+mK2YkikZMthQ1GtJqU0s4SYWXkxBPUiooayRohix
	K0u53GqJ1Yt5M+X+1rzAzds5n1AOUkuwVfSNHms8mEdWipaS1zq1VV1sDwJWqeFJ
	5IepS6DoIo+J6CI9Qh/fKKzvGPTB7DVR5wnqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zdchzl1X41Uzf+4A2tkDu0qlVoyLs84O
	uudTg9cujo5STuqFI6dz9lLqXO6cq5r20XEBJ41qQyiUUA0FwE+DZVKYoNqFxnff
	SS8EYxQZUIh0TYTSrNd55SZ3y0Dihpud3nqW9OMHaVOQEvQIrUyR+3834c7p3vgJ
	Ap2aDqnB2c0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61A7F6581;
	Thu, 12 Apr 2012 13:40:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC99A6580; Thu, 12 Apr 2012
 13:40:27 -0400 (EDT)
In-Reply-To: <fd7f09d9f7ad4ce2a32e850c0f21cc4c-mfwitten@gmail.com> (Michael
 Witten's message of "Thu, 12 Apr 2012 15:41:06 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 978C989C-84C6-11E1-B8BC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195349>

Michael Witten <mfwitten@gmail.com> writes:

> I sometimes like to set an explicit in-body `Date' header. However, Junio
> has disagreed vocally about this practice:
>
>   Subject: Dates in Commits and other issues of style
>            (Re: [RFC 2/5] Pretty Print: show tz when using DATE_LOCAL)
>   Message-ID: <811b01a9-f10e-4444-9e5e-581adaf059c2-mfwitten@gmail.com>
>   http://article.gmane.org/gmane.comp.version-control.git/171936

I do not want to see that used for patches meant for me to pick up from
mbox; the reason is explained in the message the cited one is in response
to.

It is an entirely different matter if such a "feature" should or should
not exist in the tool.  I do not think I would use it myself, and as I
said, I do not want anybody to use it when sending patches to this list,
but that does not mean Git should not support it.
