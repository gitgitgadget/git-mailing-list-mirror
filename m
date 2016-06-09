From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 12/13] dir_iterator: new API for iterating over a
 directory tree
Date: Thu, 9 Jun 2016 13:46:03 +0200
Message-ID: <575956FB.9010207@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
 <38124bd892ac1f4683b7debe721fc69424a347be.1464957077.git.mhagger@alum.mit.edu>
 <CAPig+cRKa2QF9fp0in7wbPBzyY3UQbvNrioFWjxPjQQsoY=F9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 13:46:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAyPi-0005KS-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 13:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbcFILqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 07:46:11 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62461 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750790AbcFILqJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 07:46:09 -0400
X-AuditID: 12074414-62bff700000008e6-19-575956ff248b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id FC.49.02278.FF659575; Thu,  9 Jun 2016 07:46:07 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59Bk3NQ029943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 07:46:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <CAPig+cRKa2QF9fp0in7wbPBzyY3UQbvNrioFWjxPjQQsoY=F9A@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqPs/LDLc4M9EWYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrS3OvGlkdGD32DnrLrvHs949jB4XLyl77F+6jc1j8QMvjwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8CdMbdxE3vBfouK1RMiGxhXqXUxcnJICJhI/Fl8hLmL
	kYtDSGAro8TU+ZehnPNMEm/m3mUDqRIWiJRo6L0PZosIaEt82LCJEaqIUeL1ytUsIA6zwAIm
	icMzNrCAVLEJ6Eos6mlmArF5gTrubljMCGKzCKhIXD3/CMwWFQiROL9uKytEjaDEyZlPwHo5
	BQIllj1bA7aNWUBd4s+8S8wQtrzE9rdzmCcw8s9C0jILSdksJGULGJlXMcol5pTm6uYmZuYU
	pybrFicn5uWlFula6OVmluilppRuYoSEvMgOxiMn5Q4xCnAwKvHwaqREhAuxJpYVV+YeYpTk
	YFIS5X1iHRkuxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3cBBQjjclsbIqtSgfJiXNwaIkzvtt
	sbqfkEB6YklqdmpqQWoRTFaGg0NJgvd4KFCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFi
	aUlGPCgq44uBcQmS4gHaexOknbe4IDEXKArReopRl+PI/ntrmYRY8vLzUqXEeY+AFAmAFGWU
	5sGtgCW4V4ziQB8L88oA050QDzA5wk16BbSECWjJ8iPhIEtKEhFSUg2MWd1PH7UYzv0+lT2g
	6O8KyW/ntYXDQhN8ftVFWu1jOxUX9uZaz1/1S5v5FBqDki/NXeqjMT1c+F+ffIDx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296879>

