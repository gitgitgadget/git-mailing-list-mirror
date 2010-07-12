From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 11
Date: Mon, 12 Jul 2010 16:39:51 +0100
Message-ID: <1278949191.1611.5.camel@wpalmer.simply-domain>
References: <20100712143546.GA17630@debian>
	 <4C3B2B48.4070408@drmicha.warpmail.net>
	 <20100712152403.GH1931@jack.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Greg Stein <gstein@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Huijben <rhuijben@collab.net>,
	Sam Vilain <sam@vilain.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Stefan Sperling <stsp@elego.de>
X-From: git-owner@vger.kernel.org Mon Jul 12 17:40:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYL74-0002Fi-T8
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 17:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973Ab0GLPkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 11:40:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59148 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab0GLPkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 11:40:02 -0400
Received: by bwz1 with SMTP id 1so2432487bwz.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=gZ6+2+GLaHEWd/2con44fGxGeMOYwtUboK6hIWfYj7A=;
        b=wTxt8uAtMwMh8Y+hwSFTJm2Wpdrvg55gB5aZNYZY/jzc9y/Dl5Uo9IdBneUWmYJi4g
         pDKlqxxJFaW6ZE3trgRLCKg7KDfIXUQ1i9qvaA+kfhAZacZXPx5tvYCKZmZBWC8zQusp
         FHFqvRv5puqhTIZjvppDsDC29f3p/ju4G4pGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=f5AfX37mCFZfyloWkwNuxqZj8N3Sruknxr9CB2FybYG47uzUmrUqttgmDoFPlW+XVV
         n/jbreln0uMTiN37aYYJNbgeT4Xc6ooy8HUIBC4tcI/ld9OS6VEquGrTxhYn+CgZ/j4q
         CHG1shrDbS/gm9kv4Laz84DZdbQZHAYPa34UQ=
Received: by 10.204.73.130 with SMTP id q2mr10797743bkj.137.1278949197879;
        Mon, 12 Jul 2010 08:39:57 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id y2sm19025276bkx.8.2010.07.12.08.39.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 08:39:56 -0700 (PDT)
In-Reply-To: <20100712152403.GH1931@jack.stsp.name>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150821>

On Mon, 2010-07-12 at 17:24 +0200, Stefan Sperling wrote:
> On Mon, Jul 12, 2010 at 04:48:40PM +0200, Michael J Gruber wrote:
> > Ramkumar Ramachandra venit, vidit, dixit 12.07.2010 16:35:
> > > it will be pretty painful for Git developers to compile the SVN trunk
> > 
> > While this is certainly true for the "compilation" part, at least
> > getting the source is a snap for us:
> > 
> > git://git.apache.org/subversion.git
> > git://github.com/apache/subversion.git
> 
> Regarding compilation, take a look at tools/dev/unix-build/Makefile.svn
> in the Subversion tree. Possibly the most painful thing for git devs is
> that you'll need an svn binary somewhere in PATH, but any version will do.
> Then create an empty directory (say, ~/svn), copy the Makefile in there,
> and run make (requires GNU make). That will download and compile Subversion
> from trunk, including various dependencies.
> If all goes well, binaries (with debug symbols) end up in ~/svn/prefix/
> 
> On Linux, -devel packages for a couple of libaries may be needed
> (most likely openssl, zlib, expat, libproxy).
> 
> Stefan

This is all moot, because the whole point is that svndumpr compiles
against libsvn, so you don't need the whole svn source-tree. All you
need to get svndumpr working are some header files and a working libsvn.
Everyone who currently uses git-svn already has a working libsvn, since
perl's svn bindings wrap around libsvn anyway.
