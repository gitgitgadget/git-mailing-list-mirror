From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 4/4] Add documentation for ref namespaces
Date: Thu, 15 Sep 2011 17:22:29 -0700
Message-ID: <7vaaa5pc8q.fsf_-_@alter.siamese.dyndns.org>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
 <1307470885-4018-1-git-send-email-jamey@minilop.net>
 <1307470885-4018-5-git-send-email-jamey@minilop.net>
 <CACBZZX4bow8vwrwSL5uRJQtAgeg10_K+5ss8u-HvCHOn3+0Tuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Fri Sep 16 02:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4MCV-00023p-Pa
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 02:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795Ab1IPAWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 20:22:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab1IPAWd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 20:22:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E92E546F;
	Thu, 15 Sep 2011 20:22:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8Sflg8VDmJBl
	q4jR7UFd7ZKUf3w=; b=wkmn4nB8CK27bWye2PyHu4NS+RBbruFhCPk6JymXAG6p
	UDtAPRFAZFSHn1fh7Y4+NqWCMR7eSj2CjKLVDuiXQzN4SfM+QLVnI2VBSAtlF818
	FW+xMOq3qh8UEy+p/SsAdVmbfusGf4ndUNGQxhEaYYv7/s7KEGaJt6NJXH/YlMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gBxp9B
	OWrDNXmNeYc08KIoQulRo9Qfmq3Di1Wg6yKdEXBvwlPvaM1/4gLt/aHarwQnRD9V
	Wey7soSj/IEijYr2y0y7LVe0v3crfsRYUhKVXCsprN27PxPxl6VkYIlVkJxZct41
	SmuoxwRXOQrNqoVPGWQVpGhkIvnDf+ORTgb0s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A72546E;
	Thu, 15 Sep 2011 20:22:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D6E0546D; Thu, 15 Sep 2011
 20:22:30 -0400 (EDT)
In-Reply-To: <CACBZZX4bow8vwrwSL5uRJQtAgeg10_K+5ss8u-HvCHOn3+0Tuw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 23 Aug
 2011 12:38:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7002D6A-DFF9-11E0-A411-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181522>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 7, 2011 at 20:21, Jamey Sharp <jamey@minilop.net> wrote:
>
>> Document the namespace mechanism in a new gitnamespaces(7) page.
>> Reference it from receive-pack and upload-pack.
>
> This breaks the build on older asciidoc versions, the fix is to do
> what I did in f5008f56d5aba06598e1c6272f4f55b4ee4bb016.

Earlier I sent out a tongue-in-cheek "like this" that had a completely
bogus SYNOPSIS section that is unusable in a released version of Git,
hoping that somebody who _care_ more about the feature that the page
describes would give us a better wording, but unfortunately it never
happened.

So here is a more realistic replacement, so that we won't have to suffe=
r
by complaints from people with older AsciiDoc saying "the release does =
not
build". If we were to include this in 1.7.7 final, we now need to make
sure we won't to have to hear from people with newer AsciiDoc saying "w=
hy
do we have nonsense in SYNOPSIS section", so your help is needed here.

I explicitly avoided saying:

	[verse]
	export GIT_NAMESPACE=3D<namespace>

as nothing other than the selected transports seems to pay attention to
this environment variable.

-- >8 --
Subject: [PATCH] Documentation/gitnamespaces.txt: cater to older asciid=
oc

Older asciidoc (e.g. 8.2.5 on Centos 5.5) is unhappy if a manpage does =
not
have a SYNOPSIS section. Show a sample (and a possibly bogus) command l=
ine
of running two commands that pay attention to this environment variable
with a customized value.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitnamespaces.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespa=
ces.txt
index ed8924e..c6713cf 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.txt
@@ -5,6 +5,13 @@ NAME
 ----
 gitnamespaces - Git namespaces
=20
+SYNOPSIS
+--------
+[verse]
+GIT_NAMESPACE=3D<namespace> 'git upload-pack'
+GIT_NAMESPACE=3D<namespace> 'git receive-pack'
+
+
 DESCRIPTION
 -----------
=20
--=20
1.7.7.rc1.3.g559357
