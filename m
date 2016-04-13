From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why doesn't gitk highlight commit references from git-describe?
Date: Wed, 13 Apr 2016 14:32:49 -0700
Message-ID: <xmqqk2k1jita.fsf@gitster.mtv.corp.google.com>
References: <nemal5$mb$1@ger.gmane.org>
	<CAGZ79kZVC0FxUN45KgLh-2tEK2=j2-yyTajYOc=s-LECgx+yqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Kelly <steveire@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 23:33:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSPD-0007QH-V3
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbcDMVcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 17:32:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754234AbcDMVcy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 17:32:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B58C912EE7;
	Wed, 13 Apr 2016 17:32:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7rvSDiT8QvkVm+pcnFNSV9RNyb8=; b=cbyXjl
	JlsiEsGilH7UjgKVv2cLh6tTqz9/Dq9Sz0i0RPY30/jUN8WIjO04dKn+iugWHwht
	9l0j3WKo1jxOK4BvexQ/IooG0VXURjXAKE+wpk0axQCN2IfEvi0mvr0r9criCj7c
	QBHuAOlhpoShlZM9zxSy7HXhZlKgHq6DtLBwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kXD2RvUFFF2k1d2RxQuFuvxsfq5HqmsC
	j1UG2Op4ZLaJ1aflyM9NxtFPrIDAAGOzGfg0DcRfCnqrXHpFt0T0u2FXsgh7JwMX
	DXKgJMU4a/wpom9vHDcVuYVYBFNB+OYGj0z1H0m8kxBns5ryevt1CWetXfHQU/ag
	78J4TwMJat0=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE8A212EE6;
	Wed, 13 Apr 2016 17:32:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2368912EE5;
	Wed, 13 Apr 2016 17:32:51 -0400 (EDT)
In-Reply-To: <CAGZ79kZVC0FxUN45KgLh-2tEK2=j2-yyTajYOc=s-LECgx+yqQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Apr 2016 14:27:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4652ED12-01BF-11E6-894C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291487>

Stefan Beller <sbeller@google.com> writes:

> How would you know(/code) that v1.6.0-rc0~120^2 is a text worth linking?
> "v1.6.0-rc0" is a custom string as that is how we name tags in this project.
> It can follow any convention in other projects.
>
> Maybe a first approximation is if there is a `~` followed by numbers
> or a ^ character, inspect the whole thing if it is a reference into the history?

You (as a gitk process running in a repository) know what tags are
in your repository, so you can find the above pattern and see if the
prefix matches any of the known tag.  That way, you do not have to
worry about having to special case HEAD etc.
