From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] cache-tree: update API to take abitrary flags
Date: Mon, 06 Feb 2012 11:51:07 -0800
Message-ID: <7vd39r7nbo.fsf@alter.siamese.dyndns.org>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 20:51:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuUaq-00009r-3C
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 20:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab2BFTvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 14:51:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548Ab2BFTvK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 14:51:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9BC466ED;
	Mon,  6 Feb 2012 14:51:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uBPcHebAwnMQ
	18LE/NQdf2V7ej4=; b=V7lPwsb2BJRGd2tLu4a8Cp60Pa1DIXQlw3mrpuEb1ZXe
	Bw4K0f7Kb1894cHGtt39tcZQrdaBZyyLtKKIjdz4kCbaGe4k4iHk8MmkmIRZqUFk
	JI8wCnVnmmjEal+4aFOmsnAhHM+/r19bAdGC8P62qfowFvg4YfTjcHlaMRJGS/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D1U7LN
	TgBETn7uIZoJj5TCfWiVOJwpZl31SHwBh0rk4fRe73amdBQkW3qFJlP4Pse6z02n
	afhwiPxicn3x/9pARS8OVZ3paMYPuHPur9LF4bw4fQPt7oeZiKAf5kIr0/s19lXf
	7FYVrcBBJ1n09AgprJR3iL0lQppRpqKSE5IvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1A5866EC;
	Mon,  6 Feb 2012 14:51:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59F5366EA; Mon,  6 Feb 2012
 14:51:09 -0500 (EST)
In-Reply-To: <1328525855-2547-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Feb
 2012 17:57:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA2EF904-50FB-11E1-9827-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190091>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  int cache_tree_update(struct cache_tree *it,
>  		      struct cache_entry **cache,
>  		      int entries,
> -		      int missing_ok,
> -		      int dryrun,
> -		      int silent)
> +		      int flags)

Very nice ;-)
