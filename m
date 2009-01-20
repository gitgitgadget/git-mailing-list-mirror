From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: gitk doesn't work w/o sudo.
Date: Tue, 20 Jan 2009 23:50:23 +0530
Message-ID: <c94f8e120901201020g32fad692p214fdf1640a4796f@mail.gmail.com>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
	 <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>
	 <c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>
	 <200901200912.14432.brian.foster@innova-card.com>
	 <c94f8e120901200851n21c6d67r3c43e3efd435e3db@mail.gmail.com>
	 <alpine.DEB.1.00.0901201815010.5159@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Foster" <brian.foster@innova-card.com>,
	"Reece Dunn" <msclrhd@googlemail.com>,
	"git list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 19:21:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPLEW-00070K-7w
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 19:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762287AbZATSU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 13:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbZATSU1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 13:20:27 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:19398 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762261AbZATSUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 13:20:25 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1554676yxm.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7wjDO212dQO8Mm47DJeuycAQd2O7klnB56B3AehzDb8=;
        b=jvrzNSN8k39xBoX5s4iCYi/Pnf1IOyP6KM99EVBm52URmX/tPP2ikcWUot8RHhyhbS
         TSIEloz3kI3cOPJfjhmZz3vbX2Ibgowp3DcOzbSOJpW1V8uT0rtGQXWNCPECgROGMKBC
         ZUavihYCQByVV629RDJH70CutA+4mz6MpkTBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dDgCXISlvCMfqQZu4Dv1aroNPtNyimyDLHPdALOUiiKwqJ80dD0d7hliDM2gVtu4Kn
         eurKWTnhoEnV2Hz4YwDcDVcCqyjUjUsuvNoFDVUCZXmrtsCx6pXUF7/CkW+cuFVJGOTG
         xJ9mEWTXMZbTd40g+ZYNWg0jEN1NMWmCmihKw=
Received: by 10.65.98.8 with SMTP id a8mr51118qbm.118.1232475624040;
        Tue, 20 Jan 2009 10:20:24 -0800 (PST)
Received: by 10.100.128.10 with HTTP; Tue, 20 Jan 2009 10:20:23 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901201815010.5159@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106506>

On Tue, Jan 20, 2009 at 10:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> 'd try running it with strace, and then search the output for stat()
> calls involving <something>/.git.

Seems like we are almost there....here is the log..

dm-laptop:~/repos/atria> grep gitk /tmp/gitk_1.log
execve("/usr/bin/gitk", ["/usr/bin/gitk"], [/* 37 vars */]) = 0
open("/usr/bin/gitk", O_RDONLY)         = 3
execve("/usr/bin/wish8.4", ["/usr/bin/wish8.4", "/usr/bin/gitk",
"--"], [/* 37 vars */]) = 0
stat("/usr/bin/gitk", {st_mode=S_IFREG|0755, st_size=237778, ...}) = 0
open("/usr/bin/gitk", O_RDONLY)         = 6
lstat("/usr/share/gitk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/usr/share/gitk/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/usr/share/gitk/lib/msgs", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
access("/usr/share/gitk/lib/msgs/en_in.msg", F_OK) = -1 ENOENT (No
such file or directory)  <======
lstat("/usr/share/gitk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/usr/share/gitk/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/usr/share/gitk/lib/msgs", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
access("/usr/share/gitk/lib/msgs/en.msg", F_OK) = -1 ENOENT (No such
file or directory)       <======
stat("/home/dm/.gitk", {st_mode=S_IFREG|0644, st_size=683, ...}) = 0
open("/home/dm/.gitk", O_RDONLY)        = 6
writev(5, [{"\22\0\7\0\16\0@\3\'\0\0\0\37\0\0\0\10NG\0\4\0\0\0gitk\20"...,
48}], 1) = 48
writev(5, [{"\22\0\7\0\16\0@\3(\1\0\0\37\1\0\0\10AME\4\0\0\0gitk\22"...,
112}], 1) = 112

dm-laptop:~/repos/atria> ls -l /usr/share/gitk/lib/msgs/en_in.msg
ls: cannot access /usr/share/gitk/lib/msgs/en_in.msg: No such file or directory

But how is it working when  I do 'sudo'..

-- DM
