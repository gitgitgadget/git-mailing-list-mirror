From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] check_everything_connected replacement
Date: Mon, 01 Apr 2013 07:48:53 -0700
Message-ID: <7va9pil31m.fsf@alter.siamese.dyndns.org>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 16:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMg35-0006C9-O8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 16:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758344Ab3DAOs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 10:48:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab3DAOs6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 10:48:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1A2D11BD6;
	Mon,  1 Apr 2013 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=608rsg+DFPxY
	VrKOY8wb2lPqm1w=; b=nF4t43wbY50WBKFHvwD5nV4mQWshFVM7pLJ8/Z7P6w8X
	hMcDB2e5MrU/aiMXdbcs2pvgcVNhNqSWR5j3KAaquSloKkrmihE6pd1/ONHd2rU8
	qXEupQY/6FARYid7ekA4qn8+LJsB4W7W6QjrEuCgmFpT8+hdObsTByRmt2UaOV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Oz8aQb
	TUHvjg/zEvN5xOSFyAaWQxxBOczD4KtRjZraJiaFDdek2kVGeTQ72O1OwfICaQ6Z
	lZP9Rq/QCVbECCU14eJukBh7bBSM6EQowCn3KgAUx8uOprwUlqkpfsfI26k456Da
	exAGnAwgnWILEX2n55v3BtmY3qqV8KJTvlBSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B641111BD5;
	Mon,  1 Apr 2013 14:48:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CA4611BD4; Mon,  1 Apr
 2013 14:48:55 +0000 (UTC)
In-Reply-To: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 31 Mar
 2013 18:09:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46E6A352-9ADB-11E2-9EF5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219687>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The last use of check_everything_connected after this series is
> fetch.c:quickfetch(), which I think is unnecessary. It can only catch
> errors if we have incomplete object islands in repo, which could
> happen before this series.

A typical source of object islands the quickfetch() was designed to
protect against is the HTTP walker.  I do not think your patch adds
any safety in that area (nor it should).

> After this series, incomplete object
> islands can't enter the repository, at least via git transport.

Exactly.
