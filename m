From: Jacob Keller <jacob.keller@gmail.com>
Subject: how to fetch entire heirarchy of refs from a remote?
Date: Thu, 7 Jan 2016 15:06:00 -0800
Message-ID: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 00:06:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHJdR-0000kS-4q
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 00:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbcAGXGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 18:06:21 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36988 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbcAGXGU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 18:06:20 -0500
Received: by mail-ig0-f173.google.com with SMTP id h5so24808722igh.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 15:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=YWkT2er+HhIvgjGk4bc+04fpmXVcY8Hx4md0p7EkQD0=;
        b=02Hy536GTAnlAJR8wCk77p//+BuZSfDxwdEtLg0juPByqLLtylOxrri5Zo/EJer7fE
         mxvvJXalbARPB4NR1t0T4ufEbRj+4XT4ndqI0As8XYCUhbL6kWqOsoy54ja75LMurolY
         YTwbOfIN1TwOLmza7nR2x75zdMGmUltfPEAw4oHtC+dl171svjEIUguiV1YSTYlTyplo
         ddqja0CMWo3EQXYAoBjMcKIUVfHSjJE3a4+4L4+WUQwWlc7AKw9tBXcfhFWC8UelDDy3
         LWtnna4vUjjpTEwqIMw3AUBIR7fCkKD+fJrsrnmmRCXxWKYQIU6ooNAdf7JqSDDbrdB3
         V8BA==
X-Received: by 10.50.36.74 with SMTP id o10mr17224942igj.73.1452207980217;
 Thu, 07 Jan 2016 15:06:20 -0800 (PST)
Received: by 10.107.63.130 with HTTP; Thu, 7 Jan 2016 15:06:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283514>

Hi,

Say I have a repository which has a series of refs in a heirarchy such
as a gerrit repository with changes specified something like:

refs/changes/96/55596/3
refs/changes/96/55596/4
refs/changes/96/57496/1
refs/changes/96/57496/2
refs/changes/96/69796/1
refs/changes/96/69796/2
refs/changes/96/71696/1
refs/changes/96/71696/2
refs/changes/97/40197/1
refs/changes/97/40197/2
refs/changes/97/40197/3
refs/changes/97/40197/4
...
refs/changes/97/71697/2
refs/changes/97/71697/3
refs/changes/98/47298/1
refs/changes/98/47298/2
refs/changes/98/47298/3
refs/changes/98/57298/1
refs/changes/98/57298/2
refs/changes/98/73598/1
refs/changes/99/44099/1
refs/changes/99/69299/1


Is it possible to specify a refspec such that all of these will be
fetched? I tried doing

+refs/changes/*:refs/changes/*

but this doesn't work since the * can only be one portion of a refspec

The problem is that I would like to be able to pull all of these
changes in a git mirror so that I can reduce network traffic I use to
the gerrit server, by updating my local copy once and using the local
copy on the other tasks I need. This is necessary since the gerrit
server is (a) far away and (b) closes my connection when I have too
many requests.

But, git clone --mirror and git fetch have failed to pull every ref,
and only end up with heads and tags.

Regards,
Jake
