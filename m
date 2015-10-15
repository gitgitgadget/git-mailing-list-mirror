From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Alternative to manual editing with git add --patch
Date: Thu, 15 Oct 2015 12:11:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1510151152470.31610@s15462909.onlinehome-server.info>
References: <561E6FBB.7060302@gmx.de> <xmqqk2qp8hlj.fsf@gitster.mtv.corp.google.com> <561EE700.3020002@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sven Helmberger <sven.helmberger@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 15 12:11:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmfVW-0002Ro-0F
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 12:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbbJOKLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 06:11:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:63629 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbbJOKL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 06:11:28 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MQzIE-1a96iD389u-00UNhY;
 Thu, 15 Oct 2015 12:11:23 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <561EE700.3020002@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Q5hdW+OK/Lv+kA2QFOrhrjvUax2+yCSSp3qwgvHVDxRFeD+hyU7
 frKa1aTRHB+bXwDUTGMvcZ/QryFIS60RgNICy6yi6D63L4OURs/LlBb9oAb22sbeIQbNqX4
 fB9yzQCo1C1UG5IOb3n1WXjV3L1M06Qs1EsXrMU62E5xQXVYABm4eUJ9utwLy/cO3X7oozb
 h3mDYkZi7Uc8q5RRxVqVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aeqjnBeJIog=:rf+iyN95sfKor1T3TJQNuU
 gwIefsrU8/h1ZDlZBKTOOvKI/juxfoopYfRQTYgkVCmZtbuIHsrGhDUbJg8IylmizTJ+C+gSv
 TUaunNAMjDY4xwz5HQ7Hz2uxfp8ns9eY0+sEMKue1nffTozYs7zsq88IJGk016ld1QbffFQFU
 7vdxlljh73mJkQTShTe7Aq5Z15UPdbbNRm1lxf4kmyBADMLMKb6sn74lSpOjh1gq6J3C7egbY
 sxy2bBR8dhumSlD2nCY8xsyZHZcmk5ksHboEN9ql8+JOCGhkhn9r76f+YH4UMuah1BKYjT6I3
 4EKlVIPD2dvmG33op6nGfrPcnGnk9DrZ8RhqrdgOx3O5mHKCnPj3INnCQ5M780vSBgizkkFTW
 x/7kD+F8wNJtN4NJOEjYky3MwHFCr/UjhPxO3AGU40kzPIfGnXZeEwqNsMIJjlru3T5gYgOTt
 eAcFvO44ETWyr/mVDWLwVaIIT+fn1BHGJ3CWtKvv3iPUdKbfUbW5AWUeapAq6jGoibiBua/yx
 ZtMbCkhIk81b8xUSdy2wexc8N2P51ArNVCqt8DXXqHGgCWx3ZbD9nQiW/BZnk+Fwc/dm0Cbxg
 HOo0B9pZ/CY4+08ZmWxfJb7SVD69bkI/SJchUfSwIbPUyedBmSqzUZT4dwM0fg8jvDlTo2mVT
 S7yFBdlD5zaAqyzp0+fCn4+g4MaJB3T5g63wuLDN7icYtZIdOngSDSFkvxgPsyDGTuHGcjXWj
 M5I11Xg5oqA3Kdw4jvQHsNZlqcSFAruAckoAhk5+t4UZW3RmkRmxD8bjWi0xbaHXw16IU+li 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279657>

Hi Sven & Junio,

On Thu, 15 Oct 2015, Sven Helmberger wrote:

> Am 14.10.2015 um 19:50 schrieb Junio C Hamano:
> > Sven Helmberger <sven.helmberger@gmx.de> writes:
> > 
> > As a quick-and-dirty change, you could invent a new variant of
> > 's'plit that breaks a N-line hunk into N hunks with 1-line each, but
> > obviously that would not be a pleasant-enough UI to be called usable
> > when you have a hunk that adds 100 lines.  Perhaps "Split this hunk
> > into two by ending the earlier one immediately before the line that
> > has this substring" or something might be an idea?
> > 
> 
> If we go by the style of interaction in git add --patch and git add
> --interactive, I think the most canonical solution would be to implement
> it like this.
> 
> If we know when we can't split the current patch any further ( the point
> at which selecting s changes nothing anymore), why shouldn't add --patch
> not work similar to add --interactive in that it prints the lines of the
> diff prefixed with numbers and the user can define a numerical range to
> "split off". Then they decide whether to add those lines or not and
> return to the line-numbers until they're trough with the patch.

This is all technically sound. From a usability perspective I would wish
more for a way to exclude or filter the lines by a pattern. Take for
example a diff like this (which is *quite* normal in my workflow):

-- snip --
diff --git a/80a8c9a..001a983 b/001a983
index 80a8c9a..001a983 100644
--- a/80a8c9a..001a983
+++ b/001a983
@@ -23,11 +23,15 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of

        hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
                PAGE_WRITECOPY, 0, 0, NULL);
+error("hmap: %p", hmap);

-       if (!hmap)
+       if (!hmap) {
+               errno = EINVAL;
                return MAP_FAILED;
+       }

        temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);
+error("temp: %p 0x%x", temp, (unsigned int)GetLastError());

        if (!CloseHandle(hmap))
                warning("unable to close file mapping handle");
-- snap --

(Yes, I am lazy and reuse the `error()` function for debug log messages.)

It is quite obvious what I would like to do in this case: keep the change
that sets the errno.

I would be really thankful if I had a shortcut in `git add -p` that let me
specify, say, "Xerror" to eXclude any + line (and replace the '-' by a ' '
in every - line) that contains the substring 'error'.

The way I envisage this command to work would be to present the filtered
diff in the next step:

-- snip --
@@ -23,11 +23,13 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of

        hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
                PAGE_WRITECOPY, 0, 0, NULL);

-       if (!hmap)
+       if (!hmap) {
+               errno = EINVAL;
                return MAP_FAILED;
+       }

        temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);

        if (!CloseHandle(hmap))
                warning("unable to close file mapping handle");
-- snap --

Likewise, I could imagine that something like "Ierrno" to keep only +
lines with matching substrings (and treating - lines correspondingly).

Having said that, I find myself occasionally powering up a full-fledged
`git gui` just to stage individual lines. If I had an 'L' command in `git
add -p` instead that would present the following hunks, I would be really
happy:

-- snip --
@@ -23,6 +23,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of

        hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
                PAGE_WRITECOPY, 0, 0, NULL);
+error("hmap: %p", hmap);

        if (!hmap)
                return MAP_FAILED;
-- snap --

and then

-- snip --
@@ -24,6 +24,5 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
        hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
                PAGE_WRITECOPY, 0, 0, NULL);

-       if (!hmap)
                return MAP_FAILED;

        temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);
-- snap --

and then

-- snip --
@@ -24,6 +24,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
        hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
                PAGE_WRITECOPY, 0, 0, NULL);

+       if (!hmap) {
                return MAP_FAILED;

        temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);
-- snap --

and so on.

What do you think?

Ciao,
Dscho
