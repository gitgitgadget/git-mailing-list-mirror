From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Git as a filesystem
Date: Sat, 22 Sep 2007 11:56:38 +1200
Message-ID: <46a038f90709211656n5b23783eu330e8b655cd42aa8@mail.gmail.com>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
	 <Pine.LNX.4.64.0709211208440.28395@racer.site>
	 <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
	 <20070921125337.GA28456@diana.vm.bytemark.co.uk>
	 <fbe8b1780709210628u24c14117p5174bedb3d1912cb@mail.gmail.com>
	 <20070921172941.GA7399@potapov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Peter Stahlir" <peter.stahlir@googlemail.com>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 01:56:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYsMX-00012s-Ov
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 01:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759091AbXIUX4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 19:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758556AbXIUX4k
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 19:56:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:34187 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758393AbXIUX4j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 19:56:39 -0400
Received: by ug-out-1314.google.com with SMTP id z38so600663ugc
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WvJ/MsYgQAa8RaBF/1VSs+sWR9rwGRhdWXKaZSFBOSw=;
        b=QCNUL2ksp/WplY8KD2yiptkVo2Lt2Shq9SFJVq9twUWMvn0c6tENa0k+Eiz9N7ckruMQgq+zgYWOQVHad0EEO1qrsHGISvxhx6y/4dv/iWMtmjkwqp0w8/FTLKXc/udVbdNotQrW5wzMK79dbrSuWSIX9UEag1jYxV094UywQmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oBdWFC5zAJWAX+Sukesc4fnNqnWVG/OLKMfYEL8pV63kMzPa0eBmHHcrhG1eiAkaZbaT4IIUxqDt4AQwQqlCirungwmUz2c3udb/Ewh/blIdrelcMnjsKr7SjtsfAPvck/dxqgoFnaU6Kp9uY0LbdgydMlT/CksSZRIhh9wjzAE=
Received: by 10.67.31.5 with SMTP id i5mr2641920ugj.1190418998073;
        Fri, 21 Sep 2007 16:56:38 -0700 (PDT)
Received: by 10.67.23.15 with HTTP; Fri, 21 Sep 2007 16:56:38 -0700 (PDT)
In-Reply-To: <20070921172941.GA7399@potapov>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58895>

On 9/22/07, Dmitry Potapov <dpotapov@gmail.com> wrote:
> used to create the original file. So, if you put any .deb file in such
> a system, you will get back a different .deb file (with a different SHA1).
> So, aside high CPU and memory requirements, this system cannot work in
> principle unless all users have exactly the same version of a compressor.

Was thinking the same - compression machinery, ordering of the files,
everything. It'd be a nightmare to ensure you get back the same .deb,
without a single different bit.

Debian packaging toolchain could be reworked to use a more GIT-like
approach - off the top of my head, at least

  - signing/validating the "tree" of the package rather than the
completed package could allow the savings in distribution you mention,
decouple the signing from the compression, and simplify things like
debdiff

  - git or git-like strategies for source packages

cheers,


m
