From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Mon, 17 Sep 2012 12:48:14 -0700
Message-ID: <7vlig8v3b5.fsf@alter.siamese.dyndns.org>
References: <1347844915-4130-1-git-send-email-git@shiar.nl>
 <7vtxuxw7bf.fsf@alter.siamese.dyndns.org>
 <20120917173945.GA22000@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mischa POSLAWSKY <git@shiar.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 21:48:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDhIv-0006pZ-O3
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 21:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab2IQTsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 15:48:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab2IQTsR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 15:48:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B0849306;
	Mon, 17 Sep 2012 15:48:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mrXtdUQBeiU86uHKJqtZJs2Vjx8=; b=i/JO/l
	3NmZXdC9Y09dJcnthd0CDGxhz2681EMXoSUCuDHYhmH+oKiD61xDmOl0TtiEirRO
	Rr2iMREiD1Fs80SX1FCUxabZXwu5DoNkuiYXZ484KLhcQQ9BgKMzzBM3jn+Y8ZAT
	witeW4horb8eBUgEY4a36ADZmxd/TtgWHJNF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OBmAW3ynkXNcBY8zFDF0chymh+L4QtGi
	vSdzCYQjQrylpImWrbUAGrwHPDmwANGCR9BqXKp46JBBPIi+5jIik5hVpkLMdseQ
	hmorkz6C8/Ydydlc+Jsaj0g5KL9w5U+uLQ9OivIcv5wOybY+ekq20Nqk3yVaeM7P
	n1zSZioH4KY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17ECA9305;
	Mon, 17 Sep 2012 15:48:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7028F9304; Mon, 17 Sep 2012
 15:48:15 -0400 (EDT)
In-Reply-To: <20120917173945.GA22000@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 17 Sep 2012 13:39:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F0E3E20-0100-11E2-A883-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205732>

Jeff King <peff@peff.net> writes:

> On Sun, Sep 16, 2012 at 10:24:04PM -0700, Junio C Hamano wrote:
>
>> Mischa POSLAWSKY <git@shiar.nl> writes:
>> 
>> > Matching the default file prefix b/ does not yield any results if config
>> > option diff.noprefix or diff.mnemonicprefix is enabled.
>> >
>> > Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
>> > ---
>> > Very useful script otherwise; thanks.
>> >
>> >  contrib/git-jump/git-jump | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git contrib/git-jump/git-jump contrib/git-jump/git-jump
>> > index a33674e..dc90cd6 100755
>> > --- contrib/git-jump/git-jump
>> > +++ contrib/git-jump/git-jump
>> > @@ -21,9 +21,9 @@ open_editor() {
>> >  ...
>> 
>> Makes sense to me.  Peff?
>
> Yes, looks obviously correct. Thanks.
>
> Acked-by: Jeff King <peff@peff.net>

Thanks.

It may not be obvious to many people, so here is tip of the day.

I knew Mischa knew that the patch was prepared with wrong src/dst
prefix (notice the lack of a/ and b/), but I did not say anything
special when I drove "git am".  I just did the usual "git am -s3c"
and the patch was applied just fine ;-)

What is happening is that:

 - I didn't give '-p0" to "git am", so it thought that patch was
   based on a tree that has "git-jump" directory at the top-level
   of the working tree, and the file that is being patched lived at
   "git-jump/git-jump" in Mischa's working tree;

 - However, the official git.git tree has the corresponding file at
   "contrib/git-jump/git-jump", and there is no such file at
   "git-jump/git-jump".

 - The three-way merge logic kicks in because of the "-3" option,
   using a (fake) tree that is shaped like Mischa's tree with the
   version before the patch as a common ancestor, to merge the
   version "git am" thought Mischa has (i.e. no contrib/ directory)
   and the version in my tree.  From the point of view of the
   three-way merge logic, I renamed the path to be in contrib/
   directory while Mischa kept the path intact and fixed the
   contents of the script.  This merges cleanly to produce the
   expected result.
