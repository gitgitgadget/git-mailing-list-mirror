From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH-v2 4/4] git-commit: add a prepare-commit-msg hook
Date: Tue, 05 Feb 2008 16:16:44 +0100
Message-ID: <47A87DDC.5030708@gnu.org>
References: <1202205704-10024-1-git-send-email-bonzini@gnu.org> <1202205704-10024-4-git-send-email-bonzini@gnu.org> <alpine.LSU.1.00.0802051500190.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:17:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPYT-0004iA-DT
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbYBEPQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbYBEPQv
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:16:51 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:63956 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbYBEPQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:16:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3541074wah.23
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 07:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=R1OAcMWHniOVcUmad6CZBaMPpiXOhLK5P/qWKuJYUlg=;
        b=aejE1RBEqrfb012RSJlqzXtF5PQ/FyT7Dp6RsHw42ZhJ1tL2HiVUHRl2+fQxo3QpoSjJKN564Usr4C2x+O9EPBIpN+8753T0OX92pitRrb2DgQ45fekMYjwWAGRODsa8feSln+kpsY8fwqWpqLGzfhkwBmfmqcrVeKFuM5y8Jv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=qgvz8jKknXygM0gXR33oX54pgroXF7dh7zlad3IGqqVWH9V+6ZmIGcGPEBUYNOdGdpo6bdwO+TywI+1m+9zbe7nK9l3KOKuXjZmq2SyqFwOhAGvcCLNnzgqW0OGpUtJkR2R1SIC2Vqoh6YKY1/5h94s9DnVoDrGIbYwMLHL0sXM=
Received: by 10.114.78.1 with SMTP id a1mr8529690wab.14.1202224608129;
        Tue, 05 Feb 2008 07:16:48 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id s10sm7481794mue.15.2008.02.05.07.16.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Feb 2008 07:16:47 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LSU.1.00.0802051500190.8543@racer.site>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72668>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 5 Feb 2008, Paolo Bonzini wrote:
> 
>> The hook is not suppressed by the --no-verify option, and the
>> exit status is ignored by git.
> 
> Umm.  Should the exit status really be ignored?  What _use_ would it be 
> then?

None; in the previous version I used an exit status of 1 to kill the 
commit.  But since this hook, unlike others, is meant to prepare things 
for the user, the hook itself was not suppressed by --no-verify, only 
checking the exit status.  Junio thought it was a mess, so I now 
completely ignore the exit status.

I just wrote the above sentence because prepare-commit-msg is the only 
git-commit hook whose exit status is ignored.

Paolo
