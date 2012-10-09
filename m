From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git ~unusable on slow lines :,'C
Date: Tue, 09 Oct 2012 09:46:23 -0700
Message-ID: <7vd30rh9uo.fsf@alter.siamese.dyndns.org>
References: <50731B2A.6040104@gmx.net> <87lifgct3j.fsf@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcel Partap <mpartap@gmx.net>, git@vger.kernel.org
To: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
X-From: git-owner@vger.kernel.org Tue Oct 09 18:46:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLcx3-0007v3-1X
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 18:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab2JIQq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 12:46:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978Ab2JIQq0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2012 12:46:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3FFA9B48;
	Tue,  9 Oct 2012 12:46:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O6Q8Zj3d2mn0
	mPYprZOtnQKyat4=; b=nkAOh4rDV2QnUL258rphy84zQUmGxCwi9xKng+3MR0AC
	DnhZtQ4jsk3BMf9xQ2tfE2bea+IXDlED9hW8llQ2vv1cmDZsk4E/6dhJ9ivSpS5b
	54EBgb+HcJuTQQicqLEXsrdP7sLkslIJPBXfbqKe6pGZ1EkVgoSZo+X/CuOUtZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D+sglr
	5pua3eH3TWIkRtqxIYEx9xKLFPE7PoQ/71tQL82G3tnmJ+Q2QDujUy0nahW0NX34
	agbyjZQ95eadoKzqtfDrYEZBiThXc1VW26E0JZ6Rga7oreqLGXGaeeQ5yZX2UEKo
	vZ3dZTON51hopFcJOlNCnbHcGLGj1UndU00l0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92DC79B47;
	Tue,  9 Oct 2012 12:46:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD2F89B46; Tue,  9 Oct 2012
 12:46:24 -0400 (EDT)
In-Reply-To: <87lifgct3j.fsf@centaur.cmartin.tk> ("Carlos =?utf-8?Q?Mart?=
 =?utf-8?Q?=C3=ADn?= Nieto"'s message of "Tue, 09 Oct 2012 03:49:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCF25E74-1230-11E2-83F7-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207327>

cmn@elego.de (Carlos Mart=C3=ADn Nieto) writes:

> If you want to download it bit by bit, you can tell fetch to download
> particular tags. Doing this automatically for this would be working
> around a configuration issue for a particular server, which is genera=
lly
> better fixed in other ways.

As part of an upcoming "protocol update" discussion, we may want to
include allowing "upload-pack" to accept a request for commit that
is not at the tip of any ref.

E.g. "want refs/heads/master~*0.1" might ask "I know your entire
history is very big; please give me only the one tenth of the oldest
history during this round." (this is not a suggestion on how to do
this at the UI level).
