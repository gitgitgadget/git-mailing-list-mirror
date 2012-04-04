From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: How to create empty CENTRAL  git with master / development branch
 ?
Date: Wed, 04 Apr 2012 20:00:17 +0200
Message-ID: <4F7C8C31.7050206@ira.uka.de>
References: <20120403162352.67cb165e@shiva.selfip.org>	<4F7B0F1B.3000304@ira.uka.de> <201204040711.q347BTXg025316@VM-MailSafe-02.soltecsis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Wed Apr 04 19:59:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFUUj-0000Hg-6Z
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 19:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428Ab2DDR7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 13:59:40 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52567 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932300Ab2DDR7j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 13:59:39 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SFUUX-000737-7Z; Wed, 04 Apr 2012 19:59:38 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SFUUX-00018w-2m; Wed, 04 Apr 2012 19:59:33 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <201204040711.q347BTXg025316@VM-MailSafe-02.soltecsis.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1333562378.335460000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194714>

On 04.04.2012 09:11, J. Bakshi wrote:
> well.... I like to create the master just after creating the bare repo.
> So that the users can just start working on it without "git push origin master"

But what do you mean by working on it? The users don't work on the 
central repository, everyone has his own repository. And when this user 
wants to put something into the central repository he needs to push

> As I can already ssh into the central git server, I don't need any further
> ssh://big.brother.edu/repo.git
>
> So what should I do after creating a bare empty repo to generate the master
> there ?

I can give you two answers to that, both somewhat true:

1) The master branch already exists, HEAD already points to it (look 
into the file HEAD).

2) Without a commit that master can point to a master branch can't 
exist. You first have to have a commit that you put into this 
repository. Since it is bare you can't use "git add"+"git commit" you 
have to push it from some other repository

A branch is like a pointer in a programming language, it points to a 
commit. If you don't have any commits, the pointer is NIL. I don't know 
if git has any use for NIL pointers (i.e. an empty /refs/heads/master 
file), but no file refs/heads/master or an empty file refs/heads/master 
means practically the same as having the NIL value (as far as I know)


Instead of "git push -u" you could also clone the bare repository from 
somewhere (it will give a warning), add a file (for example ".gitignore" 
if you want to keep the repository practically empty), commit, and push. 
You can do this locally on the server if you want to.
