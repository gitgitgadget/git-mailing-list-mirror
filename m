From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Wed, 28 Jan 2009 09:48:25 +0000
Message-ID: <e2b179460901280148u6413c650l25f09b60d753a8e6@mail.gmail.com>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com>
	 <20090126210027.GG27604@coredump.intra.peff.net>
	 <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com>
	 <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com>
	 <e2b179460901270210q69fe1e42xb801553e4e9005e9@mail.gmail.com>
	 <BAD975AD-323D-4278-8405-0B57E7202797@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Perry Smith <pedzsan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 10:49:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS73Q-00013o-OV
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 10:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbZA1Js2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 04:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbZA1Js1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 04:48:27 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:51323 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZA1Js0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 04:48:26 -0500
Received: by qyk4 with SMTP id 4so7809686qyk.13
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uZg9HxLy77dSmjotsTMQq/7lP1tz67k+5MQNkonC00Q=;
        b=bf06417j8ChaXD26QfJY/VkDhW4K7gyPVdsZSgIXnZaU7ezxI02Jy0c2Tml9YpLh/4
         rjO7NWy/63bMEcRELPkriNx5zmWh7HXkkhu+Nmg7PQaXvvYP+OtcZWukRFo5r+4YSLtr
         qvQkNUr0HNjWVh5Gyu72IbD/UK2BN6RFsNkr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AJ3YivBCiTFmaj3M+fvuDj6CpoSSdcyvXZDzhAfcnaI8lir1Nat+LkBDwwMq6J3du5
         LHon47/nDP/pIKbRU4lvjJvURsKuAEDdQUNdrm11VhPcE1NeGOYjL3G7gBjtEPlsmkTE
         vva/D7wFowxhBOL66B7lTqq9lHTLvpp+gKTX0=
Received: by 10.215.39.6 with SMTP id r6mr5520538qaj.15.1233136105217; Wed, 28 
	Jan 2009 01:48:25 -0800 (PST)
In-Reply-To: <BAD975AD-323D-4278-8405-0B57E7202797@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107515>

2009/1/28 Perry Smith <pedzsan@gmail.com>:
> Sorry... I thought "out of tree" was a universal term.

No, my mistake, I didn't think about what you meant.

> About 90% of the open source configure / autoconf code out there can do this
> with. The other 10% you can not.  I like it because when things die, its easier to
> grep around the source tree and I blow away the build directory and start back over and
> I know that I'm starting fresh.

Even if you're only building git, unless disc space is tight, I'd
probably recommend cloning the git.git repository, then you can either
use make clean or git clean, plus it makes updating to
latest/arbitrary versions easier. Anyway, I don't think your setup is
wrong.

> Yea, part of my larger quest is to start a web site to provide AIX builds
> of open source images as installp images.  I have not added iconv to the
> mix yet because I fear bad interactions with GNU's and AIX's.  In theory,
> AIX's commands should use AIX's library but it would not surprise me if there are
> a few AIX applications that are not built properly.

A pity package distribution for AIX is so fragmented, but when IBM had
the ball, they dropped it. Mail me if you want links to other existing
sites who might appreciate contributed builds.

>  I assume the GIT_SKIP_TESTS is done:
It's documented in test/README

> I just tried setting SHELL_PATH (and exporting it) and the make test gets
> into the second batch and then fails two tests. ... now test 10 of t0001.sh
> fails because test_cmp can not be found.
>
> Is that a GNU tool?  (I didn't see it in git or coreutils.)

As Peff said, there's a wrapper around either diff -u or a user
supplied comparison tool (e.g. cmp) set in GIT_TEST_CMP. Setting it to
cmp works fine on AIX if you don't have a diff which takes -u on your
PATH.

As (at the moment) you need bash, gcc, gmake and ginstall to build,
test and (maybe) run all parts of git on AIX, I haven't set up a clean
environment to try and flush out any other quirks to get git to
build/test/run on a stock AIX with no GNU tools installed. For obvious
reasons such AIX machines being used for dev purposes are (I believe)
rare.

Mike
