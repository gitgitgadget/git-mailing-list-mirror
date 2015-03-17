From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [GSoC] Applying for conversion scripts to builtins
Date: Tue, 17 Mar 2015 08:34:48 +0700
Message-ID: <CACsJy8BrdjNO-3ZFMVjbursTfeWjB0CMPN0-GmNRHFTLdqBvhg@mail.gmail.com>
References: <CAHLaBNJkL1CUJEk=cH=CLcDvZtoAr+PiCo2KHjfMLUKsugtRPA@mail.gmail.com>
 <CACRoPnQDopKNW2oc=UiLhupBBSh5ZmUHR7hU5aeguD4OVd1uPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yurii Shevtsov <ungetch@gmail.com>, Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 02:36:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXgPl-0006Pv-0N
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 02:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbbCQBfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 21:35:20 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33549 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbCQBfT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 21:35:19 -0400
Received: by ignm3 with SMTP id m3so43896935ign.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 18:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gsyHtFjQyopjIEoYo7oSCWOwfiRcLmexPwxTLom7nYk=;
        b=FGxwtX0BI3mVzoLnB+cURUSf3qEr61tDhHVQ/P7xDmMbemK4YGbxcDiMfXanSo/4n+
         ajBBV0qcFZT8jq4JrUN8B/6cgK5HHltus0bZxYi45Y7Ftz/vbVB4GAwm08IMjATiJk9e
         mwrWkNe6GX1NyU/9SDnHzFpgonXl7dLTJmjaaS7eHPjZK+O1VGLPTbQDUXCSo6ZSYYUg
         UtU8pRF7WeYkhVyfHj98fvvUIwErhkY3OELwP1gUpld+RVo1gF/36TGGIzSqsdIZSiL5
         ylPw5H6FI/UPPbGg4/acfUZQ4wt6Ts04K6Zzliuas+M/AwK2uHbjIXMko0C0nCVwQ3Rc
         z0Vg==
X-Received: by 10.42.88.1 with SMTP id a1mr82984222icm.29.1426556118893; Mon,
 16 Mar 2015 18:35:18 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 16 Mar 2015 18:34:48 -0700 (PDT)
In-Reply-To: <CACRoPnQDopKNW2oc=UiLhupBBSh5ZmUHR7hU5aeguD4OVd1uPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265602>

On Tue, Mar 17, 2015 at 7:22 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Hi,
>
> On Tue, Mar 17, 2015 at 12:49 AM, Yurii Shevtsov <ungetch@gmail.com> wrote:
>> I'm going to write for this idea. As I know good proposal should
>> contain timeline and Todo estimations. What should I write in my
>> proposal, since there is no clear plan for converting scripts to
>> builtins. Thanks in advance!
>
> I'm actually writing a proposal for the same topic because I somehow
> ended up with a working prototype of git-pull.c while exploring the
> internal git API ;). It's not ready as a patch yet though as there are
> some problems with git's internal API which causes e.g. double free
> errors and too much code complexity due to required functionality not
> being exposed by builtins, which will have to be addressed.
>
> Generally, it would be easy to convert any shell script to C by just
> using the run_command* functions (and in less lines of code), but that
> would not be taking advantage of the potential benefits in porting
> shell scripts to C. To summarize the (ideal) requirements:

While run_command() is not ideal, it would be a good intermediate
state where you can verify with the test suite that the C skeleton
after rewrite is working ok. Then you can start killing run_command()
in subsequent patches. That would be much easier to review code too.
-- 
Duy
