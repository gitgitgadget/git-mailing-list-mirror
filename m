From: Andrew Myrick <amyrick@apple.com>
Subject: Re: [PATCH] git-svn: persistent memoization
Date: Mon, 1 Feb 2010 08:44:43 -0800
Message-ID: <49FDA6F7-21D8-4280-A6A7-80EC2F749EA9@apple.com>
References: <1264821262-28322-1-git-send-email-amyrick@apple.com> <20100201040312.GA26199@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v1133)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sam@vilain.net
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 17:45:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbzOb-0000I2-RG
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 17:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab0BAQoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 11:44:54 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:51273 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab0BAQox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2010 11:44:53 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id CA970899F37C;
	Mon,  1 Feb 2010 08:44:51 -0800 (PST)
X-AuditID: 11807130-b7b0aae00000102c-89-4b6704fc198f
Received: from [17.151.96.165] (Unknown_Domain [17.151.96.165])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay11.apple.com (Apple SCV relay) with SMTP id 45.17.04140.205076B4; Mon,  1 Feb 2010 08:44:51 -0800 (PST)
In-Reply-To: <20100201040312.GA26199@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1133)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138625>


On Jan 31, 2010, at 8:03 PM, Eric Wong wrote:

> Andrew Myrick <amyrick@apple.com> wrote:
>> Make memoization of the svn:mergeinfo processing functions persistent with
>> Memoize::Storable so that the memoization tables don't need to be regenerated
>> every time the user runs git-svn fetch.
>> 
>> The Memoize::Storable hashes are stored in ENV{GIT_DIR}/svn/caches.
> 
> Hi Andrew,
> 
> Perhaps "$ENV{GIT_DIR}/svn/.caches" is better here since older versions
> of git svn used "$ENV{GIT_DIR}/svn/$refname" in the top-level and
> "caches" may conflict with existing repos.
> 
>> -use File::Path qw/mkpath/;
>> +use File::Path qw/mkpath make_path/;
> 
> File::Path::make_path is very recent not in Perls distributed by most
> vendors.  My 5.10.0 installation (Debian stable) doesn't have it, and I
> also don't see a good reason to use it over the traditional mkpath.
> 
> I think I'll squash the following patch and Ack.  Let me know if
> you have any objections, thanks.!
> (also wraps long lines to 80 chars)

Makes sense to me.  Thanks, Eric.

-Andrew
