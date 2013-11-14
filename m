From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 05:48:50 +0530
Message-ID: <528416EA.1070307@gmail.com>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com> <51A963B7.6060002@alum.mit.edu> <20130601050355.GA23408@sigill.intra.peff.net> <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com> <20130601090934.GA13904@sigill.intra.peff.net> <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com> <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com> <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 14 01:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgkeN-0004v4-Bb
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 01:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab3KNAS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 19:18:57 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:57368 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3KNASz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 19:18:55 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so1190286pbc.29
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 16:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=M1fu6m8bnZwTm0YTMP1G4RbrHf4QkL9ORKBGpOV9/LQ=;
        b=iw7sFrl6jyFsbdu0+DVe3N5jGCoxC4lw+hwXjKniCEa2OZXgPC0Y2KzwdX9kBbomDs
         dTWjo5AcjJtVvZUnvCmXGf8vMv93NZbjB4AwbNMSn7emFI1Saov3aq+syBW/4xFJkDDM
         4R0L5txtk9nA0Q3SsafCjKULZw2+BC0CXurNXhwdSP6A19mzaL61/dS2Sko2rJOF75xe
         CbFFmy0PUtOL065bExhSy4S0vNbUTHX6A9KAxIB0u1dvp8F+YNT/gfmSaIHP59Zmg/mm
         nU60dDUdJbjr2Waw3e/P25ueIlwZ3AxMZGJbmZmzFuCwfDPtIFkxPeiF4NXlpJE297+N
         j8EA==
X-Received: by 10.66.197.135 with SMTP id iu7mr17018252pac.149.1384388334964;
        Wed, 13 Nov 2013 16:18:54 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.166.46])
        by mx.google.com with ESMTPSA id ik1sm47146584pbc.9.2013.11.13.16.18.52
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Nov 2013 16:18:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237810>

[top posting, and not preserving cc's because the original email thread
below is just for context; I don't want to force people into a
discussion that they may have considered closed :-)]

Is there *any* way we can preserve a reflog for a deleted branch,
perhaps under logs/refs/deleted/<timestamp>/full/ref/name ?

Whatever it was that happened to a hundred or more repos on the Jenkins
project seems to be stirring up this debate in some circles.

Just some basic protection -- don't delete the reflog, and instead,
rename it to something that preserves the name but in a different
namespace.

sitaram

On 06/01/2013 11:26 PM, Ramkumar Ramachandra wrote:
> Sitaram Chamarty wrote:
>> I think I'd have to be playing with *several* branches simultaneously
>> before I got to the point of forgetting the branch name!
> 
> Yeah, I work on lots of small unrelated things: the patch-series I
> send in are usually the result of few hours of work (upto a few days).
>  I keep the branch around until I've rewritten it for enough re-rolls
> and am sufficiently sure that it'll hit master.
> 
>> More to the point, your use case may be relevant for a non-bare repo
>> where "work" is being done, but for a bare repo on a server, I think
>> the branch name *does* have significance, because it's what people are
>> collaborating on.
>>
>> (Imagine someone accidentally nukes a branch, and then someone else
>> tries to "git pull" and finds it gone.  Any recovery at that point
>> must necessarily use the branch name).
> 
> Ah, you're mostly talking about central workflows.  I'm on the other
> end of the spectrum: I want triangular workflows (and git.git is
> slowly getting there).  However, I might have a (vague) thought on
> server-side safety in general: I think the harsh dichotomy in ff-only
> versus non-ff branches is very inelegant.  Imposing ff-only feels like
> a hammer solution, because what happens in practice is different: the
> `master` does not need to be rewritten most of the time, but I think
> it's useful to allow some "safe" rewrites to undo the mistake of
> checking in an private key or something [*1*].  By safety, I mean that
> git should give the user easy access to recent dangling objects by
> annotating it with enough information: sort of like a general-purpose
> "pretty" reflog that is gc-safe (configurable trunc_length?).  It's a
> serves more usecases than just the branch-removal problem.
> 
> Ofcourse, the standard disclaimer applies: there's a high likelihood
> that I'm saying nonsense, because I've never worked in a central
> environment.
> 
> [Footnotes]
> 
> *1* It turns out that this is not uncommon:
> https://github.com/search?q=path%3A.ssh%2Fid_rsa&type=Code&ref=searchresults
> 
