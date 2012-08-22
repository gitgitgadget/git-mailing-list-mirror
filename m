From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 10:23:09 -0700
Message-ID: <CA+sFfMd5zzfZVrGJSMkr2ga8kTg6Tiun=HBdHkg6rV-stjDT8Q@mail.gmail.com>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
	<CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
	<004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
	<CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
	<01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
	<7v628epzia.fsf@alter.siamese.dyndns.org>
	<000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
	<7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
	<001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
	<7v4nnxld24.fsf@alter.siamese.dyndns.org>
	<002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
	<CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
	<002f01cd808a$2e027e90$8a077bb0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:23:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4EeJ-0002aW-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942Ab2HVRXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:23:11 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54771 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2HVRXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:23:09 -0400
Received: by vcbfk26 with SMTP id fk26so1291851vcb.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LaQAGArK1aRle/33FB2yqtulQxwdFeYF7WxXwxqlCgo=;
        b=OCwVRoCB+Tq+BZ0AtyGjTL9iNIq8kQelHcGQc0MIaEy8yHek72MkUHmK55kNF5ezbn
         Oxv41wYpm06X+yMC4lk+qe/+wjhQZZxz3GsMywmkv0/HNW9RqDzRQ7wOuXNi4vf69ikg
         6vVHsqOIFPLRarl5DeclWHX35QVMGOdN0u8bx6YdDOtgwWqJD/vtbAme/dL8jRNUZ1IP
         zqQci4PG/ezmNSBS3LT3wfNU0o0bvqlTPsLtA0bVf/bw6+4/rgDdPGdTNMuUtq0p5lKN
         ZrVqZ3eSfj5s8JqE6d5b0ilZSgSz9nNcKar2U8whd3bHd0kSARqSGsUfMowkrqVAe8L8
         xVHg==
Received: by 10.220.149.131 with SMTP id t3mr10212781vcv.1.1345656189189; Wed,
 22 Aug 2012 10:23:09 -0700 (PDT)
Received: by 10.58.29.233 with HTTP; Wed, 22 Aug 2012 10:23:09 -0700 (PDT)
In-Reply-To: <002f01cd808a$2e027e90$8a077bb0$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204038>

On Wed, Aug 22, 2012 at 10:18 AM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:
>> From: Brandon Casey [mailto:drafnel@gmail.com]
>> Sent: Wednesday, August 22, 2012 7:01 PM
>> To: Joachim Schmitz
>> Cc: Junio C Hamano; Shawn Pearce; git@vger.kernel.org;
>> rsbecker@nexbridge.com
>> Subject: Re: Porting git to HP NonStop
>>
>> On Wed, Aug 22, 2012 at 9:30 AM, Joachim Schmitz <jojo@schmitz-digital.de>
>> wrote:
>>
>> > OK, so how about this:
>> > /usr/local/bin/diff -EBbu ./compat/mkdir.c.orig ./compat/mkdir.c
>> > --- ./compat/mkdir.c.orig       2012-08-21 05:02:11 -0500
>> > +++ ./compat/mkdir.c    2012-08-21 05:02:11 -0500
>> > @@ -0,0 +1,24 @@
>> > +#include "../git-compat-util.h"
>> > +#undef mkdir
>> > +
>> > +/* for platforms that can't deal with a trailing '/' */ int
>> > +compat_mkdir_wo_trailing_slash(const char *dir, mode_t mode) {
>> > +       int retval;
>> > +       char *tmp_dir = NULL;
>> > +       size_t len = strlen(dir);
>> > +
>> > +       if (len && dir[len-1] == '/') {
>> > +               if ((tmp_dir = strdup(dir)) == NULL)
>> > +                       return -1;
>> > +               tmp_dir[len-1] = '\0';
>> > +       }
>> > +       else
>> > +               tmp_dir = (char *)dir;
>> > +
>> > +       retval = mkdir(tmp_dir, mode);
>> > +       if (tmp_dir != dir)
>> > +               free(tmp_dir);
>> > +
>> > +       return retval;
>> > +}
>>
>> Why not rearrange this so that you assign to dir the value of tmp_dir and then
>> just pass dir to mkdir.  Then you can avoid the recast of dir to (char*) in the
>> else branch.  Later, just call free(tmp_dir).  Also, we have xstrndup.  So I think
>> the body of your function can become something like:
>>
>>    if (len && dir[len-1] == '/')
>>        dir = tmp_dir = xstrndup(dir, len-1);
>
> xstndup() can't fail?

Correct.  It will either succeed or die.  It will also try to free up
some memory used by git if possible.

-Brandon
