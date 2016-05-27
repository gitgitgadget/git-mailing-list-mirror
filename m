From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC] Triangular Workflow: user friendly full implementation
Date: Fri, 27 May 2016 08:32:11 +0100
Organization: OPDS
Message-ID: <D501BE7EF38A4CDF9ADB786B53CCFE0C@PhilipOakley>
References: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <matthieu.moy@grenoble-inp.fr>,
	"Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>,
	"Tom Russello" <tom.russello@grenoble-inp.org>,
	"Samuel Groot" <samuel.groot@grenoble-inp.org>
To: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 09:32:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6CFq-0004vH-HU
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 09:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbcE0HcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 03:32:17 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:37428 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932416AbcE0HcP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 03:32:15 -0400
Received: from PhilipOakley ([92.22.67.185])
	by smtp.talktalk.net with SMTP
	id 6CFgbuEk9OORZ6CFgbgs0T; Fri, 27 May 2016 08:32:13 +0100
X-Originating-IP: [92.22.67.185]
X-Spam: 0
X-OAuthority: v=2.2 cv=Tq6kv3fh c=1 sm=1 tr=0 a=pxL+8fxP9jym1BLqsrSJlw==:117
 a=pxL+8fxP9jym1BLqsrSJlw==:17 a=8nJEP1OIZ-IA:10 a=aSBN74SrAAAA:8
 a=lTFX22NTolzt58o6f9kA:9 a=QLKLDn6n7aLR3e0nYJH2:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfGsQ8bFcNu4dlBoNmyFrdacOzp/yPQvMJADElOT1kthEDgDlGxi8exMJF2Zq+DuT73CC8EvHUF/DQxbvwsKW02/sHF3OnS1eAwLbAPP8hC405/PouQRo
 i8pKJDZ3d4kDj1f1ljBLLJxq28cmtyQZ3oSlAR1Tpaj3m1OoQsx8vFuJ4eLUB1XuzhEHEZIcBK4RdzbORlKpn9iJ9OgjCuOc3zxgPdCqEJHOnwwVGUcEwDT2
 MwkCP/bJVpho8GufRniPfCk9Rq6oH69cb0FwfHiKNCeTK2IqSC8vGsl913WQ3g8oqQvXw9adevtqyrscVnPzUZEvfK33VgSuaqL1ngBf4mg/pmO9j8EyryeJ
 73st6JstYbEQL/7diGoBBPn9MnGM5SpMJ0okT8Rm8pZobrQChi0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295740>

From: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>
> We are working on full implementation of triangular workflow feature.
> For now, the main options available are:
> - branch.<name>.pushRemote
> - remote.pushDefault
> And only setable by hands.
>
> As it can be difficult to understand, here is what we want to do.
>
>
> Context:
> - One main remote repository, e.g. git/git.
> - A remote fork (e.g. a GitHub fork) of git/git, e.g. me/git.
> - A local clone of me/git on the machine
>
> Purposes:
> - the local branch master has to fetch to git/git by default
> - the local branch master has to push to me/git by default
>
> Configuration wanted:
> - Add a remote to git/git e.g. `git remote add ...`
> - Set the fetch remote for branch as default.
>
> For now, we can do that by setting:
> - branch.<name>.remote to git/git
> - branch.<name>.pushRemote to me/git
> But many options set `branch.<name>.remote`, a suitable solution is to
> implement an option for the fetch for example.
>
>
> Here is what we want to implement:
>
> 1.
> a. add the config var: remote.fetchDefault
> b. add the config var: branch.<name>.fetchRemote
> c. add `git fetch --set-default` in order to set remote.fetchDefault
> d. add `git fetch --set-remote` in order to set branch.<name>.fetchRemote
> e. add `git pull --set-default` in order to set remote.fetchDefault
> f. add `git pull --set-remote` in order to set branch.<name>.fetchRemote
>
> 2.
> a. add `git push --set-default` in order to set remote.pushDefault
> b. add `git push --set-remote` in order to set branch.<name>.pushRemote
>
>
> What's your opinion about this feature ?
>
For me, the first step would be to actually document a (the?) Triangular 
Workflow in the documentation, so we are all taking about the same broad 
method.

At the moment there is a choice (assuming a ithub like service) of either 
clone and then fork, or fork and clone the fork, which leave the user with 
different fixups of their config's being required, so describing the easier 
one would help folk.

Likewise there are missing terms such as for the third place (the personal 
fork) that is neither the upstream, nor the local repo. Making sure the 
terminology is crisp and clean will greatly ease any implementation issues. 
And then there are the possible workflows...

--
Philip
(sorry for the rushed message, a long weekend beckons) 