On 06/07/2016 07:13 AM, Eric Sunshine wrote:
> On Fri, Jun 3, 2016 at 8:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> The iterator interface is modeled on that for references, though no
>> vtable is necessary because there is (so far?) only one type of
>> dir_iterator.
>> [...]
> 
> Some minor comments below, though probably nothing demanding a re-roll...
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> diff --git a/dir-iterator.c b/dir-iterator.c
>> @@ -0,0 +1,185 @@
>> +int dir_iterator_advance(struct dir_iterator *dir_iterator)
>> +{
>> +       struct dir_iterator_int *iter =
>> +               (struct dir_iterator_int *)dir_iterator;
>> +
>> +       while (1) {
>> +               struct dir_iterator_level *level =
>> +                       &iter->levels[iter->levels_nr - 1];
>> +               struct dirent *de;
>> +
>> +               if (!level->initialized) {
>> +                       if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))
> 
> I realize that dir_iterator_begin() ensures that we never get this far
> if path has zero length, but that check is so (textually and perhaps
> mentally) distant from this chunk of code that it's still a little bit
> scary to see this *potential* access of base.path.buf[-1]. Perhaps an
> assert(iter->base.path.len) just before this line would document that
> this condition was taken into consideration?

An assert() seems a little bit heavy for checking this invariant, which
is easy to check by inspection. I find assert() more useful for checking
state that results from more complicated algorithms, where inspection
doesn't so quickly make it clear that the invariant is held.

If you have no objections, I'll add a comment instead.

>> +                               strbuf_addch(&iter->base.path, '/');
>> +                       level->prefix_len = iter->base.path.len;
>> +
>> +                       /* opendir() errors are handled below */
>> +                       level->dir = opendir(iter->base.path.buf);
>> +[...]
>> +               if (!level->dir) {
>> +                       /*
>> +                        * This level is exhausted (or wasn't opened
>> +                        * successfully); pop up a level.
>> +                        */
>> +                       if (--iter->levels_nr == 0) {
>> +                               return dir_iterator_abort(dir_iterator);
>> +                       }
> 
> Style: unnecessary braces

Thanks.

>> +                       continue;
>> +               }
>> +
>> +               /*
>> +                * Loop until we find an entry that we can give back
>> +                * to the caller:
>> +                */
>> +               while (1) {
>> +[...]
>> +                       strbuf_addstr(&iter->base.path, de->d_name);
>> +                       if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
>> +                               if (errno != ENOENT)
>> +                                       warning("error reading path '%s': %s",
>> +                                               iter->base.path.buf,
>> +                                               strerror(errno));
> 
> Duy's warning_errno() series is already in 'master'...

This patch series is based on a version of master from before Duy's
series was merged. I think it's better to leave this the way it is, and
fix it up in a separate patch sometime after it is merged, than to make
this patch series depend on both mh/split-under-lock *and* a
post-warning_errno() version of master.

>> +                               continue;
>> +                       }
>> +
>> +                       /*
>> +                        * We have to set these each time because
>> +                        * the path strbuf might have been realloc()ed.
>> +                        */
>> +
> 
> Maybe drop the blank line between the comment and the code to which it applies.

Thanks.

>> +                       iter->base.relative_path =
>> +                               iter->base.path.buf + iter->levels[0].prefix_len;
>> +                       iter->base.basename =
>> +                               iter->base.path.buf + level->prefix_len;
>> +                       level->dir_state = DIR_STATE_ITER;
>> +
>> +                       return ITER_OK;
>> +               }
>> +       }
>> +}
>> +
>> +int dir_iterator_abort(struct dir_iterator *dir_iterator)
>> +{
>> +       struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
>> +
>> +       while (iter->levels_nr) {
>> +               struct dir_iterator_level *level =
>> +                       &iter->levels[--iter->levels_nr];
> 
> It's a bit difficult to locate the loop control embedded within this
> (textually) noisy expression. I wonder if it would be easier to read
> as a plain for-loop instead:
> 
>     for (; iter->levels_nr; iter->levels_nr--) {
> 
>> +               if (level->dir)
>> +                       closedir(level->dir);

Yes, that's a bit clearer. I'll change it.

> The documentation talks about this function returning ITER_ERROR upon
> abort failure. This implementation doesn't care about closedir()
> errors, thus never returns ITER_ERROR, which I guess agrees with
> dir_iterator_advance() which also doesn't worry about opendir() or
> closedir() errors. Do opendir() and closedir() errors at least deserve
> a warning, as lstat() failure does? (Genuine question; I haven't
> thought too hard about it.)

readdir() and closedir() can only fail with EBADF, which (I think) can
only happen in the case of a bug. But we do want to learn about bugs
*sometime*, so I'll add warnings for them.

opendir(), on the other hand, can fail for several reasons. The code
that this is replacing was completely silent in the case of opendir()
failures. I agree that some things are worth warning about, though I
don't think we should get really chatty about errors that could have
been caused by, e.g., a race. So I'll add a warning for errno != ENOENT.

>> +       }
>> +
>> +       free(iter->levels);
>> +       strbuf_release(&iter->base.path);
>> +       free(iter);
>> +       return ITER_DONE;
>> +}
>> diff --git a/dir-iterator.h b/dir-iterator.h
>> @@ -0,0 +1,86 @@
>> +/*
>> + * Advance the iterator to the first or next item and return ITER_OK.
>> + * If the iteration is exhausted, free the resources associated with
>> + * the iterator and return ITER_DONE. On error, return ITER_ERROR. It
>> + * is a bug to use iterator or call this function again after it has
>> + * returned false.
>> + */
>> +int dir_iterator_advance(struct dir_iterator *iterator);
> 
> The documentation makes it clear that the iterator is freed upon
> ITER_OK, but I'm having trouble determining if it is freed for
> ITER_ERROR, as well. The documentation for ref_iterator_advance(), on
> the other hand, makes it clear that the iterator is freed in all
> cases.

Iterators are always freed when these functions return ITER_DONE or
ITER_ERROR. I'll mention this in the docstring.

Thanks for all your great comments!

Michael
