From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 17:45:45 +0100
Message-ID: <8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
References: <1195477504.8093.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jonas Juselius" <jonas.juselius@chem.uit.no>
X-From: git-owner@vger.kernel.org Mon Nov 19 17:46:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu9lE-0001CO-RO
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbXKSQpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753143AbXKSQpz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:45:55 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:35194 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbXKSQpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:45:55 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1334657nze
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 08:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=h6eXCZ4QR8G9SloZl36j9QyraEIc2dWUgBP4Z2W0PSY=;
        b=G/vqK94MLahu9o8jRwRijBitp3QZ0slZ5NJuqsdymmq5LTkEn9wtsQ1tBLKd9HME6dhj6vLIlh23Yh/1rzJdx6l24ZDlctl1A9v03F3Fkx1rjAqnlo2/RZQsERGaOCkcbnalzU4Tlafdp89LsuG72kajElaXjREBlp82C05iw9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=awXEgVSDNNXLkcNuoDyWnJbeJYnAiVc4gcIM7eLnSgV7tP8iIdJ3NE/ZU7JLjygT1AMNgYAEd/9KrVHNv4sHAEB1inFtzicuZLRtzrPkVTSUCmPEREYNzsbXAqeFdrQZ9ZOTBHMf7qA5ae4oKCEOCwEuxcL/56v8PwD4pXbCPqI=
Received: by 10.114.196.1 with SMTP id t1mr93293waf.1195490745402;
        Mon, 19 Nov 2007 08:45:45 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Mon, 19 Nov 2007 08:45:45 -0800 (PST)
In-Reply-To: <1195477504.8093.15.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65463>

On Nov 19, 2007 2:05 PM, Jonas Juselius <jonas.juselius@chem.uit.no> wrote:
> All comments
> and suggestions are welcome!

Very nice introduction, but I have a couple of comments.

In "Specifying revisions" you say that '^' and '~' are equal, but that
is not true. ^ is used to select the first parent of a commit, ^2
selects the second parent of a merge commit (and ^3 selects the third
parent of an octopus merge), while the '~' is used to go back any
number of generations, following the first parents of each commit (~
selects the first parent, ~2 selects the first grand-parent etc).

Also, I think you might scare users away from 'git reset':

  git reset resets the branch to a specified state invisibly and
  without possibility to go back. Ever. Your call.

That's not true, since any "modern" git has reflogs enabled. If you do
'git reset --hard HEAD^^^' and then realize it was a mistake you can
just 'git reset --hard HEAD@{1}'

-- 
larsh
