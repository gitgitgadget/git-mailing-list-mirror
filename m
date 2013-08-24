From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 18/24] read-cache: write index-v5
Date: Sat, 24 Aug 2013 11:07:46 +0700
Message-ID: <CACsJy8C8rpz2zNvKB_MEbUShKGMfknDO10C47y3YDV-0-hFKLg@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-19-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 06:08:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD59Y-0004pR-1J
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 06:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab3HXEIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 00:08:18 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:42680 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3HXEIR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 00:08:17 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so1465083obc.34
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xWPXGK58TN7O6fjJH36Mbq9QOHThxuy2yPM0ck1Stp0=;
        b=KauawgzB9Q6mq6JaFwl+lTffIOzfQy1IPop03mhGG1lv4pcGIRcuAxp0JoQXLTTAuL
         X3E51EbVBtwx9ASHMbqqLoi0R8qARF/CrBfjIkgtDhDe2Q3KEu52Unu612sDd4dNIuRN
         5XI9q81qfjlVSrNWuL0cWV8344JHtXPAyIfpFIPQVn9K8nLB+M9oO7wkSSW1njHZXTwi
         agZXZOdR+gJzMbmfZ7/MGhxGwT71cR6exH9V5ILu9CONGbRvF8K76MoKiGUGLMuWNEk7
         O+dk5DuVvPKTKqFJTZj/mEIXJuIhzR7790Oqq35j3Hgnq+bAKxUF7F9HVgwVAyYqDhVL
         qBDQ==
X-Received: by 10.60.56.3 with SMTP id w3mr2740877oep.37.1377317296852; Fri,
 23 Aug 2013 21:08:16 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 23 Aug 2013 21:07:46 -0700 (PDT)
In-Reply-To: <1376854933-31241-19-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232864>

On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Write the index version 5 file format to disk. This version doesn't
> write the cache-tree data and resolve-undo data to the file.

I keep having things to add after sending my emails. Now that we have
all conflicted entries in file block, the conflict data block becomes
optional, it functions exactly (I think) like resolve-undo extension,
which makes me think it might make sense to make conflict data block
an extension.

If we make it so, we might want to move "cr" and "ncr" fields out of
direntries. I don't see a solution yet, but I think it's interesting
because future extensions might want to attach stuff to direntries,
just like "cr"/"ncr" from conflict extension. We may want to think now
how that might be done (and conflict extension is a good exercise to
see how it works out)
-- 
Duy
I
