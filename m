From: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: Announcement of git-remote-gcrypt (A custom encrypted remote format)
Date: Wed, 6 Feb 2013 19:19:39 +0100
Message-ID: <CAPQrgXuuGfrskLpdrVgCXD6RLurtBQxJHKdSzFeJd30gVpGXPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 19:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39bH-0005jO-SO
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab3BFSTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:19:41 -0500
Received: from mail-qa0-f51.google.com ([209.85.216.51]:39353 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab3BFSTk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:19:40 -0500
Received: by mail-qa0-f51.google.com with SMTP id cr7so792935qab.17
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 10:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=LCXr/DtMYNJifkTdJ1yP891+AUj1a2VY8r0/hxemtS0=;
        b=FbKSsiE3AYaWHUUTCIyrWo/mFlNtXTDqJ/wU3eByaFVW53u+pLz4IDg5WZ74ovrruX
         kcHnMUP7YuZEyh4tpug7C+oFd47EFTqBlaT8FdMH/gOguAYCyLaEphXu7bayyh5kg2cG
         DtRaAXhmZeFDm0WnZdhF7pp5ImNt2qYshd7UKsheVaxNN7FdTfmNY4jmjpAAewS5vKEV
         795AsbCKtfSoKZVGVMZP0TLhetmuhKEMku34cMgtkfGuzHT7xgs3acPHKdG8AXc41Qgv
         K5JnJnpAQ5Kz2z1HL+1dL0z/kwnNNyWd15s82Ewc8u8wJc1f6foVGxYuxhwgGnJwQ8oK
         up1w==
X-Received: by 10.49.16.9 with SMTP id b9mr24892927qed.16.1360174779370; Wed,
 06 Feb 2013 10:19:39 -0800 (PST)
Received: by 10.49.117.135 with HTTP; Wed, 6 Feb 2013 10:19:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215614>

Hi,

git-remote-gcrypt is a remote helper for git that (ab)uses this format
to make it possible to push, pull and clone directly to and from a
custom encrypted repository format. Available from::

     https://github.com/blake2-ppc/git-remote-gcrypt

It is relatively simple, and hopefully the protocol is sound and
secure; it uses GPG and allows multiple participants to possibly
collaborate using an untrusted and even public host. The git-on-git
backend is experimental and probably buggy, but it works.

The format intentionally targets mainly dumb hosts such as various
bulk storage providers and therefore there is nothing smart about the
protocol; when fetching we can do no better than downloading every new
packfile.

I hope it interests someone, and maybe it even reaches the target of
being both usable and secure. It also helps me if you point out
if/how/why it is broken(!).

-ulrik
