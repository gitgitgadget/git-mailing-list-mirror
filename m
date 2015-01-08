From: matthew sporleder <msporleder@gmail.com>
Subject: low memory system to clone larger repo
Date: Thu, 8 Jan 2015 11:10:08 -0500
Message-ID: <CAHKF-AspyE84_0CVMz2OjFLt3Q62qKDfTkbUk3-+RQ_EZ=0JGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:10:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Ff7-0000rh-CL
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 17:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbbAHQKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 11:10:11 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59209 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbbAHQKK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 11:10:10 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so3448406wgh.3
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ogg48O7EhV8yE70NkNL5IiwOXOVmVVGf2AI/WrxBT9Y=;
        b=t1yvotMO77vuJgefCzHy99krpFqH3LzZp1QmhU1zHkB5YR1tTaSyUBXfstqnnEfLSE
         YFy1N9uQl2jtby8n+KmJ2KQSZU+z81DHNd7vy4TNOeMgMQ6B0DpBv9ErtX4/V0BHV+sd
         rWLe/c5Qiva3EZA22ZEd/br5NjmusDC1ubDq57CihIrh6bXkH2fpqNd+wRBnuaY8SFjW
         ieN2U8iU7mY8IRaqNN6aOBu0JCqYUX34RqEEmwvZ9dOTYlwxKqY6AdQmBS+DZ90ti5lJ
         FdvLFi7LBnRdf/iuUKew8x90J1/P0Uc+0A1HlRRZR1GeRKmuSGxxV19NgpzSLxpg3QYc
         Vh9Q==
X-Received: by 10.180.11.98 with SMTP id p2mr21515688wib.22.1420733408818;
 Thu, 08 Jan 2015 08:10:08 -0800 (PST)
Received: by 10.194.87.193 with HTTP; Thu, 8 Jan 2015 08:10:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262198>

I am attempting to clone this repo: https://github.com/jsonn/src/

and have been successful on some lower memory systems, but i'm
interested in continuing to push down the limit.

I am getting more success running clone via https:// than git:// or
ssh (which is confusing to me) and the smallest system that works is a
raspberry pi with 256 RAM + 256 swap.

I seem to run out of memory consistently around 16% into Resolving
deltas phase but I don't notice an RSS jump so that's another
confusing spot.

My config is below and I'd appreciate any more suggestions of getting
that down to working on a 128MB box (or smaller).

---

I appreciate any suggestions,
Matt

p.s. shallow clones work fine on very small systems


[pack]
        windowMemory = 1m
        packSizeLimit = 1m
        deltaCacheSize = 1m
        deltaCacheLimit = 10
        packSizeLimit = 1m
        threads = 1
[core]
        packedGitWindowSize = 1m
        packedGitLimit = 1m
        deltaBaseCacheLimit = 1m
        compression = 0
        loosecompression = 0
        bigFileThreshold = 10m
[http]
        sslVerify = false
[transfer]
        unpackLimit = 10
