From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] bisect: avoid pipes to better catch "git rev-list" errors
Date: Fri, 10 Apr 2009 09:34:36 +0900
Message-ID: <20090410093436.6117@nanako3.lavabit.com>
References: <20090329115832.28acd74e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 02:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls4kX-0007hz-B6
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 02:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbZDJAf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 20:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765453AbZDJAf0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 20:35:26 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56659 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764572AbZDJAfX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 20:35:23 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 02B9411B8B9;
	Thu,  9 Apr 2009 19:35:23 -0500 (CDT)
Received: from 1828.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id JVG8GJYUYTAQ; Thu, 09 Apr 2009 19:35:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=hyMihCKlDIcVkpAHMNebgaBVHpPoj5DoPU6KuZqQr7cl/BREcx6oN0LrKpiDeUbz94HJpiSQlpIRLGERokgdWzbdO49WfV2u6XnfQEe9siFwp8zHuJzpMSjcu4C1X6lekruRGevrLVQ9jj96axlAnxAG7Jqgg0s7miBS1lU1Ogc=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090329115832.28acd74e.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116226>

Quoting Christian Couder:

> When doing:
> 
> eval "git rev-list --bisect-vars ..." | {
>         while read line
>         do
>                 echo "$line &&"
>         done
>         echo ':'
> }
> 
> the result code comes from the last "echo ':'", not from running
> "git rev-list --bisect-vars ...".
> 
> This means that we may miss errors from "git rev-list".
> 
> To fix that, this patch gets rid of the pipes by redirecting the
> output of "git rev-list" into a file, and then reading from this
> file.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Junio, may I ask what happened to this patch?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
