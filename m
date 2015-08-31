From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR':
 Permission denied
Date: Mon, 31 Aug 2015 16:56:09 +0700
Message-ID: <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
References: <1440157010.1759.83.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Mon Aug 31 11:56:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWLpU-0005mi-Dc
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 11:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbbHaJ4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 05:56:40 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37524 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbHaJ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 05:56:40 -0400
Received: by igui7 with SMTP id i7so51071077igu.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r/b1h5TFkVGngBj3FSNhDeym7XyEW14xlSpXU+5RqrM=;
        b=zjzhKOJuS2iD7hxOOY+lSMY3Ktk9DzLrithJw0jMfmHRG4tRRhMXU04imV1Gig3i6u
         7hY/e7gdGw5G4tavL0m9sr3Dg/mBHn5vscbNtj7xATUHQm6SfWF+0VKhFIzrtOA+5sjZ
         tR6XwJdf5P8tQu1e+asEAmy4jsl94L+oBn+yhH20i9Nm96sQfc8p95Nl6n/ql6vuXFL0
         cGZEV7LrGikkWtQdoc3uggX5IN+KW5lEv3wl+rC4V5PqiXcwVDw0uInD/KVXV34dYXL4
         FIgNtNDWmgwXGpmz60aBKME5OVvx6G85wIdcPjB1ZCHmai7ysPlg6RQNkKpvN7C8rvvC
         Mf6w==
X-Received: by 10.50.92.99 with SMTP id cl3mr12764100igb.48.1441014999369;
 Mon, 31 Aug 2015 02:56:39 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 31 Aug 2015 02:56:09 -0700 (PDT)
In-Reply-To: <1440157010.1759.83.camel@transmode.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276862>

On Fri, Aug 21, 2015 at 6:36 PM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> I cannot push:
> # > git push origin
> Login for jocke@git.transmode.se
> Password:
> Counting objects: 7, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (7/7), done.
> Writing objects: 100% (7/7), 13.73 KiB | 0 bytes/s, done.
> Total 7 (delta 4), reused 0 (delta 0)
> fatal: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
> fatal: The remote end hung up unexpectedly
> fatal: The remote end hung up unexpectedly

Noted. Will try to fix (but probably not fast). At first I thought
this was an old bug, but that old bug [1] is in the fetch/clone path,
not push. Not sure if the same approach can be reused here (i.e.avoid
temp files altoghether).

[1] b790e0f (upload-pack: send shallow info over stdin to pack-objects
- 2014-03-11)
-- 
Duy
