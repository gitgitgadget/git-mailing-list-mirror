From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Using clean/smudge filters with difftool
Date: Thu, 18 Jun 2015 14:31:27 +0200
Message-ID: <5582BA1F.1030409@drmicha.warpmail.net>
References: <CAGA3++LiX9NyK94RPiuiG83X8FSRN4EkaxMchir51hGSQY90Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Florian Aspart <florian.aspart@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 14:31:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Yyl-0003nb-4X
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 14:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbbFRMba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 08:31:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58449 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753157AbbFRMb3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2015 08:31:29 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0213820BD3
	for <git@vger.kernel.org>; Thu, 18 Jun 2015 08:31:28 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 18 Jun 2015 08:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=3AbihS5oJCKOxJ8l7lGSbyDAlLg=; b=GiMhwK
	9bs5GSO76ngdLYnGoFIIOx4tCHcYfuts/e7Y0NzbhbbmqiAHh7UDVxjHRwBO5iz1
	o+8dmgo8pkNnvTlZLfCkaUViDoLnhWhH4byBbvyE96aXRK+LMFaIh07meVM+Id9d
	MDTqfwqEJ8d84NtnLZ24RxDqoCgOX6jceqhbg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=3AbihS5oJCKOxJ8
	l7lGSbyDAlLg=; b=VY8RNab0DXRdBNXnHy53aV03633miTl5zyRpT6wbRAyAuqB
	/RKJYCR9V2yfL+kcIGtOdEMLgk8bFNXAQFmZDV+t2KDZ6evJDI2ZMvv9ZkfPW8kr
	Dhs3xo9IkVDAS3f3jkoUOzJeLAZFY4MZtiDDGxuzpkCi9+9S6aAPUozAfFlw=
X-Sasl-enc: iUUeNtLoQDq6ERPW0h0Q1n/HxanTmzCsdDglU++46yQc 1434630688
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7D831C00018;
	Thu, 18 Jun 2015 08:31:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAGA3++LiX9NyK94RPiuiG83X8FSRN4EkaxMchir51hGSQY90Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272004>

Florian Aspart venit, vidit, dixit 16.06.2015 16:11:
> Hi everyone,
> 
> I created a clean filter to apply on some files before commiting them.
> The filter works correctly when I commit the file and is also applied
> when I usethe iff command line tool.
> However, when using difftool with meld, the filter is not applied and
> the different versions of the files are compared without any
> filtering.
> 
> Is there a way to apply the clean/smudge filters when comparing the
> working copy of a file to the HEAD version in a gui diff tool?
> 
> I'm using git version 2.4.3 under Ubuntu.
> 
> Best,
> Florian

Are you saying that "difftool" compares an uncleaned working tree file
with a cleaned blob? That would be a bug in either difftool or the way
we feed difftool.

Michael
