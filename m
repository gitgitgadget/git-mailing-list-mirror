From: John Szakmeister <john@szakmeister.net>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Tue, 30 Apr 2013 13:58:42 -0400
Message-ID: <CAEBDL5W-xuNhyL81TBGhriAr2jM7CC3FtLhfcbEfEAf9GjCJAQ@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
	<CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
	<20130421160939.GA29341@elie.Belkin>
	<7vli8bu3ne.fsf@alter.siamese.dyndns.org>
	<CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
	<7va9ogezzx.fsf@alter.siamese.dyndns.org>
	<vpqy5c0oson.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEpH-0004Cl-CT
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab3D3R6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:58:46 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:63111 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760832Ab3D3R6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:58:44 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so753291wgh.12
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=pBaiEg6kd2w5YxUkHeI9DDykBsJNP0hU/lr/CkSLJps=;
        b=NYsIq16j9oMkPFY5qPx7eZm9wwArse6YHkOTnzbaAsD0EPD8K+t2X6ClLcXx8U1rl8
         7t44uvOM+J/GeQkN+FOhbmj8BF3hX0o4xPZfEwMyVENP5ca4VEt6aVRDTS8eQ78a0bX/
         qSJz5FtEQsTn7n9njOC4P5FKOo58cIK5mikwlZKBBAyEKvZefNaOzR+OyJ231tBIgtOv
         zzTTaFp34L03fnRO+8RTPJlL5WytpIm8Pl60qZznFk+OItGmPlIfRzzuGKyn1NTVNAWO
         UbD3oFH3ipNyYhRl9RLC5gvO2988FKe7O+h0u5bbjpNGLXoeLoux4Cifa0RVK0S4IMf7
         ppkQ==
X-Received: by 10.180.105.195 with SMTP id go3mr26334060wib.2.1367344722626;
 Tue, 30 Apr 2013 10:58:42 -0700 (PDT)
Received: by 10.180.108.240 with HTTP; Tue, 30 Apr 2013 10:58:42 -0700 (PDT)
In-Reply-To: <vpqy5c0oson.fsf@grenoble-inp.fr>
X-Google-Sender-Auth: Orh_YtZrkkHM8q45XkQbg4SfZ6M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222976>

On Tue, Apr 30, 2013 at 1:05 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> By the way, these options are _not_ about "showing merge commits
>> that introduce code", and they do not help your kind of "security".
>> As I repeatedly said, you would need "-p -m" for that.
>
> Actually, while defaulting to --cc may be convenient, it would indeed
> increase the security risk: currently, "git log -p" shows nothing for
> merges, so it's rather clear that _everything_ is omitted. With --cc,
> the user would see a diff, and could hardly guess that not everything is
> shown without reading the doc very carefully.

I don't believe it's that clear.  I bet people assume there's nothing
to show, and unless you dig in and discover that `-p` doesn't include
merges.  In git 1.8.2, `git help log` doesn't seem to make any mention
of `-p` not showing a diff for merges.

Just to see, I asked several people around here whether they knew `-p`
didn't show diffs for merges, and they were all surprised that diffs
were being omitted for merge commits.

-John
