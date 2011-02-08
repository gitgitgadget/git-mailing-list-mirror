From: Kevin Ballard <kevin@sb.org>
Subject: Re: Git describe finding wrong tag
Date: Mon, 7 Feb 2011 23:23:15 -0800
Message-ID: <9FE24A31-F654-4F1D-B36B-28F506B79C63@sb.org>
References: <A76F5A9B-6E22-40D5-A8C9-C471A22DF1BE@sb.org> <4D50EE88.8070005@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 08:23:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmhv8-0000Z6-4z
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 08:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab1BHHXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 02:23:18 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:38281 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1BHHXS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 02:23:18 -0500
Received: by pxi15 with SMTP id 15so1069638pxi.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 23:23:17 -0800 (PST)
Received: by 10.142.141.13 with SMTP id o13mr868699wfd.20.1297149797572;
        Mon, 07 Feb 2011 23:23:17 -0800 (PST)
Received: from [10.0.1.14] (c-69-181-71-253.hsd1.ca.comcast.net [69.181.71.253])
        by mx.google.com with ESMTPS id w42sm7148193wfh.15.2011.02.07.23.23.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 23:23:16 -0800 (PST)
In-Reply-To: <4D50EE88.8070005@viscovery.net>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166335>

On Feb 7, 2011, at 11:19 PM, Johannes Sixt wrote:

> Am 2/8/2011 5:46, schrieb Kevin Ballard:
>> I just encountered an odd situation where `git describe` insists on finding the
>> wrong tag. In my case, I tagged a branch, then merged it into another branch,
>> and now `git describe` in that other branch decides that it should emit a tag
>> name that's over 200 commits old rather than the one that's a single commit
>> away.
>> 
>> % git --version
>> git version 1.7.4.31.g3f8c4
>> % git describe
>> build_1.2.2_applestore_1-203-g742967b
>> % git describe HEAD^2
>> build_1.2.2
>> 
>> Is there any rational for why git-describe is opting for the much older
>> commit?
> 
> Most likely, the situation outlined in this commit message applies to your
> case:
> 
> http://git.kernel.org/?p=git/git.git;a=commit;h=80dbae03
> 
> Then what you observe is by design.

You are right, that does explain it. It feels rather odd that I can merge in
a tagged commit and have `git describe` not then use that tag, but I suppose
the new behavior makes sense.

Thanks for the explanation.

-Kevin Ballard