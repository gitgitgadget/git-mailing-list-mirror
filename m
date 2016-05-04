From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Splitting a project into branches afterwards
Date: Wed, 04 May 2016 01:23:26 -0700
Message-ID: <xmqqoa8mi64h.fsf@gitster.mtv.corp.google.com>
References: <loom.20160503T090745-628@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yohann =?utf-8?B?QsOpbsOpZGlj?= <yohann.benedic@orange.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:23:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axs62-0000FL-OF
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbcEDIXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 04:23:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756941AbcEDIX3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2016 04:23:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B88A1212F;
	Wed,  4 May 2016 04:23:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6ds04QHFz32J
	sth5oSUEwBRymcc=; b=PybKNEwrFtfKXk+iuh3MboxHqflGQw/H5yKHen89m1J6
	vAlIWVZsNB0laux7outbPTh5XVnG4LhpwDbi/HRotEO9FvGFmg+bvnLdogXndAfM
	IVTgQANhTTYVuf3G/qIkp7SA0OWFJVnrvipBWQCQrRbosvGAP8SQghvWRh2Ixx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fb7gkK
	R+pnN/LFEcvGxnPs5UdvMCznz43FOIY6E0x31a1ep1BxQwcdZN9UYMbfyqSMj0gM
	aWJ3s4usag80ErrPBqybpqphDE1VD93QKdPz58Pd1KZ6qg3hwyMPVNxRcQUu/JPp
	zhcJzGSs9fNOIfeBoAjnBrsTemojhKH7rFwEs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F8E21212E;
	Wed,  4 May 2016 04:23:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A326D1212D;
	Wed,  4 May 2016 04:23:27 -0400 (EDT)
In-Reply-To: <loom.20160503T090745-628@post.gmane.org> ("Yohann
 =?utf-8?B?QsOpbsOpZGljIidz?=
	message of "Tue, 3 May 2016 15:20:44 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A2A4F96-11D1-11E6-9548-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293516>

Yohann B=C3=A9n=C3=A9dic <yohann.benedic@orange.com> writes:

> branch. If the framework branch moves forward, I want my product_A br=
anch to=20
> be able follow along : that's a merge of the framework from product_A=
=2E In=20
> product_A, I might fix something from the framework and need to patch=
 the=20
> latter. That's a merge in the other direction.

Instead of doing a mixed ball of wax on product specific branch,
can't you do the latter by (1) fix something that belongs to the
framework part of the system on the framework branch, (2) merge that
to product A branch, and then (3) use that fixed framework code to
update the product A?  That way you would never have to merge
product specific part to the framework, which is meant to be product
agnistic (which is the whole point of your "initial removal" done on
the framework branch, if I am reading you correctly).
