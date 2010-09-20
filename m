From: Kevin Ballard <kevin@sb.org>
Subject: Re: Reduced privileges install
Date: Sun, 19 Sep 2010 23:51:54 -0700
Message-ID: <677DFF75-2DBB-4772-802B-4402E4024307@sb.org>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> <86k4mhfcj1.fsf@red.stonehenge.com> <6BE502C9-5507-452D-A5D5-D0C69C05F126@kellerfarm.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 08:52:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxaEN-0000Gd-Pr
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 08:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab0ITGv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 02:51:57 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:47242 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab0ITGv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 02:51:56 -0400
Received: by pxi10 with SMTP id 10so1060761pxi.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 23:51:56 -0700 (PDT)
Received: by 10.142.69.1 with SMTP id r1mr7324009wfa.119.1284965516418;
        Sun, 19 Sep 2010 23:51:56 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id v6sm761760wfg.3.2010.09.19.23.51.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 23:51:55 -0700 (PDT)
In-Reply-To: <6BE502C9-5507-452D-A5D5-D0C69C05F126@kellerfarm.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156552>

On Sep 19, 2010, at 6:31 PM, Andrew Keller wrote:

> On Sep 19, 2010, at 9:07 PM, Randal L. Schwartz wrote:
>> "Andrew" == Andrew Keller <andrew@kellerfarm.com> writes:
>> 
>>> Because I do not own the server and my account has restricted privileges, I attempted to augment my PATH to include a directory in my home folder, and then install git in there by specifying a prefix at the configure stage.  The configure and the make work, but the make install fails.  Here's the last section of the log:
>> 
>> What's your PREFIX set to?  If you set your prefix, the Perl modules are installed below the prefix, not in the system dirs.
> 
> 
> Here's what I executed:
> 
> $ ./configure --prefix=/usr/users/students/ak4390/.local
> $ make
> $ make install
> 
> I also tried providing the --oldincludedir and --datadir parameters, but I got the same result.

I admit, I'm not well-versed on the build system, but my impression was that specifying --prefix in ./configure was indeed supposed to propagate to a subsequent make and make install. However, you may wish to attempt the following to be sure:

$ make PREFIX=/usr/users/students/ak4390/.local
$ make install PREFIX=/usr/users/students/ak4390/.local

-Kevin Ballard