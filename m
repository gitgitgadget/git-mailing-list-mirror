From: Junio C Hamano <gitster@pobox.com>
Subject: Re: strbuf API
Date: Mon, 03 Sep 2007 02:18:01 -0700
Message-ID: <7vejhgksza.fsf@gitster.siamese.dyndns.org>
References: <20070902224213.GB431@artemis.corp>
	<vpqk5r8m9nz.fsf@bauges.imag.fr> <20070903084927.GB21759@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Sep 03 11:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS84Z-0004Zx-Bj
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 11:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbXICJSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 05:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754668AbXICJSH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 05:18:07 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbXICJSF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 05:18:05 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C1FF12D099;
	Mon,  3 Sep 2007 05:18:24 -0400 (EDT)
In-Reply-To: <20070903084927.GB21759@artemis.corp> (Pierre Habouzit's message
	of "Mon, 03 Sep 2007 10:49:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57460>

Pierre Habouzit <madcoder@debian.org> writes:

> On Mon, Sep 03, 2007 at 08:32:16AM +0000, Matthieu Moy wrote:
>>  ...
>> For example, it would be very tempting to compare files with
>> "strcmp(buf1, buf2)", but that would just fail silently when the file
>> contains a '\0' byte.
>
>   Indeed, OTHO doing that would be pretty silly, as embending NULs in a
> strbuf is wrong, it's a _str_buf, not a random-binary-buffer. It's meant
> to make the use of strings easier, not to use as generic purpose byte
> buffers. Of course they can, but well, it's not what they are designed
> for in the first place.

People, please realize strbuf "API" is not a serious API.  

It wasn't even intended to be anything more than just a
quick-and-dirty implementation of fgets that can grow
dynamically.  The other callers added by people to have it do
general string manipulations were just bolted-on, not designed.
I haven't taken a serious look at bstring nor any of the
alternatives yet, but defending strbuf as if it was designed to
be a sane API is just silly.
