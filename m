From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Tue, 13 May 2014 19:19:42 -0400
Organization: Twitter
Message-ID: <1400023182.14179.23.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8B6AVOHH7HhreqvusQN=UFZzj1mkjqekrOb62Lmq_8VQw@mail.gmail.com>
	 <1399747109.11843.137.camel@stross>
	 <CACsJy8Cazm+6ixw3r8WYfdFYeD01Lmf0PSF0sdsh7PGy_6WDTQ@mail.gmail.com>
	 <1399848982.11843.161.camel@stross>
	 <CACsJy8C_j2bKVwqOQtOqGFkc_-_AmY=bQXquRfL-aqk=z9YKdw@mail.gmail.com>
	 <1400020707.14179.13.camel@stross>
	 <CACsJy8CVK1codmuSvUyeVYo1d-nQ6thoV8pn1WN_8D8doYXu5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 01:19:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLzC-0004Tg-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 01:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbaEMXTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 19:19:47 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:41397 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaEMXTq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 19:19:46 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so1519305qgd.41
        for <git@vger.kernel.org>; Tue, 13 May 2014 16:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=iyOxQxwlQa89BlhyB0EphUatnJKMFD6kcKhquiC8et4=;
        b=b1lh9S/At7Zw/dmdHc+M8/X2sDJ3mkrbIlA9LxZ2UOrSaRhp4qCevOpzGGQ1EuF8G7
         iAs1air+nZO417S8Lzo1GF5IHTIB2/rvJbBkruPUznHOoxTwkmMJAnqeaaUG+TQgjnVW
         IBhCNj5bEbJFukDFmO7w7ceQc7JibW+ypGopWu5fQvEgMOoMfs1hx1byjfsFuPp1UaLu
         n3OcPHI/mPsvZsOjqniSE7xvdIY3qswVVegTEgefSPVvjad/efkV3Ewz2T4cL8JOFvVI
         Szb5sLn5Vq4E1KnzRpeJXanAuTnFfmi45nBuiwVFWneNzJF3/SbNgKeSKwbXkXNczmJq
         gJKA==
X-Gm-Message-State: ALoCoQlVJihWefFI9lhaHTFlDBo6GUc98E7cywrJgVsDyFY+ntrzoGf3sofo7L8vr90ndZEZP9b/
X-Received: by 10.140.107.67 with SMTP id g61mr50795878qgf.100.1400023185326;
        Tue, 13 May 2014 16:19:45 -0700 (PDT)
Received: from [172.17.2.145] ([38.104.173.198])
        by mx.google.com with ESMTPSA id 1sm28996qal.29.2014.05.13.16.19.43
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 16:19:44 -0700 (PDT)
In-Reply-To: <CACsJy8CVK1codmuSvUyeVYo1d-nQ6thoV8pn1WN_8D8doYXu5g@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248887>

On Wed, 2014-05-14 at 05:54 +0700, Duy Nguyen wrote:
> On Wed, May 14, 2014 at 5:38 AM, David Turner <dturner@twopensource.com> wrote:
> > On Mon, 2014-05-12 at 17:45 +0700, Duy Nguyen wrote:
> >> This is your quote from above, moved down a bit:
> >>
> >> > update_fs_cache should only have to update based on what it has learned
> >> > from watchman.  So if no .gitignore has been changed, it should not have
> >> > to do very much work.
> >> >
> >> > I could take the fe_excluded check and move it above the
> >> > last_exclude_matching check in fs_cache_is_excluded; it causes t7300 to
> >> > fail when run under watchman but presumably that's fixable
> >>
> >> So you exclude files early and make the real read_directory() pass do
> >> pretty much nothing. This is probably not a good idea. Assume that I
> >> touch $TOP/.gitignore then do something other than "git status" (or
> >> "git add") then I have to pay read_directory() cost.
> >
> > I'm not sure I understand this. read_directory does something: it checks
> > the fs_cache (instead of the filesystem) for untracked files.
> 
> A lot of commands do read_cache() that that eventually calls
> update_fs_cache, which does part of read_directory's work (the
> fe_excluded thing). But not many of those commands actually call
> read_directory(). It'd better if there's a way to mark that "this
> .gitignore is changed", but delay the actual exclude processsing until
> we are sure read_directory() will be used.

OK, that would be straighforward, I think.
