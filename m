From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/16] Add documentation for the 'bidi-import'
 capability of remote-helpers
Date: Mon, 20 Aug 2012 15:50:35 -0700
Message-ID: <7vzk5pgouc.fsf@alter.siamese.dyndns.org>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 00:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ao1-0006cJ-Ta
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 00:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683Ab2HTWul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 18:50:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756618Ab2HTWuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 18:50:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1983392E2;
	Mon, 20 Aug 2012 18:50:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=rtIBw++tfv3ZnYz8zttsjHdeqeI=; b=tTWs430V9K1xBDa88IQb
	dBzQqy8NKz3lU2Bj9aBuBCpgdyhm9glc/h9s6q7Nt3WWClI1uPquowdAGgCUSy4v
	/vyScxx77N0A8mmydODZ/WSk3Mynmp54Mss0NvcUfAxtnGrIcs+jCncnqsT/Ytza
	T5/XQHWaHah8fk92sjLeRmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Jy45X6eKSgzfkYlNBWOoImTq1Fw5HWmecPl6tp/F+wEcc2
	jKIH/L7nZnGtkbY5LzxsgwR+ONCUxHPE0sSjD7IWfPtL95K85QX+8osXxDRLG80B
	G48iPqrLiAf3KrgpLevPBvRFdLFE+jBp9SXfZskRmJ6C+7EzFK77O2RMeePAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 062F292E1;
	Mon, 20 Aug 2012 18:50:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2F9792DE; Mon, 20 Aug 2012
 18:50:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74F5350A-EB19-11E1-A057-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203903>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-remote-helpers.txt |   21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> index f5836e4..5faa48e 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -98,6 +98,20 @@ advertised with this capability must cover all refs reported by
>  the list command.  If no 'refspec' capability is advertised,
>  there is an implied `refspec *:*`.
>  
> +'bidi-import'::
> +	The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
> +    to retrieve information about blobs and trees that already exist in
> +    fast-import's memory. This requires a channel from fast-import to the
> +    remote-helper.
> +    If it is advertised in addition to "import", git establishes a pipe from
> +	fast-import to the remote-helper's stdin.
> +	It follows that git and fast-import are both connected to the
> +	remote-helper's stdin. Because git can send multiple commands to
> +	the remote-helper it is required that helpers that use 'bidi-import'
> +	buffer all 'import' commands of a batch before sending data to fast-import.
> +    This is to prevent mixing commands and fast-import responses on the
> +    helper's stdin.
> +

Funny indentation we see here...

>  Capabilities for Pushing
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  'connect'::
> @@ -286,7 +300,12 @@ terminated with a blank line. For each batch of 'import', the remote
>  helper should produce a fast-import stream terminated by a 'done'
>  command.
>  +
> -Supported if the helper has the "import" capability.
> +Note that if the 'bidi-import' capability is used the complete batch
> +sequence has to be buffered before starting to send data to fast-import
> +to prevent mixing of commands and fast-import responses on the helper's
> +stdin.
> ++
> +Supported if the helper has the 'import' capability.
>  
>  'connect' <service>::
>  	Connects to given service. Standard input and standard output
