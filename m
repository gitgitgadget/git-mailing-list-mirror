From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: Compression speed for large files
Date: Mon, 3 Jul 2006 14:54:01 +0000
Message-ID: <f36b08ee0607030754k4d10548pfb71dc62c6ee0b21@mail.gmail.com>
References: <loom.20060703T124601-969@post.gmane.org>
	 <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
	 <44A91C7A.6090902@fys.uio.no>
	 <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 16:55:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxPoO-0003KN-Li
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 16:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWGCOyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWGCOyE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 10:54:04 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:45219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932069AbWGCOyC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 10:54:02 -0400
Received: by py-out-1112.google.com with SMTP id c39so1327401pyd
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 07:54:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jq3zxqE0MFGMuMNtDjHlI2o74TlGf8i3Ek5HnsCKW5IUg/n1aynU5b0DhHWl8xiMnfm6vUylUcnrRF4VtGDLLV75FJRpBt0b75amSuQsxzfYDu/CSmdc4JK14oX7K+qX4eU28zr+xNJAk+P6Xpa0zdsgyVqdS1RMxmw42x45UTk=
Received: by 10.35.101.9 with SMTP id d9mr944674pym;
        Mon, 03 Jul 2006 07:54:01 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Mon, 3 Jul 2006 07:54:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23181>

On 7/3/06, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 3 Jul 2006, Joachim Berdal Haga wrote:
>
> > Alex Riesen wrote:
> > > On 7/3/06, Joachim B Haga <cjhaga@fys.uio.no> wrote:
> > > > So: is it a good idea to change to faster compression, at least for larger
> > > > files? From my (limited) testing I would suggest using Z_BEST_COMPRESSION
> > > > only for small files (perhaps <1MB?) and
> > > > Z_DEFAULT_COMPRESSION/Z_BEST_SPEED for
> > > > larger ones.
> > >
> > > Probably yes, as a per-repo config option.
> >
> > I can send a patch later. If it's to be a per-repo option, it's probably too
> > confusing with several values. Is it ok with
> >
> > core.compression = [-1..9]
> >
> > where the numbers are the zlib/gzip constants,
> >   -1 = zlib default (currently 6)
> >    0 = no compression
> > 1..9 = various speed/size tradeoffs (9 is git default)

It would be arguable whether, say, 10% better compression is worth
x(3-8) slower compression. But 3-4% better compression at the cost of
x(3-8) slower compression time as data suggest ? I think this begs
for switching the default to Z_DEFAULT_COMPRESSION

Yakov
