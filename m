From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [git subtree] documentation and new --squash mode
Date: Sun, 31 May 2009 12:42:43 -0400
Message-ID: <32541b130905310942x3ca98b0ibbed8598f4ba6e56@mail.gmail.com>
References: <32541b130905301136i2d9ec05ew9ba54c6ca746af15@mail.gmail.com> 
	<slrnh24bff.n9t.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAo7s-0007NF-9V
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899AbZEaQnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 May 2009 12:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756457AbZEaQnD
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:43:03 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:52403 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbZEaQnB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 May 2009 12:43:01 -0400
Received: by gxk10 with SMTP id 10so12199415gxk.13
        for <git@vger.kernel.org>; Sun, 31 May 2009 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZeM5Y/UFD4AZzqGYGdtOyfQkvo2ucUawZ/guUj2kmVk=;
        b=PHf8MdbjtDzYdui29bqXiK3bpVlWdaGok/GuAeLJ+NIOXjCPgc4apBCJBDx/4RJsWQ
         nBnBAR1lR2eYSUUqZ+lxZEUWTqk4BC5MzwUtuRU46Fg5aurlg22lWHcdiMgLeirF5013
         2zIj7EtRk/fq3hB527OZ9hpBfORNKhkP42CgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GcdCFrsP91Lzozn7BnbfhxK4OXn/cktU4IEr7VQlSnxUmMjD1V+FmJiZuavC6Q9h6X
         70NSA6dZGFqJbJ4mb9wq5hXhPPIwzmCrdwHKH35iixj7nUnYxfoe2f3pa1O2uPfm2fD0
         xJtHiGoVpNiMQ23rW9OQ6q217QMu8Ob5O04K4=
Received: by 10.151.74.9 with SMTP id b9mr9785612ybl.5.1243788183045; Sun, 31 
	May 2009 09:43:03 -0700 (PDT)
In-Reply-To: <slrnh24bff.n9t.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120420>

On Sun, May 31, 2009 at 3:12 AM, Sitaram Chamarty <sitaramc@gmail.com> =
wrote:
> As I understand the documentation (and past emails, snippets
> of IRC traffic, etc) git subtree will help me do precisely
> what I want -- a simple way to deal with this all-too-common
> SVN-ism. =A0If not "simple", at least
>
> =A0- simpler than submodules, and
>
> =A0- no need for advance planning [1] about what parts will
> =A0 =A0be subprojects.

Well, I don't know that I'd go so far as to advise against advance
planning :)  But git subtree does make it easy for you to change your
mind later, that much is true.

You might still have some troubles if you rename subdirectories a lot;
perhaps I don't understand it correctly, but the so-called file
move/rename detection in git doesn't seem to be implemented
everywhere. If you extract the history of a subdirectory that was
previously renamed, you'll get only the history since it was renamed.
(Which might be fine with you.  You can certainly still merge it back
in afterwards.)

Also, git-subtree might have bugs yet.  Watch out for that :)

> [1] I do understand filter-branch quite well, and I know that
> even without advance planning it is possible to separate a
> subdirectory into its own repo using filter-branch. =A0I don't
> fancy teaching *them* filter-branch, so that makes me
> personally central to their projects, which is not scalable
> at all.

git-subtree is certainly easier to use than filter-branch, IMHO.  Plus
it helps you merge things back in afterwards, which filter-branch
doesn't particularly.

Have fun,

Avery
