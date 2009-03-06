From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: orthogonal cases of log --date option
Date: Fri, 6 Mar 2009 01:58:36 -0500
Message-ID: <76718490903052258j277fa8e9g963deae1c3264a22@mail.gmail.com>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
	 <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
	 <20090305104304.GA17760@coredump.intra.peff.net>
	 <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com>
	 <20090305211120.GB20157@coredump.intra.peff.net>
	 <7vy6vjy5js.fsf@gitster.siamese.dyndns.org>
	 <20090306052318.GB3426@sigill.intra.peff.net>
	 <7vmybzw3el.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 08:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfU2T-0006kH-8F
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 08:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbZCFG6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 01:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbZCFG6k
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 01:58:40 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:32720 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbZCFG6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 01:58:39 -0500
Received: by rv-out-0506.google.com with SMTP id g37so359335rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 22:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L28IWJXP4yyj3l8eWy3z27VJErYh2F8Nm+8BJUrVbZo=;
        b=ehlcZjAUAtRqn3nCXDA97dL6OwT/k7IKDbpk65JxvtrVN+QvRgaWuaban5UFpEa4Lk
         6tfyA4Tj3cT4PhUTB0GbN0EWuSP9i1kOM9AwaQKV+X29fCMtrMO5QLa2QlaCouTosbr0
         6y5WVI+VDdpus751TUrtPNOH/D1CU29NL7h64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P3Vz0ABdTAtp1sTbe577YP91E+M3aJxke4KYd3d56JEiWRPRg/nwnr03OtjHXJ0ZW0
         WU7lBv9/sJeLexc34mM0w4q4cEbJhtW/OFO6E7vphjx+iEmCeRrzp96kzGeCEUVhrK3a
         2NqYTfZx3VvxgPzf2mOWT4z/qyLAlR/9h84wc=
Received: by 10.141.99.2 with SMTP id b2mr1107400rvm.182.1236322716884; Thu, 
	05 Mar 2009 22:58:36 -0800 (PST)
In-Reply-To: <7vmybzw3el.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112394>

On Fri, Mar 6, 2009 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Because from the user's perspective --foo={bar,baz,bleep} is about
>> selecting exactly one of {bar,baz,bleep}.
>
> I do not feel very strongly about this either way, and without any prior
> end user "Huh?" input, I would probably have argued like you myself, but
> I saw the original message from Miles about giving more than one --date
> and getting perplexed to see that it did not work, so...
>
> I am not likely to use --tz=Indian/Christmas myself; GMT and local might
> however be useful in some situations, though.

So I don't mind picking this up, but I'd like some guidance. There are
two issues:

1) The CLI. You and Jeff don't seem to have an agreement here, but
frankly, this is the easy part.

2) The internal implementation. Your implementation (enum -> bitfield)
is clever, but Jeff seems to prefer what I suggested (going to a
struct). The latter is quite a bit more work.

If we only care about fixing the original issue, I'll just pickup your
patch, make sure it compiles, and add some tests. I certainly don't
want to do more work than is needed, unless there's  a good reason to
do so.

j.
