X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] [checkout-index] Give names to stages
Date: Sun, 3 Dec 2006 22:59:44 -0800 (PST)
Message-ID: <314112.76253.qm@web31813.mail.mud.yahoo.com>
References: <7v7ix8rx19.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 4 Dec 2006 07:00:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=iQYZu1UBCCcdtLYss8ZGvPtlxWOU/U7r1PHIEgwui3DH1DTWbI8Ruav3W9lO1SxLbHwWITiryc7AIDpIlZrj+yQ/kJcHeLuA1HVtbYP/DEeNWsHMBfQcX9muW60BEH0t6jfRRUWbR1piLPYz5sHsgslcBs0uo4GksH4aZJ8dg1E=;
X-YMail-OSG: vmHZXO0VM1kE9vKlFbF_PiUiiQ8pSvscWlwqD_FFEJZBa09YCPnghImfJrQBYqsrhXgC9rA9t7geva.ip9P.Wb9rJ6H_kdFUO1S5dD9db5KUGRdQbx0NMYu45VpqNv_Aq7VHfqoampx98xj_0c3VMT5RnUGZmA--
In-Reply-To: <7v7ix8rx19.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33166>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr7nw-0005tO-Cs for gcvg-git@gmane.org; Mon, 04 Dec
 2006 07:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758411AbWLDG7q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 01:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758418AbWLDG7p
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 01:59:45 -0500
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:4267 "HELO
 web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1758408AbWLDG7p (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 01:59:45 -0500
Received: (qmail 77297 invoked by uid 60001); 4 Dec 2006 06:59:44 -0000
Received: from [68.186.59.199] by web31813.mail.mud.yahoo.com via HTTP; Sun,
 03 Dec 2006 22:59:44 PST
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Sometimes when I pull things from a bunch of places and do
> > a resolve, I'm presented with the standard resolve format of
> > a source file, "<<<< ==== >>>>" thingie, and all I'd really
> > like to do is "accept ours".  I.e. something similar to what I've
> > seen in other (commercial) SCMs, a la "scm resolve accept ours".
> >
> > This patch merely allows the user to say
> >    git-checkout-index --stage=ours their_broken_file.c
> > instead of
> >    git-checkout-index --stage=2 their_broken_file.c
> > and similarly for "theirs", etc.
> 
> That's _exactly_ my point.  It "merely allows to".
> 
> > If you think this breaks the ideology, ok.
> 
> It's not about the ideology.  It's in the part you quoted but
> did not respond to (by the way, please don't quote the the bulk
> of the message if you are not responding to it).
> 
> You stopped at only adding "ours" as synonym for "2" and did not
> do anything else in the patch; it is a very sensible thing to
> do, because "checkout-index" is a plumbing command that is about
> checking out files from the index to the working tree.
> 
> But that means you HAVE TO stop at that because you are working
> at the plumbing layer.  You said yourself that what you really
> wanted to do was "scm resolve accept ours".  And from an end
> user's point of view, "checkout --stage=ours" is NOT it.
> 
> A user who wants to see "accept ours" wants the scm to perform:
> 
> 	git checkout-index --stage=2 paths...
>       git update-index paths... ;# or Nico's "git add"

Yes, that's what I normally do.

> for him.  That is why I suggested to hoist the place you
> implement this usability improvement up one level and make the
> Porcelain level command:
> 
> 	git checkout --ours paths...
> 
> to do the above two plumbing command sequence internally for the
> end user.

Ok.

    Luben
