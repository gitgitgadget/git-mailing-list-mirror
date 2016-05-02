From: Daurnimator <quae@daurnimator.com>
Subject: Re: [PATCH] git-stash: Don't GPG sign when stashing changes
Date: Mon, 2 May 2016 16:06:13 +1000
Message-ID: <CAEnbY+fG60mZSKs_d8Lpyb2Czf=UfA9cKOBTtEjEXeUfGE9zLg@mail.gmail.com>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
	<loom.20160407T042319-468@post.gmane.org>
	<alpine.DEB.2.20.1604071017510.2967@virtualbox>
	<CAEnbY+eaReDYOH8azpSG7n7MOrvqORkC0ar80pd1m8wR4vv20A@mail.gmail.com>
	<CAOAY-+1TztY95z3Yi34HB3aYUG5aOHKK9G3OmpYM41ugDMtJUA@mail.gmail.com>
	<alpine.DEB.2.20.1604141748370.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Cameron Currie <me@cameroncurrie.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 02 08:06:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax706-0007ZU-NH
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 08:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbcEBGGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 02:06:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34994 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcEBGGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 02:06:17 -0400
Received: by mail-lf0-f66.google.com with SMTP id u64so23769156lff.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 23:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JwM/jN8DnwGvKz0ju1uJ+6o7WkBTOmVSnAC/qfQf748=;
        b=DeKEk7LK8RmId56OYcD1of00P5z47MtIwNs7t931dg4MvsW3ydZktmepd+c5imx+V6
         E5KgK8I6tW36D0vMYkroBB27CBTo+6PcWK+qzV4KZFFVPWsFfbHjoS4FLnlWZpT0JEOo
         tsGGXN+3FbB+RctYqp2CJyq5D/8djli84d9f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JwM/jN8DnwGvKz0ju1uJ+6o7WkBTOmVSnAC/qfQf748=;
        b=DzA8nE9xyDZt2HDMuv5xdmC412xhMwl2p14WWvVPw52bTfz2+S6EYSMxAVJFodQ0oa
         /ihCNGY8QqW+lyyDMimaJWqqmDXZYYn1GV26uM1b27Sb1lCri5zTgWHfKNFAVTpxXxaJ
         570CfIH/tG2SzBclb99PWBdAqGdAlWAvHITvHuK+7//1pAJosfjn2rn9JhX7n/8UUDWs
         wnAmim/rO6723JKDwUAvey+/qgRYFTuAIucvV/ckGYB34YU/cC2BHWLpkm280pPDt9Vk
         pWBQlUfnG/I5CXmuapgKgVkIw+niDZlmG2Pi3ASeqanaD8nb/fZx3vjKo6XgUlb5mfRa
         TL2g==
X-Gm-Message-State: AOPr4FVDb7Nm2HWmzVum3uwZYfcO9hKEHUNDk5RApTOg3hZWHV78IhgMew4QUVJbdFbeuQ==
X-Received: by 10.112.131.2 with SMTP id oi2mr14175475lbb.67.1462169175250;
        Sun, 01 May 2016 23:06:15 -0700 (PDT)
Received: from mail-lf0-f52.google.com (mail-lf0-f52.google.com. [209.85.215.52])
        by smtp.gmail.com with ESMTPSA id m125sm1415436lfd.27.2016.05.01.23.06.13
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 01 May 2016 23:06:14 -0700 (PDT)
Received: by mail-lf0-f52.google.com with SMTP id j8so45153641lfd.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 23:06:13 -0700 (PDT)
X-Received: by 10.25.15.228 with SMTP id 97mr15429804lfp.126.1462169173587;
 Sun, 01 May 2016 23:06:13 -0700 (PDT)
Received: by 10.25.141.10 with HTTP; Sun, 1 May 2016 23:06:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604141748370.2967@virtualbox>
X-Gmail-Original-Message-ID: <CAEnbY+fG60mZSKs_d8Lpyb2Czf=UfA9cKOBTtEjEXeUfGE9zLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293219>

On 15 April 2016 at 01:50, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Cameron,
>
> On Wed, 13 Apr 2016, Cameron Currie wrote:
>
>> > > On Thu, 7 Apr 2016, daurnimator wrote:
>> > >
>> > >> Cameron Currie <me <at> cameroncurrie.net> writes:
>> > >> > This is helpful for folks with commit.gpgsign = true in their
>> > >> > .gitconfig.
>> > >>
>> > >> > https://github.com/git/git/pull/186
>> > >>
>> > >> I too would like this.
>> > >> Bumping due to lack of attention.
>> > >
>> > > It lacks a Sign-off, our convention is to continue in lower-case
>> > > after the colon in the commit's subject, and I think that it would
>> > > be good to write so much as one paragraph in the commit message.
>>
>> I don't think I can find the time right now. Feel free to rewrite the
>> commit message to match convention.
>
> I am afraid that it would be improper for anybody to add your Sign-off, as
> it is *your* statement that you are indeed contributing this as Open
> Source, and that you indeed are free to do so.
>
> If you do not find the time to take care of these small changes, I fear
> the Git maintainer will *have* to drop your patch to avoid hassle for
> himself.
>
> Ciao,
> Johannes

Cameron, could you please add a sign off to your commit?
It should be as simple as running `git commit --amend -s`
