From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 30 Mar 2010 10:52:25 +0800
Message-ID: <41f08ee11003291952r467601b1o970ce3be802d8521@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <201003282120.40536.trast@student.ethz.ch>
	 <41f08ee11003282114m34aa0f61w536b996dce6cecab@mail.gmail.com>
	 <201003292042.01549.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 30 04:52:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwRZB-0002Rz-1C
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 04:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab0C3Cw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 22:52:28 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:43741 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab0C3Cw1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 22:52:27 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3508052qwh.37
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 19:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x/Yxq0TO8CZkuG54wn7vDzsH3L6dyySUL4qdGPjeiZY=;
        b=g8rvlx3A6S84xIhryvCMKGN7ZpVZ8ej9I8XERdtgDHHfeqmyrvRpcbtNF7PVDPQtbR
         OlyILuz2/CtMmz8SEh/hesuIBIp+dpiHPRur2r/3S1ZSyrXEymfwBa/3IM4bbhIwxvBk
         wqM3+vK4xxaj93WWuP8ccVv01i9Cga3XcvBU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wtrV4zNMdpaoBgbgSBQcIQtpNbKq0aCGBzqpi+SH3rFweJjmMHRDpii7N5b2XIC0ZV
         bjFzSRowa3aaaeSItEBX55EB0nPpVEihvfz0bTX8yogqyXL74AlUWd2KS7C0MORAvO7y
         Uhl9VwgvN5DWY53rbCY2P0Wm/MwRvWer/WPM0=
Received: by 10.229.84.72 with HTTP; Mon, 29 Mar 2010 19:52:25 -0700 (PDT)
In-Reply-To: <201003292042.01549.trast@student.ethz.ch>
Received: by 10.229.213.133 with SMTP id gw5mr320727qcb.13.1269917546074; Mon, 
	29 Mar 2010 19:52:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143537>

Hi Thomas,

On Tue, Mar 30, 2010 at 2:42 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>
> Is this really the right use-case? =A0AFAICT the answer to the implie=
d
> question is given by simply running 'git blame -M 93fc05e:pretty.c'.
>
> (Coming up with a better example should be easy; the way I currently
> think of the feature means that it will mostly replace git-blame for
> me...)

I will cite the same example below in the scenario. :)

> I would, by far, prefer the latter. =A0So far 'git log' has always be=
en
> noninteractive, and there's no really good way to make it interactive
> because it also goes through the pager. =A0(In the case of blame this=
 is
> solved in 'git gui blame', which might also be a reasonable approach.=
)
>
> OTOH, if you can really fake a history walk, then just about any
> log-oriented tool should be able to work with it. =A0You'd get graphi=
cal
> output for free with gitk and git log --graph. =A0I haven't really
> thought through the ramifications, though.

Ok, so let us try to abandon the interactive way totally.

>> =3D=3D=3D=3D=3DWork and technical issues=3D=3D=3D=3D=3D
>> =3D=3DScenario=3D=3D
>> For how we use the line level browser and how the utility should act
>> to us, here is an scenario:
>> http://article.gmane.org/gmane.comp.version-control.git/143024/match=
=3Dline+level+history+browser
>> It contains code movement between files but not code copy and fuzzy =
matching.
>
> I would prefer if you could inline a short example, perhaps starting
> at your second diff snippet. =A0Examples are good ;-)
>
> Even if not, please drop the /match=3D parameter since it is very
> distracting.

I put the example at the end of the proposal as a reference.

>
>> 7. Reuse 'git log' existing options as many as possible.
>
> One thing that IMO is missing from this list, is a plumbing mode that
> just feeds the raw data to a (presumed) frontend. =A0It could be as
> simple as supporting
>
> =A0git log -L ... --pretty=3Draw --raw
>
> or similar, if this provides sufficient information. =A0Compare 'git
> blame --porcelain'.

Very good feedback, I will add this, thanks a lot!

>
> This section is too handwavy for my taste. =A0I think in most cases y=
ou
> say "we can" when you really mean "git-blame already does it, so we
> can just use a similar algorithm". =A0Which is fine, but I'd rather s=
ee
> it spelled out so as to see what is not already covered by blame's co=
de.

Changed in next version to make this clear. But only add some words to
state that 'blame does similar' :)

>
> Push the code somewhere public as you go, even between feature
> completions. =A0Post RFCs once you have workable features so people c=
an
> comment. =A0Generally try to be visible.
>
> Bonus points if you can think of something visible to do during the
> period where you look at code,

Yeah, really is a good point. And I have tried to play around on
github.com and try to set up a http://github.com/byang/my_git for this
purpose. :)

>> April 26 - May 23:
>> 1st week, follow the bird's eye view on Git's source code.
>> 2nd week, have a look at the code of merge-base, analyze the rev-lis=
tmachinery
>> 3rd week, have a look at builtin/log.c,
>> 4th week, understand blame.c
>
> whether it be documenting your learnings in some way, improving docs
> as you go, or documenting the APIs you find.

Thanks a lot for this good advice, I will do so.

With these feedback, I think I can make up a complete version of the
proposal and submit it to Google. Thanks!

Regards!
Bo
