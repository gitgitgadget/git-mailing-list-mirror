From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Tue, 15 Nov 2011 15:10:56 -0800
Message-ID: <7v1ut9uglb.fsf@alter.siamese.dyndns.org>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
 <CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Smirnov <divis1969@gmail.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 00:11:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQS9h-0008BP-UE
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 00:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575Ab1KOXLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 18:11:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756524Ab1KOXK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 18:10:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B34EE57F2;
	Tue, 15 Nov 2011 18:10:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nFocQESyZ+FcbMaFknQw6e7YujY=; b=YDfek2
	rJzy4dkxqcddDn+EavkiiVB6TioIKtpPwt50Ydf5zlKVdExABu+l0rocInJG6evp
	SU0nG6Ehi+o32yQDwfbVbKx1XwOk/KTBKhHxlEyDP4nU4TI9dnKaWBB6CTCRK0kw
	M5SWDH805EKXKCrtoFUEC9IRZA3XRxg7mYjzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RAV79HokvZeRQawyX/D2AF6CR/wIq0YL
	efuYEvmxuNBPCLe9bIgN0bRvOMZ2prDWsaygBtzAMrMiYoD/pHyfTik+UAi1Gojt
	2+5zdRW9yW8BrVa4F/K+P5+tTR+6MXC4MJxG4H8pzV/+dzCxkyf0pojNexONzACb
	CMGeCE7pX8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAD6D57F1;
	Tue, 15 Nov 2011 18:10:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AD8457F0; Tue, 15 Nov 2011
 18:10:58 -0500 (EST)
In-Reply-To: <CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com> (Shawn
 Pearce's message of "Tue, 15 Nov 2011 07:03:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13D2A1CE-0FDF-11E1-8A61-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185495>

Shawn Pearce <spearce@spearce.org> writes:

> On Tue, Nov 15, 2011 at 05:52, Dmitry Smirnov <divis1969@gmail.com> wrote:
>
>> If I use the http URL (http://git.kernel.org/pub/scm/git/git.git) I
>> can clone with no problems.
>
> This may be a problem with the git.kernel.org HTTP server. It is
> probably not a problem with Git itself.

Not likely to be an issue with git.kernel.org either. I am puzzled.

$ git ls-remote https://git.kernel.org/pub/scm/git/git.git |
  grep -e HEAD -e master
bc1bbe0c19a6ff39522b4fa3259f34150e308e1f        HEAD
bc1bbe0c19a6ff39522b4fa3259f34150e308e1f        refs/heads/master

$ rungit v1.7.5.4 ls-remote https://git.kernel.org/pub/scm/git/git.git |
  grep -e HEAD -e master
bc1bbe0c19a6ff39522b4fa3259f34150e308e1f        HEAD
bc1bbe0c19a6ff39522b4fa3259f34150e308e1f        refs/heads/master

The only thing that immediately comes to mind is the rare smart-http
breakage in 1.7.5 but that was plugged in 1.7.5.1, so...
