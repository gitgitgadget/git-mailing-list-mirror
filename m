From: "Dilip M" <dilipm79@gmail.com>
Subject: SOLVED: Re: gitk doesn't work w/o sudo.
Date: Wed, 21 Jan 2009 00:03:32 +0530
Message-ID: <c94f8e120901201033r13a25cb7y905324d5205d2412@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Foster" <brian.foster@innova-card.com>,
	"Reece Dunn" <msclrhd@googlemail.com>,
	"git list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 19:35:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPLRD-0001pc-DG
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 19:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbZATSdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 13:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZATSdf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 13:33:35 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:15004 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbZATSde (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 13:33:34 -0500
Received: by an-out-0708.google.com with SMTP id c2so22908anc.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=0HFs7679GBXvU28e3uFSL3Z6tWPdIYYLXc2USAFGN+o=;
        b=xtzreeSaB0/Pk4JCNlwndpWqGxvacKJJ2YQSKOby299Fx6GhlEPYfaGaX+zEMUWQ0Q
         CugBSxfwYXMHQ5K+IuFttJLDWNGDhCi8t1yt33wEF8lXB4EGgljzkyOjAllkcivI5JJA
         DFWtdhXo1fKAYdBmAVfngcft9nbzjtBz5PveI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=oKlt8n5ZNuh6Ag8GQWaPOU91IGh7veyNURtCcB5ub3LYzGijKCURmV+WDePduInQIh
         ks5iIOMWp9fpXvX7ihb2yvDDzPjRzs/tpkGyuFYse4366miYSjXxu7BB14zQy5Ft+apQ
         68k5B07h5gUixR41yzpJgI3Ml8y2cuAOsl5D0=
Received: by 10.100.136.15 with SMTP id j15mr2340560and.11.1232476412661;
        Tue, 20 Jan 2009 10:33:32 -0800 (PST)
Received: by 10.100.128.10 with HTTP; Tue, 20 Jan 2009 10:33:32 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106508>

On Tue, Jan 20, 2009 at 11:50 PM, Dilip M <dilipm79@gmail.com> wrote:
> On Tue, Jan 20, 2009 at 10:46 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> 'd try running it with strace, and then search the output for stat()
>> calls involving <something>/.git.
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

Just re-installed tcl/tk...it is working fine..:)

Many thanks to Reece Dunn,  Johannes Schindelin, Brian Foster....who
all helped me out...:)

-- DM
