From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #04; Fri, 12)
Date: Fri, 12 Apr 2013 15:56:06 -0700
Message-ID: <7vr4ifbbp5.fsf@alter.siamese.dyndns.org>
References: <7vehefctrf.fsf@alter.siamese.dyndns.org>
 <51688AF8.3010200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 00:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQmtT-0008Br-N6
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 00:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758748Ab3DLW4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 18:56:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab3DLW4J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 18:56:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6E5916E17;
	Fri, 12 Apr 2013 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Rb1xFVP1PqWV
	Nu4V1j5etGTeQmo=; b=s41O5BbVLx/5AvRcGwo22IzGU+5kx9o7zHsqw8Gzx/Id
	zf5W3QcGG7mhIJ5eFRbJCQMCcQHnohsTKwvM6kxx81wIzuW+r5KlYL6UeqQBqIQ7
	NBBChgX/+h2X4VYnYMEV4OrJUgdfvIsGeqwGbO1GV3OjW+ZTfAxVoLOVObBvgeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o1rOic
	Gl1/bMgos2ZWRiCcU/xt1PAyU8zTMPu/IqRA/FpVCN5JeDm2REMb1P+anh8lfXJe
	EvlMe6f3ye8xl+0Esjs2gSf5kwgStiBOkYOzUouDaG9SJ+8/DFj2QSkby8qNsV7Q
	4eqtmCMXNEEUBSFhRT4RTqU+H4gZtEfxgZrlM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DDBC16E16;
	Fri, 12 Apr 2013 22:56:08 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1949716E15; Fri, 12 Apr
 2013 22:56:08 +0000 (UTC)
In-Reply-To: <51688AF8.3010200@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Sat, 13 Apr 2013 00:30:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2995EC1C-A3C4-11E2-9A97-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221036>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> So mc/count-objects-kibibytes is to be discarded, or merged to 'maste=
r'?

I asked for opinions, not questions ;-)

I am on the fence, but slightly in favor of dropping it.

I suspect some scripts will get unexpectedly hurt, just like we had
to patch cvsimport.  Among the human users who deeply care about the
output between "kilobytes" and "KiB", nobody would want "684322 KiB"
the "kibibytes" topic would give; people who care will likely to use
"-H" to obtain "668.28 MiB" instead.
