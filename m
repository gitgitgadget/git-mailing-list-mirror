From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 14:16:50 -0500
Message-ID: <53629da233345_76612eb2f075@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 21:27:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfwdr-00008J-DA
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 21:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbaEAT1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 15:27:31 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:47761 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaEAT1a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 15:27:30 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so3070556ykq.28
        for <git@vger.kernel.org>; Thu, 01 May 2014 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=DejeMO2ZgNSSii84KKGHJ1zyLLEYJO8+3Nl61rb6ul4=;
        b=fMnYMBYv5jdn81uozmPfLWI/nFuS80GC1ASwisDjGbPuuAajZnclfYlY8v/F2SA3Oi
         Teyiouo5ws2UBgK2uLJfqbLGrl8Y62TWg8T7vct7/lxf2wyY1+cO0AdAmzVSPlz5aye0
         6aZsnuZBjXVNbhKSv5m9X59uMBjlbgE208v9e4UzVE5qixY24qmTDzo4chpBw/EEEEZe
         fK8nCZuv9xjCM1f1EYcDyU04xvQWv1Tv6/RsbHKWg6su7xpuv8i9Ew0Gq/9/bR86lJjs
         QBBBP3JDFOc99rsN3AkMVbKgdvqsBfwZDVwjY/lThXmWE4RRjbEHJJDHH5sBZn05uVyg
         Helw==
X-Received: by 10.236.120.66 with SMTP id o42mr17861868yhh.66.1398972449726;
        Thu, 01 May 2014 12:27:29 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l4sm50407524yhj.24.2014.05.01.12.27.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 12:27:27 -0700 (PDT)
In-Reply-To: <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247829>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > brian m. carlson wrote:
> >> ..
> >> At work, we have a workflow where we merge topic branches as
> >> non-fast-forward, so that we have a record of the history (including who
> >> reviewed the code), but when we want to just update our local branches,
> >> we always want fast-forward:
> >> 
> >>   git checkout maintenance-branch
> >>   # Update our maintenance branch to the latest from the main repo.
> >>   git pull --ff-only
> >>   git pull --no-ff developer-remote topic-branch
> >>   git push main-repo HEAD
> >> 
> >> So there are times when fast-forward merges are the right thing, and
> >> times when they're not, and as you can see, this depends on context and
> >> isn't per-repository.
> >
> > That's not what I asked.
> >
> > I didn't ask you if fast-forward merges were the right thing to do in
> > every situation.
> >
> > I asked you, *when* people do a fast-forward merge (that is; when it's
> > possible and desirable), what are the problems that a fast-forward merge
> > causes?
> 
> But then I think you asked a wrong question.

I asked the simple uncontroversial question as a rhetorical aid. I hoped
I would get the obvious answer, but I didn't even get that, so what hope
is there of convincing these people of the one that needs real pondering?

> The opposite case of the question tells me what is wrong in it:
> 
>     When people do a real merge (that is: when it's possible and
>     desirable), there is no reason to forbid 'git pull' from creating a
>     real merge.  What are the problems that a real merge causes under
>     that condition?
> 
> By definition, because of "when it's possible and DESIRABLE" part,
> the answer is "absolutely zero".  That is not an interesting
> question, is it?

That's right, but we are discussing the default behavior of `git pull`,
which if we agree has no problems when the ff is a) possible, and b)
desirable, the problems must come when either one of those is not met.

 a) If the fast-forward is not possible, that creates problems, because
    a real merge might happen, and it's not desirable. However, if we
    don't allow real merges to happen by default this couldn't be a
    problem.

 b) If the fast-forward is not desirable, then the user wouldn't be
    running `git pull`, would be running `git pull --no-ff`.

In other words, after the proposed changes `git pull` by default would
have no issues.

> Doesn't Brian's case show the justification "because everybody will
> accept fast-forward" does not hold?  It shows that the user do not
> necessarily know when it's possible and DESIRABLE, and updating the
> command is about helping people avoid an action that may not be
> desirable in the end.

No, it doesn't hold. As I said, if we change the default the fact that
it's not possible is not an issue.

The only problem would be when it's not desirable, however, that's a
problem of the user's ignorance, and the failure of the project's
policity to communicate clearly to him that he should be running
`git merge --no-ff`. There's absolutely nothing we can do to help him.

The only thing we could do is not allow fast-forward merges either, in
which case `git pull` becomes a no-op that can't possibly do anything
ever.

> Brian needs a way to make sure he fast-forwards when pulling the
> project's maintenance-branch into his maintenance-branch, and also he
> does *not* fast-forward when pulling developer's fix branch into that
> same maintenance-branch of his.

First of all this use-case is not realistic. The moment he merges a
developer branch, hes maintenance and the probject's diverge, and all
the pulls after that cannot be fast-forward.

It's pointless to add something that just doesn't happen. It will be
possible to do the fast-forward merges only early on the life of this
branch, not afterwards. For this short period of time he can just simply
use his fingers to type `git merge --no-ff`.

-- 
Felipe Contreras
