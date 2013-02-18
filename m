From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/9] user-manual: Reorganize the reroll sections,
 adding 'git rebase -i'
Date: Sun, 17 Feb 2013 19:48:38 -0800
Message-ID: <7v1ucecmeh.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <31c45d95acaf062428f171c33c4c164d80b4becb.1361146398.git.wking@tremily.us>
 <7v621qe4xc.fsf@alter.siamese.dyndns.org>
 <20130218023908.GC5936@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 04:49:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Hj5-0004ec-ER
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 04:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab3BRDsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 22:48:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64531 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829Ab3BRDsm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 22:48:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FD3DBD9E;
	Sun, 17 Feb 2013 22:48:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OyK0Sw6TwPxisyR3SWX0/GCCVFs=; b=PzxHHa
	G7fDr870ApS3T7XBWD5sai1UCMPqYGKwGk4gbck1uB/MAFAR69Sgix4tOL0GfVts
	psf7XEpa1+qEIZvdFdDasUwth3tryeu/HLXsrw9mWWPMgyYuq+Isp3E1nKYJqctq
	Lp7KggvQVHST49KDbYTkJkx+oEjKv8hWu0ouU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OmDcqRG7FQIoOyba+tMEgj0v7khCfVBv
	AMQdPKI7ZNMiuQ9n+yYoWA4/YIXI9ngGNZ6ptCq5351BHjOQjmYHQZQiqprUo4o0
	Gqev+nFypYnMwF8uxB7FwI92Pl353AXItKnAFLBKJeHoxnAxb5kT3bATCCgJ3otk
	pBwbnD8JpZQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4332BBD9D;
	Sun, 17 Feb 2013 22:48:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CB38BD9C; Sun, 17 Feb 2013
 22:48:40 -0500 (EST)
In-Reply-To: <20130218023908.GC5936@odin.tremily.us> (W. Trevor King's
 message of "Sun, 17 Feb 2013 21:39:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1553ECF6-797E-11E2-BA58-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216438>

"W. Trevor King" <wking@tremily.us> writes:

> On Sun, Feb 17, 2013 at 06:23:11PM -0800, Junio C Hamano wrote:
>> "W. Trevor King" <wking@tremily.us> writes:
>> >  [[rewriting-one-commit]]
>> >  Rewriting a single commit
>> >  -------------------------
>> > @@ -2552,71 +2558,81 @@ $ git commit --amend
>> >  which will replace the old commit by a new commit incorporating your
>> >  changes, giving you a chance to edit the old commit message first.
>> >  
>> 
>> ... A lot of lines removed here ...
>> 
>> > +[[reordering-patch-series]]
>> 
>> This change makes the [[rewriting-one-commit]] section say "We
>> already saw you can do 'commit --amend'" and nothing else.  It makes
>> me wonder if the remaining section is worth keeping if we go this
>> route.
>
> I think there should be some mention of `commit --amend` in the
> rewriting history section.  It's a pretty straightforward idea though,
> so there's not all that much to say about it ;).

I do think teaching "commit --amend", "rebase" and "rebase -i"
together makes sense. It just felt that the remaining piece on
"commit --amend" looked too thin in the substance, but it may be a
good change in the existing flow of text.
