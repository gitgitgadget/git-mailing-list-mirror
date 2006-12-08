X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Fri, 8 Dec 2006 12:45:59 -0800 (PST)
Message-ID: <360959.72234.qm@web31809.mail.mud.yahoo.com>
References: <elcegl$qfh$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 8 Dec 2006 20:46:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=TVGQ+VR2OPaKWYw+Fd+JrJYJ/r0eEfAVy+IActtArtdvJOSq/3p1kpr42PxzDcyv5hmAxRoj8rUUUpYnpc1E54uDoboBzi6cVcS9cRZ0zlpnQFkI/13ZjQ17canmZKL07ZIm3V8xiHrSF/c2RvHayEAylgMBscHqPzFRq0obxNU=;
X-YMail-OSG: 4mxg5dcVM1nKsjpe2_9YRzYlqu9Znv_9n0n9MSXtNmnhhw3GRz45h0SYcCPjqU6qvNqcH7Vt5dvCirJZufeLJTEQPUYBd7Q3y5bEhYIvCbBeeFNjYtKCVYUtra9GNxSgW0huCN0WsN64XPyq7zW.36Bxbpbm8Ki93UZKI0g1_8dNc4Mt3Ek9GjED
In-Reply-To: <elcegl$qfh$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33741>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsmbj-0002fE-GS for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761194AbWLHUqI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761196AbWLHUqI
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:46:08 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:24558 "HELO
 web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S1761192AbWLHUqF (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 15:46:05 -0500
Received: (qmail 73573 invoked by uid 60001); 8 Dec 2006 20:46:04 -0000
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Fri,
 08 Dec 2006 12:45:59 PST
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
> > Pazu <pazu@pazu.com.br> writes:
> > 
> >> # Please enter the commit message for your changes.
> >> # (Comment lines starting with '#' will not be included)
> >> # On branch refs/heads/next
> >> # Updated but not checked in:
> >> #   (will commit)
> >> #
> >> #    modified:   perl/Makefile
> >> #    modified:   var.c
> >>
> >> Here's where the magic would happen. Removing the line "modified: var.c" would
> >> remove var.c from this commit. Of course, the template message should be
> >> modified to tell the user he can do that.
> >>
> >> So, what do you think about this?
> > 
> > Personally, I would refuse to use such a modified git, because
> > often the first thing I would do in the commit log buffer is
> > check the listed files and remove the '# ...' lines while
> > typing.  I do not want that to affect the set of changes I
> > staged in any way.
> > 
> > But maybe that is just me.
> 
> I was to raise the same objection. 
> 
> But this can be solved by using magic _only_ if the template with exception
> of "modified:" lines matches, and if there is at least one file
> in "modified:" section.

I raise the same objection as Junio.

This is how perforce does it*, and while it is useful, git is NOT perforce,
and I agree with Junio and Jakub.

If you want to commit only few files, update the index for only
the ones you want to commit.  If you did update the index for all
of them, "git-read-tree -m -i HEAD" is your friend.

    Luben

* The reason being is that there is no "index-cache" and the commit
message needs to be scanned to determine which of the edited files
you actually intend to commit to the server at this time.
