From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: borrow --sort and --count from for-each-ref
Date: Tue, 17 Jan 2012 12:12:58 -0800
Message-ID: <7vvcoaqe9h.fsf@alter.siamese.dyndns.org>
References: <1326805907-19416-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 21:13:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnFP1-0002qg-2A
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 21:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab2AQUNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jan 2012 15:13:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755584Ab2AQUNA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 15:13:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CD27770C;
	Tue, 17 Jan 2012 15:13:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wNzhsmgatjEg
	KeOoeKMCPQAzRDA=; b=YNUigq9GZv2BnGCKYnCFMKJ+OoNWsfSy/XkG8D2KOzDv
	OC27SnbxQvFtwb4u90I0mzASD14SLykCwQEHzMJFCjRPJtXZo5yjnRT2S+j0eeZX
	3Xpbh8yWClmxh7sz9Fy4oDmHa6qd2bioEB5y8+ogdrL+u19rMaNE+jlelowSYjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZqhHKb
	NTt8+ioleSFvnu0bvH3JEQ844EmDwz7WDzI8wbOhOBhfCTYgSdSi1mGQLmd9nHSR
	bRq2rLLn5TiwhEyp1bTbl1xRZCLYaF7mWVZTOD0B4y56I+e3DOoXAAoqivJyFCOe
	9+JNo3Z0KnTw5i0gz76SM3EBBPv0rD2KzFlhE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 651B1770B;
	Tue, 17 Jan 2012 15:13:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3C35770A; Tue, 17 Jan 2012
 15:12:59 -0500 (EST)
In-Reply-To: <1326805907-19416-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 17 Jan
 2012 20:11:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A71E3030-4147-11E1-9923-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188719>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Some time ago, I posted a patch that added date sort to git-branch
>  and Peff pointed me to for-each-ref. I did not look at it closely.
>  Now it does not seem hard to lend some code from for-each-ref to
>  git-branch. I can list 10 most recently touched branches with
>
>   git branch --sort=3D-committerdate -v --count=3D10
>
>  kind of cool. I don't think adding --format is necessary because
>  git-branch already has its own formatting.

Why do we even need this for "git branch", when "git for-each-ref
refs/heads" already does this?
