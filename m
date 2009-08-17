From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 18:41:29 +0700
Message-ID: <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com> 
	<fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com> 
	<2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com> 
	<fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com> 
	<4A8932BB.7030002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 13:42:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md0b7-0004b0-HA
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 13:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757815AbZHQLls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 07:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757804AbZHQLls
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 07:41:48 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:17458 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799AbZHQLls (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 07:41:48 -0400
Received: by an-out-0708.google.com with SMTP id d40so2789387and.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qlH4D/YL9iyGJF2sOypZtOMGP4AhFP/A+N7xueuuFQ8=;
        b=eRzsHnhTQByds+KPqK96KJWnb9BE2NIkgWzY2OHLz9RdoQN0wmmdCQWJVdhh3Hce7G
         KF30zOOtax+buvo9Igz4q1op5NOlpVZzuP53eh6OJ3tC+PrgjGeHFJFUZ7tS3sAHbgE5
         yuTsiRBVK42hWb4nyxL2w4imWFXmfOKHcPCSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ADjny1CaK7wg28qXlqJ9cqIJp0S6O2EnTT2glXuRVrBSxuSuyskc1eU26A90fZY1jm
         sBftHKNZRHwlbQUDoc0Cl3s1oG8LTexQO1jZPtDgZjrGZnuvbP4Mj6d76PsgqpyKk7ZW
         VNDA9lvENR4KKyB3pW1MFe+u3LpmlGasV3gCU=
Received: by 10.101.176.38 with SMTP id d38mr3281141anp.12.1250509309123; Mon, 
	17 Aug 2009 04:41:49 -0700 (PDT)
In-Reply-To: <4A8932BB.7030002@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126158>

On Mon, Aug 17, 2009 at 5:36 PM, Johannes Sixt<j.sixt@viscovery.net> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>> [I haven't read the rest of the mail, will read it through later]
>>
>> On Mon, Aug 17, 2009 at 3:49 PM, <skillzero@gmail.com> wrote:
>>> It would be nice if .git/info/sparse is there by default (like
>>> .git/info/exclude) with some commented out instructions (also like
>>> .git/info/exclude).
>>
>> No it can't be there by default. An empty .git/info/sparse means clear
>> assume-unchanged bit out of all files in index. It's not the same as
>> lacking .git/info/sparse (which does disable sparse checkout feature).
>
> Huh? Shouldn't the meaning of .git/info/sparse be: "the files mentioned in
> this file are not checked out." That is, if the file is empty, then no
> file is not checked out, IOW, all files are checked out.

That's correct. Empty .git/info/sparse -> no assume-unchanged files ->
all files are checked out. That's what I meant. It's different from
empty .git/info/sparse as "don't touch index and worktree, leave them
as they are no matther if they have assume-unchanged files".

> In order to advocate my earlier proposal: Name the file
> .git/info/phantoms, then it's clear: "The files mentioned here are
> phantoms" - they exist in the index, but not in the worktree; no phantoms
> means that everything is checked out.

OK. Phantom checkout, must be unique in VCS world ;-) If no one
objects my next series will use this name as it's better than "sparse"
and "assume-unchanged" is just too vague. Would option names to
enable/disable this be --with[out]-phantoms?
-- 
Duy
