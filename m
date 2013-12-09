From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] fetch: add missing documentation
Date: Mon, 09 Dec 2013 13:26:40 -0800
Message-ID: <xmqqa9g9wwa7.fsf@gitster.dls.corp.google.com>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
	<1386482220-18558-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:26:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq8Lo-0003VJ-G4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab3LIV0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:26:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab3LIV0o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:26:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AC2F59A6C;
	Mon,  9 Dec 2013 16:26:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0gNLUmXwPDtFcw6lq+ohOYzMuJY=; b=E68fci
	guhDsDF/wq/Q1yUlJ+1dRs/hgT4V/1ZF/YVX53A14FJ3JcZKWpT4oGFlEu/BBDa1
	OxygjeZJz/ACXBdzMr4GUL9Ll2iJhnSOAk2d6X0MHvdcUPhRB+OJj9Yg60mpmjrT
	ErNPPuZ8oNb6X3y3OEpXV8E1oUaWYwUkTWanU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9OMYPbFIbF5eUSeb1brkVkgOyYKhLG/
	tk8dL+ifPHNss3rFp1nASUS4CVZoHU48u5ssJJds52TMqqwgE6hmjIVJ/MpIJ+9A
	NPfiZCxp/cNf7Q/02Soay4md/mdxJgnBNd/emFmA5hP4td6UK4dpZYFnS0DMeacs
	w9FTfARlaE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 882A459A6B;
	Mon,  9 Dec 2013 16:26:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1AA759A6A;
	Mon,  9 Dec 2013 16:26:42 -0500 (EST)
In-Reply-To: <1386482220-18558-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 7 Dec 2013 23:56:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9915C26C-6118-11E3-9D01-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239108>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's no mention of the 'origin' default, or the fact that the
> upstream tracking branch remote is used.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-fetch.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index e08a028..a7b245d 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -37,6 +37,9 @@ or from several repositories at once if <group> is given and
>  there is a remotes.<group> entry in the configuration file.
>  (See linkgit:git-config[1]).
>  
> +When no remote is specified, by default the `origin` remote will be used,
> +unless there's an upstream branch configured for the current branch.
> +

It is better than saying nothing, but the reader will be left
wondering what happens when "upstream branch" is configured with the
above text.

    When no remote is specified, by default the `origin` remote will
    be used, unless there's an upstream branch configured for the
    current branch, in which case the `fetch` goes to the remote the
    specified upstream remote-tracking branch is taken from.

or something, perhaps?

>  OPTIONS
>  -------
>  include::fetch-options.txt[]
