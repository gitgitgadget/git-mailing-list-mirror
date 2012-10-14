From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] config: treat user and xdg config permission
 problems as errors
Date: Sun, 14 Oct 2012 01:42:44 -0700
Message-ID: <20121014084244.GA7190@elie.Belkin>
References: <20121014000210.GA19094@elie.Belkin>
 <20121014000402.GB11399@elie.Belkin>
 <20121014062218.GB13477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 10:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNJn3-0001c7-R8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 10:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab2JNIm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 04:42:58 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47870 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2JNIm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 04:42:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3990359pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=l+++Na0h5TzhHqxBlhgT6I+BB2Iw3hsoq3FhTeg7G+o=;
        b=HfgphbHNfQOxnZ0jfkN+quCkYvhRSSc3q7OsMQYDtDiY6IJGuPZOWTYR6lT53+Q8BA
         ayZzVDGNmJ9XUo6sGzlKQFQ6ZuyUpamRNKMaOi2ACvoPGrdgbYNBzPNr9Dt6WLi7wS6w
         HMI3OrUejNdJTDlgBlQjEgD3tnyUEFeVFdsRAnsLb4SDct0912H7gYkXqZSPpkmA1jqu
         ktEYMPiBIvBKHUex4f2fTKu88mdmcve5LKJbLwpGi8eQRoZK+CDHQX0Cs18iE3u0Yptl
         Km9TGweo5jjD+wqSRLdGhhUcrJNkqSOd62oAhAbOCUUk0KkTFmHLo43rZq2tlt8w70PP
         rKyQ==
Received: by 10.68.233.136 with SMTP id tw8mr27769661pbc.133.1350204176143;
        Sun, 14 Oct 2012 01:42:56 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id sj5sm7211788pbc.30.2012.10.14.01.42.55
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 01:42:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121014062218.GB13477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207645>

Jeff King wrote:

> For example, servers may depend on /etc/gitconfig to enforce security
> policy (e.g., setting transfer.fsckObjects or receive.deny*). Perhaps
> our default should be safe, and people can use GIT_CONFIG_NOSYSTEM to
> work around a broken machine.

Very good point.  How about these patches on top?

Jonathan Nieder (2):
  config doc: advertise GIT_CONFIG_NOSYSTEM
  config: exit on error accessing any config file

 Documentation/git-config.txt | 8 ++++++++
 config.c                     | 6 +++---
 2 files changed, 11 insertions(+), 3 deletions(-)
