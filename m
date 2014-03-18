From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: Apply commits from one branch to another branch (tree structure
 is different)
Date: Tue, 18 Mar 2014 12:18:27 -0500
Message-ID: <CANUGeEb6u82=GbnoFiXbWjZmdBtQ_0ObixLcPcKLF-Z0ABgXOQ@mail.gmail.com>
References: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jagan Teki <jagannadh.teki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 18:18:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPxfB-0002Ou-ET
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 18:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbaCRRSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 13:18:49 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:42936 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbaCRRSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 13:18:48 -0400
Received: by mail-we0-f179.google.com with SMTP id x48so6013856wes.24
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/03KEdChjlJHH40mMX5rnv96lYCWpDSQZ1QC3urY2m4=;
        b=nr9ptVKdoMQ6wXUT60PaNhV7f4cHtrTNnbbs7U5M4sipGKa39WavTk1VD6OhOXzTFG
         YLolTaBvGy0klAEKHm56urUIaqXvqn2ED2zDABXVDoCassVbjyC56iWo14aPB2Mcp+we
         llg03UJ9OwsvNFaQ4QLxXPyX8c0u1g1nctH7W1NIEQ4uxy64z8QdvUBFSnBA1XqUClHL
         U4s1R1wh5GUCEIO1cMlA+qE/AbNQOlfPmkHEGo70PNAx0hda9Y87I5vOMeDNWwAn4YFk
         iGwP7NY7r3fnJnwhulGPThW1UalWF9CcdjN58CNtRaoHeTsvd9JCRYZ4mjQiCWWdj4VU
         4c+Q==
X-Received: by 10.194.118.163 with SMTP id kn3mr2557702wjb.77.1395163127430;
 Tue, 18 Mar 2014 10:18:47 -0700 (PDT)
Received: by 10.217.120.8 with HTTP; Tue, 18 Mar 2014 10:18:27 -0700 (PDT)
In-Reply-To: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244362>

Jagan:

On Fri, Mar 14, 2014 at 12:39 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Hi,

Hello,

> I have two branch in one repo that I need to maintain for 2 different
> deliveries.
> Say branch1 and branch2 in test.git repo.
>
> test.git
> - branch1
>      foo_v1/text.txt
>      foo_v2/text.txt
> - branch2
>      foo/text.txt
>
> branch1 is developers branch all source looks version'ed manner and
> branch2 is superset for branch1, example foo_v1 and foo_v2 are the directories
> in branch1 where developer will update the latest one here foo_v2 and branch2
> foo is same as the latest one of branch1 for an instance.
>
> Suppose developer send 10 patches on branch1 where are changes in terms
> of <dir>_<version>/ then I need to apply on my local repo branch1, till now
> is fine then I need to apply same 10 patches on to my branch2 where source
> tree <dir> which is quite question here how can I do.
>
> Request for any help! let me know for any questions.

This just sounds like a painful workflow to me. I would suggest not
doing this at all, but rather using tags to mark specific releases,
and using individual branches for continued development (e.g., stable
or v1.x or whatever is most appropriate). You can have unstable or
master or dev or whatever for developers to work on freely without
breaking releases (albeit, there are many different workflows you can
use to manage the transition from unstable to stable code).

I would avoid using subtrees (subdirectories) within a Git repository
to represent different releases of the code. Git already tracks
versions. That is redundant and messy. It's really an outdated way of
thinking about version control.

/my 2 cents

Regards,


-- 
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bamccaig.com/>
perl -E '$_=q{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
