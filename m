From: Christian Couder <christian.couder@gmail.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Thu, 27 Feb 2014 15:47:45 +0100
Message-ID: <CAP8UFD0Wd3FcgxW+Vb-YKACLqqaeF+AAf=YRScZd84t7qiNkjw@mail.gmail.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 15:47:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ2Fc-00014z-0W
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 15:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbaB0Orr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 09:47:47 -0500
Received: from mail-ve0-f180.google.com ([209.85.128.180]:65266 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbaB0Orq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 09:47:46 -0500
Received: by mail-ve0-f180.google.com with SMTP id jz11so3821156veb.39
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=87wLMcVt41aBGiZZ2IbesbBX7U7jdbzt4ymeFxgTgsY=;
        b=aHPojIpw5n8fO1q3i48ZpdLeXL5XDrJGF0hR5ODmop6mZD+7+AjtF+xRfIzDVp/EtK
         uWPzoKsz4Ieeqk8vB9qKDXYa8t9p7InuYvK3/4FpB3l0SKywzkA5M3dE+QyC4Pp8H0hW
         dy1vN2/VL2kY3gtr2uRVdR5hXth+3ytsC67hCDhSbjRa7dsn3wTQd88NXkH5UFrBXUeg
         Eeb8G7ju93rJ31ctMA7hTkcXWo/O12TKWQt1LQcuckNMCg+hhrWKseuQ9cf3n+qwMzUP
         PC6y5DDbI3XN25p0AtvXnzht8AUFMdCZXgokIlMGWDubsNLf4cOdfFscFsdOywkRRttl
         a6jg==
X-Received: by 10.52.122.14 with SMTP id lo14mr1264079vdb.38.1393512465639;
 Thu, 27 Feb 2014 06:47:45 -0800 (PST)
Received: by 10.58.104.129 with HTTP; Thu, 27 Feb 2014 06:47:45 -0800 (PST)
In-Reply-To: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242827>

Hi,

On Wed, Feb 26, 2014 at 9:28 AM, Jacopo Notarstefano
<jacopo.notarstefano@gmail.com> wrote:
> Hey everyone,
>
> my name is Jacopo, a student developer from Italy, and I'm interested
> in applying to this years' Google Summer of Code. I set my eyes on the
> project called "git-bisect improvements", in particular the subtask
> about swapping the "good" and "bad" labels when looking for a
> bug-fixing release.
>
> I have a very simple proposal for that: add a new "mark" subcommand.
> Here is an example of how it should work:
>
> 1) A developer wants to find in which commit a past regression was
> fixed. She start bisecting as usual with "git bisect start".
> 2) The current HEAD has the bugfix, so she marks it as fixed with "git
> bisect mark fixed".
> 3) She knows that HEAD~100 had the regression, so she marks it as
> unfixed with "git bisect mark unfixed".
> 4) Now that git knows what the two labels are, it starts bisecting as usual.
>
> For compatibility with already written scripts, "git bisect good" and
> "git bisect bad" will alias to "git bisect mark good" and "git bisect
> mark bad" respectively.
>
> Does this make sense? Did I overlook some details?

As Junio said adding a command "mark" doesn't by itself solve the
difficult problems related to this project.
(By the way I think it is misleading to state that this GSoC is "easy".)

> There were already several proposals on this topic, among which those
> listed at https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_bisect_fix.2Funfixed.
> I'm interested in contacting the prospective mentor, Christian Couder,
> to go over these. What's the proper way to ask for an introduction?

As Michael said, you can just CC me or send me a private email.

But I think the most important thing right now is first to gather as
much information as you can from the previous discussions on this
topic on this mainling list.
Perhaps you should also gather information on how git bisect works.

It will help you understand what are the difficult problems.

One of the problems, for example, is that git bisect can work using a
"good" commit that is not an ancestor of the "bad" commit.
In this case it will checkout the merge bases between the good and the
bad commit. (And by the way this is related to the bug that should
also be fixed as part of this project.)

Then you are welcome to come back and ask questions, or suggest solutions.

> I tried asking on IRC, but had no success.

Sorry but I don't use IRC.

Thanks,
Christian.
