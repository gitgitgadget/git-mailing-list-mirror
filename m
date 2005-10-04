From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Tue, 04 Oct 2005 07:06:29 -0700
Message-ID: <43428C65.3040205@zytor.com>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 16:09:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMnRX-00051u-Qm
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 16:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVJDOGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 10:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVJDOGx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 10:06:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:49337 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932460AbVJDOGw
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 10:06:52 -0400
Received: from [172.27.3.248] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j94E6TNF026154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Oct 2005 07:06:31 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9678>

Alex Riesen wrote:
> 
> I noticed that rename(2) in my copy of cygwin (1.5.18-1) does not remove the
> target and returns an error (probably EPERM, but I have reasons not to trust
> strerror on that thing).
> The repository was on FAT.
> Taking "rename(2)" from cygwin's libiberty solved this (they unlink if link(2)
> returns EEXIST).
> 
> PS: Does broken rename(2) qualify a system "not worthy to support"?

In this case a better way would be to just add -liberty to all link 
lines if necessary, but I would expect the core cygwin code to do this.

	-hpa
