From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gitk doesn't work w/o sudo.
Date: Tue, 20 Jan 2009 22:10:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901202209450.3586@pacific.mpi-cbg.de>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>  <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>  <c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>  <200901200912.14432.brian.foster@innova-card.com> 
 <c94f8e120901200851n21c6d67r3c43e3efd435e3db@mail.gmail.com>  <alpine.DEB.1.00.0901201815010.5159@intel-tinevez-2-302> <c94f8e120901201020g32fad692p214fdf1640a4796f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Foster <brian.foster@innova-card.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	git list <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:11:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPNsq-0002MA-DB
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 22:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758358AbZATVKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 16:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758146AbZATVKP
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 16:10:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:59688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757688AbZATVKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 16:10:14 -0500
Received: (qmail invoked by alias); 20 Jan 2009 21:10:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 20 Jan 2009 22:10:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19U/W4ZbjtUDVRC71LeQvlk3pSPclo/q7HvBl+cMY
	Fo7tN0KXt2GX5t
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <c94f8e120901201020g32fad692p214fdf1640a4796f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106526>

Hi,

On Tue, 20 Jan 2009, Dilip M wrote:

> On Tue, Jan 20, 2009 at 10:46 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > 'd try running it with strace, and then search the output for stat()
> > calls involving <something>/.git.
> 
> Seems like we are almost there....here is the log..
> 
> dm-laptop:~/repos/atria> grep gitk /tmp/gitk_1.log
> execve("/usr/bin/gitk", ["/usr/bin/gitk"], [/* 37 vars */]) = 0
> open("/usr/bin/gitk", O_RDONLY)         = 3
> execve("/usr/bin/wish8.4", ["/usr/bin/wish8.4", "/usr/bin/gitk",
> "--"], [/* 37 vars */]) = 0
> stat("/usr/bin/gitk", {st_mode=S_IFREG|0755, st_size=237778, ...}) = 0
> open("/usr/bin/gitk", O_RDONLY)         = 6
> lstat("/usr/share/gitk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> lstat("/usr/share/gitk/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> lstat("/usr/share/gitk/lib/msgs", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> access("/usr/share/gitk/lib/msgs/en_in.msg", F_OK) = -1 ENOENT (No
> such file or directory)  <======
> lstat("/usr/share/gitk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> lstat("/usr/share/gitk/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> lstat("/usr/share/gitk/lib/msgs", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> access("/usr/share/gitk/lib/msgs/en.msg", F_OK) = -1 ENOENT (No such
> file or directory)       <======
> stat("/home/dm/.gitk", {st_mode=S_IFREG|0644, st_size=683, ...}) = 0
> open("/home/dm/.gitk", O_RDONLY)        = 6
> writev(5, [{"\22\0\7\0\16\0@\3\'\0\0\0\37\0\0\0\10NG\0\4\0\0\0gitk\20"...,
> 48}], 1) = 48
> writev(5, [{"\22\0\7\0\16\0@\3(\1\0\0\37\1\0\0\10AME\4\0\0\0gitk\22"...,
> 112}], 1) = 112
> 
> dm-laptop:~/repos/atria> ls -l /usr/share/gitk/lib/msgs/en_in.msg
> ls: cannot access /usr/share/gitk/lib/msgs/en_in.msg: No such file or directory
> 
> But how is it working when  I do 'sudo'..

Let's find out.  You can run the strace with sudo, too.

I bet it uses another git.

Ciao,
Dscho
