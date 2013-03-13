From: David Aguilar <davvid@gmail.com>
Subject: Re: Deletion of git repo causes incorrect block count on HFS+ case-sensitive
Date: Wed, 13 Mar 2013 15:14:27 -0700
Message-ID: <CAJDDKr6q4kz0oFtukmnOc3heWyRS8TfgKjEkgNmqdZdMxEeENg@mail.gmail.com>
References: <B6ED348A-2168-42F5-B6EC-81D7E62805ED@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ismail Tabtabai <itabtabai@me.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 23:15:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFtwt-00020u-3N
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 23:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344Ab3CMWO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 18:14:29 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34532 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933260Ab3CMWO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 18:14:28 -0400
Received: by mail-wi0-f181.google.com with SMTP id hm6so1247349wib.14
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sCv0EH/YLS9H+ErvXTazk4SUwnj33aWrGhEpvF8xKQ0=;
        b=lseSEqa7p9HexUD5BOA15BWhWrxscSHYUIoo0E76PzuyXfuAdonUzcOeGr6MXSCGdK
         oYl+p7ezr4Yvv+YOoMqhU5ov7ifSzvtCaxid+v7c/IuXpUvLsdQ/uzmJlksZ6q4V5hiN
         zD81LmsJxMsD8H5/cWhT1kJe50Va5rv4fx8UHpztxJiHGOfZg2W6x4Z2/nkcKvPPzmOm
         GeuUW0iRhExQDxiEBwzuJBEr/PXD+S4CZdFghioYim6uil+Ls50ETp9OjWIrlXWKu6Us
         AjNKdjFf34wmL43jZ501FR84mIaGQMk8t8zSFTVhHEhFp5vIePblXZUyFoSe2KtvuhEw
         EFxw==
X-Received: by 10.180.183.81 with SMTP id ek17mr30126846wic.2.1363212867226;
 Wed, 13 Mar 2013 15:14:27 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Wed, 13 Mar 2013 15:14:27 -0700 (PDT)
In-Reply-To: <B6ED348A-2168-42F5-B6EC-81D7E62805ED@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218095>

On Wed, Mar 13, 2013 at 11:45 AM, Ismail Tabtabai <itabtabai@me.com> wrote:
> Hello,
>
> When I delete a git repo that I have cloned on my machine using 'rm -rf repo-name' I get an incorrect block count when I attempt a Disk Repair.
>
> I am running OS X 10.8.2 on a user installed SSD. The git version is 1.8.1.5.

This is not a git issue.

I would recommend inspecting your hardware; this could be a disk going bad.

There's not much git can do to fix a broken HFS+ filesystem or faulty
hardware.  If anything, it's an HFS+ / Apple bug, though that is less
likely than a bad disk.

If you haven't already, you should probably start doing backups.
I hope that helps.

> Checking file systemChecking Journaled HFS Plus volume.
> Detected a case-sensitive volume.
> Checking extents overflow file.
> Checking catalog file.
> Incorrect block count for file pack-8c0dc1a398a22c58ea1eba09de3ee9d935ad1ea3.pack
> (It should be 4865 instead of 12244)
> Incorrect block count for file pack-db61a037ad0e043e801d8ba1db98b1af14d466af.pack
> (It should be 5889 instead of 12245)
> Incorrect block count for file pack-db61a037ad0e043e801d8ba1db98b1af14d466af.pack
> (It should be 6220 instead of 12245)
> Incorrect block count for file pack-286c1444bc32ee2ed0af1d15070e0e31f22ba0a8.pack
> (It should be 7937 instead of 12246)
> Checking multi-linked files.
> Checking catalog hierarchy.
> Checking extended attributes file.
> Checking volume bitmap.
> Volume bitmap needs minor repair for orphaned blocks
> Checking volume information.
> Invalid volume free block count
> (It should be 85306183 instead of 85282114)
> Repairing volume.
> Rechecking volume.
> Checking Journaled HFS Plus volume.
> Detected a case-sensitive volume.
> Checking extents overflow file.
> Checking catalog file.
> Checking multi-linked files.
> Checking catalog hierarchy.
> Checking extended attributes file.
> Checking volume bitmap.
> Checking volume information.
> The volume avicenna was repaired successfully.
> Volume repair complete.Updating boot support partitions for the volume as required.

It looks like it repaired itself.  bad blocks?
-- 
David
