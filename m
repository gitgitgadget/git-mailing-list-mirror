From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Thu, 22 Nov 2007 07:13:50 +0100
Message-ID: <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de>
References: <11956768414090-git-send-email-prohaska@zib.de> <11956768412804-git-send-email-prohaska@zib.de> <11956768413887-git-send-email-prohaska@zib.de> <11956768412755-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0711220121560.27959@racer.site> <7v63zv9fel.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 07:13:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv5JA-0000Sw-No
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 07:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbXKVGMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 01:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbXKVGMn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 01:12:43 -0500
Received: from mailer.zib.de ([130.73.108.11]:51045 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbXKVGMn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 01:12:43 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAM6CbjW025324;
	Thu, 22 Nov 2007 07:12:38 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1bcfd.pool.einsundeins.de [77.177.188.253])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAM6CaJX016383
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 22 Nov 2007 07:12:36 +0100 (MET)
In-Reply-To: <7v63zv9fel.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65742>


On Nov 22, 2007, at 3:34 AM, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Hi,
>>
>> On Wed, 21 Nov 2007, Steffen Prohaska wrote:
>>
>>> We have a function set_git_dir().  So let's use it, instead of  
>>> setting
>>> the evironment directly.
>>
>> Does this not have a fundamental issue?  When you call other git  
>> programs
>> with run_command(), you _need_ GIT_DIR to be set, no?
>
> It is much worse.  set_git_dir() does not just setenv() but does
> setup_git_env() as well.

What do your comments mean?

My understanding is that set_git_dir() sets the environment and
then calls setup_git_env() to cache all pointers.  This call
updates dangling pointer if they have been cached earlier.

But maybe there is a hidden secret that I don't see.

	Steffen
