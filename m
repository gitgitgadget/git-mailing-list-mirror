From: "Rajkumar S" <rajkumars+git@gmail.com>
Subject: cvsimport fails with cvsps core dump
Date: Tue, 12 Sep 2006 21:44:28 +0530
Message-ID: <64de5c8b0609120914p4ea47860x60a294093d43bc24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 12 18:15:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNAuB-0001oy-Kh
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 18:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWILQOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 12:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWILQOc
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 12:14:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:12349 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030267AbWILQOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 12:14:31 -0400
Received: by wr-out-0506.google.com with SMTP id i32so527327wra
        for <git@vger.kernel.org>; Tue, 12 Sep 2006 09:14:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Js6io2WXsEcnGR+E4o08XBKfydiBVJH6k1pjC2MqeFc7Ai8tZKA0b7SCjdiVPXpBnDlardxn7XN4WVuthWzkC24SCEgLwsZDnApADb3DEOHpBVivKMRxmXMhPbRZ6QHmNb3srfWKLJleRoSfe2gyhVd6jWY1hdtn26m7gwxqDPU=
Received: by 10.90.113.20 with SMTP id l20mr2237607agc;
        Tue, 12 Sep 2006 09:14:28 -0700 (PDT)
Received: by 10.65.248.1 with HTTP; Tue, 12 Sep 2006 09:14:28 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Google-Sender-Auth: b85904e0476e44a0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26889>

Hi,

While trying to cvsimport pfsense [1] source [2], cvsps coredumps and
cvsimport aborts with the following error.

root@beastie:# git cvsimport -v -d /usr/local/pfSense/tmp/cvsroot -C
pfSense/ pfSense
Running cvsps...
cvs_direct initialized to CVSROOT /usr/local/pfSense/tmp/cvsroot
cvs rlog: Logging pfSense
cvs rlog: Logging pfSense/bin
cvs rlog: Logging pfSense/boot
cvs rlog: Logging pfSense/boot/kernel
cvs rlog: Logging pfSense/cf
cvs rlog: Logging pfSense/cf/conf
cvs rlog: Logging pfSense/conf.default
cvs rlog: Logging pfSense/etc
cvs rlog: Logging pfSense/etc/ascii-art
cvs rlog: Logging pfSense/etc/inc
DONE; creating master branch
fatal: refs/heads/origin: not a valid SHA1
fatal: master: not a valid SHA1
fatal: ambiguous argument 'HEAD': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions
fatal: Not a valid object name HEAD
checkout failed: 256

root@beastie:# ls pfSense/
.git            cvsps.core

I am trying this in FreeBSD 6.1 with cvsps compiled from master branch
of git repository at http://ydirson.free.fr/soft/git/cvsps.git

To replicate this error get the pfSense cvsroot tarball from [2] and
run the command
$ git cvsimport -v -d /<path>/cvsroot -C pfSense/ pfSense

While this is not a git bug as such, I have written to the cvsps
author about this about one week back with no replies and this seems
to be the only place interested in cvsps.

Thanks and regards,

raj

1 http://www.pfsense.com
2 http://www.pfsense.com/cvs.tgz
