From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: recovering from "unordered stage entries in index" error
Date: Sun, 24 May 2015 16:52:37 +0700
Message-ID: <CACsJy8B=ttGa1aBKTdZAe6bLN4rbEE1r3fA+ifNNvUWhYD0Yfg@mail.gmail.com>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
 <CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com>
 <xmqqwq01kh8r.fsf@gitster.dls.corp.google.com> <CACsJy8Bdx5tto0w1q7rZ1ORx8RmHZCEKPyBqYs37k=YvbO3kzA@mail.gmail.com>
 <D377A9280DB18546A2471214D5CBB0E9087568F47B@exchdb01> <CACsJy8As8-b6kWHDnmAwAftyPG6X-BmoQdToQywzn9D4dtg2Fg@mail.gmail.com>
 <D377A9280DB18546A2471214D5CBB0E9087568F592@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "McHenry, Matt" <mmchenry@carnegielearning.com>
X-From: git-owner@vger.kernel.org Sun May 24 11:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwSao-0005tK-8c
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 11:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbbEXJxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 05:53:10 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35374 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbEXJxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2015 05:53:07 -0400
Received: by igbyr2 with SMTP id yr2so18897940igb.0
        for <git@vger.kernel.org>; Sun, 24 May 2015 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5F20Kkhzg9kvHgcEOO93nGBtHl9TynI1+2XnMvcflxo=;
        b=kKVh6R5guqc2gfY+fPyrwpkNbyuSYlPco5HCuKPYuLtwMKscO5/g9RtSys1ZgPFn2H
         1wmVJsnj1Bvo7KKNT9PG2Vpp9puuBner4gQj+Ghp6ZGvkxWlzi0mOj+sw0llIPHqMMGV
         AuWO/E2qja9XNbxNKZyU0vycs5DPwP1QZCbTkaWVDn05otqhfTQu74jZbC3n8ZbsiLmh
         8dqGrQ7M4VcinZF8s5nrn5Og0XyOgqEesibMrTOWU6uZsOjg6LHm4E6OG0DEYSIJoy00
         3wtD3XiapJ4I5MMwi4r210xu0go36NKM3U7IIPnzDtXCR4TRNiPhhM2i7vwlpErD3lR3
         h7IQ==
X-Received: by 10.43.172.68 with SMTP id nx4mr6512381icc.48.1432461187429;
 Sun, 24 May 2015 02:53:07 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Sun, 24 May 2015 02:52:37 -0700 (PDT)
In-Reply-To: <D377A9280DB18546A2471214D5CBB0E9087568F592@exchdb01>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269829>

On Sat, May 23, 2015 at 9:47 AM, McHenry, Matt
<mmchenry@carnegielearning.com> wrote:
>> So maybe you can do "GIT_TRACE=2 git svn fetch" and post the output.
>> I'd expect to see something like "git read-tree <sha1>" before "fatal:
>> unorder...". You can then use git ls-tree <sha1> to examine this tree,
>> try to sort the file list with "LANG=C sort" and compare with the
>> original list.
>
>         There is no read-tree in the output (below).  The sha1 that is mentioned, 74332b7, is the one for the current trunk:

Hm.. neither read-tree nor update-index is in the output. I can see
git-svn closing stderr sometimes, but not sure if that's why we don't
see these commands, or something else. Could you try again with
GIT_TRACE=/absolute/path/to/some/where instead of GIT_TRACE=2 and post
the content of /abso../some/where?
-- 
Duy
