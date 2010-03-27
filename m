From: Scott Chacon <schacon@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 05:44:12 -0700
Message-ID: <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com>
References: <20100326215600.GA10910@spearce.org> <4BAD3C6E.4090604@gmail.com>
	 <20100326230537.GC10910@spearce.org>
	 <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
	 <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
	 <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org>
	 <alpine.LFD.2.00.1003262125120.694@xanadu.home>
	 <20100327013443.GE10910@spearce.org>
	 <alpine.LFD.2.00.1003262142121.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Mar 27 13:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvVNJ-0002OC-VV
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 13:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab0C0MoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 08:44:15 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33470 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab0C0MoO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 08:44:14 -0400
Received: by wwe15 with SMTP id 15so7195474wwe.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X3Se8TW/8sJEwtnFecE8lDPkT66ffbhiQE0NZDtsrnY=;
        b=lEkb/BlpMju5ZvE5u3pUouFzM6eVi7iNOJLnd6itqCsFKfbwTufU7459aHV11PJciL
         9dz+QKipaWpbKbh1ujgYF/xoGp/v6NbAKoDQpW4hOl67sv+7wvzgVfki2dho64hBcFor
         fcEbmEXxbx1was+d1R2yS9fkRmZnJGf4Sx1RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZLNKXl2dvFScBuYQrRBHCdfSv3EFC+dCkUNctDYGPzv89AQlmqXe4LjGGuLDfdj47Z
         Hz13yXq4Yxyr47muongK3+SsNXYfVjFh/cNat1Tuqbewy+NlZRarRiRlF7GAbdDCumr7
         8L3sNVK8rMvtfqWrPIrzTxgUa6+DDAKhQsG6U=
Received: by 10.216.52.2 with HTTP; Sat, 27 Mar 2010 05:44:12 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003262142121.694@xanadu.home>
Received: by 10.216.86.206 with SMTP id w56mr1308794wee.1.1269693852926; Sat, 
	27 Mar 2010 05:44:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143328>

Hey,

Sorry it's taken me a bit - I'm traveling right now.

On Fri, Mar 26, 2010 at 6:56 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
>> > > Given that GitHub has blessed the world with this corruption,
>> > > we may need to modify JGit to accept it.

Well, shouldn't it accept it just because CGit accepts it?  Isn't that
an incompatibility in implementation?

>> But GitHub's approach here seems to be "Meh, its fine, don't worry
>> about it".

That isn't really my approach, I actually thought I had fixed this a
while ago.  It seems to be a pretty understandable mistake, since
ls-tree and cat-file -p both output zero padded modes and it is only
an issue on trees with subtrees, obviously, so we don't see it all the
time at GitHub.  I have fixed this and it's in the queue for
deployment which should be in the next few days (I gotta get home
first).

> It's up to GitHub to fork Git then, and while at it stop calling it G=
it
> compatible. =C2=A0Really. =C2=A0If we start to get slack about the pa=
ck format
> like this then every Git reimplementation du jour will make similar
> deviations except in different directions and we'll end up with a mes=
s
> to support.

Really?  It's not the pack format - we use stock Git servers and
almost always have.  It's the tree writing when someone edits a file
inline - I was writing out zero-padded trees. And, it _is_ Git
compatible - CGit only issues a warning, and that only if the
circumstances align such that we write a tree with a subtree, which
again is pretty rare.  There are only a handful of projects like this
and in all CGit circumstances makes no practical difference.

> My stance has always been that the C Git is authoritative with regard=
s to
> formats and protocols. =C2=A0It's up to Github to fix their screw-up.

It is fixed and will be deployed soon, but really, there is no reason
to be snippy.  It is a simple and minor mistake effecting very few
repositories (maybe 100 out of 730k), and the only reason it's an
issue at all is that JGit is not following the authoritative CGit
implementation of basically ignoring it.

Also, if we're all concerned about "Git reimplementation du jour"
deviations, then we need to focus on libifying Git so there isn't a
need for such re-implementations.  I'm hoping to help with a possible
GSoC project on libgit2, but the lack of a linkable library will
ensure that re-implementations in nearly every useful language will
continue.

Scott
