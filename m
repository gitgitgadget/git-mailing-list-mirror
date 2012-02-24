From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git compiled on same distro, different versions
Date: Fri, 24 Feb 2012 14:08:23 -0800
Message-ID: <7vboonhoko.fsf@alter.siamese.dyndns.org>
References: <ji8u2f$gml$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 23:08:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S13JW-0002OT-IL
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 23:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab2BXWI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 17:08:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab2BXWIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 17:08:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D711B79B4;
	Fri, 24 Feb 2012 17:08:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PJUIiE8WTngvcyOnFmImENqWb3k=; b=yBO6mw
	bqQYRLA7Ds/ALaWw8D6REiD+WLGfURJunHvwLSRo3w4Ynm9vh2HJUT2M8lNzT8II
	7I0E274UnKNPI43/uKuLfHVmr2e9/YWgqYcyPT+zTpUwutClGyGo7JFTXXmEhDH/
	qmWLlRfDdJXmwcAoAFLuJsBaPddikDlN3RSAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BmJ0y6v8xyo47nm2V/KyvYYAdXaPyl32
	XW5m41lOh9/auEm4VM97g58BGWYXbtzdH7AOt1aXc+LnWNYSVL7yYYwjlAmiLSPm
	geM1ohHzW4mHFRCPbr1KglFWSlfLv9HPPLroBQQKCEvAPTl9X4y/UVXD8jkAOYDf
	CijZriySVbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CED6979B3;
	Fri, 24 Feb 2012 17:08:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67E1679B2; Fri, 24 Feb 2012
 17:08:24 -0500 (EST)
In-Reply-To: <ji8u2f$gml$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Fri, 24 Feb 2012 15:05:21 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12188890-5F34-11E1-9426-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191493>

"Neal Kreitzinger" <neal@rsss.com> writes:

> If I only test a new git version (compiled from git.git source) on RHEL6 
> before I put it on the RHEL5 box is that sufficient for validation?  Should 
> git behave the same on both?  If not, why?

I somehow find this a strange question to ask to Git people; you may have
better luck asking the question to RHEL folks.

Having said that, one of the reasons the result may not work, off the top
of my head, is that the binary you compiled would expect to link with the
system libraries that are available on your RHEL6 installation.  If your
RHEL5 installation does not have a matching and ABI compatible library to
any of them, the resulting binary would obviously not work there.
