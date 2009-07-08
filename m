From: Fritz Anderson <fritza@uchicago.edu>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 8 Jul 2009 12:10:11 -0500
Message-ID: <102A43B8-AD35-4B1D-850C-3642CEDB2864@uchicago.edu>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <7viqi386th.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=windows-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:10:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOafD-0005u6-37
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 19:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbZGHRK2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2009 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754282AbZGHRK2
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 13:10:28 -0400
Received: from authsmtp00.uchicago.edu ([128.135.249.245]:35713 "EHLO
	authsmtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbZGHRK1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 13:10:27 -0400
Received: from fritzanderson.uchicago.edu (fritzanderson.uchicago.edu [128.135.0.17])
	(authenticated bits=0)
	by authsmtp00.uchicago.edu (8.13.1/8.13.1) with ESMTP id n68HACG0003088
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2009 12:10:12 -0500
In-Reply-To: <7viqi386th.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122905>

On Jul 8, 2009, at 11:42 AM, Junio C Hamano wrote:

> Fritz Anderson <fritza@uchicago.edu> writes:
=2E..
>> $ sudo GIT_TRACE=3D1 git clone myusername@remote.example.com:/Users/
>> myusername/scientia/scientia.git
>
> I have heard that pseudo resets the PATH so you are invoking "git" =20
> from
> one of those standard system PATH, perhaps /usr/bin.
>
>> trace: built-in: git 'clone' 'myusername@remote.example.com:/Users/
>> myusername/scientia/scientia.git'
>> Initialized empty Git repository in /srv/scientia/.git/
>> trace: run_command: 'ssh' 'myusername@remote.example.com' 'git-=20
>> upload-
>> pack '\''/Users/myusername/scientia/scientia.git'\'''
>> Password:
>> trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' '--
>> keep=3Dfetch-pack 17580 on local.example.com'
>> trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin' '--
>> keep=3Dfetch-pack 17580 on local.example.com'
>> trace: exec failed: No such file or directory
>> trace: exec 'index-pack' failed: No such file or directory
>
> This is saying that "git" on the local side (the one you are running
> "clone" on) couldn't find its "index-pack" subcommand.  Why?
>
> I think this is an issue with your RHEL5 box, not the MacOS box.  A =20
> quick
> check that might be useful is to type:
>
> 	$ git index-pack
> 	$ sudo git index-pack

Here is the result:

=3D=3D=3D
$ git index-pack
usage: git index-pack [-v] [-o <index-file>] [{ ---keep | --=20
keep=3D<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-=
=20
file>] }
$ sudo git index-pack
usage: git index-pack [-v] [-o <index-file>] [{ ---keep | --=20
keep=3D<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-=
=20
file>] }
=3D=3D=3D

So git is apparently found. HOWEVER, if I do this, it's a different =20
story:

=3D=3D=3D
$ which git
/usr/local/bin/git
$ sudo which git
which: no git in (/usr/bin:/bin)
=3D=3D=3D

On that evidence, I reissued my problem command under sudo, =20
specifying /usr/local/bin/git as the command. That worked. Thank you; =20
I would not have found it without you.

I'm obviously ignorant on the path issue, but that's off-topic for =20
this list.

Thanks again.

	=97 F
