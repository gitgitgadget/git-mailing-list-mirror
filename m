From: demerphq <demerphq@gmail.com>
Subject: Re: git-rev-parse --symbolic-abbrev-name [was Re: git-branch --print-current]
Date: Sun, 4 Jan 2009 13:40:08 +0100
Message-ID: <9b18b3110901040440i70ce50d0v8996b8fef33a58cf@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	 <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
	 <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
	 <20090104033839.GD21154@genesis.frugalware.org>
	 <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
	 <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
	 <quack.20090104T0434.lthfxjz1c8x_-_@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"David Aguilar" <davvid@gmail.com>,
	"Git mailing list" <git@vger.kernel.org>
To: "Karl Chen" <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Sun Jan 04 13:41:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJSIQ-0001B6-A1
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 13:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbZADMkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 07:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbZADMkM
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 07:40:12 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:16404 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbZADMkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 07:40:11 -0500
Received: by qw-out-2122.google.com with SMTP id 3so6016199qwe.37
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 04:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WpcznK0jCUaV4uv08+fITzTQhJWW4Qzg0cwsuwZ2zzw=;
        b=UcAa1/dbg1Ii0HVm94yfsA2TGKtA75rJaLBbUMhIUAxvmqbbnxfnJTy+gK8VY1Vur5
         lbICHICAJir/n0HINcoInuVeIHnq/Uyn2puQY5CGnFCYt1qO2JJJJkYy8POuccNFfW3q
         BsiTy3um+Zxu6QPzkHo1Qi0w0ArkfDjN/hp7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oLwH9Xk2mTUu2r8amFYGq072iA3gSa6OaRmPAUryD15Am0M/fDahM/x6PYLhH9mS2M
         yijhdj8Xd0s5uu4NSD+K46zV6A9ryQT7uNIdvfDAiuKOZl12oGmWCuAEbqzk6MLjClFO
         1o/DDQ9KWUr4xD9/UGBJwCvTFkjWjENp8cLmo=
Received: by 10.215.40.9 with SMTP id s9mr220018qaj.123.1231072808631;
        Sun, 04 Jan 2009 04:40:08 -0800 (PST)
Received: by 10.214.241.2 with HTTP; Sun, 4 Jan 2009 04:40:08 -0800 (PST)
In-Reply-To: <quack.20090104T0434.lthfxjz1c8x_-_@roar.cs.berkeley.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104512>

2009/1/4 Karl Chen <quarl@cs.berkeley.edu>:
>>>>>> On 2009-01-03 21:17 PST, Junio C Hamano writes:
>
>    Junio> That is a good point about user education, and is a
>    Junio> demonstration why a new option to cover a very
>    Junio> narrow-special case to symbolic-ref will not help the
>    Junio> situation.  People will add their own embellishments
>    Junio> around the name of the branch anyway, and the most
>    Junio> generic symbolic-ref output is just as useful as a
>    Junio> special case option to show without refs/heads/.
>
> That's arguable :) you really think "branchfoo" instead of
> "refs/heads/branchfoo" is a narrow special case?  Seems like a
> common case for everyone except plumbing tools.

I agree. All the scripting I've done involves using the non qualified form.

> Here's a more general idea you might like better:
>
>    git symbolic-ref --abbrev BLAH
> or even
>    git rev-parse --symbolic-abbrev-name BLAH
>
> This would be like git-rev-parse --symbolic-full-name, but strips
> the "refs/x/" iff the result is unambiguous.  Since it's much more
> work for a script to check whether the stripped version is
> ambiguous, this functionality is appropriate as a builtin option.

I vote for this, I could and would use it many scripts. Also please
dont make it die if BLAH is not a symbolic ref if this option is used.
Just return nothing.

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
