From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: A shortcoming of the git repo format
Date: Thu, 28 Apr 2005 08:51:15 +1000
Message-ID: <2cfc403205042715513d8123f3@mail.gmail.com>
References: <426F2671.1080105@zytor.com>
	 <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
	 <426FD3EE.5000404@zytor.com> <20050427183239.GE19011@redhat.com>
	 <426FDE48.1050700@zytor.com>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:47:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvJ0-0007MA-26
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVD0Wvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVD0Wvs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:51:48 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:26856 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262068AbVD0WvU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 18:51:20 -0400
Received: by rproxy.gmail.com with SMTP id j1so248734rnf
        for <git@vger.kernel.org>; Wed, 27 Apr 2005 15:51:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CIy/vvjmJh9QLOlPOisxM+HYtXENj4W6Z15Sf84TIzG8ctwS0jgz7d+aYwUG/MghjfNtR9w3tHe97OGSV/472gRKFVg41Us+oNYK7CWhHyAN25U+qwwl3PNLsoZHOeamyvCbpCl6jRen1ZH2V8PS7NRniB/AcKAJms7BRkQlKMs=
Received: by 10.38.97.35 with SMTP id u35mr1645413rnb;
        Wed, 27 Apr 2005 15:51:16 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Wed, 27 Apr 2005 15:51:15 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426FDE48.1050700@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/28/05, H. Peter Anvin <hpa@zytor.com> wrote:
> Dave Jones wrote:
> >
> > That actually broke one of my first git scripts when one of the
> > changelog texts started a line with 'tree '.  I hacked around it
> > by making my script only grep in the 'head -n4' lines, but this
> > seems somewhat fragile having to make assumptions that the field
> > I want to see is in the first 4 lines.
> >
> 
> You have the delimiter for that; there is an empty line between the
> header and the free-form body, similar as for RFC822.
> 

...and a relatively simple way to use that rule to extract just the
header lines:

      sed -n "1,/^\$/p"                     # with the separator line

or, either one of these to remove the separator line as well:

      sed -n "1,/^\$/s/^\(..*\)/\1/p"  
      sed -n "1,/^\$/p" | tr -s \\012

jon
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
