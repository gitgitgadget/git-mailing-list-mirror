From: "Michael Kerrisk" <michael.kerrisk@googlemail.com>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Tue, 16 Sep 2008 22:16:09 -0700
Message-ID: <c49095e30809162216m5c7885dbibbb022e65f43231c@mail.gmail.com>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
	 <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com>
	 <c49095e30809161640o21cb89b7x17a9ac1b5b18054f@mail.gmail.com>
	 <20080917011816.GL28210@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mtk.manpages@gmail.com, git@vger.kernel.org,
	michael.kerrisk@gmail.com
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 07:17:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfpQ2-0001ad-Fm
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 07:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbYIQFQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 01:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbYIQFQM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 01:16:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:58633 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYIQFQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 01:16:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3017583rvb.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 22:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y09YCiDzRvCBJvQJyEbko30+QU4qDRTCLgvpNIaD4Lk=;
        b=DelgDblRDvSR23to15TLzIFs8rFzNTWxNszYsWqhaKiyCFzoccVWI98+ZtxHhO54e0
         MIJfJuj4csKryUlpOvY8uKyYERyVuN9DNmdqM+glqPa382peQMUzr5EfxEBgbDum2O/M
         vwSGmKiKikWZRKqh/RSi2ZnfQDULNUB0MqoLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=saBPEL71rw+zbn9Kf/UFrtS8mVOasx6r+vw9Q4aFDo48z4LcBWXZO/ZItG+AuLXlG0
         6JY/1R1eko+sNu/mBUesygkPKoW1jP8d3f63te4YQA+/fGYLTK1l64DAdHH3L5Dme8JV
         YDaezLDzLapqr1ZQ/kYaTv29JpLitPpxCHyNM=
Received: by 10.114.157.3 with SMTP id f3mr1696918wae.40.1221628569830;
        Tue, 16 Sep 2008 22:16:09 -0700 (PDT)
Received: by 10.114.88.9 with HTTP; Tue, 16 Sep 2008 22:16:09 -0700 (PDT)
In-Reply-To: <20080917011816.GL28210@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96066>

Hi Dimitry,

On Tue, Sep 16, 2008 at 6:18 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Wed, Sep 17, 2008 at 01:40:36AM +0200, Michael Kerrisk wrote:
>>
>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches
>>
>> takes about half an hour to run, the other command (which I already
>> started yesterday) seems to be taking (far) more than a day!
>
> What version of Git do you use?

1.5.4.5, on Linux.

> If you use a version earlier than 1.5.6
> than you can notice *considerable* speed up by upgrading to the latest

How much is "considerable"?  My import is *still* running.

> version of Git. Also, git-svn does not work well on Windows. Cygwin
> version is slow due to fork(), and MSYS Git has some other issues with
> Perl. So, if you want to convert a huge SVN repo,

My svn repo is not huge.  5000 commits, 176MB.

> it is better to do on
> Linux and using the latest version of Git. Perhaps, running on tmpfs may
> speed up the process even more.
>
>> Therefore, so far, I have not had a chance to run the command to
>> completion to see if it gives the desired result.  The greatly
>> increased tun time also made me suspicious about whether the command
>> was going to do the right thing.  And, I end up with a lot of strange
>> looking tags in the (as yet incompletely) imported tree:
>>
>> $ git branch -a
>>   tags/man-pages-2.00
>>   tags/man-pages-2.00@117
>>   tags/man-pages-2.01
>>   tags/man-pages-2.01@145
>>   tags/man-pages-2.02
>>   tags/man-pages-2.02@184
>>   tags/man-pages-2.03
>>   tags/man-pages-2.03@232
>>   tags/man-pages-2.04
>>   tags/man-pages-2.04@283
>>
>> What are the @nnn tags about?
>
> I have never encounted them. Are you sure that you import into a clean
> Git repo?

Yes.  It's a clean repo in a new directory.

Cheers,

Michael
