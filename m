From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 9 Jun 2011 08:23:44 -0700
Message-ID: <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com> <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: NAKAMURA Takumi <geek4civic@gmail.com>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:24:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUh5h-0007fp-5W
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab1FIPYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:24:07 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51525 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab1FIPYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:24:05 -0400
Received: by ywe9 with SMTP id 9so853077ywe.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 08:24:04 -0700 (PDT)
Received: by 10.150.8.8 with SMTP id 8mr2032879ybh.186.1307633044065; Thu, 09
 Jun 2011 08:24:04 -0700 (PDT)
Received: by 10.147.182.11 with HTTP; Thu, 9 Jun 2011 08:23:44 -0700 (PDT)
In-Reply-To: <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175530>

On Wed, Jun 8, 2011 at 23:50, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> [+shawn, who runs into something similar with Gerrit]

> On Thu, Jun 9, 2011 at 05:44, NAKAMURA Takumi <geek4civic@gmail.com> wrote:
>> Hello, Git. It is my 1st post here.
>>
>> I have tried tagging each commit as "refs/tags/rXXXXXX" on git-svn
>> repo locally. (over 100k refs/tags.)

As Jakub pointed out, use git notes for this. They were designed to
scale to >100,000 annotations.

>> Indeed, it made something extremely slower, even with packed-refs and
>> pack objects.

Having a reference to every commit in the repository is horrifically
slow. We run into this with Gerrit Code Review and I need to find
another solution. Git just wasn't meant to process repositories like
this.

-- 
Shawn.
