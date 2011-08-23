From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Add documentation for ref namespaces
Date: Tue, 23 Aug 2011 10:19:22 -0700
Message-ID: <7vfwksrqp1.fsf@alter.siamese.dyndns.org>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
 <1307470885-4018-1-git-send-email-jamey@minilop.net>
 <1307470885-4018-5-git-send-email-jamey@minilop.net>
 <CACBZZX4bow8vwrwSL5uRJQtAgeg10_K+5ss8u-HvCHOn3+0Tuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jamey Sharp <jamey@minilop.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 19:19:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvudN-0000aY-Du
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 19:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab1HWRT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 13:19:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234Ab1HWRTY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 13:19:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1194836BC;
	Tue, 23 Aug 2011 13:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4cYMvU8hLt9k
	UkImiVnsSBuhqE0=; b=U+tfeWguuMPwEPBMfvWp3W9BOKsFZcB2mVL7bZRjr7OT
	kK8M4RjpxoEX8YGhNvjjC45DhTdnq45BzrgghRSkCJcahKqvwWo7Jqs7kmdSKAo/
	5nMYbfhsiZ6ZPpNfXyLOq4XlchShRtL6sNAyOhdmodcPmaV/F6wf0pJJCgp5CV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nv/uWP
	newEvtU9hCkuDQaKvCrMWeW1V7Lhs60jm+kgoC03ahNmpVnHlfaFp0iVGP6eTTNF
	ALt8NMLdVlSQdW1Jf94Ikd1CfyN2BoVf9N3bbaHDVK5oKwAwPywnTQDDOFkMUt0y
	6f9ZxytlfPIMz3OexI0V+f8g5tzdcPdPXDWFs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0769336BB;
	Tue, 23 Aug 2011 13:19:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87B4736B2; Tue, 23 Aug 2011
 13:19:23 -0400 (EDT)
In-Reply-To: <CACBZZX4bow8vwrwSL5uRJQtAgeg10_K+5ss8u-HvCHOn3+0Tuw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 23 Aug
 2011 12:38:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BBA9606-CDAC-11E0-A800-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179954>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 7, 2011 at 20:21, Jamey Sharp <jamey@minilop.net> wrote:
>
>> Document the namespace mechanism in a new gitnamespaces(7) page.
>> Reference it from receive-pack and upload-pack.
>
> This breaks the build on older asciidoc versions, the fix is to do
> what I did in f5008f56d5aba06598e1c6272f4f55b4ee4bb016.

Thanks for a sharp-eye, even though I would have appreciated it even mo=
re
if you spotted it while the series was still in 'next'.

Like this?

 Documentation/gitnamespaces.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespa=
ces.txt
index ed8924e..6e03946 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.txt
@@ -5,6 +5,11 @@ NAME
 ----
 gitnamespaces - Git namespaces
=20
+SYNOPSIS
+--------
+None (this section is to only please older version of AsciiDoc)
+
+
 DESCRIPTION
 -----------
=20
