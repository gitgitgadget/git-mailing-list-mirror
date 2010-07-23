From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 04:40:44 -0400
Message-ID: <AANLkTinBtXmMei2Q6MZrXWxa3t+_quGdzpcq46EZvgvG@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<20100723083149.GD27082@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"?var Arnfj?r? Bjarmason" <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 10:41:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcDoj-0005mR-Gc
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 10:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab0GWIlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 04:41:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42907 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab0GWIlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 04:41:07 -0400
Received: by wyf19 with SMTP id 19so1323546wyf.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=GGKiiaatvzSNJKTz/aG3xJojknwcbi2/1fvnJxdr9qk=;
        b=i4EUhpOvf1H2K9xzeAaWKKbaKe89gTNQnz5NFaIiFtaiE3uKBqrtqLX4qH+Eki10XR
         lOK+oY8COH8aooDLrPLmq58ypJkd40kJOVrfibDgGsvzO28tubN0T7iR39nH/TjD+SkD
         lz0LYADHfyJpK2QrimRPpcK2o4CEdMCJ3ASqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=M4in0AMzn49r/0LMGyJpbFxpvo5TBRTZ5HBRMvudZgQcIvEgRG/kjip7EUl+rDKS1u
         u+KhtkmCXWX0FKHq77NDV0/ffPcJVbqV76ax/VKetVVWYKrgYtiuz92094r+spTXHu9p
         k4SeJ7/mfi66wdz45hMovqlhD84p6HbdkIGWM=
Received: by 10.227.142.132 with SMTP id q4mr3150531wbu.90.1279874464259; Fri, 
	23 Jul 2010 01:41:04 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Fri, 23 Jul 2010 01:40:44 -0700 (PDT)
In-Reply-To: <20100723083149.GD27082@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151506>

On Fri, Jul 23, 2010 at 4:31 AM, Chris Webb <chris@arachsys.com> wrote:
> You've surely considered this already, but reading your description in this
> thread, my first thought is that commits within trees could mean different
> things depending on whether they're at paths listed in .gitmodules or not.
> If the path is listed, the commit is in an external repository. If it isn't,
> it's a reference to a local commit, allowing submodules to live in the same
> repo as their parent and share some of the advantages you describe for
> sub-tree.

I think it would be better if we could abandon .gitmodules entirely;
it's really only useful for listing repository URLs, and listing
repository URLs is a major part of the problem.

Something that would be neat, and at least vaguely backward-compatible
would be to simply *try* fetching the linked commit objects from a
remote repo, and checking them out from the local repo.  If the
objects exists, fetch/checkout of them will just work; if they don't,
then it can (for backwards compatibility) revert to the current
behaviour.  Push would, if the objects exist, send them to the remote
repo.

Then there could be a .gitconfig option that flips this new behaviour
on and off, ie. auto-checkouts subprojects that *can* be checked out
without any extra knowledge, or not.  If not, then you have to use the
old-style git submodule stuff.

(This proposal is not as easy as it sounds; to do it *right* would
involve not having a separate .git repo for each subproject.  That
means changes to the index file format and a bunch of related stuff.
Though I guess you could keep the sub-repo stuff and it would still be
better than what we have now.)

Have fun,

Avery
