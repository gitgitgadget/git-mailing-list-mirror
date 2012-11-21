From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/15] fast-export and remote-testgit improvements
Date: Wed, 21 Nov 2012 11:05:58 -0800
Message-ID: <7vtxsi22g6.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s3h5+KS3ixoLkJeiS+n_neBV-Dyj=Cww0ZrU6UKsNxphQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFlH-0004bT-4n
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab2KUTOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:14:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755784Ab2KUTOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:14:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43F839661;
	Wed, 21 Nov 2012 14:14:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=hnPemHJXevnZ8skta5wAVyjF2PU=; b=PwOlYWFl/YuH9PdwdI0L
	vgKgU5abAHzMsLtbD1weUO5FLOSrNFyMJOuCYgXK4kRC2O4P6x/n7gsBlxKc5D5K
	pEtbFH5THbzAVeSa3MDsViReKwt3DOAmIZ+foT5aVwhakZ0/NjHLlamfjGSK6bAo
	RV9z3TLJ+R1ZocS/Jn2O6yA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aZiT6RBi4UxPNEjW7ocosxEUPy9E8lFySaYtn3WMZ7c7ej
	AiIMljcXoDPC4pKavaV1PAbp+DnMeh+ofEdfgWa7R0h5KkkKTJjbK5Wqo7yzFsBO
	1/CDKIkQ2Cqme1UXrR9MD9I7X4JNVMBv4SW0PqYXLKudUG1DOq21x8TelJ5x0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3027D965F;
	Wed, 21 Nov 2012 14:14:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80449965D; Wed, 21 Nov 2012
 14:14:34 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF5BFE7E-340F-11E2-98AC-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210157>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Nov 11, 2012 at 2:59 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
> Since these are having some problems getting in, let me point out
> which I think are important, and which not.

I finished reading the series, and found them mostly sensible.

I'll send out comments on individual patches, and will push them
out, interspersed with "fixup!" commits, later on 'pu' when I am
done for the day, perhaps in 7 hours or so.

There is one thing I am not sure about with this series, though.

I can agree that the updates to fast-export will make remote-testgit
script work better, but I cannot tell how big an impact the changes
will have to people's existing use of fast-export.  Some of them may
be relying on the current behaviour (in other words, they may be
relying on "existing bugs"), which may mean that this series will
bring regression to them.  I am still open to reasonable objections
along the lines of "This script X uses fast-export and is broken
when used with the updated behaviour." if there is any.
