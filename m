From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 17/20] transport-helper: change import semantics
Date: Sun, 19 Jun 2011 18:38:23 -0500
Message-ID: <20110619233822.GJ23893@elie>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-18-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 01:38:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYRZa-000392-Lk
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 01:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab1FSXi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 19:38:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45595 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab1FSXi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 19:38:28 -0400
Received: by iyb12 with SMTP id 12so1531544iyb.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 16:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vi9c/42yeujiLRIouz4MS4atf2g3LGHqNv6jW3ZcC2o=;
        b=v/xrOiKyR3Q0bvPyn9qQuSMHcmZ08gOtQ2EhcguuoS4c8uv+4DlQ5jVopMbZuRVk5O
         RMMKCy4HtGHpuiEhLx0nunXDXFjZkxjGvN42JVaeAAr3wYNFtg3AcDBFBZfFlh6GsXQD
         7tgkvj4oFTaSU2I66hP8+LxvQ6LfXrDHSfB+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HjnWwr01Mc22HZfoQJAoV2X305WsslHbk7n3Q11s82TWi36zosjpK7vfTqTpB+rZZT
         Rt+zEbS9kEqmG2UqJbYkRe1QkjFCvNCX5qLcbqjK+Lt3JpHVcSwgMcVczp/8Em6WqPxG
         lqnUsabb7Jy704gioqkv/m5qWHQtNwv3tbtjE=
Received: by 10.231.64.148 with SMTP id e20mr4726732ibi.91.1308526708149;
        Sun, 19 Jun 2011 16:38:28 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.ameritech.net [69.209.50.158])
        by mx.google.com with ESMTPS id fw9sm2802533ibb.13.2011.06.19.16.38.26
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 16:38:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308496725-22329-18-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176041>

Sverre Rabbelier wrote:

> Change the semantics of the import statement such that it matches
> that of the list statement. That is, 'import\n' is followed by a list
> of refs that should be exported, followed by '\n'.

I think that for learnability, it would be better to use

	import <ref>
	import <ref>
	...
	[blank line]

since that is consistent with "fetch" and "push".  I'll try mocking up
a patch for that tonight.
