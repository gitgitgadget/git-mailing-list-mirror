From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 20:01:17 +0200
Message-ID: <003d01cd8090$214ca710$63e5f530$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org> <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> <7vy5l9lj6m.fsf@alter.siamese.dyndns.org> <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de> <7v4nnxld24.fsf@alter.siamese.dyndns.org> <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de> <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com> <7vvcga96n9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Brandon Casey'" <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:01:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4FFM-0006oz-NA
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab2HVSBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:01:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:50590 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571Ab2HVSBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:01:34 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MOiCE-1SzGtR1gd4-0063Ao; Wed, 22 Aug 2012 20:01:24 +0200
In-Reply-To: <7vvcga96n9.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDMCb+a+7QMjYLRhAalBYtECWH7b+QJMED4YAf2RaVICOYYBSZVLGMjQ
Content-Language: de
X-Provags-ID: V02:K0:MyXN6KZHOomXhEsFPuKTMYkvwJlbjUU1AUIbHFuj+jz
 8FqtCJFtnhE2uzFGM/6w1cpBkw9g3R/nJOEyB37pDO2LLtfQr4
 HklWAPyivinJEIUurHyjeN5jPBf49wGmNlbDtIKGGjLvsq0aim
 RVO1X5dhBHqD0BDs8Obeg9lyMi1ahGuaFcVdN994MFSuAWHI8c
 esqxZjcf6RLvVyTTts1r0nM5ASghfiiMsChhC8vV+Se2CwPbqp
 0POBvYdRq4hUpuWOhfyquFk1//t2/hEV5oBZ1Eq9TZSbKo5IDC
 of4mlstn9yBBgGE5x8kHerI4E0gyJpGXL8r6LFv3DJpjr4YtZ3
 hhJLSMKqUZGmPL8hIl0eENEeNRg7yb84RQmprAFnGy9KnPtZ7R
 NtnQEqwL3Eagw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204052>

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, August 22, 2012 7:30 PM
> To: Brandon Casey
> Cc: Joachim Schmitz; Shawn Pearce; git@vger.kernel.org;
> rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> Brandon Casey <drafnel@gmail.com> writes:
> 
> > On Wed, Aug 22, 2012 at 9:30 AM, Joachim Schmitz
> > <jojo@schmitz-digital.de> wrote:
> >
> >> OK, so how about this:
> >> /usr/local/bin/diff -EBbu ./compat/mkdir.c.orig ./compat/mkdir.c
> >> --- ./compat/mkdir.c.orig       2012-08-21 05:02:11 -0500
> >> +++ ./compat/mkdir.c    2012-08-21 05:02:11 -0500
> >> @@ -0,0 +1,24 @@
> >> +#include "../git-compat-util.h"
> >> +#undef mkdir
> >> +
> >> +/* for platforms that can't deal with a trailing '/' */ int
> >> +compat_mkdir_wo_trailing_slash(const char *dir, mode_t mode) {
> >> +       int retval;
> >> +       char *tmp_dir = NULL;
> >> +       size_t len = strlen(dir);
> >> + ...
> > Why not rearrange this so that you assign to dir the value of tmp_dir
> > and then just pass dir to mkdir.  Then you can avoid the recast of dir
> > to (char*) in the else branch.  Later, just call free(tmp_dir).  Also,
> > we have xstrndup.  So I think the body of your function can become
> > something like:
> >
> >    if (len && dir[len-1] == '/')
> >        dir = tmp_dir = xstrndup(dir, len-1);
> >
> >    retval = mkdir(dir, mode);
> >    free(tmp_dir);
> 
> Nice.  And we have xmemdupz() would be even better as you followed-up.

How's that one used?

Bye, Jojo
