From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are
 pending
Date: Wed, 27 Jul 2011 07:17:55 +0200
Message-ID: <20110727051755.GK18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 07:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlwVY-0006mC-Iv
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 07:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab1G0FSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 01:18:08 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63463 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab1G0FSG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 01:18:06 -0400
Received: by ewy4 with SMTP id 4so1044971ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 22:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=U8L3fD7J651FBOtsONt044092a7A+xnq1hwAJ5SpzsQ=;
        b=psoWcvsDa6LUDbJN+5T2MVzI3RhUqvi5Jlo1mHcyopbbB1fCztdI7N/EJS54VhA4/2
         uqI2rJnFU/cm4WIpAoM5zUDIPalr3UfEQBFABtfP0wJhsxz4T4zh+BbWUZ7KawXekZBQ
         9O0koZsn3mAt5GygBYSovFilQcj00+zfKzL8k=
Received: by 10.213.9.146 with SMTP id l18mr1355546ebl.77.1311743885134;
        Tue, 26 Jul 2011 22:18:05 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id e45sm831430eeb.45.2011.07.26.22.18.02
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 22:18:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-17-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177933>

Ramkumar Ramachandra wrote:

> Change this so that the sequencer state is cleared when a conflict is
> encountered in the last commit.

This defeats the point of keeping a ".git/sequencer/head" file.  Why
not remove the cherry-pick state when it is known no longer to be needed,
namely after the conflict resolution is commited?
