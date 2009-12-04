From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Fri, 04 Dec 2009 14:29:44 -0800
Message-ID: <7v4oo6l6ef.fsf@alter.siamese.dyndns.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <6672d0160912041419s2cbcb8ech49f69250b99386ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 23:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGgfE-0001aS-Gc
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 23:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbZLDW3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Dec 2009 17:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757435AbZLDW3v
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 17:29:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603AbZLDW3u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 17:29:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53548A4FA5;
	Fri,  4 Dec 2009 17:29:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=y95xiKF8pJDx
	QUNwSMJht4f0vNk=; b=iTHXFhHpZSSMjolHELiAejTA/fVOjlrVN/SnACnFnE1+
	U1iD6sNffsadrIr7IJGSfOn1adwtDizh4oP4lqVckF9+UsPFpKxp0WWu5tN8i5sU
	iyJ7FcPbhglOU3Z9fR5wIaxeIS/X1bcIrjc+7i8VOKUh1yEsafsnNyxD98q+ZZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kuDy0h
	KVgtzlOOQDynCD5VUGOJuodc08GylhKYRgj9N4grvYyrx4Gkgmn1eRgHSjv/IL50
	DZklykfjZGDRW+DEKrwC+4ZgixnoFlP/jx6RvEqkrGjwWvcbbidjMHcFp+nnYJ29
	+uJJANW7QeAd9VC30TugpeQmiUHaY7dbdiBPk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1286FA4FA2;
	Fri,  4 Dec 2009 17:29:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7DC5BA4F9E; Fri,  4 Dec 2009
 17:29:46 -0500 (EST)
In-Reply-To: <6672d0160912041419s2cbcb8ech49f69250b99386ae@mail.gmail.com>
 (=?utf-8?Q?=22Bj=C3=B6rn?= Gustavsson"'s message of "Fri\, 4 Dec 2009
 23\:19\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A2330D2-E124-11DE-B59A-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134581>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> On Fri, Dec 4, 2009 at 3:36 PM, Michael Haggerty <mhagger@alum.mit.ed=
u> wrote:
>
>> If the idea of a "fix" command is acceptable, then I would like to
>> implement a further convenience: if a group of commits to be folded
>> together includes *only* "fix" commits, then the first log message
>> should be used without even opening an editor. But I would like to
>> get a reaction to the "fix" command in general before doing so.
>
> I would really prefer that the editor is not entered at all if there
> are only "fix" commands in a group of commits to be folded.

I think all of these ideas were already discussed in the earlier thread
from mid June this year, so I do not think there is no need for any mor=
e
"me too like it" comments to show the support for this feature, unless =
it
adds any new ideas of value.  I think "fixup and nothing else shouldn't
open editor" and "an option to pay attention to specially marked commit=
"
are good ideas but they both appear in the old thread already.

IIRC, the end result of the bikeshedding for the name of the command wa=
s
won by Dscho's "fixup":

  http://thread.gmane.org/gmane.comp.version-control.git/127923/focus=3D=
121820
