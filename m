From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: How to create empty CENTRAL  git with master / development branch
 ?
Date: Tue, 03 Apr 2012 16:54:19 +0200
Message-ID: <4F7B0F1B.3000304@ira.uka.de>
References: <20120403162352.67cb165e@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Apr 03 16:53:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF57C-0001Ko-7a
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 16:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab2DCOxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 10:53:41 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33880 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753206Ab2DCOxk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 10:53:40 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SF570-0005KW-NF; Tue, 03 Apr 2012 16:53:39 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SF570-0003Cy-Hm; Tue, 03 Apr 2012 16:53:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20120403162352.67cb165e@shiva.selfip.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1333464819.721759000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194628>

On 03.04.2012 12:53, J. Bakshi wrote:
> Dear list,
>
> I need to create git repos on a remote server by the command executed on that server
> through ssh as
>
> ` ` ` ` `
> git --bare init project_name.git

you probably meant "git init --bare project_name.git"

> How can I also add the master branch, so that users don't need to
> execute  [ git push origin master ]  ?

What else do you want them to execute? "git init --bare" creates an 
empty repository. Without pushing to it it will always stay empty

Generally: If you want a central repository, the first one to push to it 
might do something like this:

git remote add origin ssh://big.brother.edu/repo.git
git push origin master
git config branch.master.remote origin
git config branch.master.merge refs/heads/master

Everyone else could do

git clone ssh://big.brother.edu/repo.git

Now everyone will push to the repository master when they do "git push".

Is that what you wanted to know?
