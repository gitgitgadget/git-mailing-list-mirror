From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [PATCH] git-fetch should not strip off ".git" extension
Date: Wed, 22 Oct 2008 07:35:50 -0400
Message-ID: <ee2a733e0810220435v5f1bfa62y508f78f2d9bef8ba@mail.gmail.com>
References: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
	 <48FC5F1B.1050608@op5.se> <7vzlkz2jv7.fsf@gitster.siamese.dyndns.org>
	 <ee2a733e0810210323j249c3460x881af6d6aefc647c@mail.gmail.com>
	 <7vej29zy2r.fsf@gitster.siamese.dyndns.org>
	 <81b0412b0810211506y400ba750k2613ba19f01fb57@mail.gmail.com>
	 <7vd4htwp6v.fsf@gitster.siamese.dyndns.org>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 13:37:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksc1T-0003ft-EE
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 13:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYJVLfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 07:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbYJVLfx
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 07:35:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:18833 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbYJVLfw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 07:35:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so331104fgg.17
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vRSSU/2QSra7hKkLWE+V7KeIcGmzllE1vUZjELARbDU=;
        b=Bad5gjAYdbVzRFHVt6XbwpdYA15m//P51iDuMBOWThrerH+/wE1X0zT8CqSitmEbrB
         y5l2V7zV8AeNeA1ig3Y1KH2ycApHr6d3N8MhyDeJX3BF9kcAblW4GdUnUtd+qu3Vp/WY
         qgvdCvZxy7xGjmgEZkO/SdFKKa9qoG//0l43Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=DFtWXjcxjP2T8EHivlWxO5JYdZnxASSn3EUt/0w8vfe8yb+ILsHahYbD+bCca6iVmD
         BcF82fjqTXchBoLE7ySG1ZoFv9yUT0Q+T+mXbgA+Cc0rgp9Q8pkRM4XJ2dxGrB2NqOVS
         36pVb2+yB11XzJyts0X6bAyNrNtAvXZu7FJZY=
Received: by 10.187.231.1 with SMTP id i1mr1453357far.18.1224675350647;
        Wed, 22 Oct 2008 04:35:50 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Wed, 22 Oct 2008 04:35:50 -0700 (PDT)
In-Reply-To: <7vd4htwp6v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98858>

On 10/21/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
>  > 2008/10/21 Junio C Hamano <gitster@pobox.com>:
>  >> "Leo Razoumov" <slonik.az@gmail.com> writes:
>  >>
>  >>> Even though the old behavior is "long established", it introduces
>  >>> unnecessary ambiguity. If I have two repos
>  >>> ...
>  >>
>  >> Of course.  Now you know why people don't name such a pair of repositories
>  >> like that ;-).
>  >
>  > FWIW, I support Leo on that. The "established" behavior is stupid.
>
>
> I am not inclined to respond to such an emotional argument.  On the other
>  hand, it is fair to say that the existing behaviour is established,
>  because it is backed by a long history, which you can objectively verify.
>
>  If you think about it deeper, you will realize that it is not even clear
>  if it is "stupid".
>
>  More importantly, the behaviour is consistent with the way how "git fetch"
>  and "git clone" DWIMs the repository name by suffixing .git when the input
>  lacks it.  And this DWIMmery comes from the expectations that:
>
>   (1) people name their repository project.git; and
>
>   (2) people like using and seeing short names (iow, "clone
>      git://$somewhere/project" is preferred over "clone
>      git://$somewhere/project.git");
>
>  If a repository whose real location is git://$somewhere/project.git is
>  cloned/fetched as git://$somewhere/project by people, recording the merge
>  source using the shorter name used by people to fetch from it is more
>  consistent.  The patch breaks this consistency [*1*].
>
>  What is clear is that you would confuse yourself if you have two
>  repositories A and A.git next to each other, and that is primarily because
>  it breaks the above expectation.
>
>  git core-level rarely imposes such policies, but what Porcelains do is a
>  different matter.
>
>  Hence the suggestion: don't do it.
>
>  [Footnote]
>
>  *1* It would be a different matter if the patch at the same time removed
>  the fetch/clone DWIMmery.  At least such a patch would be internally self
>  consistent.
>

I think this discussion went in the direction of "correct" versus
"convent". I, personally, will choose correct over convenient any
time. Different people use git for different projects and their
expectations differ in this regard. In my case
after I do "git clone Foo.git" I get "Foo" repo side-by-side with
"Foo.git" and the ambiguity becomes apparent.

Regarding your footnote *1*. I agree with your suggestions and I can
improve the patch in the following way:

(1) Fetch/clone messages/comments will refer to the source/destination
repos by their complete names without stripping off any parts
(2) Searching for a source repo, clone/fetch will first try an exact
match and if it fails it will remove/add ".git" suffix and
