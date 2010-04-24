From: Wincent Colaiuta <win@wincent.com>
Subject: Re: 'commit -a' safety (was: Re: Please default to 'commit -a' when no changes were added)
Date: Sat, 24 Apr 2010 13:10:24 +0200
Message-ID: <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> <20100422155806.GC4801@progeny.tock> <m3633hdw9u.fsf_-_@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 13:27:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5dVm-0000xA-38
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 13:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab0DXL0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 07:26:44 -0400
Received: from outmail149113.authsmtp.com ([62.13.149.113]:54133 "EHLO
	outmail149113.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751967Ab0DXL0n convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 07:26:43 -0400
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Apr 2010 07:26:43 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt5.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o3OBAViD006151;
	Sat, 24 Apr 2010 12:10:31 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o3OBAS2w098652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 24 Apr 2010 12:10:29 +0100 (BST)
Received: from [192.168.1.6] (175.Red-88-3-72.dynamicIP.rima-tde.net [88.3.72.175])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o3OBAO6W030411
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 24 Apr 2010 07:10:26 -0400
In-Reply-To: <m3633hdw9u.fsf_-_@localhost.localdomain>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: fdf405e5-4f91-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCEVH aBodB0JJdwdEHAkR AmQBWlReUlQ/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNF3oacH8D QR4XWh93dUtHfXd3 Zwg0CiZfXEEvcFt5 FEdVCGwHMTF9YWdN Al1YdwFWdgdDeRdA a1gxNiYHcXJUOSc9 HhN7ejl+dS5WJilJ U0lNMlsJEw4xE2x0 fxQPFC4iVUEISSwu KwBuNllUU00WN0Az LRNkUB1QLB8fDEVY GAlGACZfKFQaDzUm Fw4SVEISHTEcKQAA 
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145666>

El 24/04/2010, a las 11:40, Jakub Narebski escribi=F3:

> It's a pity that people didn't concentrate on this part: improving
> error message...
>=20
>=20
> On a bit unrelated note what I'd like to have is 'git commit -a'
> (optional) safety against accidentally getting rid of staged changes.
>=20
> I'd like for 'git commit -a' to *fail* if there are staged changes fo=
r
> tracked files, excluding added, removed and renamed files.  If you
> have some staged changes you would get an error message:
>=20
>  $ git add tracked-file
>  $ git commit -a
>  fatal: There are staged changes to tracked files
>  hint: To commit staged changes, use 'git commit'
>  hint: To commit all changes, use 'git commit -f -a'=20
>=20
> Perhaps this behavior would be turned on only if some config option,
> like commit.preserveIndex or something like that is set to true...

=46or me this is going to far. While we don't want to make it _easy_ fo=
r users to shoot themselves in the foot, neither do we want to make it =
difficult or impossible for them to get the tool to do things that _mig=
ht_ be a mistake. And what's the risk here? Accidentally committing too=
 much is not a destructive change, and can be easily undone.

Where do we stop here with the hand-holding? Would you also want a fata=
l error here?:

$ git add foo
$ git commit -- bar
fatal: There are staged changes to tracked files

IMO, the fact that the commit message editor is populated with a list o=
f changed files that will be included in the commit is enough for peopl=
e to see what's actually going to happen.

Cheers,
Wincent
