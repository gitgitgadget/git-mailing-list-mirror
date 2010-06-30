From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 8
Date: Wed, 30 Jun 2010 14:45:53 +0200
Message-ID: <20100630124553.GA30999@debian>
References: <1277386408-29943-1-git-send-email-artagnon@gmail.com>
 <20100624173956.GA1600@burratino>
 <20100624180752.GA1642@burratino>
 <1277862665.23613.8.camel@wilber>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jun 30 14:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTweO-0006iw-N2
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 14:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab0F3MoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 08:44:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:60763 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab0F3MoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 08:44:17 -0400
Received: by fg-out-1718.google.com with SMTP id e21so254991fga.1
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=idXeMIaWUSi98zlBQaW6Xmgn3fCUCCjPbkSznQgDlSU=;
        b=dh5ZFIWPU6n/zqNhUS6eRF6QqIhk0w4HDk3GZuLunf+7Kn/AURxXFrEwm7miOY+yVa
         xGtNaGd9+lEoSH1G+dnDmfMtY6og5F+GwMFBbG5vNwoTggrLNkw77JFrGCnT4/JGY55/
         ZBtwG4Q5welE8bEhE0sNB6XtpcQ6GSvKmKHbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=mT0fL93b9xpAIXWnDFWcjYY2Uh0hiFb1s9MDnXWO6seIHdLFWv2U6bfwXQ4CzhSEOO
         KziE268NeRpyVQk2yEi80FmG0mzN94y9E706EfIFJxCY2YIAj4jBQtrNuFiZOROViLRh
         VVsE7xpjgOV/U/j4EAzOBtcHQrtG/UCvRtV28=
Received: by 10.216.88.85 with SMTP id z63mr7059238wee.105.1277901855710;
        Wed, 30 Jun 2010 05:44:15 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id l4sm8302708wej.8.2010.06.30.05.44.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 05:44:13 -0700 (PDT)
Mail-Followup-To: Sam Vilain <sam@vilain.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <1277862665.23613.8.camel@wilber>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149957>

Hi Sam,

Sam Vilain writes:
> On Thu, 2010-06-24 at 13:07 -0500, Jonathan Nieder wrote:
> > operation.  In other words, it needs the tree for
> > http://path/to/some/svn/root/branches@r11.  This does not correspond
> > to a single git tree, since the content of each branch has been given
> > its own commit.
> 
> I wrote at length about this near the beginning of the project;
> essentially, figuring out whether particular paths are roots or not is
> not defined, as SVN does not distinguish between them (a misfeature
> cargo culted from Perforce).  It becomes a data mining problem, you have
> this scattered data, and you have to find a history inside.

Right. Implementing git-svn on top of git-remote-svn might not be a
bad idea.

> As I recommended before, it probably makes more sense to keep a "remote
> tracking" branch which mirrors the *entire* repository, and sort out
> efficient ways to convert SVN revision paths like the above into tree
> IDs.
> 
> I consider it very important to separate the data import and tracking
> stage from the data mining stage.

We're following this approach. At the moment, we're just focusing on
getting all the data directly from SVN into the Git store. Instead of
building trees for each SVN revision, we've found a way to do it
inside the Git object store: we're currently ironing out the details,
and I'll post an update about this shortly.

> Once the data mining stage is well solved, then it makes sense to look
> at ways that a tracking branch which only tracks a part of the
> Subversion repository can be achieved.  In the simple case, where no
> repository re-organisation or cross-project renames have occurred it is
> relatively simple.  But in general I think this is a harder problem,
> which cannot always be solved without intervention - and so not
> necessary to be solved in short-term milestones.  As you are
> discovering, it is a can of worms which you avoid if you know you always
> have the complete SVN repository available.

Right. I'm not convinced that it necessarily requires user
intervention though: can you systematically prove that enough
information is not available without user intervention using an
example? Or is it possible, but simply too difficult (and not worth
the effort) to mine out the data?

-- Ram
