From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] Replace ce_namelen() with a ce_namelen field
Date: Wed, 4 Jul 2012 17:01:49 +0700
Message-ID: <CACsJy8BjfJa5VWusARkP4g5h_BTHywMiwzmtd5b9S4Cpf7g30Q@mail.gmail.com>
References: <1341393528-21037-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 12:02:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmMPk-0008Ek-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 12:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933797Ab2GDKCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 06:02:23 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62493 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933624Ab2GDKCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 06:02:21 -0400
Received: by wgbdr13 with SMTP id dr13so7194994wgb.1
        for <git@vger.kernel.org>; Wed, 04 Jul 2012 03:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HmOTWBlAPFwAc1ZggLZ2ZBd/85C+fW76ez/uez7EWcE=;
        b=THNXtbNzcQ04eH/UDtHPbohBDlhde5qWujAiixvq1pBzdTukapLVK1g0JJ9yc8B+1x
         Ie0DKtuGPL0DwmLKTC4tUpK0JJTJ67ZyYtL6pAPuEz4lExarleUdrZ2Rqmr1qnS2lzFo
         llk8s9Q7dVfQ3Nnp7y2Zzk4X2Jqz5CgPkpwaal4G6nGErCg0ij00bJVQkMsGH/htgeJa
         xYQR4GeDku69kjTl2jfXiZs6aSq6G7ddKYcZc2TNQGx/Ipyb77r4Vhf/PUqKhT8SJLVA
         y4EhbF9qfOngTgzWLv6ErDm4AurAh8r1KpNtGtN63L/OX6zuJj5hl8exHo12lbkP5kBc
         kwyA==
Received: by 10.216.27.207 with SMTP id e57mr5719672wea.197.1341396139534;
 Wed, 04 Jul 2012 03:02:19 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Wed, 4 Jul 2012 03:01:49 -0700 (PDT)
In-Reply-To: <1341393528-21037-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201000>

On Wed, Jul 4, 2012 at 4:18 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Replace the ce_namelen() function in cache.h with a ce_namelen
> field in struct cache_entry. This will both give us a tiny bit
> of a performance enhancement when working with long pathnames
> and is part of the refactoring for the index-v5 file format.

Can we just wrap ce->namelen in ce_namelen() instead? Less changes
this way. We can do the replacement once v5 patches come.

static inline int ce_namelen(struct cache_entry *ce)
{
   return ce->namelen;
}

something like that.
-- 
Duy
