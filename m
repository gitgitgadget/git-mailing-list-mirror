From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: Specifying N revisions after the initial commit
Date: Tue, 22 Sep 2015 15:10:42 -0400
Message-ID: <CA+5PVA6YWJizRjseeJ4EpRya0Mpyrv3DoNsB3=Gi=dOiAoDfHg@mail.gmail.com>
References: <CA+5PVA40x8bxW63X+b77FDO8btRBaVOg=fq+ZyX=bdJ+uEm9gA@mail.gmail.com>
	<20150922214037.b6b48059f051fcd4060a5a85@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:10:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSxm-0004lw-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 21:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759533AbbIVTKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 15:10:45 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36714 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759286AbbIVTKn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 15:10:43 -0400
Received: by ioii196 with SMTP id i196so24283456ioi.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hOfdyMvga8X0l2vRdk7SZUjmP92YQxBRElh8flGltBM=;
        b=Yfv9eZ1J1xjJjH7S1S28HtbZaaUn+9mqxSZzR3ecbt6Ij+SJfoHGWHjR/h8leI+3ck
         nY43rSrFENwcM73Swc7Rn4bKuHm/NTnZG/zon+Fyt7xvWy99aIflv+C9EtHD7SjA8xfg
         Jm5bbhwBQJs2bW8fjm11EY70gHQbQpJQSnqXTfoROx6ArUo+HhsxYiuuAFi2XIc5OE3G
         ZdL7idgHZ9CEUk7yY91kuydUfaxVCVRA4yeJjiDBIauC32R9I1F8xakDbVLqqs5S+47w
         n0hRw4OL+8WV7uIwAKFljeXAtUwEJBWD6+nAPTHinXm8XotKpPkORW4DsyZmh5S9rT72
         QPMA==
X-Received: by 10.107.29.70 with SMTP id d67mr33707836iod.27.1442949042709;
 Tue, 22 Sep 2015 12:10:42 -0700 (PDT)
Received: by 10.64.132.167 with HTTP; Tue, 22 Sep 2015 12:10:42 -0700 (PDT)
In-Reply-To: <20150922214037.b6b48059f051fcd4060a5a85@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278418>

On Tue, Sep 22, 2015 at 2:40 PM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> On Tue, 22 Sep 2015 14:32:19 -0400
> Josh Boyer <jwboyer@gmail.com> wrote:
>
>> Please CC me as I'm not subscribed.
>>
>> I was hoping someone could help me with the revision shorthand to get
>> the commit sha of a commit N commits after the initial commit.
>
> What happens if right after the initial commit, there have been five
> branches created -- with no common commits except for the initial one?
>
> That's the core limitation of the data model Git uses (and arguably any
> other DVCS system): all commits form a directed acyclic graph.
> The "directed" in that construct means that child commits contain a
> link to their parent commit (or commits) but not vice-versa.

Hm.  It has been so long since I've looked at the underlying model and
git has proven to be so flexible on such a variety of things that I
guess I forgot it was constructed through a DAG.  The --reverse
parameter to git-log and git-rev-parse had left me hopeful.

> Hence, given any particular commit, you're able to trace all of its
> ancestry, but the reverse is not possible.

That makes sense.  I suppose I will have to resort to parsing output
of git-rev-list or something.  Thanks for the reminder.

josh
