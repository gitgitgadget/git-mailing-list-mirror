From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/13] pretty: add %C(auto) for auto-coloring
Date: Tue, 16 Apr 2013 14:37:30 -0700
Message-ID: <7v8v4ijgx1.fsf@alter.siamese.dyndns.org>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 23:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USDZJ-0008HO-67
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 23:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965444Ab3DPVhd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 17:37:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965344Ab3DPVhc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 17:37:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41BE016452;
	Tue, 16 Apr 2013 21:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CiZiUpMWRYYp
	T8hql8TvuK4f+lE=; b=ErsmdASSCYP/LgxY/yHcucLM9vmtKMZ0fVN1qPLneok4
	Lks/UUaWS7y66c3g1BYe0VOKs07lyHTqU/u14KuqRXT8adwIuKYZ7PkNw1VHxfCm
	TxDx355Cst4yA5/1k1aZ9nCfxbG/FFBOrwMzDNuktHEGEXC4nNoBEo4uQ27+iU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hOQvSd
	5/XbBYxLKCez7rZJ3fDghD1wLAFgLlVW+BPWodmmOZbblocWPSGGi0rOh/EPcM8C
	ZtNgdbq2+dfEUeHRaL3kf8KJhUWWQ/uUaew37WcfYWCWyxeWR/gjPZmKTeyziHWp
	jJu2drcxtPb20vDectBP3O2TqHUzTcnzXdVpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 323B716451;
	Tue, 16 Apr 2013 21:37:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 967E91644F; Tue, 16 Apr
 2013 21:37:31 +0000 (UTC)
In-Reply-To: <1366100702-31745-11-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 16 Apr
 2013 18:24:59 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7FDF634-A6DD-11E2-8E65-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221479>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  	case 'h':		/* abbreviated commit hash */
> +		strbuf_addstr(sb, diff_get_color(c->auto_color_next, DIFF_COMMIT))=
;
>  		if (add_again(sb, &c->abbrev_commit_hash))
>  			return 1;

Doesn't this early return mess things up?

>  		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
>  						     c->pretty_ctx->abbrev));
> +		strbuf_addstr(sb, diff_get_color(c->auto_color_next, DIFF_RESET));
>  		c->abbrev_commit_hash.len =3D sb->len - c->abbrev_commit_hash.off;
>  		return 1;
