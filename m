From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Port to QNX
Date: Sat, 15 Dec 2012 10:38:30 -0800
Message-ID: <7vy5gzrwih.fsf@alter.siamese.dyndns.org>
References: <1355510300-31541-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:38:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjwdP-0000Nz-2h
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab2LOSie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:38:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab2LOSid (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:38:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BFD7A037;
	Sat, 15 Dec 2012 13:38:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RnG5tbVIHrFJ9PCx16e9wTKxsXs=; b=nSWNhQ
	809PEPux9v8PedWdxqHDZSPSySZbUFofcHPj5w8pG4cbpoCvDo7m+jEAzJqS3DIO
	vwcFwSy0g7kknpyEXlVHPcteMM4OsubY1BKd42Z2xhGeq6PHjzf5kldSWCt//Xgu
	3hODuuYdsGTDP8228kIBOdaNotYXLY0yh03Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dzdZKmP71VgNdIlXxJOuzK9dPZCBDRWk
	EAgpfHmeIvcCzBiCBzZU2QmHi9twbEWAMzQxqs7oYBd/HhVLtBpmN425+QcI885r
	KnnSEin2MZ/DAkQHIWh9co+pkwXJah9HqYI8E53WGb/2W6czsYMmw3e4Nlvyiv5P
	xsGZD55GHr8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18D69A036;
	Sat, 15 Dec 2012 13:38:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C388A035; Sat, 15 Dec 2012
 13:38:32 -0500 (EST)
In-Reply-To: <1355510300-31541-1-git-send-email-kraai@ftbfs.org> (Matt
 Kraai's message of "Fri, 14 Dec 2012 10:38:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0A046EE-46E6-11E2-9831-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211556>

Matt Kraai <kraai@ftbfs.org> writes:

> This series ports Git to QNX.  It builds on both QNX 6.3.2 and QNX
> 6.5.0.  The test suite does not pass.  Unless the corresponding
> software is installed, the following arguments must be passed to Make:
>
>  NO_CURL=1 NO_GETTEXT=1 NO_OPENSSL=1 NO_PERL=1 NO_PYTHON=1 NO_TCLTK=1
>
>   [1/2]: Make lock local to fetch_pack
>
> QNX 6.3.2's unistd.h declares a function named lock, which causes
> fetch-pack.c to fail to compile if lock has file-scope.  Since it's
> only used in a single function, move it therein.
>
>   [2/2]: Port to QNX

I do not mind queuing this on 'pu' but do you want to see your
ftbfs.org address in the commit objects, or the other one that you
are not using to interact with us?
