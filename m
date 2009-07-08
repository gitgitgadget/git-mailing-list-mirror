From: Fritz Anderson <fritza@uchicago.edu>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 8 Jul 2009 13:22:15 -0500
Message-ID: <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <7viqi386th.fsf@alter.siamese.dyndns.org> <102A43B8-AD35-4B1D-850C-3642CEDB2864@uchicago.edu> <7vskh76pui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=windows-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 20:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MObn2-00083B-Ai
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 20:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZGHSWf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2009 14:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbZGHSWf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 14:22:35 -0400
Received: from authsmtp00.uchicago.edu ([128.135.249.245]:36467 "EHLO
	authsmtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbZGHSWf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 14:22:35 -0400
Received: from fritzanderson.uchicago.edu (fritzanderson.uchicago.edu [128.135.0.17])
	(authenticated bits=0)
	by authsmtp00.uchicago.edu (8.13.1/8.13.1) with ESMTP id n68IMEh0010855
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2009 13:22:14 -0500
In-Reply-To: <7vskh76pui.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122909>

On Jul 8, 2009, at 12:34 PM, Junio C Hamano wrote:

> Which makes the initial "sudo git clone..." find git in _your_ path =20
> before
> sanitization (and that is why it even starts), but then the path is =20
> nuked
> for the git process it launches, and we cannot find git-index-pack =20
> on the
> PATH.
>
> But this should be fine, as git is expected to find git-index-pack =20
> in its
> GIT_EXEC_PATH that is compiled in the binary of "git" itself.
>
> Which makes me suspect that your "git" in /usr/local/bin may be
> misconfigured.  You might want to check what these tell you.
>
> 	$ git --exec-path
> 	$ /usr/local/bin/git --exec-path

Glad to oblige. These are the four possibilities:

$ git --exec-path
/usr/local/libexec/git-core
$ /usr/local/bin/git --exec-path
/usr/local/libexec/git-core
$ sudo git --exec-path
/usr/local/libexec/git-core
$ sudo /usr/local/bin/git --exec-path
/usr/local/libexec/git-core
$

Same path every time, sudo or not, full path to git or not.

I built git (after installing zlib) simply with "./configure" and =20
"sudo make install".

	=97 F
