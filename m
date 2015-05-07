From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/12] t5520: implement tests for no merge candidates cases
Date: Thu, 07 May 2015 07:04:57 -0700
Message-ID: <xmqqh9roscty.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-2-git-send-email-pyokagan@gmail.com>
	<554B2AEB.3020608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 07 16:05:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqMQF-0002yJ-0v
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 16:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbbEGOFC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2015 10:05:02 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750863AbbEGOFB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2015 10:05:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E35274CF9A;
	Thu,  7 May 2015 10:04:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xr8DJUfHywMX
	SSsfIJw+5Iyj74Y=; b=JIhxBkMoDOULgzzE/mu7d+DmxRm3ehBVf/xHCjJU/GK5
	6g6SFeFmT/x6ohGXvdb+QPb0+oQi6e6wGih048oP6hh02Q6LerrRgSePQKNKaTm/
	R4HKCQ0Yj0ABI8KZwuCAPZ9sc5gT5PiApPPpytQ46DBgTLFlnmVlqjf7j4XVktw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=W+X52z
	coM3wKuaE0LY5Gr0MLoaXFBYVA5MHcT1ZW5IvotD5FrRBIZ9cM5p4jwFkp0sSxh8
	g3VWmY4oAYhbbzxtKC45wBTy/TR0rg+7ELbJHN9t4UlIMojPgP6T3zcs8/qhljDn
	jGMDSjEZZDFy76zeuMRMD2bxyhYP3qDum51+U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9F5C4CF99;
	Thu,  7 May 2015 10:04:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00DF54CF95;
	Thu,  7 May 2015 10:04:59 -0400 (EDT)
In-Reply-To: <554B2AEB.3020608@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 07 May 2015 11:05:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C0B80A2-F4C2-11E4-A1A7-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268531>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> In other words:
> test $(cat file) =3D file &&

Is there a guarantee that file has a single word?  Can it be empty?
Can it contain "foo bar\n"?
