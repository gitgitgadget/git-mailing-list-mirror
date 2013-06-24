From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 15:24:25 -0700
Message-ID: <7v61x36tba.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
	<7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
	<vpq7ghjtpv1.fsf@anie.imag.fr>
	<7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
	<CALkWK0ngNrxT1MrdhXyz8ViN9an1XQsRD=DnxXYXqhDRmGO8EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 00:24:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrFBZ-0008OR-CR
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 00:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049Ab3FXWY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 18:24:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab3FXWY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 18:24:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6B42B70D;
	Mon, 24 Jun 2013 22:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ovzZgxCoDp+AcR11gm/itZPTqQU=; b=HZTnqZ
	EaieuelYQnpDiiA9JByZctalf6YesCdHzqfsDHRt9xda1NpKhClFWk8djRUkTv8e
	P1hNK2fWLIS1T4b1vS7wP5jToccT87v/JcD4Xk8dyirPsmdQnwwo52DgIoGMCdfF
	oWAmDi+AaJ5jRPhNSVajlKDAZLNP7fHcb6ryk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bV9h/ygkkGaQ+6ghHcSu1YyE7vPEaBip
	m54CdV7a3KrjVqo1zd1hZgXZbJbsqdy7cA09dFpITkrh14T805q0+yfJSjdS3/2/
	OFk9QhnTB1X+2st3wGLYLMJIOND13HuPkBwKzChEGGk05gVcyOUuyV7zWVA89EuJ
	ZDgkwF41zNk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D4B2B70C;
	Mon, 24 Jun 2013 22:24:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C4332B708;
	Mon, 24 Jun 2013 22:24:27 +0000 (UTC)
In-Reply-To: <CALkWK0ngNrxT1MrdhXyz8ViN9an1XQsRD=DnxXYXqhDRmGO8EA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 25 Jun 2013 01:00:23 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4D1B6A6-DD1C-11E2-99B8-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228912>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> If we want to continue that tried-and-proven approach as a
>> short-term fix, a patch may look like this.
>
> I don't like this special-casing for show_branch at all.

The patch does not special-case show_branch at all, in that I would
expect that people over time will want to add more and more
configuration not to type short and sweet command line options.  The
primary value of the patch is to illustrate how we would ignore the
ones we do not want when we want to still call git_status_config().
It lays a groundwork for doing so, using one single variable we
happen to know about today as an example.

> What is the
> problem with skipping branch configuration altogether and going
> straight to diff-ui configuration, like I suggested earlier?

Why diff-*UI*-config, not diff_basic or even default_core?

I actually find that alternative approach a lot nicer, and I wish
the world were that simple.

One thing that complicates the matter is that "--porcelain" output
is affected by "status.showuntrackedfiles" setting, whose parser
dates only back to June 2008, while --porcelain came much later in
Sep 2009.  So we have close to four years worth of user scripts that
read from --porcelain and expects no untracked paths shown in a
repository with that configration set.  If we care about not
breaking people's scripts, we need to somehow arrange the option to
keep honoring status.showuntrackedfiles setting, which may mean that
we cannot just say "let's bypass git_status_config() and be done
with it".

So...
