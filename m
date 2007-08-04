From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 04 Aug 2007 13:56:31 -0400
Message-ID: <46B4BDCF.9060809@gmail.com>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site> <46B4A2B0.9080208@gmail.com> <Pine.LNX.4.64.0708041704040.14781@racer.site> <46B4A5FD.3070107@gmail.com> <Pine.LNX.4.64.0708041719490.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:56:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHNri-0006rk-Es
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764931AbXHDR4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 13:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764927AbXHDR4f
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:56:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:51446 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764893AbXHDR4f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 13:56:35 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1101461wxd
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 10:56:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Mb4EX7xRIjwbIKNE+xTQPdVEK9vhvn7r8hpCPK8O6VsNtSFJgAmlVkk2dpFyPl7i/1pbVWCoxEnCKMkYBuwoMOk2A6KjwtI2HCUoep6dNv45Ye9DVQRJ/hMJVQEAmdpgF3NjGzoYg6+DDvRnH5ZRTd/JpYL+s4hWDcPi5Aqn4uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UycYBsmUPsNDeMIHyhhnYGIGXjR/TN0PaOU2/Bn3J/B4HNc33tdVFT9UufKmoZQc0qnTV3rj4x9tLx2m8i2Vbaxri82O8NS3JAZVO1RPVdvKuIsaDEgY6RV0AcV7DarBzgHY2RGpwKTUcSSIZBqo9HLD4I+QOF30rOsuKBW+aTc=
Received: by 10.70.28.9 with SMTP id b9mr7109024wxb.1186250194097;
        Sat, 04 Aug 2007 10:56:34 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id i34sm7258990wxd.2007.08.04.10.56.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Aug 2007 10:56:33 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <Pine.LNX.4.64.0708041719490.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54891>

Johannes Schindelin wrote:
> At this point, could you try debugging it?  For example, set a break point 
> in set_work_tree(), since that is the only function that commit touches, 
> and see what it returns both before and after the bad commit?
>
> Ciao,
> Dscho
>
>
>   
Before the bad commit, set_work_tree returns (null), and
variable dir_buffer in the call to get_relative_cwd is 
"/usr/src/git/.git/HEAD"

After, it returns "Documentation/", and
variable dir_buffer in the call to get_relative_cwd is "/usr/src/git"

I do not understand what the desired changes in this patch were so am 
really lost as to what should be fixed. However, the above I hope will 
give you a good clue as to what is broken.

Mark
