From: "Ronald Landheer-Cieslak" <ronald@landheer-cieslak.com>
Subject: [PATCH] Add support for # in URLs in git-remote (was: Re: [PATCH] New script: git-changelog.perl - revised)
Date: Sat, 3 Nov 2007 11:26:19 -0400
Message-ID: <67837cd60711030826q6b3b5c00l5b228531ab6a323e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16915_27232834.1194103579948"
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 16:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoKtR-0008Gh-K5
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 16:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbXKCP0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 11:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754500AbXKCP0X
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 11:26:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:6962 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbXKCP0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 11:26:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1036158nfb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        bh=N94c6ffZ32CuUaG2iPqfseudQsHz2Q+Q2AzHNuDu9Ig=;
        b=f62HDFBITPFkb4u95YHE/4NBDPrahyq0xZoDrshABMiu9i4dmpHFeRO78m2EvJzsLnB/NjPlBtIHMJdLPUL4VH3DQNaNAzOi4JqcuAEmiknfDo3OubhI1OQSPk3dA6QBHtIpZDOLhfK+GHqqi/MSNDTovIVfn3abyy8iofg3wnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=br+FYnlFPQjiyh3IkBkuInk1cmWMMpRNuuu6ARcYClzL8eHNm58j4OKA2Guq9U7z25bagOvM9nCaQgHXGz23rnCL6wtG2jJe4vsKlWDVgwkPti5Dtj7eNQgB8+NSoWPrVzUOeWCdFNwnSzsROrXADH/AApgmb9j7S20lncvNIvk=
Received: by 10.78.138.14 with SMTP id l14mr2202117hud.1194103579949;
        Sat, 03 Nov 2007 08:26:19 -0700 (PDT)
Received: by 10.78.39.14 with HTTP; Sat, 3 Nov 2007 08:26:19 -0700 (PDT)
X-Google-Sender-Auth: ca66ede9e155618c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63283>

------=_Part_16915_27232834.1194103579948
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch adds support for # signs in URLs passed to git-remote add.
The suggestion that, in stead of putting a # in the URL I should set
up a new public repository with just the topic branch in it triggers a
reaction of dismay in me: to me, Git is a fast and resource-sparing
SCM and setting up a second repository just for publishing a branch
seems more than awkward to me - it's a waste of space and a waste of
(my) time.

So I've taken a look at the git-remote code and added a small patch to
support # signs in git-remote add URLs
 1 files changed, 6 insertions(+), 1 deletions(-)

This makes git-remote add behave as if whatever comes after the # in
the URL was passed as a -t option. Other options are still allowed, so
with # in the URL, nothing else changes

HTH

rlc

On Nov 3, 2007 9:58 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 3 Nov 2007, Ronald Landheer-Cieslak wrote:
> > On Nov 3, 2007 4:36 AM, Andreas Ericsson <ae@op5.se> wrote:
> > > Ronald Landheer-Cieslak wrote:
> > > >
> > > > This is also available through git at
> > > > git://vlinder.landheer-cieslak.com/git/git.git#topic/git-log-changelog
> > > >
> > >
> > > This mode of specifying a repository + branch was just thoroughly shot
> > > down in a list discussion, and git certainly doesn't grok it. I'd be a
> > > happier fella if you didn't use it.
> > >
> > Is there a canonical way to specify both the location and the branch
> > in one shot, then?
>
> Yes.  Create a repository containing only that branch, as "master", and
> point people to that repository.

-- 
Ronald Landheer-Cieslak
Software Architect
http://www.landheer-cieslak.com/
New White Paper: "Three Good Reasons to Plan Ahead"

------=_Part_16915_27232834.1194103579948
Content-Type: text/x-diff;
 name=9aa00ba7096d050bb62e48334a400270afd65735.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f8ka7ehf0
Content-Disposition: attachment;
 filename=9aa00ba7096d050bb62e48334a400270afd65735.patch

Y29tbWl0IDlhYTAwYmE3MDk2ZDA1MGJiNjJlNDgzMzRhNDAwMjcwYWZkNjU3MzUKQXV0aG9yOiBS
b25hbGQgTGFuZGhlZXItQ2llc2xhayA8cm9uYWxkQGxhbmRoZWVyLWNpZXNsYWsuY29tPgpEYXRl
OiAgIFNhdCBOb3YgMyAxMDo0NzowMCAyMDA3IC0wNDAwCgogICAgU3VwcG9ydCAjIGluIFVSTHMg
YW5kIGludGVycHJldCB0aGVtIGFzIHRyYWNraW5nIGJyYW5jaGVzCgpkaWZmIC0tZ2l0IGEvZ2l0
LXJlbW90ZS5wZXJsIGIvZ2l0LXJlbW90ZS5wZXJsCmluZGV4IGQxM2U0YzEuLjZiMjY1MjMgMTAw
NzU1Ci0tLSBhL2dpdC1yZW1vdGUucGVybAorKysgYi9naXQtcmVtb3RlLnBlcmwKQEAgLTI3MSw3
ICsyNzEsMTIgQEAgc3ViIHNob3dfcmVtb3RlIHsKIH0KIAogc3ViIGFkZF9yZW1vdGUgewotCW15
ICgkbmFtZSwgJHVybCwgJG9wdHMpID0gQF87CisJbXkgKCRuYW1lLCAkdXJsXywgJG9wdHMpID0g
QF87CisKKwlteSAoJHVybCwgJGJyYW5jaCkgPSBzcGxpdCgvIy8sICR1cmxfKTsKKwkkb3B0cy0+
eyd0cmFjayd9IHx8PSBbXTsKKwlwdXNoIEB7JG9wdHMtPnsndHJhY2snfX0sICRicmFuY2ggaWYg
KCRicmFuY2gpOworCiAJaWYgKGV4aXN0cyAkcmVtb3RlLT57JG5hbWV9KSB7CiAJCXByaW50IFNU
REVSUiAicmVtb3RlICRuYW1lIGFscmVhZHkgZXhpc3RzLlxuIjsKIAkJZXhpdCgxKTsK
------=_Part_16915_27232834.1194103579948--
