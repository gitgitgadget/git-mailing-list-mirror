From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/16] shortlog: add missing declaration
Date: Thu, 31 Oct 2013 12:05:34 -0700
Message-ID: <xmqqk3gt5kht.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:05:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbxZ3-00033R-TY
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab3JaTFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:05:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab3JaTFh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:05:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 960994CBB3;
	Thu, 31 Oct 2013 15:05:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ERJH9pxAit9xAhzeeMzZzEt/bBg=; b=KBrzub
	9XNa/MiYFYfBy4h90EiTMKC9XXRKh7214+VeWHWpwnCYTA+pSbwffX3ty+MWHT1z
	JHkwqn4B+j1icKDA/N0BjrAxXTGpj25Cz4AmfSdgqVyuTscJDkjCvneCFM77bRQc
	061yanshrE58HyNQJ+ScqaPKK8QgLWHu1n9I8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xv1lmCrdgxiM8XJUEHYVC5HeMu9cLhUy
	3IvA0QgT14UVwSZQvOMwL97HCJJplqD5qjKRkuUd3oh2KOymXDUK8vcL2RAuNx5U
	Bg17F3UKjAouUatccipa32KFl1RN5DokwiF3qYp+ZAn+qCPFO7ODlmnP0KkGHFck
	4RtZpFHnKFU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CAD94CBB0;
	Thu, 31 Oct 2013 15:05:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA6B54CBAD;
	Thu, 31 Oct 2013 15:05:35 -0400 (EDT)
In-Reply-To: <1383211547-9145-7-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 03:25:37 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6C59DBA0-425F-11E3-BE88-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237159>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise we would have to include commit.h.

Was there a reason why commit.h is not included here, just like
revision.h would include diff.h, so that users of shortlog.h do not
have to worry about including commit.h themselves?

Note: not requesting the patch to be changed; just inquiring the
reasoning behind a different approach to solve related/same problem.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  shortlog.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/shortlog.h b/shortlog.h
> index de4f86f..54bc07c 100644
> --- a/shortlog.h
> +++ b/shortlog.h
> @@ -19,6 +19,8 @@ struct shortlog {
>  	struct string_list mailmap;
>  };
>  
> +struct commit;
> +
>  void shortlog_init(struct shortlog *log);
>  
>  void shortlog_add_commit(struct shortlog *log, struct commit *commit);
