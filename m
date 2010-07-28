From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Tue, 27 Jul 2010 23:58:18 -0400
Message-ID: <AANLkTi=WjBHYngSDgowD2+0FT3hG+oDYefp2aUostV3U@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com> 
	<AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com> 
	<AANLkTin3OB6mw6rih208ybCL2+QQ8LpuCP5y=DywMuyw@mail.gmail.com> 
	<AANLkTinpGO=TU3+1wZw68tUmPL8yQatPUEJ6uTGynbHq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 05:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odxn4-0006cV-EO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 05:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab0G1D6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 23:58:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50016 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0G1D6k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 23:58:40 -0400
Received: by wyf19 with SMTP id 19so3749855wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 20:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=x6GsRGLmrRfOXXub3Vxxg+Oy5A2fCYlPC05O92GpZ9w=;
        b=lZooCOCtLQ6eTTKiDckrRJKhu6cEiXYAggpBKZiCVWRvnkXXNhPqU/M6/cuPI//JGZ
         Ts8ka+15v6h12Cb85yTnf3V9AExlvUghyJ4Ls2+AnuvgdT4k0igD23MfvgryxB7o6uPW
         s1T0b8DLHHXINDZdrXzSs6B5vQQqol/adIUAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DnSVL0RYeeu0StRtSn6tozfpBCWD1291aPoKjv6iLkJ1b1+32Fk/0TLxK8GCbX0egQ
         Y1MskWilLDGvMh+OhjwWKJrhZcoNJbbKuLBHHPtdGBP8UjMVIt4duiaPV7jUUg1sllYw
         2LWTCkHOFPXJMHrKHsJJLY4vMQwaTHq/kyuJ4=
Received: by 10.216.35.148 with SMTP id u20mr8738227wea.35.1280289519206; Tue, 
	27 Jul 2010 20:58:39 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 27 Jul 2010 20:58:18 -0700 (PDT)
In-Reply-To: <AANLkTinpGO=TU3+1wZw68tUmPL8yQatPUEJ6uTGynbHq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152035>

On Wed, Jul 28, 2010 at 1:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> 2010/7/28 Avery Pennarun <apenwarr@gmail.com>:
>> 2010/7/27 Elijah Newren <newren@gmail.com>:
>>> 0) Sparse clones have "all" commit objects, but not all trees/blobs=
=2E
>>>
>>> Note that "all" only means all that are reachable from the refs bei=
ng
>>> downloaded, of course. =A0I think this is widely agreed upon and ha=
s
>>> been suggested many times on this list.
>>
>> I think downloading all commit objects would require very low
>> bandwidth and storage space, so it should be harmless.
> >
> > In fact, I have a pretty strong impression that also downloading
> > all *tree* objects would be fine too.
>
> Here you go. A pack with only commits and trees of git.git#master is
> 15M. With blobs, it is 28M. Git is not a typical repo with large blob=
s
> though.

Hmm, that's very interesting - more than half the repo is just tree
and commit objects?  Maybe that's not so shocking after all, given the
tendency in the git project to use long commit messages and relatively
short patches.

Was your pack carefully ordered for best deltification?

Knowing how much of that is commits vs. trees would also be very intere=
sting.

But if so, only saving half the space is kind of disappointing.  If
you have a script around for generating this, it would be very
interesting to compare the results with, say, the Linux kernel repo
(especially since it seems to be the #1 example of "submodules people
don't want to check out because they're so bloody huge").

In bup, I know the trees+commits are much smaller than the blobs, so
my intuition was telling me it would be the same in git.  It's
entirely possible that I was wrong, though.  In retrospect, bup uses
really short computer-generated commit messages, and backs up large
numbers of files at once, most of which never change (and thus most of
the trees never change).  Commits+trees end up somewhere around 0.5%
of the total repo size.

Have fun,

Avery
