From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Submodule confusion when checking out branch
Date: Tue, 11 Oct 2011 19:35:04 +0200
Message-ID: <4E947E48.7080201@web.de>
References: <CAHVO_90rHbqqUx6HCh7tLWO9aP9PyPMpYnZGszCDB2bfNzUXAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Tue Oct 11 19:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDgEW-00082V-5S
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 19:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab1JKRfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 13:35:09 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:56863 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab1JKRfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 13:35:08 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id BC8B11B0849DA;
	Tue, 11 Oct 2011 19:35:06 +0200 (CEST)
Received: from [79.247.238.142] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1RDgEM-00038p-00; Tue, 11 Oct 2011 19:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CAHVO_90rHbqqUx6HCh7tLWO9aP9PyPMpYnZGszCDB2bfNzUXAQ@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19YiEvBU30RsSeJGu/nrnWm7dOFo2F2FwmyM1c0
	J5ZHDuJ38Hhs4A+u+o2oYlcW5KoYowmosHVeuAS3Uv+B5rIMzA
	z99yJ9NThRDgY3AsUfRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183309>

Am 11.10.2011 11:38, schrieb Howard Miller:
> I added a submodule to my project like this (all from the root of the project)
> 
> git submodule add git@.....   path/to/submodule
> git submodule init
> git add path/to/submodule
> git commit -m 'I added a submodule!'
> git push
> 
> All looks good and 'git status' reports 'nothing to commit'
> 
> However, I now cannot change branches. On checkout, I get...
> 
> "error: The following untracked working tree files would be
> overwritten by checkout:"
> (followed by a big list of all the files in the submodule)
> 
> Where did I go wrong and what can I do to sort it?

Hmm, as I don't know for what checkout you see this problem (do you
switch from a branch containing the submodule to one that doesn't
have it or the other way round?) and assuming you had some files
committed in the directory where the submodule lives I can take a
guess what happened:

Could it be the case that you converted an existing directory into a
submodule and then get this error when you want to switch back to a
branch where this directory is still filled with the original files?

Then this is a known shortcoming of submodules at the moment. I have
experimental code to make Git work in that case but it is not ready
for inclusion yet.
