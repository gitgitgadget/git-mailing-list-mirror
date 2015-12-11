From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: remove 'git column' from porcelain commands
Date: Fri, 11 Dec 2015 10:16:17 -0800
Message-ID: <xmqqegesg8b2.fsf@gitster.mtv.corp.google.com>
References: <1449835500-24844-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 19:16:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7SF0-0007kY-5n
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 19:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbbLKSQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2015 13:16:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751818AbbLKSQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2015 13:16:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8160D315C5;
	Fri, 11 Dec 2015 13:16:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N2kq+2P97ivX
	cXlqP5uFTFQhaIM=; b=E47iwrN2VHkzN9awmDt9mRisoyk+00utd8qEbJpDqwu0
	2wZzzSjuz/DI7xRmSzM40UGQY1MwmCeA8KgaVSv+EWNGxOURPNVxWEvG601m1x+q
	VM36rq9s54wjwFJ7kfeTdELOkNHMxL3tC7XjrLqfbBYNLAsFntshPux40KWmJyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OZ4Krb
	7nzm+VaxV2byUUfAKbSbjmdnjD7lv+WBBN48u59Gr/FVaT0SXzrU5zeVG8jlsz+C
	zRaAlEYjcLb1PQixG2OYcw2syhxyF3Oic7q+JrKO1T0ZX2Bw33TwlP4GeoYEOKwS
	WlT8tQ6iseEcMb2gxngriHHCo395O41p/KKJ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78EE7315C4;
	Fri, 11 Dec 2015 13:16:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DB40A315C3;
	Fri, 11 Dec 2015 13:16:18 -0500 (EST)
In-Reply-To: <1449835500-24844-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 11 Dec 2015 13:05:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 465FC2BE-A033-11E5-8DA5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282265>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> 'git column' is an internal helper, so it should not be offered on
> 'git <TAB>' along with porcelain commands.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---

I think this makes sense.
Objections?

>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 111b05302b..5dec8778f7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -664,6 +664,7 @@ __git_list_porcelain_commands ()
>  		check-mailmap)    : plumbing;;
>  		check-ref-format) : plumbing;;
>  		checkout-index)   : plumbing;;
> +		column)           : internal helper;;
>  		commit-tree)      : plumbing;;
>  		count-objects)    : infrequent;;
>  		credential)       : credentials;;
