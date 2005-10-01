From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Destructive side-effect of "cg-status"
Date: Sat, 1 Oct 2005 22:24:54 +1200
Message-ID: <46a038f90510010324h65bea422tf9a519a014ed4844@mail.gmail.com>
References: <20050930160353.F025C352B7B@atlas.denx.de>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 12:25:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELeYR-0003UG-69
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 12:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVJAKY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 06:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVJAKY4
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 06:24:56 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:59844 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750786AbVJAKYz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 06:24:55 -0400
Received: by qproxy.gmail.com with SMTP id q10so59930qbq
        for <git@vger.kernel.org>; Sat, 01 Oct 2005 03:24:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KRAD9zXxJlGoPTi2BLLVCjKSdw/V6IR9q4dZ/pCysfV2RZDCsd8HKCIzTQH+NaOVb/RNNp2a5fPRXt/45o0Sai+4dJTSJkllo3TMzt0XnVR2qBplVmRsD/EBt9u99kHfdNKVTW69qVePQ1gPdS3Mp6lycMvxU4qNSryhB8w3Ev4=
Received: by 10.65.11.15 with SMTP id o15mr1433148qbi;
        Sat, 01 Oct 2005 03:24:54 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Sat, 1 Oct 2005 03:24:54 -0700 (PDT)
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050930160353.F025C352B7B@atlas.denx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9596>

On 10/1/05, Wolfgang Denk <wd@denx.de> wrote:
> So far I  thought  "cg-status"  is  a  harmless  command  which  just
> displays  some  status information. It ain't so. One of our engineers
> reported a  corrupted  repository  after  I  ran  "cg-status"  in  his
> directory:

Interesting... cg-status, and sometimes cg-diff, have to update the
index. The index is the trick behind git's performance (and some other
smarts). It's never really touched by Cogito, but by the git-*-index
commands.

Perhaps git-*-index commands should check ownership vs current uid and
print a warning?

cheers,


martin
