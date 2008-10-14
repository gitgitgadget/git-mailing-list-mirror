From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Re: concerns about git
Date: Tue, 14 Oct 2008 14:25:11 +0300
Message-ID: <8e04b5820810140425j14c1c7efm2346a967ad6a070e@mail.gmail.com>
References: <19959918.post@talk.nabble.com> <20081013181941.GT4856@spearce.org>
	 <e1dab3980810131140p45c62e5cs690ac190eeacc38e@mail.gmail.com>
	 <82c87da00810131251i52d10170h5c1991e2da0bd208@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Tweed" <david.tweed@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	deepwinter <deepwinter@winterroot.net>, git@vger.kernel.org
To: Brandon <siamesedream01@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 13:27:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpi3C-0000Gt-On
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 13:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbYJNLZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 07:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbYJNLZU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 07:25:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:63869 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbYJNLZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 07:25:19 -0400
Received: by ug-out-1314.google.com with SMTP id k3so875161ugf.37
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=V5eU+NjnKDL2tHAF2B9o9PDYMTIBVmWJVYH9bJteO6s=;
        b=HXwjL8f+YsU5dJtZdhcBa4xct50w0oyBC/A0Y0XFJAlMhI1aNTttARa2h5XBlmXPih
         ujuJLDxK/KS+GVjZJGOhJZJDhRN/jYbHo3Y19LHdi6OUjyL7Z9NRagv1GG5tQ/ZoKOcT
         0xtY2JRRnw3VXvLPQNq912HuYrNBWTLNHTGnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tqa4pQ/x/vTLlBbOJVSGEja/cypTvlVkROjPI4/WdWpvhX48QGC6qtCmuwUGL01AwF
         f9sub9+RhE6Wi+GJ8GseCRfKypxaJCzGaAkClrZFBY09K0tR6xzN1AsMf1jBGWCugQ9i
         swjm10WsZpDiuWfGALMWhIAl4Jh7YR5qdiOL8=
Received: by 10.210.66.1 with SMTP id o1mr7120392eba.193.1223983511260;
        Tue, 14 Oct 2008 04:25:11 -0700 (PDT)
Received: by 10.210.129.8 with HTTP; Tue, 14 Oct 2008 04:25:11 -0700 (PDT)
In-Reply-To: <82c87da00810131251i52d10170h5c1991e2da0bd208@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98180>

On Mon, Oct 13, 2008 at 10:51 PM, Brandon <siamesedream01@gmail.com> wrote:
> You can use "git config core.worktree <location>" to create a ".git"
> folder that manages a working copy in another location.
>
> I know some of the GUI tools don't support this though so I would only
> use it if truly necessary  . (For example a using git to manage a
> mapped network drive, it would be faster to keep the ".git" folder on
> the local harddrive)
>
> More documentation here: http://www.kernel.org/pub/software/scm/git/docs/
>
> On Mon, Oct 13, 2008 at 2:40 PM, David Tweed <david.tweed@gmail.com> wrote:
>> On Mon, Oct 13, 2008 at 7:19 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>>>  # then every once in a while, or from a cron job
>>>  $ git push --all backup
>>>
>>> Of course since Git is distributed you can you use this same approach
>>> to make backups to other systems.  You can even edit the .git/config
>>> to give the [remote "backup"] section more than one url line, so
>>> that "git push --all backup" will send updated copies to multiple
>>> locations at once.
>>
>> Another advantage of 'git push'ing to another repository (possibly via
>> cron) as backup is that (for technical reasons) git push has to
>> 'parse' the new changes to your repository in order to push, so it is
>> likely to spot corruption (eg, dying disk) at that time and when you
>> can decide what to do about it. (I have enough backups all over the
>> place that I don't worry about not having a 'copy' of any stuff I care
>> about, but that there'll be some fatal corruption I don't notice
>> immediately that then gets propagated everywhere rendering them
>> useless.)
>>
>> --
>> cheers, dave tweed__________________________
>> david.tweed@gmail.com

    I have the same problem as David, but I manage it by using a
symlink. That is my .git folder is a symlink to the real repository
(possibly on another partition). (So far I had no problems with this
setup.)

    Ciprian Dorin Craciun.
