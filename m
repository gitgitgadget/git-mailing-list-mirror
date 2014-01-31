From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: don't complain when adding empty project root
Date: Fri, 31 Jan 2014 10:10:09 -0800
Message-ID: <xmqqppn8ggzi.fsf@gitster.dls.corp.google.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
	<1387789361-29036-1-git-send-email-pclouds@gmail.com>
	<52B87759.2090901@web.de>
	<CACsJy8A7j_ERqH_TDuKDdssaLFCvM5yVT4eUjTqkN_qW4iXuGA@mail.gmail.com>
	<52BA0110.4050003@web.de>
	<CACsJy8ApEBq+G+swpBPPJwL1E94x-P+e+V_jYknG+rXybLxPgQ@mail.gmail.com>
	<52EA3A07.2090203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 31 19:10:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9IXq-0008C3-9a
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 19:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbaAaSKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jan 2014 13:10:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170AbaAaSKV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jan 2014 13:10:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90AF567C86;
	Fri, 31 Jan 2014 13:10:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vTW9hSFXWqHn
	uz0fk7g/mz0nqvE=; b=t4DuKgk2sRZqIwiuQ/qiQ0sKLlQIVcbJDGTgoRgA1aa8
	zuWQz6/lJ8ohyYmQu7T4NCasCdrh4bdPe1efClaq/V51bHDqBSsrZ8Iyi/Yw6M1n
	Ia+GnMPzRBQRqe6NIaAwtWIHaA2vz9Fhu9ABFiDfVuWHDXZ/atfqG1gLxoZz1YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gVzR6d
	3Lb5rs54kVYD20KyTolnUAMwFYFqWfV1Q/eoUqH5VmuUIEU2YthnfKlcHdKSxzWo
	ytZ9IGTMd8Z5TKXc8Jv6DlQa2vrYEIcC8mEavcZeqBvpHA/DvRJ9qIrOe724w70T
	FBg8yMF5hQ4OGMLZgmURVP86Q9/VoA44UQXc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B79F667C85;
	Fri, 31 Jan 2014 13:10:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9CBB67C7C;
	Fri, 31 Jan 2014 13:10:13 -0500 (EST)
In-Reply-To: <52EA3A07.2090203@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 30 Jan 2014 12:39:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EE5DFBE6-8AA2-11E3-8B75-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241312>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> But, look at
> https://www.kernel.org/pub/software/scm/git/docs/git-add.html
>
> This page seems to need an update too, and I wonder why:
> a) The makefile did'nt re-generate html even if it should have
> b) That page is not owned or updated by the git.git maintainer
> c) Any other reason?

Sorry, but if I understand correctly, k.org these days requires each
file to be GPG signed and uploaded individually (i.e. there is no
way as far as I can tell to say "here is a tarball, and I've even
signed it with my key to convince you that it is from me. Please
accept it and then unpack the contents there").  There is no way I'd
do that every time I update git-htmldocs repository for 500+ files.
