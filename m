From: Brad King <brad.king@kitware.com>
Subject: Re: serving git with both "git:" and "http:" and submodules
Date: Thu, 15 Jul 2010 10:07:19 -0400
Message-ID: <4C3F1617.7020706@kitware.com>
References: <4C3DD7EF.6010805@panasas.com> <20100714153900.GB1583@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 16:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZPEN-0006U3-Uq
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 16:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297Ab0GOOQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 10:16:01 -0400
Received: from public.kitware.com ([66.194.253.19]:37515 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282Ab0GOOQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 10:16:00 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jul 2010 10:16:00 EDT
Received: by public.kitware.com (Postfix, from userid 5001)
	id 945A91A46E; Thu, 15 Jul 2010 10:07:20 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on public.kitware.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id ACBBD1A46B;
	Thu, 15 Jul 2010 10:07:19 -0400 (EDT)
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id 8EAE6E75C8;
	Thu, 15 Jul 2010 10:07:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
In-Reply-To: <20100714153900.GB1583@burratino>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151081>

On 07/14/2010 11:39 AM, Jonathan Nieder wrote:
> Boaz Harrosh wrote:
>> So my question is: Can I automate this so people with "http:"
>> clones are not forced to manually edit their config files?

Almost.

> Of course, even this would not make
> 'git clone --recursive http://my-domain.org/trees/my-tree/.git'
> work.

Firewall-ed users can just run

$ git config --global url.http://my-domain.org/.insteadOf git://my-domain.org/

*once* per user per machine, or even

$ git config --global url.http.insteadOf git

if they want to be really aggressive.  After that they can just
pretend to use the git protocol and all URLs will be mapped under
the hood:

  git clone --recursive git://my-domain.org/...

-Brad
