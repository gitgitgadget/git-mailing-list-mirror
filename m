From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2 v2] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 21:56:04 -0800
Message-ID: <20130211055604.GE15329@elie.Belkin>
References: <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
 <20130211043322.GA12735@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 06:56:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mNp-0008P5-Eu
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 06:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910Ab3BKF4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 00:56:13 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:56527 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3BKF4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 00:56:12 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so2630951dan.23
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 21:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FemhHuWSK1GyZfoLmrt3orsj2vQECt3P+xdOTd14e8Y=;
        b=CxBndBBov29vNEJHdUytb4uyLxI4c25QLz596XkaotDU4yuKMAdq20SHeJAs5pvOIy
         bKsDw9TQuYP7MYoWkATc1pCXP3NMaYLTxmrRMDQCt4AwvukbeJCJYf7vl7Fio/Z0Z2jY
         fv04FXoWYGoCRSP5uFbVEZ1Cq1khcYccA3pvEGIUGSiZCmTI+Jr1tPYOwTFqEsMygqh9
         3GMhFfKT7EeQa7Kp4gIX2+RiEgomw4/n3USRIqD8Zw4NS6RunsJuBJtyhrh9nQzczvXR
         ytLQ+ncccgA4GNlTZ5xi7I1c0VfR09gq4zLcCTu9RcDDbzrxGc7LVP9e9BgVqyW5+y+C
         jGMA==
X-Received: by 10.68.195.41 with SMTP id ib9mr16087631pbc.151.1360562172095;
        Sun, 10 Feb 2013 21:56:12 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id iw8sm6582412pbc.15.2013.02.10.21.56.09
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 21:56:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130211043322.GA12735@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215993>

Jeff King wrote:

> I think what threw me off was reading the documentation part of the
> patch, which adds a note that we run "help" on startup, and then
> elaborates on the exit value. I didn't realize that the first half was
> documenting what already happened.
>
> Tweaking the third paragraph of the commit message to:

Very nice.  How about this version?

Jonathan Nieder (2):
  shell doc: emphasize purpose and security guarantees
  shell: pay attention to exit status from 'help' command

 Documentation/git-shell.txt | 86 +++++++++++++++++++++++++++++++++++++--------
 shell.c                     | 10 ++++--
 2 files changed, 79 insertions(+), 17 deletions(-)
