From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: Re: How to create empty CENTRAL  git with master / development
 branch ?
Date: Wed, 4 Apr 2012 12:41:22 +0530
Message-ID: <201204040711.q347BTXg025316@VM-MailSafe-02.soltecsis.com>
References: <20120403162352.67cb165e@shiva.selfip.org>
	<4F7B0F1B.3000304@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Apr 04 09:12:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFKO6-0002xL-9K
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 09:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab2DDHLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 03:11:53 -0400
Received: from smtp.unlimitedmail.net ([94.127.184.243]:45641 "EHLO
	VM-MailSafe-02.soltecsis.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753390Ab2DDHLx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 03:11:53 -0400
Received: from shiva.selfip.org (ABTS-North-Static-116.30.176.122.airtelbroadband.in [122.176.30.116] (may be forged))
	(authenticated bits=0)
	by VM-MailSafe-02.soltecsis.com (8.14.5/8.14.5) with ESMTP id q347BTXg025316;
	Wed, 4 Apr 2012 09:11:32 +0200
In-Reply-To: <4F7B0F1B.3000304@ira.uka.de>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAgMAAAAqbBEUAAAADFBMVEW2UCaWJQ3jnnRrCARshP4hAAACQElEQVQokRWSzU4aYRiFDwhiJjGAimxqRlzhbGpDm24wjmhTQtIIOlMag6GXUP92Tj5obcaaJqRJidvBlDi8N1FpbUzcFGgNK0MvgZKZsmHydVw+OWd1zgOiaH+98Ejt/SGCaTDlmZMYdl+cEmjMKQydBL97kJFAYlfbVab5KHS5AONrnoenPhVHbU1A4yezEYup+1crGRhtfuv9kPZtLRcz8Mw4ykJ1UPJF72Qkg09SdHFFxkY/iZW1HxNSY/zLSbS1B9sKLW7TaU3yB55DHXnjL4n0m1BSRNOZoKo8IXqx1YVqZ6is+C0YwS7Gml4q5/mdRFEbSkig95xbZEaHCMpEJ5x3yPRzyCEqzcTm0lMUscEEE0gfm/64RwPbpJyTIlPbLnNoMoku1JxNAHyTzhzQO2fWXL5PKgOD9H+fPQW4lUqnJk0OqkYEWorETE0SBzrmwFP0lj7Gn1r6qgZ4z8/jM/GVm7Mcg5apH4db8d43PccBoY6oHGAdPRuBX2m8DrSn+Y1+GALLNtLskjWFQHaEXsvMFvsFgc5sD4oyZT39wjiJQwu5ljRbSheqQnHIEfGfV2n+oL7KeBetvrcumQc1lbsQWJVj2fkDk/dceCwqi6qn4y7gcLxhlnCY71DgyGG4yNuvKnyPfBtzNipdRy6r/YXI9Pc+dM7WocqIHGU7KDlsSQn7wsHfSS9MVti9Dau5jfYkuU
 9Y13Z45+havZRg6H/Xhgk+au7c61L6FVD3XVu44IpkPpxUtnrqkiXRf3v/EFxxaZnHAAAAAElFTkSuQmCC
X-SOLTECSIS-MailScanner-ID: q347BTXg025316
X-SOLTECSIS-MailScanner: Found to be clean
X-SOLTECSIS-MailScanner-From: joydeep.bakshi@infoservices.in
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194683>

On Tue, 03 Apr 2012 16:54:19 +0200
Holger Hellmuth <hellmuth@ira.uka.de> wrote:

> On 03.04.2012 12:53, J. Bakshi wrote:
> > Dear list,
> >
> > I need to create git repos on a remote server by the command executed on that server
> > through ssh as
> >
> > ` ` ` ` `
> > git --bare init project_name.git
> 
> you probably meant "git init --bare project_name.git"

Yes right. Sorry for the mistake.

> 
> > How can I also add the master branch, so that users don't need to
> > execute  [ git push origin master ]  ?
> 
> What else do you want them to execute? "git init --bare" creates an 
> empty repository. Without pushing to it it will always stay empty
> 
> Generally: If you want a central repository, the first one to push to it 
> might do something like this:
> 
> git remote add origin ssh://big.brother.edu/repo.git
> git push origin master
> git config branch.master.remote origin
> git config branch.master.merge refs/heads/master
> 
> Everyone else could do
> 
> git clone 
> 
> Now everyone will push to the repository master when they do "git push".
> 
> Is that what you wanted to know?

well.... I like to create the master just after creating the bare repo.
So that the users can just start working on it without "git push origin master"
As I can already ssh into the central git server, I don't need any further
ssh://big.brother.edu/repo.git

So what should I do after creating a bare empty repo to generate the master
there ?

# git init --bare project_name.git

# cd project_name.git

.... and can I execute here any command to add master ?

Thanks
