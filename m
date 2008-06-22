From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: linux-x86-tip: pilot error?
Date: Sun, 22 Jun 2008 23:11:07 +0200
Message-ID: <237967ef0806221411x39f57434p949b0ff13dfce8a@mail.gmail.com>
References: <20080622123620.GA9328@linux.vnet.ibm.com>
	 <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com>
	 <20080622132105.GD22569@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, git@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
X-From: git-owner@vger.kernel.org Sun Jun 22 23:12:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAWqz-0006G5-OC
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 23:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679AbYFVVLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 17:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754706AbYFVVLJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 17:11:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:36242 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605AbYFVVLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 17:11:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6686875rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=J+a11L7y7H7K9AP58GQf2XW7Lnqk3SZtKnOHOWtM2cU=;
        b=QvZmAM/Z7zT84xkGJgmBWm1DCVdawUVLcIlVWtZCianzqtS+HiOIVtx9eWz+p1c05i
         SOhGG4m/sMFjqIbRFWgn4b5B548sJGAcF9Tvenp6oboULc3XBgtyDC2DeaZwy/E0hwXt
         3YSmVPv9PSzyHuPTU2Hip2arPtnxw1KQxmDoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VmNkDm7EzWSKC168Cuck1SMG2NSZl+fKcyo+UKZZOj+lvwPEoWxkmTKd54SylEzxg6
         XCT/xD64bQMmBuI0fqmjvrfkH1UZU2f2g92eY7cuMqnOF1dAMe+/9CB5GusQU48Bils8
         jXNp/UmzA8C6CFKV1DtsQT849va1U+xER+oM0=
Received: by 10.140.171.18 with SMTP id t18mr11550998rve.22.1214169067672;
        Sun, 22 Jun 2008 14:11:07 -0700 (PDT)
Received: by 10.141.153.6 with HTTP; Sun, 22 Jun 2008 14:11:07 -0700 (PDT)
In-Reply-To: <20080622132105.GD22569@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85803>

2008/6/22 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> On Sun, Jun 22, 2008 at 02:48:35PM +0200, Mikael Magnusson wrote:
>> 2008/6/22 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
>> > Hello, Ingo,
>> >
>> > I took the precaution of rebuilding my linux-2.6-tip from scratch as follows:
>> >
>> >  544  mkdir linux-2.6-tip
>> >  545  cd linux-2.6-tip
>> >  546  git-init-db
>> >  547  git-remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> >  548  git-remote add tip git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
>> >  549  git-remote update
>> >  550  git-checkout tip-core-rcu-2008-06-16_09.23_Mon
>>
>> When checking out remote branches, you have to specify the remote:
>> git checkout tip/tip-blabla
>> (it'll warn about detaching HEAD, this is normal).
>
> Thank you, Mikael!
>
> But when I try "git-checkout tip/tip-core-rcu-2008-06-16_09.23_Mon",
> it says:
>
>        error: pathspec 'tip/tip-core-rcu-2008-06-16_09.23_Mon' did not match any file(s) known to git.
>        Did you forget to 'git add'?
>
> Trying "git-checkout tip/tip-core-rcu" gets me:
>
>        error: pathspec 'tip/tip-core-rcu' did not match any file(s) known to git.
>        Did you forget to 'git add'?
>
> Trying "git-checkout -b tip-core-rcu tip/tip-core-rcu" gets me:
>
>        git checkout: updating paths is incompatible with switching branches/forcing
>        Did you intend to checkout 'tip/tip-core-rcu' which can not be resolved as commit?
>
> Trying "git-checkout -b tip-core-rcu tip/tip-core-rcu-2008-06-16_09.23_Mon"
> gets me:
>
>        git checkout: updating paths is incompatible with switching branches/forcing
>        Did you intend to checkout 'tip/tip-core-rcu-2008-06-16_09.23_Mon' which can not be resolved as commit?
>
> Trying "git-checkout -b tip-core-rcu tip-core-rcu-2008-06-16_09.23_Mon"
> acts like it is doing something useful, but doesn't find the recent updates,
> which I believe happened -before- June 16 2008.
>
> Help???

Oh, i didn't realize you were trying to check out a tag... In that case
the commands you gave were correct. I could successfully run your commands
here (though i have no idea if the file you talk about is up to date or not).

It's probably worth trying a newer version of git, could be a bug I guess.
Given the error message you could also try first checking out a branch, and
then the tag. ie git checkout -b master linus/master; git checkout tip-foo
It could also be that the tag just doesn't point to the commit you expect..

-- 
Mikael Magnusson
