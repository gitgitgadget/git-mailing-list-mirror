From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Mon, 09 Mar 2009 17:19:28 -0700
Message-ID: <7v7i2ydyb3.fsf@gitster.siamese.dyndns.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
 <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 01:21:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgpiU-0006WS-CR
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 01:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbZCJATi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 20:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbZCJATi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 20:19:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbZCJATh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 20:19:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3C3AA0D8E;
	Mon,  9 Mar 2009 20:19:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E9F84A0D8D; Mon,
  9 Mar 2009 20:19:30 -0400 (EDT)
In-Reply-To: <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 09 Mar 2009 17:07:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 224411E2-0D09-11DE-B518-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112768>

Junio C Hamano <gitster@pobox.com> writes:

>    - Even if the answer to the above question is "no", are there other
>      commands that we currently do not allow a quick shorthand to mean
>      "the default thing", but would benefit from having one?  If so, how
>      good does it look to use '-' as such a short-hand?

I need " for these other commands" before the question mark at the end of
this sentence.

>      In other words, is it safe to establish a precedent to use '-' to
>      denote "the default thing"?  Would we later regret, saying that
>      "'git-frotz command would benefit from a short-hand notation for 'the
>      default thing', but - is already taken -- it means send the output to
>      the stdout"?

I need ", or something like that" before the question mark at the end of
this sentence.

>    - Do we use a short-hand '-' to mean something entirely different in
>      the UI, making this new use of '-' to mean the default confusing?
>
>      I think '-' for checkout means "the previous one", which already
>      answers this question somewhat.

I am wondering if we can handle this by DWIMming the command line
arguments better.  For example, in all of these:

	$ git push HEAD
        $ git push :
        $ git push master

when "HEAD", ":", or "master" can only be refspec, we know that the user
said "I do not bother saying which repository to --- you know what I
mean."  It would be natural to DWIM it to "the default remote" without
even having to use your '-' notation.
