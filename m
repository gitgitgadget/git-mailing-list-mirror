From: "J. Bakshi" <j.bakshi@unlimitedmail.org>
Subject: Re: can I use multiple worktree in same git repo ?
Date: Wed, 20 Jul 2011 21:42:09 +0530
Message-ID: <201107201611.p6KGBvna012304@dcnode-02.unlimitedmail.net>
References: <20110720182438.3c40cf1d@shiva.selfip.org>
	<CACsJy8CLRjLag65H6KQ1AUABLwiL09wNQw3VH8Y-JQnw7CqLUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 18:12:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjZNj-00015Y-5x
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 18:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab1GTQMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 12:12:12 -0400
Received: from smtp.unlimitedmail.net ([94.127.184.244]:35591 "EHLO
	dcnode-02.unlimitedmail.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752173Ab1GTQML (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 12:12:11 -0400
Received: from shiva.selfip.org ([113.21.64.216])
	(authenticated bits=0)
	by dcnode-02.unlimitedmail.net (8.14.3/8.14.3) with ESMTP id p6KGBvna012304;
	Wed, 20 Jul 2011 18:11:58 +0200
In-Reply-To: <CACsJy8CLRjLag65H6KQ1AUABLwiL09wNQw3VH8Y-JQnw7CqLUw@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAgMAAAAqbBEUAAAADFBMVEW2UCaWJQ3jnnRrCARshP4hAAACQElEQVQokRWSzU4aYRiFDwhiJjGAimxqRlzhbGpDm24wjmhTQtIIOlMag6GXUP92Tj5obcaaJqRJidvBlDi8N1FpbUzcFGgNK0MvgZKZsmHydVw+OWd1zgOiaH+98Ejt/SGCaTDlmZMYdl+cEmjMKQydBL97kJFAYlfbVab5KHS5AONrnoenPhVHbU1A4yezEYup+1crGRhtfuv9kPZtLRcz8Mw4ykJ1UPJF72Qkg09SdHFFxkY/iZW1HxNSY/zLSbS1B9sKLW7TaU3yB55DHXnjL4n0m1BSRNOZoKo8IXqx1YVqZ6is+C0YwS7Gml4q5/mdRFEbSkig95xbZEaHCMpEJ5x3yPRzyCEqzcTm0lMUscEEE0gfm/64RwPbpJyTIlPbLnNoMoku1JxNAHyTzhzQO2fWXL5PKgOD9H+fPQW4lUqnJk0OqkYEWorETE0SBzrmwFP0lj7Gn1r6qgZ4z8/jM/GVm7Mcg5apH4db8d43PccBoY6oHGAdPRuBX2m8DrSn+Y1+GALLNtLskjWFQHaEXsvMFvsFgc5sD4oyZT39wjiJQwu5ljRbSheqQnHIEfGfV2n+oL7KeBetvrcumQc1lbsQWJVj2fkDk/dceCwqi6qn4y7gcLxhlnCY71DgyGG4yNuvKnyPfBtzNipdRy6r/YXI9Pc+dM7WocqIHGU7KDlsSQn7wsHfSS9MVti9Dau5jfYkuU
 9Y13Z45+havZRg6H/Xhgk+au7c61L6FVD3XVu44IpkPpxUtnrqkiXRf3v/EFxxaZnHAAAAAElFTkSuQmCC
X-SOLTECSIS-MailScanner-ID: p6KGBvna012304
X-SOLTECSIS-MailScanner-From: j.bakshi@unlimitedmail.org
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177541>

On Wed, 20 Jul 2011 20:25:55 +0700
Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> On Wed, Jul 20, 2011 at 7:54 PM, J. Bakshi <joydeep@infoservices.in> wrote:
> > As a result whenever there is a commit , it updates the related folder in filesystem.
> > Say a commit at svn->mysite-repo->dir1->trunk->src ==> modify ==> /var/www/demo/dir1
> >
> > Can I do the same in git with multiple worktree ? possible ?
> 
> Using multiple worktree with the same repo won't work in git because
> the repo also have worktree-related information. But you can create a
> central, bare repository, then make several clones from that. Each one
> is checked out with different branches. You work on a clone and push
> to the central repo. The post-commit hook in the central repo will do
> pull from it, for example
> 
> for site in dir1 dir2 dir3; do
>     cd /var/www/$site && /usr/bin/git pull
> done
> 

Thanks for your response. I am afraid that I can't understand the approach clearly but I must say that I am hopeful to see a direction.
Obviously there will be a central git repo which will have its worktree under htdocs at the same server. That's why the post-receive 
hook will update the website after each push. But the issue is mapping the structure at git which is different than the structure at 
filesystem. And a push should reflect to its correct folder only.

[git]->[mysite]->dir1/trunk/src => physically map => htdocs/demo/dir1
[git]->[mysite]->dir2/trunk/src => physically map => htdocs/demo/dir2


Please tell me with little more clarification, how can I do this ?

-with kind regards
