From: "Klas Lindberg" <klas.lindberg@gmail.com>
Subject: Re: How to remove a commit object?
Date: Thu, 2 Oct 2008 16:26:29 +0200
Message-ID: <33f4f4d70810020726g71c6f39eq16585269fb268322@mail.gmail.com>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>
	 <48D36DF4.3030607@drmicha.warpmail.net>
	 <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>
	 <m3ljx7qemk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Git Users List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:28:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlP9a-00016t-V5
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbYJBO0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753610AbYJBO0c
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:26:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63485 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbYJBO0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:26:32 -0400
Received: by nf-out-0910.google.com with SMTP id d3so429004nfc.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fgZfhq0I9q460bNGT+logyEMoaZfhTKA76FJA5c3XzU=;
        b=WH9r/dCoFf/cnHjuM4eJ+oVGCUnqASqdxvPlKW7oJcT6gSaQzVL8gE8LEtt6Wdtucm
         8sGvqa/D8vTggIHQK0dUZiqZA1dEy4uhnt6paZaShzC+yoZktE5vk/Yj1s/Va5L4ZtLM
         ISYZu7WS/WcciK+S9vwi9uGp+t3erNaJB5CLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tbluWAXN353eb05pYhHmEp3lK+ZePiVa6jawZr8VpDIm0Lz7ZEfXM+B4SMHpLJuNgS
         nRAFuMAjpURLWrP7k8elocMPDxAgyjbs5rPoB2uQQCkla/WDBoBAWgRs4nF/d229zc6A
         42qW8CXkfat0jHm1CB1HPISlwfNWhXjj51YoY=
Received: by 10.86.1.1 with SMTP id 1mr8711167fga.61.1222957590014;
        Thu, 02 Oct 2008 07:26:30 -0700 (PDT)
Received: by 10.86.84.16 with HTTP; Thu, 2 Oct 2008 07:26:29 -0700 (PDT)
In-Reply-To: <m3ljx7qemk.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97341>

Repo size is a problem too, actually.

A solution to both problems seemed to be to use git-filter-branch to
create a new repo by filtering out all the unwanted files. The
astonishing result was that, for the subdirectory I tried it on, 90%
or so of the commits on that subdirectory just disappeared. It didn't
look right at all. Although I can't say for sure exactly what I did
with filter-branch, I would appreciate some guidance for using it. It
basically seemed to do exactly what I wanted (recreate the repo, minus
some explicit stuff, with history intact otherwise), except the result
looked crazy.

/Klas

On Thu, Oct 2, 2008 at 4:02 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Klas Lindberg" <klas.lindberg@gmail.com> writes:
>
>> This doesn't seem to work for me. I will soon be in a situation where
>> I need to selectively delete commits in such a way that they become
>> completely irrecoverable. I.e. it is not enough to revert a commit.
>> The *original* commit must be removed. And of course, the repo history
>> is too complex to allow for rebasing followed by garbage collection or
>> something like that.
> [...]
>
>> Would it be feasible to write a tool that can selectively replace a
>> specific commit in the commit DAG, or would that automatically
>> invalidate every SHA key for every commit that follows the replaced
>> original?
>
> It would invalidate SHA1 for every commit after first rewritten.
> There are two tools which you can use to rewrite large parts of
> history automatically: git-filter-branch, and git-fast-export +
> git-fast-import.
>
> HTH
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
