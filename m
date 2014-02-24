From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git am and mangled subject lines
Date: Mon, 24 Feb 2014 12:05:56 -0800
Message-ID: <20140224200556.GH7855@google.com>
References: <530B9D50.6020705@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:06:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1mz-00019g-RY
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbaBXUGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:06:04 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:46602 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbaBXUGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:06:03 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so2823518pbc.7
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 12:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1hZJNm6tspXi9mBdgLr5Y/wOxUVC8rc7F9s+1LU5QK8=;
        b=yqlUaxLQkDVIfKN2KjZiDFmMpNaVTC6yVTF6i8QmtbgplOsP6ln3lxFEGCOfiAM8XX
         Sjmj+rCz02XkopZ8wvPR/GHT8onwfmofIajH3CuS3zn6fSu9ofItjPp24han6/TeRbv6
         j+8fAkQkIEZWCibL1F+V4hhqIeW2H2QJylknBMyMQqKb55v8Krs0if7yPKGZirX5+sqd
         FNWWsQhgN+LgLl38UnPStkrYktTBZMP76VPWBp4elMogSvJRWKcMiNIAMv4nKC9OG6qb
         LUMBNcWwkFIdsFdHb+eMJ3gyEQwA85ZXn2iojy2d0oiaZ9R7fKjN9lNR26sqxgnK8zJP
         hEZg==
X-Received: by 10.67.12.171 with SMTP id er11mr27521963pad.123.1393272359622;
        Mon, 24 Feb 2014 12:05:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dk1sm2761934pbc.46.2014.02.24.12.05.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Feb 2014 12:05:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <530B9D50.6020705@ubuntu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242637>

Hi Phillip,

Phillip Susi wrote:

> git am already ignores the "[PATCH X/Y]" prefix that format-patch
> adds.  Is it possible to get it to ignore any additional prefix that a
> bug tracker mangles into the subject line?  i.e. "bug #nnnn:"?

builtin/mailinfo.c is the place to start (see git-mailinfo(1)).
This is a little tricky because some people *like* the "bug #nnnn:"
in the subject line for a commit.

Hope that helps,
Jonathan
