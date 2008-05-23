From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk - restore operation of git-reset on Cygwin
Date: Fri, 23 May 2008 19:13:06 -0400
Message-ID: <48374F82.7050005@gmail.com>
References: <1211511636-3552-1-git-send-email-mlevedahl@gmail.com> <18486.15879.551874.408651@cargo.ozlabs.ibm.com> <483744AB.8070509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat May 24 01:14:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzgSg-0006kj-Uy
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 01:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbYEWXNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 19:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbYEWXNT
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 19:13:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:37918 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYEWXNS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 19:13:18 -0400
Received: by wx-out-0506.google.com with SMTP id h29so679296wxd.4
        for <git@vger.kernel.org>; Fri, 23 May 2008 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=mwibF4NPZhiyLFXm4a8nLlWfm5wtpTgPtaN5MWAAFkY=;
        b=qJ2NAUdhtu3u3vIFOtBhtwYGwKtTDnmAaLa0oZd9VYo/QjXg+4etRsSTkCpnLpj4+IwDyjLMjYUI2V0PsqgAdOCU3bTiUWqkgLExpFnml4h9LGohrLmsNlU2W3O7bye0qRDg2dUVuDhk/OAw79cYRBxcWDPwWWFCFONgLxDLozM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kSVxak1cOCuXRZg8uMAgaiS9SPGBrrurTUoNqKmwcSUvb84746l/oen/DaTX0cFVeLGEXb574uBARqW6vbOLri4AdfNgbuD3Zl/1DoMfA6zmoLz9lDVbmXC3UNPVgTV+iXlL7+wlqXI7VDibg1QD4NXYHijkEr8eXUc8J0zTRss=
Received: by 10.70.87.5 with SMTP id k5mr1088403wxb.21.1211584394950;
        Fri, 23 May 2008 16:13:14 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.126.133.203])
        by mx.google.com with ESMTPS id c78sm5308423hsa.12.2008.05.23.16.13.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 May 2008 16:13:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <483744AB.8070509@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82770>

Mark Levedahl wrote:
> Paul Mackerras wrote:
>> Are you using Tk 8.4 or 8.5?  The man pages for 8.5 imply that the
>> 2>@1 form should work for all platforms, but maybe that wasn't true in
>> 8.4.  If that's the case it's worth mentioning in the patch
>> description.
>>
>> Paul.
>>   
> Cygwin's Tcl/Tk is essentially frozen at 8.4.1. However, I really 
> believe the problem is that the Tcl/Tk is not a full Cygwin 
> application: it is mostly Windows, with only a few pieces converted to 
> Posix through the cygwin.dll, so many things don't quite work 
> correctly. For instance, the current gitk works fine under a pure 
> Cygwin build of Tcl/Tk (8.4.13) I have locally. So, I believe the 
> commit message I wrote is correct.
>
> Mark
>

I just tried installation of ActiveState Tcl 8.4.16, put that on the 
Cygwin path, and gitk operates correctly without the patch. So, the 
issue seems to be entirely one of Cygwin's particular Tcl/Tk build, 
though whether that is due to the version or the odd attributes of its 
compilation I cannot say.

Mark
