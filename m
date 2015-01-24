From: Kevin <compufreak@gmail.com>
Subject: Re: git pull not ignoring the file which has been sent to the
 temporary ignore list
Date: Sat, 24 Jan 2015 12:03:41 +0100
Message-ID: <20150124110341.GA15090@vps892.directvps.nl>
References: <3278910.5D06XWKxyS@linux-wzza.site>
 <CAGZ79kbk=DFcMSVtnWHw7Vn-xm4q4x5T_9qiPrqt5oN1DMhFSw@mail.gmail.com>
 <xmqq8ugtqjxg.fsf@gitster.dls.corp.google.com>
 <1557175.bcUxN10iZq@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 12:13:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEyeS-000657-65
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 12:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbbAXLNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2015 06:13:10 -0500
Received: from ikke.info ([178.21.113.177]:50211 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbbAXLNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2015 06:13:09 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Jan 2015 06:13:08 EST
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 167D94400B2; Sat, 24 Jan 2015 12:03:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1557175.bcUxN10iZq@linux-wzza.site>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262992>

On Sat, Jan 24, 2015 at 10:20:46AM +0630, Arup Rakshit wrote:
> On Friday, January 23, 2015 01:14:03 PM you wrote:
> 
> [..]
>
> There are some configuration files, like `database.yml`, where we
> generally put our local DB credentials and we don't want to share such
> things. That's why we always put related settings inside the
> .gitignore file. But  while I will change it, git will not track the
> changes of the file, but .gitignore. That's why I used the first
> thread command. But when the time the came to take a `git pull`, I got
> to know about the mess. What should be the ideal decision in this case
> ?
> 

In an ideal sittuation, configuration data is not stored inside git,
because this would tie the code only to one environment.

So what you would store in git is a template of the configuration data,
that can be used to create the actual config file that is used.

This way, you don't have any problems with having to change tracked
files only for you local environment.
