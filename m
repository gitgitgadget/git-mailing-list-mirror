From: Mark Junker <mjscod@web.de>
Subject: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 16:17:01 +0100
Message-ID: <478E1FED.5010801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 16:17:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFA1K-0001yH-Tg
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 16:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbYAPPRF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 10:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbYAPPRE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 10:17:04 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:34371 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbYAPPRD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 10:17:03 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 205C3CA791A7
	for <git@vger.kernel.org>; Wed, 16 Jan 2008 16:17:01 +0100 (CET)
Received: from [80.146.179.234] (helo=mark-junkers-computer.local)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JFA0i-0008IM-00
	for git@vger.kernel.org; Wed, 16 Jan 2008 16:17:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
X-Sender: mjscod@web.de
X-Provags-ID: V01U2FsdGVkX18fHgi6Q9Yb2LUQ2sVSvpNBTlSAeVSF57M8SZFm
	8VddROeues3AfU2yhAAtuJC0qmZdVJyYctj4lS3xPsTaMRXarw
	/hpJwp6uA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70688>

Hi,

I have some files like "L=C3=BCftung.txt" in my repository. The strange=
 thing=20
is that I can pull / add / commit / push those files without problem bu=
t=20
git-status always complains that thoes files are untraced (but not=20
missing). My assumption is that it's a problem with the way MacOSX=20
stores the file names (decomposed UTF-8). So something like=20
"L=C3=BCftung.txt" becomes "Lu=CC=88ftung.txt".

It seems that git-status does two things:
1. Find files under version control (i.e. search for missing files)
2. Find files not under version control (i.e. search for untracked file=
s)

I guess that the first look-up succeeds because MacOS X converts=20
composed UTF-8 to decomposed UTF-8 when searching for a file. But it=20
seems that the second look-up takes the file names as-is (decomposed)=20
without converting them to composed UTF-8.

Is there an easy way to fix this behaviour? It's really annoying to see=
=20
all those "untracked" files that are already under version control when=
=20
executing a git-status.

Regards,
Mark
