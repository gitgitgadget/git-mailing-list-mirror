From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Continued work on sr/vcs-helper and sr/gfi-options
Date: Sun, 06 Dec 2009 15:36:24 -0800
Message-ID: <7vfx7nekuf.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e0912051653s77ba25e1g9ff1e21219cd06c9@mail.gmail.com>
 <7vr5r8oov1.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0912060223h148a67b0q589b8461dae6330e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 00:36:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHQec-0001ps-2e
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 00:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757815AbZLFXg2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 18:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757809AbZLFXg1
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 18:36:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757790AbZLFXg0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 18:36:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D61AA42D4;
	Sun,  6 Dec 2009 18:36:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OxRhWwvrLDqK
	Tescv8WzWMRo7VY=; b=sWI5DP7YilnqUXqHoQMqCLxFS4mjTrkLQZeuCiVEzjE8
	O9aS60ZJ8o5Xfdey6W5BRqyD2dqyInKmgDxGOVJPS6BOETkBjqgO+edLfXcoiHca
	h0ve/93IN9eIEFuoSHmmuFpSB+nOheDc0AVw2bvESfkjnhO4MxjUXG58GDfDze0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rAhhC1
	7YpHOtITHNtkkk/BNc3GvxBq7nc3eEbuCgWUaacfp7PdTiGd4YQhxS3rVMqh1RfB
	OxdmOBPATzNDRhB49iBQQKkY+sQwpni33kY6yuHKnZAPkJA1l2vChLigfSK88kyg
	9HlBo385YezcxAK79raTws8/1pA7Te/v1l16w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 298DDA42D3;
	Sun,  6 Dec 2009 18:36:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2A54EA42CE; Sun,  6 Dec 2009
 18:36:25 -0500 (EST)
In-Reply-To: <fabb9a1e0912060223h148a67b0q589b8461dae6330e@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun\, 6 Dec 2009 11\:23\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D6B02BE-E2C0-11DE-A382-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134694>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> =C2=A0- Merge today's 'master' to sr/remote-hg (optional);
>
> I'm not sure why this is though? (no objections against it, I just
> don't understand the motivation)

It would make sense if you use 1.6.6 features in your new series (as th=
e
forkpoint of sr/vcs-helper is beginning to look a tad stale), but
otherwise unnecessary; that is the reason why I said it is "(optional)"
and it is up to what is in the remote-hg patch.

>> =C2=A0- Create an unstable sr/pu-remote-hg branch that:
>>
>> =C2=A0 - is reset to the tip of sr/remote-hg at the beginning of the=
 day;
>> =C2=A0 - merges the day's sr/gfi-options on top;
>> =C2=A0 - re-applies patches to implement Hg interoperation on top of=
 the
>> =C2=A0 =C2=A0 result.
>
> Ok, that does make sense, how would I send out patches for review fro=
m
> this unstable branch though? (since others would not have the require=
d
> merges etc) I reckon it would be necessary to publish sr/pu-remote-hg
> somewhere?

I was thinking about carrying it myself (perhaps with help from you in
conflict resolution as necessary) when I wrote it, but if you want me t=
o
pull from your repository somewhere e.g. repo.or.cz, that would also be
fine.
