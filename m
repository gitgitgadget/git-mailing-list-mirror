From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle path completion and colon for tcsh script
Date: Sat, 02 Feb 2013 12:10:00 -0800
Message-ID: <7vboc2bhpj.fsf@alter.siamese.dyndns.org>
References: <E59706EF8DB1D147B15BECA3322E4BDC09AA38@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"manlio.perillo\@gmail.com" <manlio.perillo@gmail.com>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 21:10:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1jPx-0001yk-Of
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 21:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab3BBUKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 15:10:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757766Ab3BBUKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 15:10:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 432EBBBEB;
	Sat,  2 Feb 2013 15:10:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q/nDbsMfBez3GRihs+LnhAa/GFU=; b=eLu/mg
	TBZo7yDF7q+Zlj8rFgu9p6C4boCZ2YXa/FfpJ7ujBdNMAwPEKLn3MXnQyQ5UzcVN
	aT1gjtmLC7KNKXUV9aSb+73jZIVzVK0pbCjjGBaJVKQySZc8Y8pUAZbvC1epr10U
	GgdXn95Fm2XeIcbxm3nXVReYkZTpUJMSSWjm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UKD0Zi7Z3s5fa3owlWWevrYo+QZpi0+Y
	5dI/fbedklstp61Ab+MnuVls/wgwE4org6URQhWaoR0OYYE1H01ASY3m4TMzqt7N
	H9I8oM9Ps4Wor5QaqTcI+lT/z7Gvm1HZY10xhH0NeeoiMd2mD+yHVUFVDOnngnVa
	qNgCP8/hbwo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36782BBEA;
	Sat,  2 Feb 2013 15:10:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB551BBE5; Sat,  2 Feb 2013
 15:10:03 -0500 (EST)
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC09AA38@eusaamb103.ericsson.se>
 (Marc Khouzam's message of "Sat, 2 Feb 2013 19:43:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87FDAB4A-6D74-11E2-B418-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215292>

Marc Khouzam <marc.khouzam@ericsson.com> writes:

> Recent enhancements to git-completion.bash provide
> intelligent path completion for git commands.  Such
> completions do not add the '/' at the end of directories
> for recent versions of bash.
> ...
> Here is the update for tcsh completion which is needed to handle
> the cool new path completion feature just pushed to 'next'.
>
> Also, Manlio reported that tcsh completion was broken when using
> the colon, and this patch fixes the issue.
>
> I haven't quite figured out the process to indicate which branch
> a patch is meant for.  Do I just mention it in the email?

Yes, instead of wondering "Do I mention it here?", saying "This
should come on top of Manlio's completion update." is good.

But I have to wonder if this is sweeping a problem under the rug.
Shouldn't the completion for bash users end completed directory name
with '/', even if we didn't have to worry about tcsh?
