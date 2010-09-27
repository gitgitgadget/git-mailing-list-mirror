From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Mon, 27 Sep 2010 15:59:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1009271559110.2187@intel-tinevez-2-302>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com> <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com> <7vy6asoz0i.fsf@alter.siamese.dyndns.org> <AANLkTi=p13eTY-dqGZJYaogRyj0Z5uO3YM8n1RW4iBUi@mail.gmail.com>
 <AANLkTikv8M8xuESQzO7qfPB72d51hTcosUgKreLu7Y=C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: kusmabite@gmail.com, Junio C Hamano <gitster@pobox.com>, 
    msysgit@googlegroups.com, git@vger.kernel.org, 
    "Shawn O. Pearce" <spearce@spearce.org>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncCLLz_5DuGxDfxoLlBBoEevkxCg@googlegroups.com Mon Sep 27 16:00:23 2010
Return-path: <msysgit+bncCLLz_5DuGxDfxoLlBBoEevkxCg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLLz_5DuGxDfxoLlBBoEevkxCg@googlegroups.com>)
	id 1P0EFi-0001YP-EH
	for gcvm-msysgit@m.gmane.org; Mon, 27 Sep 2010 16:00:22 +0200
Received: by fxm14 with SMTP id 14sf1154909fxm.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 27 Sep 2010 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:x-authenticated
         :x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:x-y-gmx-trusted
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=kkxPBDfsT57cjtMYEaxnoyTvLqJmWbCl1O+hIi6mLbo=;
        b=HoE7LI02VWAlgntlEwAyjIHGnjjpyXAFQnbJzVaFCYJnuyKhk+rRsZNwOmtcYMumXV
         r+Gwux6lagvpJ+larms1tTlrVZMVUBTPcl0y9lP2yh8dU0deTZNGzCkmBSmmPPg+r7Jr
         5dyHsI6VMt+jWvf6Lf0afMJesT5Gl+XMzJy1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        b=aSuU7Rw5b0XU+x4fCoCz/lrI50oXho7DB93F9tuFBat1Ug0AvpC4uA6JBj6lvV4Yvs
         mf8ghmKbvR4mlcP3Q5IAIc7jCDV4cFNG6+U9Q24BPw425uxtMGsd0aX9XifL5y+IRYiU
         4QYoomllYsp1pg0fSelBFQeg5SIH8d/lfHN/c=
Received: by 10.223.79.138 with SMTP id p10mr355337fak.42.1285595999368;
        Mon, 27 Sep 2010 06:59:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.137.193 with SMTP id x1ls1470281bkt.0.p; Mon, 27 Sep 2010
 06:59:58 -0700 (PDT)
Received: by 10.204.127.65 with SMTP id f1mr291006bks.5.1285595997978;
        Mon, 27 Sep 2010 06:59:57 -0700 (PDT)
Received: by 10.204.127.65 with SMTP id f1mr291005bks.5.1285595997950;
        Mon, 27 Sep 2010 06:59:57 -0700 (PDT)
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
        by gmr-mx.google.com with SMTP id n18si3110970bkw.2.2010.09.27.06.59.57;
        Mon, 27 Sep 2010 06:59:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 27 Sep 2010 13:59:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 27 Sep 2010 15:59:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4fKsRoPT4ENIDRdXRkpURsk+HnZXblQINw4PgSH
	z4xLRBb9ZPZCQ5
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <AANLkTikv8M8xuESQzO7qfPB72d51hTcosUgKreLu7Y=C@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157332>

Hi,

On Mon, 27 Sep 2010, Pat Thoyts wrote:

> On 27 September 2010 14:19, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> > On Fri, Sep 24, 2010 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Erik Faye-Lund <kusmabite@gmail.com> writes:
> >>
> >>> On Thu, Sep 23, 2010 at 10:35 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> >>>> Since open() already sets errno correctly for the NULL-case, let's just
> >>>> avoid the problematic strcmp.
> >>>>
> >>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> >>>
> >>> I guess I should add a comment as to why this patch is needed:
> >>>
> >>> This seems to be the culprit for issue 523 in the msysGit issue
> >>> tracker: http://code.google.com/p/msysgit/issues/detail?id=523
> >>>
> >>> fetch_and_setup_pack_index() apparently pass a NULL-pointer to
> >>> parse_pack_index(), which in turn pass it to check_packed_git_idx(),
> >>> which again pass it to open(). This all looks intentional to my
> >>> (http.c-untrained) eye.
> >>
> >> Surely, open(NULL) should be rejected by a sane system, and your patch
> >> looks sane to me.
> >>
> >
> > Since this doesn't seem to be in git.git yet, perhaps you could squash
> > this on top? I didn't notice it in time, but fopen lacked the same
> > check (freopen already had the check). It's not as important, because
> > it doesn't seem like we have any code reaching this path so far, but
> > it would IMO be better to fix this now rather than having to chase
> > down the issue again later...
> >
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 4595aaa..f069fea 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -160,7 +160,7 @@ ssize_t mingw_write(int fd, const void *buf, size_t count)
> >  #undef fopen
> >  FILE *mingw_fopen (const char *filename, const char *otype)
> >  {
> > -       if (!strcmp(filename, "/dev/null"))
> > +       if (filename && !strcmp(filename, "/dev/null"))
> >                filename = "nul";
> >        return fopen(filename, otype);
> >  }
> >
> 
> I'll apply this to the devel branch and try to remember to squash it
> on the next rebase-merge.

Usually I mark commits like this with ("amend deadcafe") in the commit 
subject so I do not forget... ;-)

Ciao,
Dscho
