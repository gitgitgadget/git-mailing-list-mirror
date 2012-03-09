From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Need to set GIT_WORK_TREE when setting GIT_DIR !?
Date: Fri, 09 Mar 2012 15:06:02 -0800
Message-ID: <7v4ntx4bol.fsf@alter.siamese.dyndns.org>
References: <CALeToSUaPzdr=u7FfwHEtEanphVP5LZ09QdQXno52PLBTK0H-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:06:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68t3-0003hn-6b
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 00:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab2CIXGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 18:06:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850Ab2CIXGG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 18:06:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E37E279AE;
	Fri,  9 Mar 2012 18:06:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xDwJXjZEm9MB
	CelPXRRGayIu05Y=; b=WKM4tLXFQqnAjB2/mpQXTZlGeoijT6RJ0jaBVO2fgYu/
	BCvI0BivddOycWawjApeHHQbOEuEhar9OXbNlloY4CGQUMIvMJB5BeyL5B9iaRIn
	wQUqKUXQbUNtBJir3bgtzHq9lP3kHZTSx9qGOCpYfMvhnk2C2ebcRG/sV6tv8hM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=O1pP6Y
	gBjEfZxCeyABQ22JwMSYtp8riOnL/OIdfyFlTwPUntlhgPjYjpI2WfbofY99P7oH
	EefAth0d+fIefcxHcOjp5+ZSZqRg2bAAy0ewYK/kNbv89FySAoAwpEoKlHBNoJxH
	AtiRZ/R9i3hpo6CT1e6g5uinT56tYNlVvHI9s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA8BE79AD;
	Fri,  9 Mar 2012 18:06:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5754279AC; Fri,  9 Mar 2012
 18:06:04 -0500 (EST)
In-Reply-To: <CALeToSUaPzdr=u7FfwHEtEanphVP5LZ09QdQXno52PLBTK0H-g@mail.gmail.com>
 (=?utf-8?B?IkZyw6lkw6lyaWM=?= Heitzmann"'s message of "Fri, 9 Mar 2012
 23:51:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7228D218-6A3C-11E1-B044-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192756>

=46r=C3=A9d=C3=A9ric Heitzmann  <frederic.heitzmann@gmail.com> writes:

Yes, to the question on the Subject line.  But you can also say=20

    [core] worktree =3D /path/to/the/work/tree

in $GIT_DIR/config.  Make sure your $GIT_DIR/config does *NOT* say
that the repository is a bare repository.

> ...
> Note: that using --git-dir instead of GIT_DIR give the same errors.

Yes, that is the intended behaviour; the command line option and the
environment variable should give you the same consistent effect).
