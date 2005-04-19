From: Jon Seymour <jon.seymour@gmail.com>
Subject: A VFS layer - was: SCM ideas from 2003
Date: Tue, 19 Apr 2005 18:07:39 +1000
Message-ID: <2cfc403205041901074ca57724@mail.gmail.com>
References: <42647D3D.6030906@qualitycode.com>
	 <u0tkboecbuybl.fsf@merleau.ntc.nokia.com>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 10:05:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNniu-0005xd-Mg
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 10:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVDSIIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 04:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDSIIM
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 04:08:12 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:16221 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261388AbVDSIHk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 04:07:40 -0400
Received: by rproxy.gmail.com with SMTP id j1so1157107rnf
        for <git@vger.kernel.org>; Tue, 19 Apr 2005 01:07:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VlO8i4pJCJvPoQiHRPwi3gODPkX48af7T9OsfNneF7kfy3H1SJsXhHlrFafJzwsI7U8DCF6QS3W7p9I95DJy8J5XH/IC5dzI96pQIUXKfM0LdX4TJ/BDt+wk9WzrLnPER3sdkenVvP5zSVK/mOOvASn8hJnZRpxE2+u3f+syZRM=
Received: by 10.38.208.76 with SMTP id f76mr3749368rng;
        Tue, 19 Apr 2005 01:07:39 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Tue, 19 Apr 2005 01:07:39 -0700 (PDT)
To: Marc Girod <girod@shire.ntc.nokia.com>, git@vger.kernel.org
In-Reply-To: <u0tkboecbuybl.fsf@merleau.ntc.nokia.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 19 Apr 2005 08:31:42 +0300, Marc Girod <girod@shire.ntc.nokia.com> wrote:
> >>>>> "KS" == Kevin Smith <yarcs@qualitycode.com> writes:
> 
> KS> "what's so special about files ?" where the author suggests that
> KS> existing SCM systems are so blinded by the tradition of file
> KS> orientation that they can't see that there might be alternatives.
> 
> Correct: file orientation is eventually a limitation.
> 
> But there are other dimensions to investigate in order to overcome it.
> The issue is to offer a *location* for the possible versions -- not
> only sequential changes but also alternatives.
> 
> A directory may be considered as a namespace.
> Note that there are other cases of 'containers': archives, packages,
> libraries, etc...
> 

Of course, it is not just SCM's that are "blinded" by file orientation
- every other tool (editors, compilters, etc) that we use has this
orientation. An SCM really has to have some notion of file
orientation, at least at the UI level, because every other tool we use
has the same orientation. The ENVY/VisualAge environments tried to
work with a pure class-level orientation and in some ways that was
great, but most developers hated it precisely because it removed the
file orientation and hence their ability to work with their favourite
tools. IBM/OTI saw the light which is why Eclipse is avowedly a
file-oriented platform.

It seems to me that file-orientation is here to stay and it would be
really cool to layer some kind of virtual filesystem over the git
repository so that different trees become transparently accessible via
different branches of a file system, e.g.:
    /mnt/gitfs/working                  # some kind of writeable
virtual directory over the git cache
    /mnt/gitfs/c157067185209b50b350571fe762c2740ea13fc1  # read-only
tree of commit c157...
    /mnt/gitfs/5b53d3a08d64198d26d4f2323f235790c04aeaab # read-only
tree of comit 5b53...

Given the purity of Linus' concept and his natural orientation towards
file systems rather than SCMs, this seems like a rather natural thing
to do.  If anyone is planning to do this and wants a helper, count me
in!

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
