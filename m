From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: Restricted git push ?
Date: Tue, 19 Jul 2011 21:36:24 +0530
Message-ID: <20110719213624.7be7b928@shiva.selfip.org>
References: <20110719150637.596b9791@shiva.selfip.org>
	<CAMK1S_jsv-pFy6bNPG=EK=4YsJOh3GUZ+_DAq6n36ajWuhyNaQ@mail.gmail.com>
	<20110719160311.10f2364d@shiva.selfip.org>
	<20110719161529.47268b52@shiva.selfip.org>
	<20110719164037.05fd4a36@shiva.selfip.org>
	<CAMK1S_hhHhETL2tE=E98Bku96KULC9L-pHCwz3iPjwEcMbCe9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 08:09:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjPyG-0003MN-Op
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 08:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab1GTGJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 02:09:19 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:39090
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941Ab1GTGJS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 02:09:18 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 9A4261808001;
	Wed, 20 Jul 2011 08:09:14 +0200 (CEST)
In-Reply-To: <CAMK1S_hhHhETL2tE=E98Bku96KULC9L-pHCwz3iPjwEcMbCe9w@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177519>

On Tue, 19 Jul 2011 20:33:23 +0530
Sitaram Chamarty <sitaramc@gmail.com> wrote:

> On Tue, Jul 19, 2011 at 4:40 PM, J. Bakshi <joydeep@infoservices.in> wrote:
> 
> > Just like git-receive-pack anything for git pull,clone etc.. ? then we can use those to restrict read access separately. Users having read access need not have the right access then.
> 
> git-upload-pack I guess.  Maybe git-upload-archive also.
> 

I have tried with git-upload-pack, but it gives error as

````````````
Cloning into ....
error: RPC failed; result=22, HTTP code = 401
fatal: The remote end hung up unexpectedly
````````````````

The configuration I use is

````````````
<LocationMatch "^/git/.*/git-upload-pack$">
AuthType Basic
# Message to give to the committer
AuthName "Write access requires a password"
# File listing users with write (commit) access
AuthUserFile /home/git/pushACL
Require valid-user
</LocationMatch>
````````````
