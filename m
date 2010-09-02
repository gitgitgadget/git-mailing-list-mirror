From: "J. Bakshi" <j.bakshi@unlimitedmail.org>
Subject: Re: newbie problem - gitweb  and git over http
Date: Thu, 2 Sep 2010 11:13:53 +0530
Message-ID: <201009020543.o825hfUm005721@dcnode-02.unlimitedmail.net>
References: <20100902110242.2da0c81d@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 08:11:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or31S-0000dp-2f
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 08:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab0IBGLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 02:11:33 -0400
Received: from smtp.unlimitedmail.net ([94.127.184.242]:42924 "EHLO
	dcnode-02.unlimitedmail.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754351Ab0IBGLb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 02:11:31 -0400
X-Greylist: delayed 1662 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2010 02:11:31 EDT
Received: from debian (ABTS-North-Static-116.30.176.122.airtelbroadband.in [122.176.30.116] (may be forged))
	(authenticated bits=0)
	by dcnode-02.unlimitedmail.net (8.14.3/8.14.3) with ESMTP id o825hfUm005721
	for <git@vger.kernel.org>; Thu, 2 Sep 2010 07:43:43 +0200
In-Reply-To: <20100902110242.2da0c81d@debian>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAgMAAAAqbBEUAAAADFBMVEW2UCaWJQ3jnnRrCARshP4hAAACQElEQVQokRWSzU4aYRiFDwhiJjGAimxqRlzhbGpDm24wjmhTQtIIOlMag6GXUP92Tj5obcaaJqRJidvBlDi8N1FpbUzcFGgNK0MvgZKZsmHydVw+OWd1zgOiaH+98Ejt/SGCaTDlmZMYdl+cEmjMKQydBL97kJFAYlfbVab5KHS5AONrnoenPhVHbU1A4yezEYup+1crGRhtfuv9kPZtLRcz8Mw4ykJ1UPJF72Qkg09SdHFFxkY/iZW1HxNSY/zLSbS1B9sKLW7TaU3yB55DHXnjL4n0m1BSRNOZoKo8IXqx1YVqZ6is+C0YwS7Gml4q5/mdRFEbSkig95xbZEaHCMpEJ5x3yPRzyCEqzcTm0lMUscEEE0gfm/64RwPbpJyTIlPbLnNoMoku1JxNAHyTzhzQO2fWXL5PKgOD9H+fPQW4lUqnJk0OqkYEWorETE0SBzrmwFP0lj7Gn1r6qgZ4z8/jM/GVm7Mcg5apH4db8d43PccBoY6oHGAdPRuBX2m8DrSn+Y1+GALLNtLskjWFQHaEXsvMFvsFgc5sD4oyZT39wjiJQwu5ljRbSheqQnHIEfGfV2n+oL7KeBetvrcumQc1lbsQWJVj2fkDk/dceCwqi6qn4y7gcLxhlnCY71DgyGG4yNuvKnyPfBtzNipdRy6r/YXI9Pc+dM7WocqIHGU7KDlsSQn7wsHfSS9MVti9Dau5jfYkuU
 9Y13Z45+havZRg6H/Xhgk+au7c61L6FVD3XVu44IpkPpxUtnrqkiXRf3v/EFxxaZnHAAAAAElFTkSuQmCC
X-SOLTECSIS-MailScanner-ID: o825hfUm005721
X-SOLTECSIS-MailScanner-From: j.bakshi@unlimitedmail.org
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155106>

On Thu, 2 Sep 2010 11:02:42 +0530
"J. Bakshi" <joydeep@infoservices.in> wrote:

<snip>

> 
> ``````````````
> The requested URL /index.php was not found on this server

</snip>

gitweb related issue is solved. At /etc/gitweb.conf the following was creating the problem

```````````````````
$feature{'pathinfo'}{'default'} = [1];
```````````````

commenting it has solved the gitweb issue.   But no success with webda  :-(
 
> ```````````````````
> 
> webdav is already running in this server for some other project. I have setup webdav for git like
> 
> `````````
> <IfModule mod_dav_svn.c>
> <Location /myproject.git>
> Dav on
> AuthType Basic
> AuthName "My repo with git"
> AuthUserFile /home/svn/PASSWORD
> <Limitexcept GET HEAD PROPFIND OPTIONS REPORT>
> Require valid-user
> </Limitexcept>
> </Location>
> </IfModule>
> ```````````````
> 
> Now testing with cadaver
> 
> `````````````````
> cadaver https://192.168.1.1/gitweb/test.git
> 
> Authentication required for Write access requires a password on server `192.168.1.1':
> Username: svnadmin
> Password:
> Could not open collection:
> 404 Not Found
> 
> ``````````````````````
> 
> I think for both the cases there are some configuration problem which can't find the correct location/path. Could anyone kindly enlighten me, actually where the problem is ?
> 
> Thanks for your time
