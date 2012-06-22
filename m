From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFE] option for find branches in a remote repo which contain a
 certain commit
Date: Fri, 22 Jun 2012 11:14:59 -0700
Message-ID: <7vtxy3p61o.fsf@alter.siamese.dyndns.org>
References: <CAKkAvazNqZWk=QRmSFsFL33M6z+nZZ_yyxxbxwAh=fQk5DVt-Q@mail.gmail.com>
 <CAKkAvazRfb0kTphLKoRQxSEBZwHfVZeaM0xEbcxEw7Mt5RMg8A@mail.gmail.com>
 <CACBZZX6nbWCFWWy5NTMSAPOf4RHUAbC9TuffPPy=2Ehn7KSnaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ryenus <ryenus@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 20:15:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si8O0-0005fR-9B
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 20:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab2FVSPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jun 2012 14:15:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53371 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab2FVSPE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2012 14:15:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4623A7C99;
	Fri, 22 Jun 2012 14:15:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GbdUNkTI2E8I
	QFUrtgsQMzIEMYM=; b=hlwbBErsQs+ds0YNE4uXThcPbk57u7tcOT9aWXW47afT
	nYbwN5dns6r+HChVJJawUqbqYvI8ai9Vo0vAtQWqQaOtGL2cxbQayHar9h7U6d0t
	SgtJshYtAmn2wVVr/MiSPQq+4gAoLBigpipFVC+Mo6UwNQzdiFv97C8qRqVPzmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S8vShH
	0QNcty/IkAmiioOaAKcOTvu7R+StTpqFMTSHuANB4YZv6I0+oAmIJ+v7ZqEGvWJN
	NPF2gEzOLFRlyPtmHI3YPHt+gx3XuUn9NDudoeTInzebFi9qIWVtizsULXu6RcTK
	Ut64Cj90bl+cE0SFmWKeqPHBJ8qLIXhvLDloE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D3AD7C98;
	Fri, 22 Jun 2012 14:15:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EBDB7C8D; Fri, 22 Jun 2012
 14:15:00 -0400 (EDT)
In-Reply-To: <CACBZZX6nbWCFWWy5NTMSAPOf4RHUAbC9TuffPPy=2Ehn7KSnaA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Jun
 2012 17:24:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E98DADC-BC96-11E1-AC22-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200455>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 22, 2012 at 4:58 PM, ryenus <ryenus@gmail.com> wrote:
>> Given a certain commit, I want there's a command/option for git to
>> make it search the remote repo (e.g. origin) and tell me the
>> branches there which contain that commit.
>
> git branch --contains <commit>
> git branch -a --contains <commit>
> git tag --contains <commit>

Yes and no.  These are all local operations, so you would need to do
a "git clone" before starting to dig history like that.
