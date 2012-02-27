From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Perform cheaper connectivity check when pack is used as
 medium
Date: Mon, 27 Feb 2012 10:14:07 -0800
Message-ID: <7vmx849ma8.fsf@alter.siamese.dyndns.org>
References: <1330357191-32011-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:14:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S255U-0001lJ-3t
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab2B0SOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:14:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444Ab2B0SOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:14:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2C7576B0;
	Mon, 27 Feb 2012 13:14:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gdc2/NjBLZknSByjz/apFTOVi9I=; b=gYwZnT
	f6ZuZivFqqmY9ulTVYeN+eACoUdS0FDWCP+1lmmnZn5tpQJuZvj4vHTOcQ6gAp7d
	yEvOHUlgdOY4icxi1jlBWU9/aFfr9VRKp3QSWqEyVsf+s7bECqcgAihqoneL+Z1s
	bq2pHeLTiiBeXMdjm+/6yvmNvPPTJJiggmu9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m3rCXDsTOIHHt49UDlCE02H6GvktpZsP
	TIOnnJRrkHHQNMPXex0UdCAowg/mYiYtapLBsceh85t3EXZq56jqChGW2K9gYxLF
	EWUW+c6f+E4Qeun9G8CemVIcHffJeiRFY7HpFpEf357m4tPEGTILolseYy/7zMVy
	T+gh6Vc69II=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA1D276AF;
	Mon, 27 Feb 2012 13:14:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62A5276AE; Mon, 27 Feb 2012
 13:14:09 -0500 (EST)
In-Reply-To: <1330357191-32011-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 27 Feb
 2012 22:39:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7E3B13A-616E-11E1-98B6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191641>

Please turn the existing "int quiet" that carries only one bit into a flag
word, instead of adding yet another int that is only used for one bit.

Other than that, the idea/approach feels sound.

Thanks.
 
