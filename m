Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F30ECAAA1
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 11:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiILLQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiILLQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 07:16:36 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AF4113A
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662981387;
        bh=ozMh8A+KpYtM6Z6c7+nrMyQsl982ntl0doEfcW5R/5s=;
        h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
        b=GbVRPjHvw4JIHTs2JebPf7kToHbfbXOwO+4LQzuw93djWvdP2vmt+ZktwhGlILPRr
         4B+YDsYMpCODp4ag8U8XQHcJCiPHicSNoesdhra1DgmVg8RMY2sp+XzTLisVd34Dhm
         jr8o3zoC18NLH3fF4JdwIY/1ksoGnB1WxCZMxwzU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.21.137]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1ovjYw1Zer-00Si08; Mon, 12
 Sep 2022 13:16:27 +0200
Message-ID: <9e0c1a2c-542b-156f-4c70-371d3a9b452d@web.de>
Date:   Mon, 12 Sep 2022 13:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: git diff ^! syntax stopped working for stashes in Git 2.28
To:     Tim Jaacks <tim.jaacks@garz-fricke.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <6f729c8c43c4409faf6a11a69791f45a@garz-fricke.com>
Content-Language: en-US
Cc:     Chris Torek <chris.torek@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <6f729c8c43c4409faf6a11a69791f45a@garz-fricke.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:15peISS5YpH6LJs0FqBnsN3Y1+O+2gkdI38Tk/9xbDU5d7pzQP6
 n25LeJH1VAvGCZJvj0c+z6f7/kxqfUMWihehQxOkSlj4kHauPzsHRqL1JyCt+Dr26o+kgxG
 JFLhp1pqVOKPMyyLH7OESufmKbeGAV/aZNKnHTvXVtv+9grTk3cy9suqrWnu5APFwXn7DLD
 0sCY8Vo6lS2OFzGjSMjJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nJM4HP81gs0=:pJq3LU2pZmO7fhf3AJodx6
 sm7OfgnNZBbvf9XtWtMH1D6CjYsesVSh4pEEUPnBuaURfDOTNEoqCGIg+bRpF5Ez4gdPtGgVL
 hdxn0gIshd+8/LHT+R3uXK6I0KNJkRfL2zURwqVj7Gjo1dIL0jyASvo38P80HjNyuB2RZS2V/
 EIFv1m96NLxYjmRryy01Cf3WudCtqbOlM6AgiSArPBT4T1OmxYPFmxQmqfCSv70hjQYyoJ31i
 7uORoiy3/UBRyvz0ju1wOF8LfsTxUMmihYEOPHaj7gO85CVcZSkt5piQL/HyY8chsCjfhVQMF
 J5aejJbUiLfgZlpei142B4NDIwICJA/V60qSntVAo3ULQylOlldwVcgQG0MUsS52Boff7qsNy
 YY29uxsclcTXFmnva+Mv3NyrrMsrmoQWEO2iagjmvvmMulJzs/xQ5xrOqvV+clx2WWs7eHSmD
 M9ss2GX/4G+mkWCyHs4sb5A8XcgW/pSDTaUVHBtkh5/EVxFSA5JkXEL3o/FZLnW99RUfGn/U5
 8Xzm6Pyy/1CQ/aCFWLEpLhigaVOI7VEJfnDYJPcqNYGhtBvjxh3hw7sxSlHMfMAjdzCZJ4Pur
 Vv50+fOsQtorgdBQ8dscUt90ROeLk5ZKjrBDop2gKPKccYEJ/1ocX3u5GEx/TFqwuov46KJ7K
 XFERQ1/HyDKNtsEOw4WPRE65lHe9+37KQjUYOCYXziiBUSnhTbbNErG0Ia4Hdr4Kxv+EnOOAC
 5wpmmfQl/YbX702kyQuIB01FXugOCBqE3MPjcLbgJHpwIMkdDVwD/PZoFF0UlxmzWZl8Gq9hF
 Oxv0CW3RJQKMyofuc+el2VqvkdIZy94uh5fMCwWM60WJ6RVbJZjf64HtVIML0700FbbX7yHeC
 giwcB2e3BciidY+mDGcZovvvymvfZ71c2T1bY9oVOfm7qa0GW3lqoKH/hxTY6kvRzUZn0wTAJ
 CuG+/q47MOy6ZYjTEAIbpJYTjdFujHG2me2Ci9YZhn4xKzCD70fWddMNycES7QG3axQgUd5Es
 z/PKA4p2iuHCnths7OSDDbevPaN5udE8GM1g/jdjodS3xRFqhJ1N/Tddc35j5ZNmAATsF5IC/
 IRJsn/Z2P96z7nO5qOyDAZhAa3Eas7yf2PD+KY2vIg10KEkhK+HisiHQ83rNNkN1eoSF8BmWc
 di2kQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.09.22 um 11:57 schrieb Tim Jaacks:
> Hello,
>
> I noticed that the following syntax to show the changes of a stash stopp=
ed working in Git 2.28:
>
>   git diff stash@{0}^!
>
> It still works on commits and HEAD, though:
>
>   git diff f27984d^!
>   git diff HEAD^!
>
> And diffing against the stash's parent works as well:
>
>   git diff stash@{0}^1 stash@{0}
>
> I assume this is a bug. Can anybody confirm this? I verified the behavio=
r change trying different Git versions via docker:
>
>   docker run -it --rm --user $(id -u):$(id -g) -v $HOME:$HOME:rw -v /etc=
/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v $PWD:$PWD:rw -w $PWD=
 bitnami/git:2.27.0 diff stash@{0}^!
>
> With v2.27.0 the above syntax works, with v2.28.0 and later it doesn't.

Bisects to 8bfcb3a690 (git diff: improve range handling, 2020-06-12).

Reverting it partially like in the patch below restores the behavior of
"git diff stash@{0}^!".  Tests still pass.

A stash revision is a merge.  With "stash@{0}^!" it ends up in
ent.objects[2] and its parents (marked UNINTERESTING) in ent.objects[0]
and ent.objects[1].

I don't know if the current behavior is expected or if the patch is the
right fix, but in any case it would need a good explanation that I
cannot come up with on the spot.

Copying Chris, author of the mentioned patch.  Old discussion thread:
https://lore.kernel.org/git/pull.804.git.git.1591661021.gitgitgadget@gmail=
.com/

Ren=C3=A9


diff --git a/builtin/diff.c b/builtin/diff.c
index 54bb3de964..c34adf2695 100644
=2D-- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -588,6 +588,10 @@ int cmd_diff(int argc, const char **argv, const char =
*prefix)
 				sdiff.left, sdiff.right, sdiff.base);
 		result =3D builtin_diff_tree(&rev, argc, argv,
 					   &ent.objects[0], &ent.objects[1]);
+	} else if (ent.objects[0].item->flags & UNINTERESTING) {
+		result =3D builtin_diff_tree(&rev, argc, argv,
+					   &ent.objects[0],
+					   &ent.objects[ent.nr-1]);
 	} else
 		result =3D builtin_diff_combined(&rev, argc, argv,
 					       ent.objects, ent.nr);

