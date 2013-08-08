From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message (gitml: message 5 of 20)
Date: Thu, 8 Aug 2013 16:20:18 +0200
Message-ID: <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
	<877gfw4byx.fsf@linux-k42r.v.cablecom.net>
	<262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
	<87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
	<9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost>
	<vpqli4cfhhe.fsf@anie.imag.fr>
	<813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost>
	<vpqfvukfgr5.fsf@anie.imag.fr>
	<edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Stefan Beller" <stefanbeller@googlemail.com>
To: <gitml.jexpert@recursor.net>
X-From: git-owner@vger.kernel.org Thu Aug 08 16:20:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7R4k-0007ee-SB
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 16:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965269Ab3HHOUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 10:20:22 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:25420 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965190Ab3HHOUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 10:20:21 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 8 Aug
 2013 16:20:11 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 8 Aug 2013 16:20:18 +0200
In-Reply-To: <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost> (gitml
	jexpert's message of "Thu, 08 Aug 2013 15:43:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231888>

gitml.jexpert@recursor.net writes:

>> Using
>> 
>>   addr2line -e ~/projects/git.git/git-fsck
>> 
>> on these addresses may help a little, but not sure it's going to be
>> sufficient :-(.
>
>
> I'm still trying to reproduce this issue using gdb.
> Also I'm trying to reproduce this issue with my git repo on another machine.
>
> ben@n179 /tmp $ addr2line -e ~/projects/git.git/git-fsck
> 0x51e401
> 0x51e53c
> 0x51ecc3
> 0x4e707b
> 0x4e7485
> 0x43d433
> 0x405158
> 0x4052ee
> 0x4054ba
> /home/ben/projects/git.git/sha1_file.c:1901
> /home/ben/projects/git.git/sha1_file.c:1928
> /home/ben/projects/git.git/sha1_file.c:2096
> /home/ben/projects/git.git/pack-check.c:119
> /home/ben/projects/git.git/pack-check.c:177
> /home/ben/projects/git.git/builtin/fsck.c:678
> /home/ben/projects/git.git/git.c:291
> /home/ben/projects/git.git/git.c:453
> /home/ben/projects/git.git/git.c:543

Can you try to reproduce with a version older than v1.8.3?
E.g. v1.8.2.3.

I'm asking because the above points at packed_object_info(), which I
recently rewrote to be nonrecursive.


Also, can you please stop losing the Cc list?  The etiquette on this
list is to Cc everyone who was involved so far, usually meaning everyone
who was already a recipient of the mail you are replying to.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
