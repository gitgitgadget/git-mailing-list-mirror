From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a separate gitdirs.
Date: Mon, 10 Mar 2014 12:36:47 -0700
Message-ID: <xmqqsiqprgkw.fsf@gitster.dls.corp.google.com>
References: <1394178834.7891.38.camel@Naugrim>
	<BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
	<1394231714.7891.39.camel@Naugrim>
	<xmqqvbvpshqn.fsf@gitster.dls.corp.google.com>
	<1394239852.7891.40.camel@Naugrim>
	<B2A4F350-1F20-4ABA-80A6-CF244DD7FAFD@kellerfarm.com>
	<xmqq61nmrrxe.fsf@gitster.dls.corp.google.com>
	<1394475733.7891.53.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Keller <andrew@kellerfarm.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:37:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN60Q-0004AC-5S
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbaCJTgy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2014 15:36:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbaCJTgx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 15:36:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EB2E73296;
	Mon, 10 Mar 2014 15:36:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cHni25l/ObSp
	DWL9zUEF47DExnU=; b=VsbcGwwY2qfgObOCmxFujfzHe0NWUu+rf+ytC9UCQyoM
	XMGiezMQyldyvO+vZLB9x2LJUmfJz6Vx1IpY2WImGtQx85MGlb6lke5JwSKAz9dD
	c1O+y0aXOrIEW7ggKFvXEKY1Wk4AIA9iMYT/pseeK6adnk/5UtjtB29MaoiOeMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PgVXve
	vI+bpPdN7blHvjC8uvw7ac7nv6R3G+eTZIDOZgTp8jOE1JDtUTfXLNUbAUTdk/So
	AHIzTlKsTNXdHn+Uneyqm7UlK5hqfXQMfN5szZU3O9jm1wix360h2ig/TnIEmyZf
	nqddt4w2Z1Ni/l6kkPoYq3vmCRMjF7nISPtTQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A96B73294;
	Mon, 10 Mar 2014 15:36:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 495B673292;
	Mon, 10 Mar 2014 15:36:51 -0400 (EDT)
In-Reply-To: <1394475733.7891.53.camel@Naugrim> (Henri GEIST's message of
	"Mon, 10 Mar 2014 19:22:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53EB7050-A88B-11E3-BFEC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243798>

Henri GEIST <geist.henri@laposte.net> writes:

> Le lundi 10 mars 2014 =C3=A0 08:31 -0700, Junio C Hamano a =C3=A9crit=
 :
> ...
>> This is not limited to submodules.  There are multiple lower-level
>> mechanisms for a $path/.git to borrow the repository data from
>> elsewhere outside of $path and a cloned submodule uses only one of
>> them.  For any such $path, "cp -R $path $otherplace" will result in
>> an "$otherplace" that does not work as a Git repository in exactly
>> the same way, whether it happens to be a submodule checkout or not.
>>=20
>> That is why I suggested to enhance description on a more general
>> part of the documentation that covers what a Git repository is.
> ...
> If there is some other situation where this can occur as a side effec=
t
> of a git command it can be good to have the user aware of the list or
> at least inform them in general case a git repository cannot be copie=
d
> in a place every body will see.
> Or place a note in the manpage of every git command which can have th=
is
> side effect.

I think we should do two things:

 - In the repository format document, state that there are two
   lower-level mechanisms and a half that lets a repository borrow
   from somewhere else, and "cp -R" of the former will not result in
   a complete, usable repository, and who employs these mechanisms.

   * Redirecting the entire .git via the textual gitfile mechanism,
     which is used by "clone --separate-git-dir" and "submodule";

   * Borrowing .git/objects read-only from elsewhere, overlaying our
     own, via .git/objects/info/alternates, which is used by "clone
     --reference";

   * Redirecting some paths in .git to another, via "git workdir";
     soon to be replaced with .git/commondir mechansim.

 - In each of the documentation page on an end-user facing command
   that will be mentioned above, add "See also" reference to the
   above description in the repository format document.

   We could elaborate the "See also" as something like "If you use
   this feature, do not think you can "cp -R" the repository to
   elsewhere and expect the copy to function; see also ...", if we
   wanted to.
