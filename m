From: Aneurin Price <aneurin.price@gmail.com>
Subject: Re: Git and Amazon S3
Date: Wed, 3 Feb 2010 12:05:42 +0000
Message-ID: <501db8661002030405h23e940e7r6e8fd0149818c80f@mail.gmail.com>
References: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
	 <20100202194455.GO9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 03 13:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcdzW-0005vs-9w
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 13:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230Ab0BCMFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 07:05:49 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:49091 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167Ab0BCMFs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 07:05:48 -0500
Received: by ewy28 with SMTP id 28so1293305ewy.28
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 04:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=czwfKcFFV5hhDfiX/ET13KSi1d8o7FqUSMjwuA24RPk=;
        b=J98kgzxrn5eB7kJ8pIUpQcycCPGoxUTBIn/bhwq9713RCbK03MyaN7DJaGA0tocWCX
         4nHBUYXA6HXmHQ48IARvBl+mbQ1/HRau70UluPfWeJUlV9w1dNmjo4nmvOqZbWXXek54
         fcexPNncS+ZtBi1e3NyqXxGbreSOeH+o9dg5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rlFgsK0b7Z/lse/EjWs8ZW8cACi3Y4+09wzFBmHfK3B1aUu4vic4R3EOCmkQYirNwz
         U9yP10I+s8mAvxru6VYU/eyZlgXp9pJxhndVhokcvz5yt3DpqNtpmu9PalDdwFjz2JXk
         qDZmhYg1eQ6ze5Ck5oG8gEsjVEaKxV1ffoNBQ=
Received: by 10.216.87.79 with SMTP id x57mr4769921wee.83.1265198742701; Wed, 
	03 Feb 2010 04:05:42 -0800 (PST)
In-Reply-To: <20100202194455.GO9553@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138831>

Thanks for the replies everyone.

On Tue, Feb 2, 2010 at 19:44, Petr Baudis <pasky@suse.cz> wrote:
> On Tue, Feb 02, 2010 at 01:56:41PM +0000, Aneurin Price wrote:
>> Does anyone have any remarks about these options? Is there a better option - how
>> difficult would it be to add native support to git?
>
>  I'm not really familiar with Amazon S3 _or_ the current transport
> code, but by cursory examination of both, it seems that it would be
> fairly easy to add support for another transfer. And it might be even
> better idea to actually just add generic support to invoke an external
> helper to perform all the heavy lifting.
>
>  Basically, all the abstraction is already pre-cooked in the form of
> rsync protocol support. I would just cut'n'paste that and replace rsync
> magic with simple calls to external helper along some sensible simple
> API, then code up an easy wrapper for S3 there. Or just add S3 API
> support directly to core Git - it doesn't seem to be licence-encumbered.
> Should take just a couple of hours including debugging, if you just
> copy the existing rsync support functions.
>

This sounds like the most interesting option, if not necessarily the most
practical. I've also discovered s3cmd (http://s3tools.org/s3cmd) which seems to
be widely packaged and could probably serve nicely as that wrapper.

If I can manage to get those couple of hours free at some point I'll give it a
go. Is this something that might be a mergeable feature?

Thanks again,
Aneurin Price
