From: skillzero@gmail.com
Subject: Re: git commit <path> scanning entire working tree?
Date: Tue, 17 Feb 2009 18:25:56 -0800
Message-ID: <2729632a0902171825g2078755cx6b966417240a59ca@mail.gmail.com>
References: <2729632a0902161458m732af362od59e5f35af5643c3@mail.gmail.com>
	 <7vwsbpewkl.fsf@gitster.siamese.dyndns.org>
	 <2729632a0902161937o4ac3a1aeg143dda509ba5e384@mail.gmail.com>
	 <7vvdr98rkd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 03:27:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZcAE-0006Md-Mz
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 03:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbZBRCZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 21:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZBRCZ6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 21:25:58 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:44499 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbZBRCZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 21:25:58 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1220280ywh.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 18:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=exED+a8w9iTxDlIxcwRwQ/ctxvPVCcMDGCpo4lGuSWE=;
        b=p6UbZavDsDyqViPKNFtgVBW+5ty5b+z1sYJdCvJVHSafGLCm4OBDv40rThFSF7IqHh
         vBcao7GvRrtQrTOX3CBbS4JJ86QLa/E2Ko9DR8fflGTHfmcLGkn43Xq9r/Ih0G9SLH8Q
         1D3sZnXJ5yczUe8sKgea4WnBFNEIuoXh6WSV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=MAseIWXsQrlxHv/Ae5D8FmQEpQhUkIC2enMM0hde8/7hlAd4BB75OaZWHdS74EFZHD
         t/qWU//iPI5dq3B9+HcduTaXyqrkvASrRZclKAn7tLsVh6bb+pAsLwgwKHL2i4MLfEzn
         SHJ0gGyJHmPSJKPtW7xFPYn/mKTIJFspnKZ9s=
Received: by 10.150.189.9 with SMTP id m9mr991191ybf.205.1234923956793; Tue, 
	17 Feb 2009 18:25:56 -0800 (PST)
In-Reply-To: <7vvdr98rkd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110498>

On Mon, Feb 16, 2009 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> skillzero@gmail.com writes:

> People do rely on that information.  Why else we would spend cycles to show
> them?

My guess was that most people didn't work with very large trees. For
example, the Linux kernel tree stat's pretty quickly (.7 seconds when
hot on my machine), but my tree contains the code for an entire OS
distribution so even on a fast machine and OS, it takes many seconds.

My thinking was that in the case when a path was specified, people
might be less interested in changes/untracked files outside that path
(although I may be totally wrong). If a path wasn't specified, I can
see why it would be useful to show everything. I tend to do a 'git
status' then a bunch of 'git commit <path>' commands.

> There is a precedence to allow a configuration variable to skip various
> computation to help slow systems, e.g. 6c2ce04 (Add argument 'no'
> commit/status option -u|--untracked-files, 2008-06-05).

Thanks, I'll check it out. If that doesn't do what I need, maybe I can
trying changing git to add support for automatically skipping files
outside the specifies path and submit a patch for you guys to rip to
shreds :)
