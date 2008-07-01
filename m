From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Multiple remote.<...>.fetch and .push patterns
Date: Tue, 01 Jul 2008 11:59:43 +0200
Message-ID: <g4cv6f$g29$1@ger.gmane.org>
References: <308083c30806301158i1100c84dqe7f50daad417934c@mail.gmail.com> <48693434.4090402@freescale.com> <308083c30806301252l25f072anafbc457f48c6b19e@mail.gmail.com> <g4croa$3eu$1@ger.gmane.org> <7vprpynech.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 12:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDcfR-0007rO-9Y
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 12:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbYGAJ77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbYGAJ77
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:59:59 -0400
Received: from main.gmane.org ([80.91.229.2]:39736 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbYGAJ76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:59:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KDceN-0002Ia-Ej
	for git@vger.kernel.org; Tue, 01 Jul 2008 09:59:51 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 09:59:51 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 09:59:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7vprpynech.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87019>

Junio C Hamano venit, vidit, dixit 01.07.2008 11:27:
> Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:
> 
>> The files under remotes are the old way of configuring remotes (see
>> git help push). The new are config lines in the remotes section, as
>> written by "git remote". I don't think "git remote" can write the
>> lines you want, so I'd suggest:
>>
>> git config remote.ko.url kernel.org:/pub/scm/git/git.git
>> git config remote.ko.fetch refs/heads/master:refs/tags/ko-master
>> git config --add remote.ko.fetch refs/heads/next:refs/tags/ko-next
>> git config --add remote.ko.fetch refs/heads/maint:refs/tags/ko-maint
> 
> I'd actually suggest:
> 
> 	$ edit .git/config

Sure, it just seemed OP wanted cut-n-paste commands for his co-workers 
(or ko-workers).

> and create this section:
> 
>         [remote "ko"]
>                 url = master.kernel.org:/pub/scm/git/git.git/
>                 fetch = +refs/heads/*:refs/remotes/ko/*

I think that's what OP wanted to avoid.

>                 push = heads/master
>                 push = heads/next
>                 push = +heads/pu
>                 push = heads/maint
> 
> (I used to say ko-master but these days I say ko/master).

OK, that would make it ko/workers above ;)

Seriously: I found the info about those config keys in "git-push.1"; 
it's also in "git-{pull,fetch}.1". I would expect that info to be in 
"git-{remote,config}.1". The latter points to it, the former not really.

Michael
