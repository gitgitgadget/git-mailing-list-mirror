From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Gate between git and mediawiki : remote-helpers
Date: Thu, 26 May 2011 12:16:16 +0200
Message-ID: <BANLkTinFnv+dgYXwJkbO5bvp7WhvpCAwQg@mail.gmail.com>
References: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
 <BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com> <7vfwo6y1kg.fsf@alter.siamese.dyndns.org>
 <BANLkTinvnm7NvUs4BuGpBYsYKR0D1eP+cQ@mail.gmail.com> <vpqk4dhzsvh.fsf@bauges.imag.fr>
 <7vd3j9wll0.fsf@alter.siamese.dyndns.org> <BANLkTikax2T3BFs_wac-W8tWeiZ=YHsxvg@mail.gmail.com>
 <7v4o4lwe6r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arnaud Lacurie <arnaud.lacurie@gmail.com>,
	Claire Fousse <claire.fousse@gmail.com>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 12:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPXcR-00033i-01
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 12:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757344Ab1EZKQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 06:16:37 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48950 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757114Ab1EZKQg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 06:16:36 -0400
Received: by pzk9 with SMTP id 9so237988pzk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=VhJwIVInybuPE2hCrgpV9xf8xyZwnBwI9lXDkQ34+h4=;
        b=v4cQtV3Vvi57BncII0GBYvsx5TD5RSsiIOjJnfkdj/9M+HJxhRcVMinAYq7iwqBidO
         pqG2U1F5qz1pZCeK3/59QJfg02ppltotuQpo9cvOjpyvl3hGcoSHgHGU9RTLxdO7dCj7
         KnhzbSyAzkyR7e+YCDEBY+Ort5QZTKK1Ko9R4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OdFYKzcj/FPqTiPj3r0jte+4IlyRiBct+mqsnX9Jx24jzc6DJ/k2RxvOTFbpC60Ds2
         s6U68AbtZRqBML9S5QY6g0YCIXcS2nPhevpqXiOrWLuG1e2ZDBvPzz7wOpBfF5+IOqNO
         Ud/81+pWFMphk0L9a/NBoOBvdIqnEPW+QDJg0=
Received: by 10.142.43.15 with SMTP id q15mr87416wfq.348.1306404996159; Thu,
 26 May 2011 03:16:36 -0700 (PDT)
Received: by 10.142.13.11 with HTTP; Thu, 26 May 2011 03:16:16 -0700 (PDT)
In-Reply-To: <7v4o4lwe6r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174504>

Thank you for the advice regarding the project. Here is its status :

- We decided with your advice to use remote helpers, using the syntax
mediawiki::http://url.com (thanks to Sverre Rabbelier & Junio Hamano)
- We created a github at the following url
https://github.com/Bibzball/Git-Mediawiki
On it you will find
	* Our source code featuring
		- A start of a remote helper. The functions currently supported are
described on the wiki
		- The import part, for which we would like to thank Jeff King for
his initial perl code that we used and altered to realize the import
function of the remote helper
		- The export part is for now only a quick application of the
mediawiki API to export a file
	* A wiki with the basic documentation on our project
Feel free to consult it and give comments / ask questions

In order to maintain coherence between revisions (mediawiki) and
commits (git), we have to store metadata somewhere. Since we want to
keep transparency on the mediawiki's side, we want this data to be
stored in git. Git notes seem to be a good answer here. They could
contain the revision numbers that correspond to the commited files.
Also, a commit with t files on git should be t revisions on mediawiki.

We identified a few issues :
* Conflicts :
	- A git user wants to push files
	- He is allowed to do so : no new revisions were made on mediawiki
	- The git user starts to push the files one by one, using the mediawiki API
	- A mediawiki user edits one of the files queued up in the for-push
list and saves his modifications
	-> The git user should be interrupted in his process. If not, the
changes of the mediawiki user will be overridden.
 	We still don't have a solution for this problem. Our guess is that
we should send each file in 2 steps.
a) get the timestamp of the last revision of this file from mediawiki
b) send the file, if allowed to, based on this timestamp

* A tree from mediawiki is necessarily linear. The tree from git can
have multiple branches. Let's have this example :
	- The mediawiki has been cloned on our side
	- We made changes and committed them
	- We want to pull changes from the mediawiki
2 solutions from here :
	a) Pull including merge
		Pros : The tree is saved on our side. If someone wants to clone our
repository, he will keep this structure.
		Cons : Because of mediawiki's trees linearity, keeping branches on
our side forces us to pull again right after the push in order to
maintain coherance between mediawiki revisions and git commits.

	b) Pull -- rebase
		Pros : We are very close to mediawiki's structure, facilitating
synchronisation.
		Cons : Forbids other git users to clone my repository since some of
my branches might die after a rebase. This, in our opinion, kind of
goes against some of git's principles.

To you, which solution do you prefer ? Do you see any alternative ?

* We would like to have the alternative to clone only partially the
mediawiki (for example, only a few pages). Let's illustrate this one :
	- A user clones pages a, b and c
	- Later on, he wants to add another page d to his clone list
	-> The entire history/tree has to be remade as commits have to be
inserted in between others

Thank you for your support on this project. If any information
reported was not clear enough, feel free to ask questions. Any
contribution / suggestion is welcome.

Regards,
The Git-Mediawiki team, Arnaud Lacurie, David Amouyal, Claire Fousse &
Jeremie Nikaes.
