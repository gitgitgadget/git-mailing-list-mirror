From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix minor grammatical and other formatting issues in the "git log" man page
Date: Wed, 13 Nov 2013 13:56:24 -0800
Message-ID: <xmqqy54sc6ev.fsf@gitster.dls.corp.google.com>
References: <1384323709-2690-1-git-send-email-jstjohn@purdue.edu>
	<1384323709-2690-2-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Nov 13 22:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgiQM-0003wf-T8
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 22:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab3KMV4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 16:56:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab3KMV4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 16:56:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 544E35273E;
	Wed, 13 Nov 2013 16:56:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o1wPEuernfkKgOShg0NUHh9qQ3U=; b=nQ6w01
	ElM/o5s6VCaTPPt43MOJvQvVr1c4TwXvTU3at8K2bifyYmbo9Wyz1htxmwGNPeIJ
	oD9g9by2HyF6yT28v8NUtQCAp2zWNuHfOIBQ1ItYgAlobUvgd+3sqwRsUADXBJTw
	/ZGVEmDsVeNgbxrGajMliPY//1jHLqSv+Qz0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CwItbLYG8RG6LWf/bsmJNoOJhSCsEPVb
	olmP2XJ+0oHViFMHIVZbAGZTkLBKH4RS9v5dJ17+n5uun1dCMF2RN9BFln1Y4XZc
	eYaM6bIse3bRNlJnc+NwHYPldRDhfO5k79lathkZcJ5UMjuAcuPqU8op9neKbrl6
	53bh6hGTDBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 457715273D;
	Wed, 13 Nov 2013 16:56:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B3215273C;
	Wed, 13 Nov 2013 16:56:28 -0500 (EST)
In-Reply-To: <1384323709-2690-2-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Wed, 13 Nov 2013 01:21:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 72D448C2-4CAE-11E3-BCBA-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237803>

"Jason St. John" <jstjohn@purdue.edu> writes:

> Documentation/git-log.txt:
> -- replace single quotes around options/commands with backticks
> -- use single quotes around references to sections
> -- replaced some double quotes with proper AsciiDoc quotes (e.g.
>      ``foo'')
> -- use backticks around files and file paths
> -- use title case when referring to section headings
> -- use backticks around option arguments/defaults
>
> Signed-off-by: Jason St. John <jstjohn@purdue.edu>
> ---
> When working on this commit, I noticed a difference in how options and
> option descriptions are separated (e.g. with a blank line or not). At least
> with Vim's syntax highlighting, if there is a blank line between the option
> and its description, the text block is all colored the same; however, if
> there isn't a blank line, then the text block is not specially colored.
>
> Is there an existing convention for how this should be done?

I do not think we have a written rule or convention (and I do not
know if we want one).  While reading the text in the source form
(and the point of choosing AsciiDoc was to be able to read the docs
without formatting), I personally have a slight preference to
immediately follow the body text to the label in the labelled list,
and a blank line after the item, i.e.

	item label::
		This describes the item.

	next item label::
		This describes the next item.

as it makes it clear that the body belongs to the heading that
precedes it.

But it does help to have a blank between the label and the beginning
of the body when reflowing the body with fill-paragraph, i.e.

	item label::

		This describes the item.

You say that it is also easier on Vim to have the blank line there,
so perhaps we may want to aim for updating the documentation over
time to consistently do so.  I dunno.
