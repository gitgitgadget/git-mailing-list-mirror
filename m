From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Tue, 21 Dec 2010 07:29:41 -0500
Message-ID: <1292934581.26698.14.camel@drew-northup.unet.maine.edu>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
	 <AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
	 <1292846433.19322.1.camel@drew-northup.unet.maine.edu>
	 <AANLkTimkxJHvTAvra+B-0bAQopd8s21ZrFCPG_ALbZZ9@mail.gmail.com>
	 <1292863989.19322.27.camel@drew-northup.unet.maine.edu>
	 <AANLkTin2QuMF93RqrRcScxvkzhU4OFJ9Nt42tV+FOjxS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 13:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV1MS-0008Ql-1U
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 13:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045Ab0LUMaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 07:30:30 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:35979 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0LUMaa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 07:30:30 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oBLCTijW030014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Dec 2010 07:29:49 -0500
In-Reply-To: <AANLkTin2QuMF93RqrRcScxvkzhU4OFJ9Nt42tV+FOjxS@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oBLCTijW030014
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1293539406.70666@oxdxqqgoEZm4deZ7c0byWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164029>


On Mon, 2010-12-20 at 22:28 -0200, Thiago Farina wrote:
> On Mon, Dec 20, 2010 at 2:53 PM, Drew Northup <drew.northup@maine.edu> wrote:
> >
> > On Mon, 2010-12-20 at 13:17 -0200, Thiago Farina wrote:
> >> On Mon, Dec 20, 2010 at 10:00 AM, Drew Northup <drew.northup@maine.edu> wrote:
> >> >
> >> > On Thu, 2010-12-16 at 21:43 -0200, Thiago Farina wrote:
> >> >> On Thu, Dec 16, 2010 at 8:38 PM, Vasyl' <vvavrychuk@gmail.com> wrote:
> >> >> > Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
> >> >> > ---
> >> >> >  trace.c |    2 +-
> >> >> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >> >> >
> >> >> > diff --git a/trace.c b/trace.c
> >> >> > index 1e560cb..62586fa 100644
> >> >> > --- a/trace.c
> >> >> > +++ b/trace.c
> >> >> > @@ -25,7 +25,7 @@
> >> >> >  #include "cache.h"
> >> >> >  #include "quote.h"
> >> >> >
> >> >> > -void do_nothing(size_t unused)
> >> >> > +static void do_nothing(size_t unused)
> >> >> >  {
> >> >> >  }
> >> >> >
> >> >> If it means something, this looks sane to me.
> >> >>
> >> >> Acked-by: Thiago Farina <tfransosi@gmail.com>
> >> >
> >> > It may be sane, but why should we trust that it is without a commit
> >> > message?
> >>
> >> Why such trivial thing needs further explanation?
> >
> > Because even trivial fixes may break non-trivial things.
> > In addition, without justification we'd just as soon have somebody come
> > back with another patch six months down the road that changes it back to
> > the original code. Now that wouldn't make a whole lot of sense, now
> > would it?
> 
> I don't think so, it's making the function private, because the
> function is used only in that file and as such if you see a function
> marked as static you know that and doesn't need further explanation in
> my pov (but it seems you don't think like that).

All the patch above does is tell the compiler to enforce compilation of
that function as static. That is most definitely not the same thing as
making it private. (I think we can agree that it is being used as if it
were being enforced as private at some meta-level, but the compiler
isn't going to enforce it for us...) While I think the code change is
fairly clear, as I said earlier: without a commit message we don't have
a good reason for not making it non-static again later on, flip-flopping
ad-infinitum.

Commit messages for isolated changes such as this build up a story, if
you will, providing future contributors with insight as to why the group
made a change when it did--even when the change is minor (in fact often
most importantly when the change is minor)--by putting it in context.

> > Alas the best way to avoid such a situation is to explain why a change
> > was made to begin with.
> >
> 
> So, you are welcome to contribute and suggest such description for
> this trivial (that may break non-trivial things) patch. So we can
> please you and others in the future.

As I am complaining that I don't know what the submitter was thinking
that sounds particularly odd to me. How I am supposed to describe for
the group what the commit's author was thinking in a commit message that
I would like to see added to a patch when in fact the whole problem is
that I don't know specifically what he was thinking? "Changed function
to static for no known reason whatsoever" isn't much of a commit
message.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
