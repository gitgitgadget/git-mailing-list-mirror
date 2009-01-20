From: "Ludvig Strigeus" <strigeus@gmail.com>
Subject: Re: Git rebase -i failing on cygwin -- git checkout-index says File Exists
Date: Tue, 20 Jan 2009 23:44:26 +0100
Message-ID: <4285cd450901201444g711626afm296bf372a100b999@mail.gmail.com>
References: <4285cd450901201209i792195dfmdec1fb14d627b25e@mail.gmail.com>
	 <alpine.DEB.1.00.0901202212470.3586@pacific.mpi-cbg.de>
	 <4285cd450901201420l8929dci25688dc9723c917a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPPLz-00067w-TS
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbZATWo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 17:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbZATWo1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:44:27 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:15134 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbZATWo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 17:44:26 -0500
Received: by wf-out-1314.google.com with SMTP id 27so4016772wfd.4
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 14:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Xg3QcHYU23UZlzUtql8lhFVeXGN6xtolXaOk809eX5Y=;
        b=dS+KW6ms6g1CY6cjWY/8GPkrw+P/einsZiPrclRXuDrEq3cCNe1HA1Wk0erMe7D9uf
         KcHvJF7+R0KBWfaCMM4JXhNdQe+OzapCeFS1qC+BbHg9HhMdoWi5xAe8ux7xxiSSsHvm
         r3WRYvOYW1HbUbD9Ben6BsKmnxvWRuXhwOTmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HIOQOdVIfULUue8EH8qT2+CoZHAujH+NBF3Sw+NPIKzR+aiprYktnq5a3+LLXbBJ1B
         5a/L5ed06UDyAAvCsDNDYXgbynC7D8/PjBf4Set4jSVBT8NTVHe8mVkjlSABgr6vVsxz
         /TPGhM5zjW9oPgccKjoZA3RY2TlthShtAZCm4=
Received: by 10.142.50.15 with SMTP id x15mr3051281wfx.43.1232491466107;
        Tue, 20 Jan 2009 14:44:26 -0800 (PST)
Received: by 10.143.109.1 with HTTP; Tue, 20 Jan 2009 14:44:26 -0800 (PST)
In-Reply-To: <4285cd450901201420l8929dci25688dc9723c917a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106536>

On Tue, Jan 20, 2009 at 11:20 PM, Ludvig Strigeus <strigeus@gmail.com> wrote:
>
> Maybe this command log is useful. I got this while aborting the
> rebase. Looks like some file creation race condition? Windows doesn't
> allow files to be deleted while they're open.

I believe I found the source of my problems with git rebase. I had an
editor open that wanted to reload the files when changed, and this
seemed to conflict with git's file manipulations. After closing the
editor, I don't get the mysterious errors anymore.

/Ludde
