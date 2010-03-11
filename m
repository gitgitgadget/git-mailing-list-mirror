From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: re-running merge on a single file
Date: Thu, 11 Mar 2010 15:20:40 -0800 (PST)
Message-ID: <m3hbomla3u.fsf@localhost.localdomain>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
	<201003112129.52596.markus.heidelberg@web.de>
	<a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 00:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NprgS-00024o-0h
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 00:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab0CKXUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 18:20:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:35570 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab0CKXUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 18:20:45 -0500
Received: by fg-out-1718.google.com with SMTP id 16so306534fgg.1
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 15:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=uk+ihQ8Mkw54OmmfqUlvtxtFDzUm/l9MB4cAA56KVCs=;
        b=uOEAdOwd4lCGIlb2nDEdEvWQCtGNAtzrQqdl22A1zlnox68tzHcZ8dkHe32i4mvET1
         +y+QvNrCmWpROLIpVYC1c3X1Y73+4U0hq3DLUI2oosOo88PFFZ95LUJ/vqkxo339COX8
         zOMnkQhOAhYIHr1vZR6+8ibvvWVvJ5ZasMCcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=EHOUIgZBWxBiV9JTaJXNdj4J94N7sIFTP9UBsjms9voxibOfD8GkNccZo+pKKuor62
         PP4+8RPtDepXCMFPNFOL1O6lKbbNhkyVm2SgbW2WOOvSkk91IVunyZEfGrPhL49d/SZd
         GmxVDB5Q6Mcs1djW9dDZwzWlOgPUg5b8+xJOo=
Received: by 10.87.55.31 with SMTP id h31mr6532776fgk.32.1268349643350;
        Thu, 11 Mar 2010 15:20:43 -0800 (PST)
Received: from localhost.localdomain (abwe142.neoplus.adsl.tpnet.pl [83.8.228.142])
        by mx.google.com with ESMTPS id 15sm497351fxm.4.2010.03.11.15.20.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 15:20:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2BNK6ev007862;
	Fri, 12 Mar 2010 00:20:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2BNJnbL007807;
	Fri, 12 Mar 2010 00:19:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142006>

Chris Packham <judge.packham@gmail.com> writes:

> Hmm, having trouble with cat-file syntax
> 
> On Thu, Mar 11, 2010 at 12:29 PM, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > Not mergetool, but checkout:
> > git checkout --merge -- file
> 
> Ok.
> $ git checkout --merge -- cpu/mpc83xx/start.S
> 
> > git cat-file blob :1:file > file.base
> >
> 
> $ git cat-file blob :1:cpu/mpc83xx/start.S > cpu/mpc83xx/start.S.base
> fatal: Not a valid object name :1:cpu/mpc83xx/start.S
> 
> So I think I have figured out that I'm trying to get at stage 1, 2 and
> 3 of the file that git checkout --merge has just setup but I'm
> tripping over the syntax.

First, instead of 'git cat-file blob <blob-id>' you can simply use 
'git show <blob-id>'.

Second, while in

  $ git checkout --merge -- cpu/mpc83xx/start.S

the path cpu/mpc83xx/start.S is relative to your current directory,
in

  $ git show :1:cpu/mpc83xx/start.S > start.S.base

the path has to be "absolute path in repository", i.e. path relative
to top directory of the repository.

Try

  $ git show :1:$(git rev-parse --show-prefix)cpu/mpc83xx/start.S \
    > cpu/mpc83xx/start.S.base

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
