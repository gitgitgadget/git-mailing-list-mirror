From: jiho <jo.lists@gmail.com>
Subject: Re: Issues with file status over samba
Date: Wed, 17 Jun 2009 11:51:26 -0700 (PDT)
Message-ID: <3dfcd29f-a1cd-4007-b962-2cf5156ab708@g19g2000yql.googlegroups.com>
References: <3A1A5212-FFB4-4B0D-A972-C90EA336F5D9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 21:00:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH0NQ-0003xs-Fq
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 21:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbZFQTAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2009 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbZFQTAj
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 15:00:39 -0400
Received: from mail-yx0-f162.google.com ([209.85.210.162]:52032 "EHLO
	mail-yx0-f162.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbZFQTAg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 15:00:36 -0400
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2009 15:00:36 EDT
Received: by yxe34 with SMTP id 34so382531yxe.33
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 12:00:38 -0700 (PDT)
Received: by 10.100.248.16 with SMTP id v16mr71395anh.0.1245264686618; Wed, 17 
	Jun 2009 11:51:26 -0700 (PDT)
In-Reply-To: <3A1A5212-FFB4-4B0D-A972-C90EA336F5D9@gmail.com>
X-IP: 129.171.100.9
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) 
	AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121767>

Hi,

I am replying to my own message in the hope to get more follow ups.

On Jun 2, 5:11=A0am, JiHO <jo.li...@gmail.com> wrote:
> When working on a git repository on a mounted samba share, I am havin=
g =A0
> trouble because some files are detected as changed while they are not=
=2E =A0
> [...]
> The issue was initially investigated through gitX and the bug report =
=A0
> is there:
> http://gitx.lighthouseapp.com/projects/17830/tickets/147-wrong-status=
=2E..

I am now including here the finding reported there, for easier access.


* On the server, through a ssh connection:

acanthurus:~/discus $ git update-index -q --unmerged
--ignore-missing --refresh

acanthurus:~/discus $ git ls-files --others --exclude-standard
-z
discus.tmprojggplot_dens_and_points.Rij.shinvert_Y.Rjava_options.
txtplot_gps.Rplots.pdfrange_circular_fix.Rscratchpad.Rscratchpad.sh

acanthurus:~/discus $ git diff-files -z :100644 100644
7387d20924d2d956de25c6e9bf64f30e02aa9d35
0000000000000000000000000000000000000000 Mbb.conf:100644
100644 ec878543abb1f97a9236707b36b367e318e3393b
0000000000000000000000000000000000000000 Mreorg_data.R:100644
100644 4340bf03097dbb7c3da5519ba809915515c4b155
0000000000000000000000000000000000000000
Msrc/correct_tracks.R:100644 100644
c2ed8503d24cd97ce026c865a81094da4fca9ba9
0000000000000000000000000000000000000000 Msrc/stats.R

git gui works just fine with X11 forwarding.



* On my machine, in the same directory mounted via samba:

/Volumes/jiho/discus $ git update-index -q --unmerged
--ignore-missing --refresh

/Volumes/jiho/discus $ git ls-files --others
--exclude-standard -z
discus.tmprojggplot_dens_and_points.Rij.shinvert_Y.Rjava_options.
txtplot_gps.Rplots.pdfrange_circular_fix.Rscratchpad.Rscratchpad.sh

/Volumes/jiho/discus $ git diff-files -z :100644 100644
3c92e1bf126ac860c901056b95a12ca5ec3c9fab
0000000000000000000000000000000000000000 M.gitignore:100644
100644 e589c53c8bc1236f2c26fb919b7cbde58eeba5a4
0000000000000000000000000000000000000000 MREADME.md:100755
100755 b2627bde1a657c64002f12f46bd875ba1510d31f
0000000000000000000000000000000000000000
Mapply-to-all.sh:100755 100755
872559f9a0ab6c0d6652e28f76bc327d8710d378
0000000000000000000000000000000000000000 Mbb:100644 100644
7387d20924d2d956de25c6e9bf64f30e02aa9d35
0000000000000000000000000000000000000000 Mbb.conf:100755
100755 549031662747a3e72b3bab1f632c254249cb9ed1
0000000000000000000000000000000000000000 Mdata_stats.sh:100644
100644 f9ce73e94f14285292a84b4fabeb0419afbbc522
0000000000000000000000000000000000000000
Mglobal_stats.R:100644 100644
ec878543abb1f97a9236707b36b367e318e3393b
0000000000000000000000000000000000000000 Mreorg_data.R:100644
100644 94a9ed024d3859793618152ea559a168bbcbb5e2
0000000000000000000000000000000000000000
Msrc/GNU_GPL.txt:100644 100644
4340bf03097dbb7c3da5519ba809915515c4b155
0000000000000000000000000000000000000000
Msrc/correct_tracks.R:100644 100644
d62437858ec20a4e2ea205cba03d0d0d4a12d97c
0000000000000000000000000000000000000000
Msrc/ij.macro.open_process_stack.txt:100644 100644
ea87b2ed9f28789ad11dfb8d3a101f7824e4498e
0000000000000000000000000000000000000000
Msrc/imagej/plugins/Manual_Tracking.java:100644 100644
9f9f3c08fc1a2c86b4e52ed0d3b9f3650e27e0e9
0000000000000000000000000000000000000000
Msrc/lib_circular_stats.R:100644 100644
5b54e19e1d271cbe18886fe1979e2f87a4eed926
0000000000000000000000000000000000000000
Msrc/lib_discus.sh:100644 100644
2c0b85db44a1f90e1c00c828cce94f3de67348a7
0000000000000000000000000000000000000000
Msrc/lib_image_time.R:100644 100644
d2fe114ea8044716b73d103d9fffda18a7417c4e
0000000000000000000000000000000000000000
Msrc/lib_shell.sh:100644 100644
c2ed8503d24cd97ce026c865a81094da4fca9ba9
0000000000000000000000000000000000000000 Msrc/stats.R:100644
100644 776694862aec61259f9445d8e4f2bcfe176728a8
0000000000000000000000000000000000000000
Msrc/test_circular.R:100755 100755
28c9181bbdfd6aa0651242d66db386eef4b7cf40
0000000000000000000000000000000000000000 Msync_data.sh

/Volumes/jiho/discus $ git gui

A window pops up stating:

	No differences detected

	.gitignore has no changed

	The modification date of this file was updated by
	another application, but the content within the file
	was not changed.

	A rescan will be automatically started to find other
	files which may have the same state.

	[OK]

After pressing OK, the window keeps reappearing. .gitignore is the
first file in the list so that's why it is mentioned here.

This is not an issue of clock differences betweent eh two computer
because setting the time on the server to -1h does not help.


I hope this will be enough information for people indicating me where
to look from here. I understand that this might not be a very common
scenario: after all git is in part about having local copies of the
code and pushing to servers. Yet I find it very practical to edit the
remote files with the local tools I know and be able to use the
changes immediately on the server, and for this, a file system share
is a very good solution. The server is within a windows infrastructure
and Samba was simpler to setup than NFS (I don't have the same user ID
on both machines and none can be easily changed) so overall it made
sense to use Samba.

Thanks in advance for your help,

JiHO
---
http://maururu.net
