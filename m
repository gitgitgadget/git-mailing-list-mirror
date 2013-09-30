From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase -i: respect to core.abbrev
Date: Mon, 30 Sep 2013 14:36:05 -0700
Message-ID: <20130930213605.GZ9464@google.com>
References: <1380384435-20846-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20130928211013.54361E0090@blue.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
X-From: git-owner@vger.kernel.org Mon Sep 30 23:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQl8Z-0006ON-IJ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 23:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab3I3VgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 17:36:11 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60203 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415Ab3I3VgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 17:36:10 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so6154433pbc.29
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=e0Atc9EQR1fvmC52ZI5LdOBn2bghdmr5kJJ+609h3/g=;
        b=KbtIwvxjsx7lEG1HlNJcgHBQRJRC0RjN/GdyIUmcNKyMTUvqX6PChcsJGwcmFM0ob7
         xosyuvLB/0kv/QkRQKXrPIqE6Z0Qf+0C0dPK/j8xB+yXTZRyonzrtxeaayNy9LPS0Klv
         Q9LQZqY5rgcXx6kCXnjtLbnz3TzkloSllaG+q9SAHfXBCE8bgFKgEVGemgbbyFnChEJB
         kIEqaj2fal7skTx4VJ6TdjDTQ0lywUW2ix1bu2ixa3b0LcPyUxK2oN9G9p3ew9wMFD64
         fk/ga5MOm9tBu9P+SWxDThWUeV3eMzooKUc61Ag9qs5e0j5hQyJA/KrGzGChg8yIB9h0
         OtBQ==
X-Received: by 10.66.140.40 with SMTP id rd8mr30221950pab.119.1380576969966;
        Mon, 30 Sep 2013 14:36:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id im2sm2671739pbd.31.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 14:36:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130928211013.54361E0090@blue.fi.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235630>

Kirill A. Shutemov wrote:

> collapse_todo_ids() uses `git rev-parse --short=7' to abbrev commit ids.
> Let's drop argument from --short to use default (7) or config value
> instead.

Since the todo ids are expanded immediately after the editor exits,
there is not much risk of accidental hash collision due to new
objects, so this should be safe.

Thanks, both.
