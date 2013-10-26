From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #06; Fri, 25)
Date: Sat, 26 Oct 2013 17:30:42 +0700
Message-ID: <CACsJy8A3s4TUmUOC+i-k97GxxvBQ7mQmdoPJizfy1yS3rqLEkA@mail.gmail.com>
References: <xmqqeh79hr3o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Karsten Blees <blees@dcon.de>
X-From: git-owner@vger.kernel.org Sat Oct 26 12:31:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va19l-0008R8-0I
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 12:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3JZKbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 06:31:14 -0400
Received: from mail-qe0-f44.google.com ([209.85.128.44]:34139 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab3JZKbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 06:31:13 -0400
Received: by mail-qe0-f44.google.com with SMTP id 6so3007770qeb.17
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gzzIyoIEVdnIVHuaDmh0CowXwiTDIAKoHadpIzuAC0A=;
        b=KnP0oDIPTVI3tWcPropQcSfgnfC+UGckFmz3NFIRPw4OmwaBd6ks9J2Zswtpvk0jxn
         ddHXjhGe9ldtVU3iLMDstht+igeJYmNbprcCAEQZr/gX07EsULSw5d7ONIv1HhSuzKPa
         Gs3hVtM/YjhBSRtHVXjB7BrVqp+w4BSw19TiurjjJlxe3Cd24dRb1f7g3Hx7A4+d7v94
         8I3cYa8OtLvDdAEBUJDb7YzBTZ1TrZ4k0MjnSsllauLkPKJGgoCckY3eeeNFqfilO629
         GDqACH0DMnboAfH7z9hgQWyVowUYv5mMoOqqvY+GCr/Xk+c79+D2baMBZ8HD4BtEDkqs
         oLig==
X-Received: by 10.49.86.35 with SMTP id m3mr16304833qez.7.1382783472722; Sat,
 26 Oct 2013 03:31:12 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Sat, 26 Oct 2013 03:30:42 -0700 (PDT)
In-Reply-To: <xmqqeh79hr3o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236751>

On Sat, Oct 26, 2013 at 6:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * kb/fast-hashmap (2013-10-22) 12 commits
>  - remove old hash.[ch] implementation
>  - read-cache.c: fix memory leaks caused by removed cache entries
>  - name-hash.c: remove cache entries instead of marking them CE_UNHASHED
>  - name-hash.c: use new hash map implementation for cache entries
>  - name-hash.c: remove unreferenced directory entries
>  - name-hash.c: use new hash map implementation for directories
>  - diffcore-rename.c: use new hash map implementation
>  - diffcore-rename.c: simplify finding exact renames
>  - diffcore-rename.c: move code around to prepare for the next patch
>  - buitin/describe.c: use new hash map implementation
>  - add a hashtable implementation that supports O(1) removal
>  - submodule: don't access the .gitmodules cache entry after removing it
>
>  Improvements to our hash table to get it to meet the needs of the
>  msysgit fscache project, with some nice performance improvements.
>
>  The preparatory clean-up to submodule from Jens is at the bottom. I
>  also squashed in a fix-up by Karsten found at $gmane/236468 (please
>  double-check the result).

jk/pack-bitmap adds khash.h, which from a first glance looks like yet
another hash table implementation. I was just wondering if kb's new
hash tables can cover the need of pack-bitmap.c too so we can remove
khash.h later..
-- 
Duy
