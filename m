From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: 'git add -A' can remove files
Date: Sun, 06 Dec 2009 23:34:03 -0800
Message-ID: <7vbpib9r10.fsf@alter.siamese.dyndns.org>
References: <4B1C384A.8000106@gmail.com>
 <7vr5r7el2q.fsf@alter.siamese.dyndns.org>
 <20091207005732.GA20909@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 07 08:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHY6w-0004S6-4g
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 08:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbZLGHeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 02:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758576AbZLGHeI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 02:34:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758566AbZLGHeG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 02:34:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C0216A4F2B;
	Mon,  7 Dec 2009 02:34:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sXRwdAyq+Taj
	k5kD78vI1Lgv118=; b=kcTXRJmkRrkkiQVF/Ys9vYfbtHytyuZJOlS1cK9YvN7E
	UWdcWy23I2Hkzc3BoXonsLMBUW3w9EvpHMLA7Nxm9PtrLuV5HgEs3J2AEBlNvGgt
	HM2A2DL6edNtLWd0UCcy/cDL60nZNz8fROqcFUwH+MCiegOp89qKIBc0l/prcBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g9xOXu
	yZkGRjoTFRAjYUqtbmbPeYE0ZwWz2B2G3Nmeuo9lOOlDk5PHKIxfLgkl9i+yBaB3
	HCZVRwK8gIStRoWws4DI9/39xYp/cOIxUBi5xxISlOZqv03eBkUV23vDYHNZLgwX
	dnSLeKmwEJ8KAmszW34rbVHOkjxbEX/3iJi2k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 918E7A4F29;
	Mon,  7 Dec 2009 02:34:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 56EFDA4F27; Mon,  7 Dec 2009
 02:34:05 -0500 (EST)
In-Reply-To: <20091207005732.GA20909@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Mon\, 7 Dec 2009 01\:57\:32
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E85CEE10-E302-11DE-98A1-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134720>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> What I usually say on #git is something like:
>
> 	"git add <path>" looks at the working tree to find files
> 	matching <path>.  "git add -u <path>" looks at the index, and
> 	"git add -A <path>" looks at both. Therefore "add" and "add -A"
> 	can add new files to the index, and "add -u" and "add -A" can
> 	remove files from it.
>
> 	And for convenience, -u and -A default to "." as the path argument.

Hmm, an interesting way of teaching. How effective is it with the real =
new
to mid-level users we see on the #git channel?

> So maybe something like this?
> ...
> -A, --all
>     Like -u, but matches <filepattern> against files in the index in
>     addition to the files in working tree. This means that it can fin=
d
>     new files as well.

Sounds easier to read to me but I think this description of "-A" seems
backwards from your explanation.  "Like -u" means "matches the index" a=
nd
the difference is it in addition matches with the work tree, so it shou=
ld
probably be the other way around, i.e.

     Like -u, but matches <filepattern> against files in the work tree =
in
     addition to the index. This means that it can find new files as we=
ll.
