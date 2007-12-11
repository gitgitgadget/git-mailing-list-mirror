From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 14:03:49 -0500
Message-ID: <4aca3dc20712111103s1af3b045h484ea749378c6282@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <e5bfff550712111032p60fedbedu304cab834ce86eb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:04:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AOp-0003WA-S7
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbXLKTDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbXLKTDx
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:03:53 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:37984 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbXLKTDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:03:52 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1279824nze
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 11:03:50 -0800 (PST)
Received: by 10.142.237.20 with SMTP id k20mr540354wfh.1197399829729;
        Tue, 11 Dec 2007 11:03:49 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Tue, 11 Dec 2007 11:03:49 -0800 (PST)
In-Reply-To: <e5bfff550712111032p60fedbedu304cab834ce86eb9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67905>

On 12/11/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On Dec 11, 2007 6:33 PM, Daniel Berlin <dberlin@dberlin.org> wrote:
> >
> > Annotate is treasured by gcc developers (this was a key sticking point
> > in svn conversion).
> > Having an annotate that is 2x slower and takes 15x memory would not
> > fly (regardless of how good the results are).
> >
>
> Speed of annotation is mainly due to getting the file history more
> then calculating the actual annotation.
>

Yes, i figured as much.

> I don't know *how* file history is stored in the others scm, perhaps
> is easier to retrieve, i.e. without a full walk across the
> revisions...

It is stored in an easier format. However, can you not simply provide
side-indexes to do the annotation?

I guess that own't work in git because you can change history (in
other scm's, history is readonly so you could know the results for
committed revisions will never change).

> I would be interested in cold start and warm cache start (close the
> annotation tab and start annotation again).

I will try to do this.
