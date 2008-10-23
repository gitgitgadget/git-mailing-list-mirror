From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Thu, 23 Oct 2008 16:21:34 +0200
Message-ID: <cb7bb73a0810230721o755182dfg10270e4a84208786@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org>
	 <fcaeb9bf0810230550t54813c09m3b1984f065732c0@mail.gmail.com>
	 <cb7bb73a0810230633r9970a50mbb4ecf3a855c3a21@mail.gmail.com>
	 <fcaeb9bf0810230651j1c02de13j61238c97661c32e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 16:23:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt15Y-0003Jw-Tt
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 16:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbYJWOVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 10:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbYJWOVh
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 10:21:37 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:65387 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYJWOVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 10:21:36 -0400
Received: by yx-out-2324.google.com with SMTP id 8so87901yxm.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oDB5FkfknRvNlukR8/94yb/47yNVjqX43rtedL249Pc=;
        b=t0GFdY8OYsHw+B/7Vqj9ezezMJzCJpSEsObu4axo4LcVwmg2emOuiqMx7btXO2N1DT
         3rF9oyI1DehK2t4z7RYrhsDgmpVhp/8o8jUYtBWCQTPoGY8/nlfQDEPvyU79SB/nIvGF
         gS1tyAxPXRVBR8vQluAnYhM/bD4R42bSskQsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=t237R5KAsuE2emIHcYA+Cgr2PLBuUDzDXIMtdCymJEpcB7TcU19xOPenVkM478Eh0F
         PfU9toOHg2Kk1LBepONguVJ9bKbsdsvU0JeWDgA9Lro8xxiL/JBsgZNUY5vvyF0Tbl9g
         b7WIxQlG0krTto66kEybD+oGS1MpiSku1jONw=
Received: by 10.151.42.10 with SMTP id u10mr3843627ybj.237.1224771694497;
        Thu, 23 Oct 2008 07:21:34 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Thu, 23 Oct 2008 07:21:34 -0700 (PDT)
In-Reply-To: <fcaeb9bf0810230651j1c02de13j61238c97661c32e9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98969>

On Thu, Oct 23, 2008 at 3:51 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 10/23/08, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
>> On Thu, Oct 23, 2008 at 2:50 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>  > On 10/23/08, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
>>  >>  The principle is extremely simple: when you choose to start tracking a
>>  >>  file with Zit,
>>  >>
>>  >>  zit track file
>>  >>
>>  >>  Zit will create a directory .zit.file to hold a git repository
>>  >>  tracking the single file .zit.file/file, which is just a hard link to
>>  >>  file.
>>  >
>>  > Why not use one .zit repo and track each file on each own branch?.
>>
>>
>> So your proposal is to have a single .zit repo which is actually a git
>>  repo and where each additional tracked file becomes its own branch,
>>  and zit would take care of switching from branch to branch when zit
>>  commands are called?
>
> I don't know if switching is necessary. With one file per pranch, the
> index is even not necessary.

[...]

> The history should be linear. Git (or zit) repository is just a
> container for git branches. Each branch contains only one file. Moving
> a file history is equivalent to "git push" + "git branch -D".
> Something like this (not tested):
>
> cd dst
> git init
> cd src
> git push dst local-branch:remote-branch
> git branch -D local-branch
> git gc

Looks a little too clumsy for my taste. Also, I don't like the idea of
having to enforce linear history for files, or getting rid of the
index. I would like zit to be as lightweight a wrapper for git as
possible, retaining the whole functionality.





-- 
Giuseppe "Oblomov" Bilotta
