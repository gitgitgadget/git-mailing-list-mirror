From: =?ISO-8859-2?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
Subject: Re: Question about right-only
Date: Tue, 06 Sep 2011 17:42:26 +0200
Message-ID: <4E663F62.7030603@intland.com>
References: <4E6607B2.2090000@intland.com> <ec1404d75fd6461fa731f31625126884-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: mfwitten@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 06 17:43:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0xnd-0006bH-U2
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 17:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab1IFPmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Sep 2011 11:42:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:61042 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab1IFPmw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 11:42:52 -0400
Received: from [192.168.1.101] (77-234-81-240.pool.digikabel.hu [77.234.81.240])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LosLT-1Rgaw63Fxj-00gL7m; Tue, 06 Sep 2011 17:42:50 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <ec1404d75fd6461fa731f31625126884-mfwitten@gmail.com>
X-Provags-ID: V02:K0:w/jx8/jRYi+qCOWt9gsE5IxQeL1yt+uzURrZTPINwob
 pCcQVHehvEu0MPbn5tCM5hfRTIQCkAKY8kydrxxyuNKc9yEctZ
 sQN4gBhmeuEr+Its1FEbGP4aJgjj4F2Rw+uZQpsPJ86U39FnFC
 mZYTeILAXKp3XIA4L27eCm9WrhGLZiY7dfCLe+5RJp6f+RSa3x
 H8hZu2SdZ8q7x7XapXHlG2oZ8p9xk27GzT+GWE5g8/nNJKcb76
 pErNPtFdO2qPgLMYQZpjNzUoDVLQfOg/+Jy1VJA8W+1Bt8Cfyc
 WRC4nIFhe7vl5wcyqbE2WHtLUyOpbreOFnDgF3iRVGzoNeRMUW
 KT9q01P73OE0QlBBMA2U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180807>

Thanks four your answer, it was really great help (cleared up everythin=
g)!

Best regards,
=C1kos Tajti

2011.09.06. 17:24 keltez=E9ssel, mfwitten@gmail.com =EDrta:
> On Tue, 06 Sep 2011 13:44:50 +0200, Tajti wrote:
>
>> what does the right-only option of git-log actually do? The manual i=
s
>> not too verbose about it.
> The documentation is indeed a bit messy, so let me rearrange it for y=
ou.
>
>  From `git help rev-parse':
>
>    r1...r2 is called symmetric difference of r1 and r2 and is
>    defined as `r1 r2 --not $(git merge-base --all r1 r2)'. It is
>    the set of commits that are reachable from either one of r1 or
>    r2 but not from both.
>
> Then we have this from `git help log':
>
>    --left-right
>        Mark which side of a symmetric diff a commit is reachable
>        from. Commits from the left side [(r1 above)] are prefixed wit=
h
>        <  and those from the right [(r2 above)] with>...
>
> which should explain what `<' and `>' mean in the following from
> `git help log':
>
>    --left-only, --right-only
>        List only commits on the respective side of a symmetric
>        range, i.e. only those which would be marked<  resp.>  by
>        --left-right.
>
> This is probably most useful with the following option, described
> in `git help log':
>
>    --cherry-pick
>        Omit any commit that introduces the same change as another
>        commit on the "other side" when the set of commits are
>        limited with symmetric difference.
>
>        ...
>
>        For example, --cherry-pick --right-only A...B omits those
>        commits from B which are in A or are patch-equivalent to a
>        commit in A. In other words, this lists the + commits from
>        git cherry A B. More precisely, --cherry-pick --right-only
>        --no-merges gives the exact list.
>
> That is, you often run into multiple commit objects that are unique
> because of, say, differing commit dates, but that actually introduce
> the same change to the source; this combination of options is helpful
> in weeding out commits that introduce the same change.
>
> If you're still confused, don't hesitate to poke the list some more;
> the documentation is quite lacking over all topics, so don't feel
> stupid.
