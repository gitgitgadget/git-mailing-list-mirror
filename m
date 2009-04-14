From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3 08/13] send-email: Remove superfluous `my $editor =
 ...'
Date: Tue, 14 Apr 2009 01:51:35 -0700
Message-ID: <7v3acb7h48.fsf@gitster.siamese.dyndns.org>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
 <49E3CD48.1010809@gmail.com> <20090414061645.GB3948@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 10:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LteOP-0002tP-NN
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 10:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbZDNIvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 04:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbZDNIvq
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 04:51:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZDNIvo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 04:51:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CC22E9EA;
	Tue, 14 Apr 2009 04:51:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 357CEE9E5; Tue,
 14 Apr 2009 04:51:38 -0400 (EDT)
In-Reply-To: <20090414061645.GB3948@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Tue, 14 Apr 2009 08:16:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A3C39B8-28D1-11DE-AF00-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116529>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2009.04.13 16:39:52 -0700, Stephen Boyd wrote:
>> Michael Witten wrote:
>>> -	my $editor =3D $ENV{GIT_EDITOR} || Git::config(@repo, "core.edito=
r") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
>>
>> I don't want to start an editor war, but why is 'vi' here? It seems
>> that one of the previous four should be set at all times, correct?
>
> Probably because that's how the rest of git works, too. See core.edit=
or
> in git-config(1) or launch_editor() in editor.c if you don't trust th=
e
> docs.
>
> Oh, and I seem to rely on that behaviour :-)

The git specific parts are obviously our invention, but $VISUAL then
$EDITOR and finally as the last resort falling back on vi has been a
longstanding UNIXy tradition that is shared by many tools.
