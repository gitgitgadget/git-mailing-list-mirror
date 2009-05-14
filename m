From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: how to update origin/<branch> after a push to origin <branch>?
Date: Thu, 14 May 2009 01:29:49 -0400
Message-ID: <32541b130905132229nf873a39m4b7c93e3bac0f39c@mail.gmail.com>
References: <19640.1242276135@relay.known.net> <32541b130905132158s44cc5b19n974901c05cf025b2@mail.gmail.com> 
	<20329.1242278469@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Thu May 14 07:30:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4TWO-0000sK-5I
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 07:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbZENFaL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 01:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbZENFaJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 01:30:09 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:19065 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbZENFaI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 01:30:08 -0400
Received: by yx-out-2324.google.com with SMTP id 3so621938yxj.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 22:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xJl6JWw0xKlemF5gSUvNX392WBqt1nbjj0SAOraDrFo=;
        b=bYnronJjRnhYy0RL/zn373D2XauxtER9qXSnfHx9Jax6ILdtwVHxbUmVjJncmT5PvP
         C/YTG/ts9OC7L+bvhjT2Ak26BC6CZFSWWZH3b8NfZNVfZ2fcHKgHaSb27H5Ah6UAIPPv
         kh9Te8vfIZshcCAzKK+RphSFKfQw7ub9bujG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xBDqRCpsVtrd/vuRlmlVFHBsjaejZIL26Owt6ymGd/KtujW/ZY/HX6atgB5tSdebuH
         vEZ/e7VlaShbuqD+w1JmKCyby1unPiaqkIyV9CIfh/EOCdXDjeguPTi9kVg+asSCMHhF
         CxzWXG3DvMsnh9fB8pvIgPKk44dlCbE7MoQR4=
Received: by 10.151.121.9 with SMTP id y9mr2816326ybm.125.1242279009316; Wed, 
	13 May 2009 22:30:09 -0700 (PDT)
In-Reply-To: <20329.1242278469@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119143>

On Thu, May 14, 2009 at 1:21 AM, layer <layer@known.net> wrote:
> Avery Pennarun <apenwarr@gmail.com> wrote:
>>> Short answer:
>>>
>>> =A0 =A0git fetch origin
>
> I wasn't doing exactly this, but I was doing the equivalent of
>
> =A0git fetch $(git config --get remote.origin.url)
>
> Why would these be different?

If you fetch only based on URL, then git doesn't know the name of that
url is 'origin', and thus can't possibly know that it's supposed to
replace origin/master.

BTW, the reason 'git fetch origin master' doesn't work is completely
unrelated: in *that* case, that syntax means you want to fetch the
branch named master, but you're going to do something specific to it,
so it ends up being stored as FETCH_HEAD instead.  Generally you don't
want to use that syntax.

Avery
