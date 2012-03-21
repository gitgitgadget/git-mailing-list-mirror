From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Wed, 21 Mar 2012 17:34:15 +0700
Message-ID: <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 11:34:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAIsX-0001az-Mc
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 11:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354Ab2CUKer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 06:34:47 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46289 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758334Ab2CUKeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 06:34:46 -0400
Received: by wibhj6 with SMTP id hj6so6307105wib.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bpnE1jOWd1Cp4ZHwGzIKH0FfD6OvjVijipFJLppK8N8=;
        b=ot9/e0c0BbPq9nL67HsqhheD9hQ0n8arRNWpNDbplNPg2CaiINKodNXkhXbiFHhMPI
         K7RltAgXYksCxpjc6fM0Wz3wY/F+N4LK8zVo1OIs5LiGhNYBp5Jc7xuCFrhPpPw3dI+m
         HpzQianhScKDnx6Lea7aHVw9E0gi1G3bPK0mF+KaacY6LFLlljjkHOT0/mu9qNL3YSNH
         v9IcCOMH6uVPjwpOe7hvSmGFY+qEsI5lDH1yrCK0M5kyAZw0Ll75k1zXcGqHoDfVBBK4
         sqaI5lDDRPixcAUGiGQWgjgBsifzRILPWjYB8LBzbsJuphcjNiZZ8e6Uu7D33sRaBTkZ
         whOw==
Received: by 10.180.80.40 with SMTP id o8mr7782840wix.10.1332326085506; Wed,
 21 Mar 2012 03:34:45 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Wed, 21 Mar 2012 03:34:15 -0700 (PDT)
In-Reply-To: <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193564>

On Wed, Mar 21, 2012 at 4:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On Mar 21, 2012, at 2:29 AM, Nguyen Thai Ngoc Duy wrote:
>
>> On Wed, Mar 21, 2012 at 4:17 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>> There are some questions I would have about the project.
>>> Has there already been any development or thoughts in that direction?
>>
>> Tree-based format seems to be favored by core developers, for example
>> in the footnote in [1]. But there have been no attempts to realize it.
>> You may want to search mail archive for more.
>>
>
> Thanks for your answer, so I would probably implement a tree based structure.

There may be a better approach, maybe a simple database format that we
could immitate. It's up to you to find out :)

> However I got one more question, since I'm not yet really familiar with the
> code and internal structure of git, what exactly does the SHA1 over the
> index exactly achieve? Is it only for checking if the index is still correct
> for the next time it is used and has not been changed or is there a more
> important function of it?

It makes sure the index is not corrupt (by disk faults for example). I
don't think it is used for anything else. Cheaper checksum can be used
if good enough for the index. See
http://thread.gmane.org/gmane.comp.version-control.git/190016 and the
following reply.
-- 
Duy
