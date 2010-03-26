From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 16:09:02 -0700
Message-ID: <7vbpeaadf5.fsf@alter.siamese.dyndns.org>
References: <20100326215600.GA10910@spearce.org>
 <20100326222659.GA18369@progeny.tock> <20100326222950.GB10910@spearce.org>
 <20100326224038.GA18454@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>,
	mike.lifeguard@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 00:09:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvIeY-0003z5-98
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 00:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab0CZXJR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 19:09:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab0CZXJQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 19:09:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03A70A5558;
	Fri, 26 Mar 2010 19:09:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3tb/WbnZFbdl
	BoegKnqB7ffOz0s=; b=RGm+W05XL8peuxgrOItd+FGrOxFmy1Cn1W+4nogVKzWW
	SSK0SwGW6UuDZCiCeFfxH6bj8n3NKFHAUvzs3K6HrAwhuh15I1wq4gr4uKRSNWYk
	OpntYV3b4txLq120pPmilD/qzHafD171/gF1gTgXguOj3cDU17gEEFuhA1VUoog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DXMiuj
	h5xkR+b9IfOSyDMeDRBAtPOv1Wmdzzy3EBlY3hNhN4Aj2cPCpMs4cjruhHim8lff
	2Rn2qztAxm/cnS1BiIcHAlvQe8wTDgbM6DEpSDprp0kt8xexUQW+a8J8RrBQNhSG
	RWOyvPu2sJ9HSUOKaT/VzTRfh4C5nqQLBGWkM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C2A2A5555;
	Fri, 26 Mar 2010 19:09:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9292AA5552; Fri, 26 Mar
 2010 19:09:04 -0400 (EDT)
In-Reply-To: <20100326224038.GA18454@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 26 Mar 2010 17\:40\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9597542E-392C-11DF-ABE9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143297>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Shawn O. Pearce wrote:
>> Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Shawn O. Pearce wrote:
>
>>>> Any ideas?  Why is Git 1.7.0.3 jamming a leading '0' on a file mod=
e?
>>>=20
>>> See http://thread.gmane.org/gmane.comp.version-control.git/141028
>>> and commit c88f0cc (notes: fix malformed tree entry, 2010-02-24).
>>>=20
>>> The regression that that fixes appeared in 61a7cca0 (Notes API:
>>> write_notes_tree(): Store the notes tree in the database, 2010-02-1=
3),
>>> which is not part of 1.7.0.3.
>>
>> That may be true... but I doubt the tree in question was a notes
>> tree.  The path entries were names like 'README', 'modules' and
>> 'stewardbot'.  Something I would assume was the project's source
>> tree, not its notes tree.
>
> Yes, true.  The problem is probably elsewhere, especially because
> 1.7.0.3 doesn=E2=80=99t even have that commit.  Still, I find this a =
bit
> strange because such breakage should have been noticeable if it
> happens often.
>
> What has changed recently that involves writing trees?

Asking grep for "%06o" reveals nothing.  Perhaps somebody else's imitat=
ion
implementation?
