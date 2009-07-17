From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of 
	subtrees separately.
Date: Fri, 17 Jul 2009 11:47:31 -0400
Message-ID: <32541b130907170847g67c89d54ke9426ed8da26a9aa@mail.gmail.com>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com> 
	<32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com> 
	<20090430085853.GA21880@pvv.org> <32541b130904300732i691800f5kecc2f845584071c1@mail.gmail.com> 
	<loom.20090716T160021-218@post.gmane.org> <32541b130907161134n51e070a1l93690d1b8a63bee8@mail.gmail.com> 
	<cdea6cd10907161509g7771c72bl608b1924785b49fc@mail.gmail.com> 
	<32541b130907161527l1955bf06pf54b5099a5988c65@mail.gmail.com> 
	<cdea6cd10907170016u11af7230hbbee92682604530f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrey Smirnov <allter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 17:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRpfJ-0007KI-JX
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 17:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbZGQPr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2009 11:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbZGQPr4
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 11:47:56 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:49669 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964831AbZGQPr4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 11:47:56 -0400
Received: by mail-gx0-f213.google.com with SMTP id 9so1685979gxk.13
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wSCV2tK3C5qhdzUzSu54SGIexTiNyT85KFO2cvDp3ko=;
        b=utLcpLssrgYGnBG7UqSq72NbpGVIl73b35OpJYnmLI7vRr1gcwlAY9A9VaGz/T74NQ
         k8irpW++z44DgfIYjysQpnSa+Clnr3iU+QlfPP6GFe00f0zWKP9it/60u/jthd/wQrlh
         /lkwk4T1IwJk+QhxbMqVnTaCFN2GO3gNIJQ/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i4w2pW7/pD5cd9tnVsErjj8u4PzVGIKRe0sX4BqWhM/IlyVh2MKKL7VTrwEmkjCntQ
         1zS+luXDc0t9XawYBBd5jX+VWozLGs1+8A0Vg9teWwSXiNJvufjRh69fVpfDoK555Yk2
         7UdPdavDciITT3Nxeeayb1z95HOOumbAOr1vQ=
Received: by 10.150.121.5 with SMTP id t5mr2177379ybc.40.1247845671051; Fri, 
	17 Jul 2009 08:47:51 -0700 (PDT)
In-Reply-To: <cdea6cd10907170016u11af7230hbbee92682604530f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123469>

On Fri, Jul 17, 2009 at 3:16 AM, Andrey Smirnov<allter@gmail.com> wrote=
:
> On Fri, Jul 17, 2009 at 2:27 AM, Avery Pennarun<apenwarr> wrote:
>>> The only thing that links git-subtree with git-rebase is the fact, =
that
>>> git-subtree "knows" the target commit for rebases dealing with subt=
rees.
>> rebase doesn't
>> have any parameters called a "target." =A0What does git-subtree know
>> that you don't know?
>
> By "rebase target" I mean the mutual relation of git-rebase <newbase>
> and <upstream> paramaters
> that define where will be the rebased commits. git-subtree can infer
> that NewProj contains library up to
> test-split and that OldProj contains library upto test-split-old. The
> concept of the whole git-subtee workflow
> is still blurry to me though, so I will report when I gather more
> usage statistics.

The problem is that test-split and test-split-old are completely
unrelated trees that have similar-looking files but no common
ancestry.  All git-subtree knows is exactly that.  It can't simplify
anything (in your case) like you seem to think it can.

git-rebase tries to be cleverer, and starts comparing patches and file
similarities so it can graft one tree onto another, and for
convenience, it throws away redundant commits that do exactly what
some other commit did (basically).  This is actually really messy.  As
soon as you get into that situation, you have nothing but a mess.  My
advice would be to clean up the mess as soon as you can (which
appropriate use of git-subtree + git-rebase can help you do).

Then you'll have actual, valid merge history, and git-subtree will be
able to work smoothly using just that.

>> I don't really understand what you're asking for here.
>
> At most I need generic ability to shift merged and rebased
> repository's or ref's "left" (selecting some directory or file)
> and "right" (prepending some directory to all paths) before actual
> operation(s). I.e. the antonym of 'split'
> but without 'add' committree-joining semantics. This can be
> implemented with some chaining/plumbing presets.

I think that if you're having this problem, you should look for a less
ugly solution :)

What I think you're asking for is a way of turning all the commits in
a subdir into a patch stream (which git-subtree split can do,
essentially), but then to add a prefix to all the paths in all the
patches, so that you can then apply those patches on top of some other
repo where the files were in another location.  You can do that, I
guess, but you're not taking advantage of git's convenience.

git-subtree encourages you to think of the files in the subtree as
their own separate project, and you can then merge that separate
project into yours.  That's actually a more accurate model of reality,
I think.

Have fun,

Avery
