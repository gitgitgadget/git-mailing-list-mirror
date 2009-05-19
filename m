From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: committing to a checked out branch
Date: Tue, 19 May 2009 11:21:52 -0400
Message-ID: <76718490905190821p1776905bn53610c0e8acd0113@mail.gmail.com>
References: <bbd12f0f0905181733h6a9537d2hf4e6b7a1384fa32d@mail.gmail.com>
	 <76718490905181917u1f41e06dq9cf527a1dac9bea5@mail.gmail.com>
	 <bbd12f0f0905190809k3dc13c3ak170535a5c0eed9b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff Brown <jeff@jeffandbetsy.net>
X-From: git-owner@vger.kernel.org Tue May 19 17:22:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6R8l-00020N-7E
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 17:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbZESPVw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 11:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbZESPVv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 11:21:51 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:60503 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbZESPVv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 11:21:51 -0400
Received: by gxk10 with SMTP id 10so7595192gxk.13
        for <git@vger.kernel.org>; Tue, 19 May 2009 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4AH999zARkXQg9hkZbnXsTGdh7ILAWYubhMytTIyeb8=;
        b=AXiuLW5/AVbi7Km53ycF2JuwiZAq2cDK09JApeNfaPWEUk/vNitmq/LZm3UUgCqVV3
         JxErE4RBvkDiQu5h2LMPytHkKfy7fLmeHN1sQXKYEHpt5qUG0ak/4b6weC7yRmvCh2ch
         o0H3Nv0BFEa3IHY4AyULA4DENqcQyAALTWdLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DKAnhSdU0lUE174GoyxHmr3jEukbZMmYv1lPvFT52ozxb6AeX+Q8YrisQwaNTGapuo
         7pzTyKCkJgca/w3QqzWdUlbOGlq7k0/doCxnVibzHv0fZWJ+A0ddnzEK50XaKPxSj4Ra
         p9Fi5MXm5djFu6XmTrDgY09jW5AyKr1KWT/IM=
Received: by 10.151.121.9 with SMTP id y9mr452685ybm.125.1242746512187; Tue, 
	19 May 2009 08:21:52 -0700 (PDT)
In-Reply-To: <bbd12f0f0905190809k3dc13c3ak170535a5c0eed9b9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119537>

On Tue, May 19, 2009 at 11:09 AM, Jeff Brown <jeff@jeffandbetsy.net> wr=
ote:
> When I create a new repo on my server I have been creating an empty
> directory, then git init, then git add some file and commit. =C2=A0I =
expect
> that is the long/wrong way to initialize a repo, especially if I want
> it to be bare. =C2=A0What is the best approach to creating a cloneabl=
e bare
> repo?

server$ mkdir /path/to/newrepo.git
server$ cd /path/to/newrepo.git && git init --bare
laptop$ git clone ssh://server/path/to/newrepo.git
laptop$ cd newrepo
laptop$ # add; commit; add; commit; ...
laptop$ git push origin master

(This may only work with recent versions of git as I believe earlier
versions used to complain about cloning an empty repository.)

j.
