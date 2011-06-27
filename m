From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] pretty: Add %D for script-friendly decoration
Date: Mon, 27 Jun 2011 12:07:31 -0700
Message-ID: <7voc1jw0ss.fsf@alter.siamese.dyndns.org>
References: <cover.1309133817.git.greg@quora.com>
 <9d9e18b8c062380025f52a6ff992fae51a17f5d1.1309133817.git.greg@quora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jun 27 21:09:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbHBG-0003cT-VO
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 21:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab1F0TIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 15:08:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab1F0THe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 15:07:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 355A46D2A;
	Mon, 27 Jun 2011 15:09:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=cK0B1xq1xXSK/OOEspCoxwN//gI=; b=sML+CiEWiughlJN9gUYp
	tB+8deV4+5CQ4N1bi/9ZrBQm87xd0LmvBHhFiV8oixrrxdeoTvNtLrZEvH68GvVA
	vYAWnjhTT+wIcwsHw5olPRLbXM3/VzRhr4QFvrgpX5qhMfjHSuFqek917QNslIbd
	5nG7s5ZgfuGpAdHcO4RVIVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=F8DY9qRhVrXV+UbpJUxO0dhmlMMngFpw3+1++dwoS05Sx6
	08YqLSXBuL00/HiuELrNZRbXIAPuDeapR9pBcA5uizQSX0iKSNOXmlJH+NCLMQLD
	T5ipNd2GersXzTv6hV5szyf5tVx3gXwWn4DPSTI258oTYQNhmV+Cjn3wfDtu8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E6AE6D29;
	Mon, 27 Jun 2011 15:09:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9116B6D28; Mon, 27 Jun 2011
 15:09:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 049C2476-A0F1-11E0-8757-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176366>

Greg Price <price@MIT.EDU> writes:

> +static void format_decoration_short(struct strbuf *sb, const struct commit *commit)
> +{
> +	const char *affixes[3] = {" (", ", ", ")"};
> +	format_decoration(sb, commit, DECORATE_SHORT_REFS, affixes);
> +}
> +
> +static void format_decoration_full(struct strbuf *sb, const struct commit *commit)
> +{
> +	const char *affixes[3] = {"", " ", ""};
> +	format_decoration(sb, commit, DECORATE_FULL_REFS, affixes);
>  }

Nice and cute abstraction. I like this part of the series.
