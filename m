From: kevin molcard <kev2041@gmail.com>
Subject: Re: [git-users] Git clone fails with "bad pack header", how to get
 remote log
Date: Tue, 30 Oct 2012 08:01:12 +0100
Message-ID: <508F7B38.5020603@gmail.com>
References: <7f498800-ed38-474d-86ad-cb937be68173@googlegroups.com> <20121029211854.b58c791d30a6c8d68665e574@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git-users@googlegroups.com, git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 08:01:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT5pK-0007Kc-4b
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 08:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab2J3HBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 03:01:18 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:39046 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab2J3HBR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 03:01:17 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2767255wey.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CqDex+otVjZViQUWdXPWhPEpnYb/3eUHZCAF+WBVP5E=;
        b=0UVA/eOWt/U/GQ/bLIoOnOYQsWmmxUgXbbu/xPYZHRP0IWJ+amn21ENFDnV9IpoEL+
         Ba1NM46J4nqvr8bdUdg05vVYEnbCGXW4M7mgXg8xvXYjVq0X2dIeJ0u2w9PsOvZ8uOWY
         IJm8JfVPXg/NVMYyHyzcwc10oLMrAwt3lk3NG5efC3m3amk/HqyZfAuNsCe4UqGQF4xy
         x9R+hsMc1uFZLfurXYd4m/+TekuUVLI9ncAeraP9G6vnjqeBVumd8G1xYsQghPXrBKlu
         SZM4yZ8fBdJld2RKZqeBo5GYNhpT8V8p7Vf5be5pT/IVcl5Cg6VrnIoatdr0nl0ca9Bs
         8X9Q==
Received: by 10.216.213.152 with SMTP id a24mr17986864wep.224.1351580475978;
        Tue, 30 Oct 2012 00:01:15 -0700 (PDT)
Received: from md009.arturia.lan (mey38-2-82-228-181-124.fbx.proxad.net. [82.228.181.124])
        by mx.google.com with ESMTPS id fg6sm5052393wib.3.2012.10.30.00.01.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 00:01:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20121005 Thunderbird/16.0
In-Reply-To: <20121029211854.b58c791d30a6c8d68665e574@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208682>

Hi Konstantin,

thanks for the reply.
The versions of git are:
- on remote: 1.5.6.5
- on windows build machine: 1.7.11.msysgit.1
- on mac build machine: 1.7.3.4

I will try to install latest git version on my remote server and get 
back to you.

thanks again
Kevin

On 10/29/12 6:18 PM, Konstantin Khomoutov wrote:
> On Mon, 29 Oct 2012 09:52:54 -0700 (PDT)
> Kevin Molcard <kev2041@gmail.com> wrote:
>
>> I have a problem with my build system.
>>
>> I have a remote server with a relatively large repository (around 12
>> GB, each branch having a size of 3 GB).
>>
>> I have also 2 build servers (Mac, Windows) that are cloning the repo
>> from the remote.
>>
>> Sometimes (very often when several git clone are sent at the same
>> time), I have the following error:
>>          
>>      remote: internal server error
>>      fatal: protocol error: bad pack header
>>
>> I know that it happens when the remote is compressing objects (thanks
>> to `--progress -v` flags) because the last line of the log before the
>> erro is:
>>      remote: Compressing objects:  93% (17959/19284)   [K
>>
>>   * So I have 2 questions, does anybody what is the problem and what
>> should I do?
>>   * Is there a way to get a more precise log from the remote to debug
>> this problem?
> This reminds me of a bug fixed in 1.7.12.1 [1]:
>
> * When "git push" triggered the automatic gc on the receiving end, a
>    message from "git prune" that said it was removing cruft leaked to
>    the standard output, breaking the communication protocol.
>
> In any case, bugs should be reported to the main Git list (which is
> git at vger.kernel.org), not here.
> I'm Cc'ing the main Git list so you'll get any responses from there, if
> any.
>
> Kevin, please answer to this message (keeping all the Ccs -- use "Reply
> to group" or "Reply to all" in your MUA) and describe exactly what Git
> versions on which platforms your have.
>
> 1. https://raw.github.com/git/git/master/Documentation/RelNotes/1.7.12.1.txt
>
