From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Disallow amending published commits?
Date: Sat, 21 Mar 2009 21:53:49 -0400
Message-ID: <eaa105840903211853p65327ffdvebbe28da5f256871@mail.gmail.com>
References: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
	 <eaa105840903211146s4ff398e3qa8b570a8d29a83f4@mail.gmail.com>
	 <885649360903211549h751c19e6sbaa0e07a14413d19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 02:58:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlCxA-00059M-RJ
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 02:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbZCVBxx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 21:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZCVBxw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 21:53:52 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:2938 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbZCVBxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2009 21:53:51 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1611459ywb.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 18:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=eMZ/Vidsb5yA8TiykcnhowljzepKnsKeZUlnRedEMlU=;
        b=Pzrk5uzlw+aeUv7XMT8pWln2tNdb7Kc5aokVRWonybRnx/FIqYMHSXo4jiOjWMwLPM
         E45C6LjTAJIl+XFungZxDSoj0+/NqzCl2g9KVSjMXYjHh3pFjg7/P4JwBOVehAl5eJwg
         yGwJetrYzv7/zidMG6DJ8qnzDo8zJwzNM2P8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=OPsaxYSME47bEo9A91OYIeqZTd3ginvcYVOhXLRS2b+ZGqg4w4+y+9rDqw00owMALG
         YFnexY38VPg7+SzxZhpfrKWeULCBtOjJP41OcqpyErAz5IcebolPmBrCOA2OEdSf0WtO
         BrhZ5ngKRyqrxYraSfQeZUFJLUt+7cuP6ezCU=
Received: by 10.90.74.9 with SMTP id w9mr3181562aga.75.1237686829668; Sat, 21 
	Mar 2009 18:53:49 -0700 (PDT)
In-Reply-To: <885649360903211549h751c19e6sbaa0e07a14413d19@mail.gmail.com>
X-Google-Sender-Auth: f63bf091689391ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114108>

On Sat, Mar 21, 2009 at 6:49 PM, James Pickens wrote:
> On Sat, Mar 21, 2009, Peter Harris <git@peter.is-a-geek.org> wrote:
>> Set receive.denyNonFastForwards if you don't want people to be able =
to
>> amend (or otherwise rewind) published history.
>
> Thanks, but unfortunately that won't work in our workflow. =A0Users n=
ever
> push their changes; instead, they do a turnin to a continuous integra=
tion
> server. =A0The server clones the central repo, pulls their changes in=
to the
> clone, builds and tests it, then pushes to the central repo if it pas=
ses
> the tests. =A0So integration happens via 'pull' instead of 'push'.
>
> We can't force the pulls to be fast forward only, because we need to =
allow
> turnins from multiple users to be built and tested in parallel, witho=
ut
> requiring users to pull from each other or otherwise coordinate their
> turnins.

Okay. So in that workflow, you won't ever lose the original history.

If someone creates an alternate history that differs only slightly,
odds are your continuous integration server will get a merge conflict.
Presumably it will reject the pull request at that point.

If it doesn't conflict, you'll have both alternate histories. So
nothing is lost.

Maybe I'm misunderstanding the question? (That is definitely possible.
The idea that a person would go to the effort of rewriting history -
especially when that person knows the original history would stay put
- often enough to cause problems is like suggesting that a person
might write log messages in latin. I'm having a hard time envisioning
the need to write down a social rule about it, much less the need to
write an AI to try to detect it.)

Peter Harris
