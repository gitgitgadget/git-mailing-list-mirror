From: Ray Xie <samuiotoko925@gmail.com>
Subject: Re: A git hook that does git cherry-pick and push automatically
Date: Fri, 20 Mar 2015 02:01:38 -0700
Message-ID: <65D8F41C-9576-4899-B700-F779A30A1F42@gmail.com>
References: <CAA4Z6SXzekMdPgKKaXqAObPcpFXDWpaQvNhJg6DEsOxbMOy3Lw@mail.gmail.com> <20150320071625.GA90632@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 10:02:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYsoN-0003uT-J7
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 10:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbbCTJBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 05:01:43 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34199 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbCTJBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 05:01:40 -0400
Received: by pdbni2 with SMTP id ni2so103151771pdb.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qRFjonTSICsTOLfOSSoInA4Tf31lkw0e5HS4BWA9FxY=;
        b=XuYVLmYVYuChwXJgyc5LCSCgjDyGA/VW6BbRCbKOEUjDGW/ej0TuHQUwi9GHptTNdl
         d7B6dn7pwrTyRNPNjN7OCj7N91MJgN1sUnwn6AzvH7msFFvAQN1d8nUlKbbhvN5hb7JV
         h2uLrqfv4MEzCu43qAesTMcgSL3p3mxoDFHhsfp7rIMuGp8Nj6lMPW0otbsQEcPfw/rB
         XthouYvjGRP2M/by1sxbbLRGaihCWjbyCqTa/JHT3OSGRbZTSYHeziIHjeWsDlLukfBK
         BTwGadxuK1Rftnz6SQYYRYQRsdOffAr7Oe/5pwJLy5TARisGaQsRuVdu+XSMHaJiqD9i
         tsDg==
X-Received: by 10.66.65.169 with SMTP id y9mr183858166pas.60.1426842100081;
        Fri, 20 Mar 2015 02:01:40 -0700 (PDT)
Received: from [192.168.2.251] (108-193-0-136.lightspeed.sntcca.sbcglobal.net. [108.193.0.136])
        by mx.google.com with ESMTPSA id g11sm6991941pat.24.2015.03.20.02.01.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 02:01:39 -0700 (PDT)
X-Mailer: iPhone Mail (12D508)
In-Reply-To: <20150320071625.GA90632@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265872>

David,

Thanks for the suggestions, I left out the most unfortunate part of the problem I am facing, the one that add this hook is the git admin, aka our release engineer, so it's a sever side hook that it's forced down to all developers. I sure will try to persuade them from a different perspective more calmly this time.

Regards,
Ray
>> On Mar 20, 2015, at 12:16 AM, David Aguilar <davvid@gmail.com> wrote:
>> 
>> On Thu, Mar 19, 2015 at 09:07:28PM -0700, Ray Xie wrote:
>> So today I had a shocking moment while I was doing my cherry-pick,
>> after I performed all the pre-checkin duties (the usual build the
>> code, run the test to make sure the cherry-pick infact works), I found
>> out that my original commit was already cherry-picked, then I found
>> out someone in engineering make the decision to do an automate
>> cherry-pick from that branch to another so he added a git hook to run
>> do cherry-pick and push on every commit, yes, a simple cherry-pick
>> then push; mind you, these are not feature / dev branch, these are
>> release branches, both of them.
>> 
>> Then after I came back from the shock, made a big protest about how
>> this is the worst thing I have seen and I will never live with it, and
>> that's why "git cherry-pick" and "git push" are 2 separate commands,
>> as any reasonable developer, you do your very best to ensure you are
>> not pushing something that is fundamentally broken; however for the
>> life of me and talk these few people into senses.
>> 
>> So, I am sending this to seek for some expert advice how I can drive
>> some sense into these people so they don't screw up my life as an
>> developer.
>> 
>> Regards,
>> Desperate developer, Ray.
> 
> It's interesting that your clone picked up the hooks that they
> added.  Do you have a centrally managed git installation, where
> perhaps they are modifying the default .git/hooks/ template that
> is used to seed the initial repo when cloning?
> 
> One way to check that is to look at your git installation.
> If your git is installed as /usr/bin/git then check
> /usr/share/git-core/templates and see if the hook is present
> there.
> 
> Assuming that you have the ability to create your own clones,
> and that you are not all working in a common shared sandbox,
> then the simplest solution would be to simply delete your
> .git/hooks/* when cloning a new repo.
> 
> That way you can at least have your sandboxes work the way
> you want them to work.  Hooks are local to your sandbox so you
> have full control over them.
> 
> Is this hook resilient to rebasing?  Does it cause havoc if you
> a feature onto this branch?  Those are the kinds of things that
> sound scary based on your description of the hook.
> 
> I don't have any tips on how to convince people.  One thing that
> might help is to remember that people are self-motivated ~ try
> to focus on what *they* stand to benefit from not having this
> hook.  If you can convince them that they are better-off without
> the hook, from their POV, not from yours, then you might have a
> better chance of persuading them.
> 
> Good luck,
> -- 
> David
