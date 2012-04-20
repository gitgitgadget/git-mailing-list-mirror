From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC] Git to SVN bridge
Date: Fri, 20 Apr 2012 09:21:16 +0530
Message-ID: <CALkWK0mdzWQRY=fSmyML1p7352c7Lb3vuYoJd+TXSdTmFX1teg@mail.gmail.com>
References: <CALkWK0=Mqo=PMv7+_sr22Dnm6xxzxzaXL=Zh+2LsvT=usC7csw@mail.gmail.com>
 <20120418201050.GB30625@burratino> <CALkWK0=7SPR-4Km5TUwg+rHm30aC7Uru9GJkkfYnL3OORV7nfg@mail.gmail.com>
 <20120419225659.GA4971@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 05:51:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL4sp-00032M-Nj
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 05:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757037Ab2DTDvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 23:51:39 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64277 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab2DTDvi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 23:51:38 -0400
Received: by wgbdr13 with SMTP id dr13so9251083wgb.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 20:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=96bQNMIT00h2WfyNR/vugOko7qJixSZIe3R7yXPX9FQ=;
        b=mvfm/yIpAFuCoqKKm5k9fHVGnKu/oKLYd6ZTVNj0zCUZ50ZMt7tHf1jq+G+sHMM/WF
         CxBd8gvr7VaWOGyOzixhUAdrPFBGIdvX+INixw1OwNb8xQRqqO9gXyNhX43Cdny5V+f1
         uS22ukM9/bV6t2hxRhZrPhJCxuM09HSqUKJ0iLXfpWcPsKAi5ZtOOKp/73PGelu8lDlh
         oSL1vFJwqZOPCXoxYvR16kbPszRcoR6T5Kzupo9O0muMUaHYJu4N6HO86tKgISbAEJK3
         z5ZwXUS/u+Z7mJ8NCLRQgrw+LfbY9AmgtVQBvpxBH1HcS0v81rZW1jCrBFaMVH0fxtiL
         gmWw==
Received: by 10.180.78.105 with SMTP id a9mr2220975wix.20.1334893896524; Thu,
 19 Apr 2012 20:51:36 -0700 (PDT)
Received: by 10.216.53.136 with HTTP; Thu, 19 Apr 2012 20:51:16 -0700 (PDT)
In-Reply-To: <20120419225659.GA4971@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195980>

Jonathan Nieder wrote:
> In other words, if you are hitting a wall with that part which doesn'=
t
> seem to have much to do with differences between git and Subversion
> anyway, I imagine there are easier places to start. =C2=A0Alternative=
ly, if
> you prefer to work on making it easy for an importer to handle "ls"
> and "cat" commands and mark references, I think our previous attempts
> were misguided and we can do better. :) =C2=A0What do you think?

Yeah, I think the fast-export filter was a misguided attempt.  In
addition to git-fast-export, we have to start up a fast-import process
that'll reply to our "ls" and "cat" commands, and I think we'll be
good.  I'm a little more worried about the mapper- I'm finding it hard
to imagine a fast-import stream that contains subdirectories
(branches/*) as opposed to head refs.  Any idea how we'll achieve
that?

    Ram
