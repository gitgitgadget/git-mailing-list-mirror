From: "Russ Dill" <russ.dill@gmail.com>
Subject: Re: git-svn+cygwin failed fetch
Date: Wed, 11 Jul 2007 02:54:46 -0700
Message-ID: <f9d2a5e10707110254j46d1123fuade955f17da0a8c5@mail.gmail.com>
References: <f9d2a5e10707101106w305e28acy55f465e558485298@mail.gmail.com>
	 <20070711090600.GB29676@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 11:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8YuX-00030P-Hn
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 11:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765AbXGKJyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 05:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758429AbXGKJyt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 05:54:49 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:12211 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757765AbXGKJys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 05:54:48 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1824801mue
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 02:54:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s6aRBmp4BQMLMU1YoEMZgRKlHm4TrV2nquuu/IOubt1V0AQkh//2arSkdeO3qhCTxzDiuHPjqMXVLPuEW1v7RbEfdvYkHQdWNTFtOc8K4uyt5sPLan3f6CNGf/UWX9J/cTqeHb/AVqebRYiNSKsa/VL83N2mMBDkF7BdR2IxK/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EP61YhtgC1mh1ThvwRh+tfW5FaitnhlD811dzmoeZ1MDf9/ghDWTAoP1GiRD19xT4FGxI6sHOWo39fTjvgkQAYm479FgQrvSlWAogoFMqEhJta4wFcDO4jDlv66LbMc+xduofAvxWHV5VoLg/LxcDIUj9QxPMVLBJ6zODAQ0iA8=
Received: by 10.82.116.15 with SMTP id o15mr10628096buc.1184147687042;
        Wed, 11 Jul 2007 02:54:47 -0700 (PDT)
Received: by 10.82.149.11 with HTTP; Wed, 11 Jul 2007 02:54:46 -0700 (PDT)
In-Reply-To: <20070711090600.GB29676@muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52147>

On 7/11/07, Eric Wong <normalperson@yhbt.net> wrote:
> Russ Dill <russ.dill@gmail.com> wrote:
> > [...]/src $ mkdir foo
> > [...]/src $ cd foo
> > [...]/src/foo $ git-svn init -t tags -b branches -T trunk
> > https://www.[...].com/svn/foo/bar/bla
> > Initialized empty Git repository in .git/
> > Using higher level of URL: https://www.[...].com/svn/foo/bar/bla =>
> > https://www.[...].com/svn/foo
> >
> > [...]/src/foo $ git-svn fetch
> > config --get svn-remote.svn.url: command returned error: 1
> >
> > [...]/src/foo $ git config --get svn-remote.svn.url
> > https://www.[...].com/svn/foo
>
> Sorry, I can't help here other than recommending a real UNIX with
> fork + pipe + exec and all that fun stuff.
>
> git-svn relies heavily[1] on both input and output pipes of the
> safer-but-made-for-UNIX fork + pipe + exec(@list) variety, so I suspect
> this is just the tip of the iceberg for Windows incompatibilies with
> git-svn...

Its actually reading and writing quite a bit of stuff from the config
file, so why this one simple command would fail eludes me. Especially
since it wrote it there in the first place. If I comment out the
command_oneline and hardcode the value I know it should return,
git-fetch runs. Its actually been running for several hours now.
