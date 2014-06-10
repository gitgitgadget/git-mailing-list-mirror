From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] t9001: avoid not portable '\n' with sed
Date: Mon, 09 Jun 2014 22:55:43 -0700
Message-ID: <xmqqk38pb95s.fsf@gitster.dls.corp.google.com>
References: <5396849F.7060206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 07:55:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuF2I-0005Ie-0S
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 07:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbaFJFzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 01:55:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59532 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbaFJFzt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 01:55:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 17F33101EF;
	Tue, 10 Jun 2014 01:55:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PBySBr0flahE
	+t97xR35dNReQSs=; b=MI9aqM3vBIa9NDQwTokkOukFx9+zgo5SvvXLfSjl4jDN
	P/0pe0xvIFIm0IdjNsZFVubA7CsTnvgTlzM0zPL3NhwkICeJpI5V82JXxJvfVFuC
	ERnIn0l/Oi0OVX8nGec82gSo9MW6FTBLmhbdGr5P7L8VF2Krsgmb1GFebv0GqpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kM6gXJ
	heo7K9NBDrj2shQHi+VHx1f0DI4aYpBWOHk2B+KT84Wrh9KcmGDH5LsNd4f147g1
	M9EghKbFXsVxrgOX9L+DAkbg1n91h8bjrsdlGXJJqjHam937KXDNo2tvfG0MzClz
	F4f4eIvw808MZ8ea8V2+tlx0iyBx/gn2MZhGA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F3B9101EE;
	Tue, 10 Jun 2014 01:55:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 25FCB101E9;
	Tue, 10 Jun 2014 01:55:45 -0400 (EDT)
In-Reply-To: <5396849F.7060206@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 10 Jun 2014 06:07:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DD0320DE-F063-11E3-A09A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251163>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> t9001 used a '\n' in a sed expression to split one line into two line=
s,
> but the usage of '\n' in the "replacement string" is not portable.

This looks peculiarly familiar; don't I already have it queued?
