From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Lift --stdout restriction for using reachability bitmap in pack-objects?
Date: Wed, 18 Feb 2015 16:09:22 -0800
Message-ID: <59A24487-0FAC-4E02-B019-8EBCD9306A47@gmail.com>
References: <CACsJy8AC5ZcsB2_qS4k-+6fJt2_e7m=o8C9UAEcywh=P_4HXAw@mail.gmail.com> <20150217101344.GA5343@peff.net> <CACsJy8C=MC2xVbkXE-RBcLtcn0yEX4iqBLjgOw+M0iK5n-Kyhw@mail.gmail.com> <20150217104228.GA26301@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Vicent Marti <tanoku@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:09:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOEgN-00060g-2M
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 01:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbbBSAJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 19:09:26 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44568 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbBSAJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 19:09:26 -0500
Received: by padet14 with SMTP id et14so5022652pad.11
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 16:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=xDjk0rvJK8b1IHrsm8oIRBQID9eRh5PfVxamYLe+Gjw=;
        b=N7sOO7WprfMpvZzSPwaZYc5Dm29GaqA/SiHL9ratVOm+KyalnoaT13fiCvOTiOmGkD
         ebP0m4Gr3rtwydhDnSp+jiX4wJkEVRjYHSBR/uZcopadXwrMPgGP56siLrKxnp4L4eRV
         cyXIVDYQa2VPjnudz1uPrd6gKx4saZ3tc6xXW7LYkczyXUuA1XPRUAgjXS39iTAxcO22
         PqlD2dzb58U4fe821uioxwfUuxFWABroa6kK4B1PZ6nGXzdgjbDSKdMBsxwddtqdzKCA
         LGI1KdEq+Ype9iW4i0lOXRo7O3C9Zg6j9Z2Sy2vNUfvI6OE2Ua8znmQMWEzf7TihVvmv
         +FSQ==
X-Received: by 10.67.5.226 with SMTP id cp2mr3104391pad.122.1424304565496;
        Wed, 18 Feb 2015 16:09:25 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id nd5sm21696064pbc.64.2015.02.18.16.09.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Feb 2015 16:09:24 -0800 (PST)
In-Reply-To: <20150217104228.GA26301@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264074>

On Feb 17, 2015, at 02:42, Jeff King wrote:

> On Tue, Feb 17, 2015 at 05:36:30PM +0700, Duy Nguyen wrote:
>
>> On Tue, Feb 17, 2015 at 5:13 PM, Jeff King <peff@peff.net> wrote:
>>> If the only reason is for gdb, then perhaps:
>>>
>>>  set args pack-objects --stdout </dev/null >/dev/null
>>>
>>> in gdb would help?
>>
>> Right. I used "gdb --args command >/dev/null" instead. Stupid
>> question. Sorry for the noise.
>
> I've made the same mistake myself many times. I really wish gdb would
> interact over /dev/tty by default. The perl debugger does this, and I
> find it quite handy. But I've never managed to make gdb do it. Maybe
> there is an option I've missed[1].

You may want to try cgdb.  It is a curses front-end to gdb.  I almost  
never run bare gdb anymore.  It has a source file pane (no more line- 
by-line), a gdb pane and, although a bit clumsy, a TTY pane (not shown  
in the screen shot) that you can interact with the debuggee with.   
It's been around for a while, so debian-derived distros can usually  
just `apt-get install cgdb`.  There's a screen shot available [1].

-Kyle

[1] http://cgdb.github.io/
