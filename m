From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: pack v4 trees with a canonical base
Date: Tue, 10 Sep 2013 07:52:15 +0700
Message-ID: <CACsJy8C+SFBRD1czeeK5VBDYT4xA6K+61HgLRnjB+CYJ-2g+uA@mail.gmail.com>
References: <alpine.LFD.2.03.1309091517380.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 02:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJCCI-00046t-DW
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 02:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab3IJAwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 20:52:46 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:43479 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203Ab3IJAwq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 20:52:46 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so7165525oag.40
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O7hMqChrYhy1we9CDZHTivMU9YpDuFlWAumtfcvJ6KA=;
        b=zYn1gBNJBUughJGuDyHJmYNP5nFLZNrfPloC/4BkOXvVJ4jDCAZB6PLQVLbZlrsDBc
         4QEHnBzfN2anNmb2cDxNyqlbLful7kzaReNXFxjhx2kcfcdKZdN2J5IrkrMCvqjW/9dN
         arcnoLj50b37RSPF7mVIYSYdIvz3CRiF6x8OxY/Pp8VXwzC8PHBJYH9xnXJ2/9jzFFvr
         fe9/96HW4JPN4M5JF2mB+Ke/Iug3revjCQBbUdLPSjTfYZJxZNQK0WFA3m6YTUmFZVrL
         yiJc6+t165jhJJvKbjGj+24IPN2yRcYrEC0pwmkVKjpj/hPXd/de1SdXwsun0FgiiOmq
         XwvA==
X-Received: by 10.182.75.201 with SMTP id e9mr576483obw.28.1378774365544; Mon,
 09 Sep 2013 17:52:45 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Mon, 9 Sep 2013 17:52:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309091517380.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234405>

On Tue, Sep 10, 2013 at 2:25 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> An eventual optimization to index-pack when completing a pack would be
> to attempt the encoding of appended tree objects into the packv4 format
> using the existing dictionary table in the pack, and fall back to the
> canonical format if that table doesn't have all the necessary elements.

Yeah, it's on the improvement todo list. The way pack-objects creates
dictionaries right now, the tree dict should contain all elements the
base trees need so fall back is only necessary when trees are have
extra zeros in mode field.
-- 
Duy
