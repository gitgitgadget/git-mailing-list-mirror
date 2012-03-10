From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Need to set GIT_WORK_TREE when setting GIT_DIR !?
Date: Sat, 10 Mar 2012 13:20:50 -0800
Message-ID: <7vsjhg17bh.fsf@alter.siamese.dyndns.org>
References: <CALeToSUaPzdr=u7FfwHEtEanphVP5LZ09QdQXno52PLBTK0H-g@mail.gmail.com>
 <7v4ntx4bol.fsf@alter.siamese.dyndns.org> <4F5B55E8.4080000@gmail.com>
 <CACsJy8AUo3+ECdxfnyfYGA-mAtHB8KBOUrie3_Qo3cyfshZmAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 22:20:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6Til-00018G-Cz
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 22:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248Ab2CJVUx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 16:20:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab2CJVUx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Mar 2012 16:20:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EF456460;
	Sat, 10 Mar 2012 16:20:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Rsj6sU+7XNIN
	8u+vAvE4wt/0SK0=; b=YeW9CsQ+SRBFnsloEthllHuVViA1/rh3v0m2t2fKvIi5
	qk0attPqVcgVUtIW6LakREyWd4FtsqRD0boUT0/yBFAfSJFLjHYV/+CvjAXduspD
	jtKzVC+sYVk/1LplZJ3TgrHhnAqy7PgTWW2HRR3z22mGETCKbbZrhZuVwE0wNhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MYNjhi
	hOGKHbbFO9t4WQUnh5aOi0/SQUpXVXhMuhOUX/SvhGEm9agIrkAJ5ufVFct7V8+d
	/640KLz/coyEldYAhdSBLxmvfSDwzQpd3i+kFTo4pdb6tL+k3RFq4QR9BrgIIPpA
	igXCmSSajL/Z5tyd1B+oDQ7HWcK1lrr2WLisE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86348645F;
	Sat, 10 Mar 2012 16:20:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D5EF645E; Sat, 10 Mar 2012
 16:20:52 -0500 (EST)
In-Reply-To: <CACsJy8AUo3+ECdxfnyfYGA-mAtHB8KBOUrie3_Qo3cyfshZmAA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 10 Mar 2012 21:05:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA2FB0E6-6AF6-11E1-B39F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192787>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Historical reason: before separate worktree feature was introduced,
> git assumed worktree was at $GIT_DIR's parent directory.

Isn't the rule that the current directory becomes the root of the
working tree if you did not have GIT_WORK_TREE?

In any case, the way I read Fr=C3=A9d=C3=A9ric is that the other reposi=
tory's
files will be accessed only from the root of the working tree, so as
long as the GIT_DIR/config says it is not a bare repository, it
should be OK.
