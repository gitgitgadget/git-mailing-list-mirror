From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Wed, 29 Apr 2009 23:05:43 +0200
Message-ID: <49F8C127.4000400@drmicha.warpmail.net>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>	 <49F8B7D1.2090903@drmicha.warpmail.net> <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzGyk-0004gr-Ir
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbZD2VFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756296AbZD2VFu
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:05:50 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44005 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758875AbZD2VFt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 17:05:49 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 27055336A4B;
	Wed, 29 Apr 2009 17:05:49 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 29 Apr 2009 17:05:49 -0400
X-Sasl-enc: zy5GoSDlC95dBi85LuJ5Mjd48mvYy4LPU5psR1nbod4U 1241039148
Received: from localhost.localdomain (p5DCC1814.dip0.t-ipconnect.de [93.204.24.20])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2CC382D1B4;
	Wed, 29 Apr 2009 17:05:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117946>

Martin Langhoff venit, vidit, dixit 29.04.2009 22:47:
> On Wed, Apr 29, 2009 at 10:25 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Given the versions that fail for Martin and work for Avery and me I
>> would think it's not a git issue but rather a matter of the svn version
>> resp. the svn perl bindingds.
> 
> Good point. The machine where this is failing is an Ubuntu Intrepid box...
> 
> $ dpkg -l libsvn* | grep '^i'
> ii  libsvn-perl                                1.5.1dfsg1-1ubuntu2
>                 Perl bindings for Subversion
> ii  libsvn1                                    1.5.1dfsg1-1ubuntu2
>                 Shared libraries used by Subversion
> ii  libsvncpp1                                 0.9.6-1
>                 Subversion C++ shared library
> dpkg -l subversion* | grep '^i'
> ii  subversion                                 1.5.1dfsg1-1ubuntu2
>                 Advanced version control system
> 
> On the F9 box where things succeed...
> 
> $rpm -qa subversion*
> subversion-perl-1.4.6-7.i386
> subversion-1.4.6-7.i386
> $ rpm -qa *svn*
> git-svn-1.6.0.6-3.fc9.i386
> 
> What are the versions in that F-10 box? Could it be an incompatibility
> with svn-1.5.x?

1.5.4

But I just re-read your original report, and there's some inconsistency:

git-svn triggers cat-file's usage message which says "git-cat-file ...".
The dash indicates that it is a git cat-file before v1.6.0.1-13-g34baebc
(where the dash was removed), so it's definitely not the current maint
you think you are using.

Do you have older ubuntu git packages installed in $PATH?

Michael
