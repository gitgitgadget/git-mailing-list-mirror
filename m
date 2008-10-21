From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH 7/7] gitk: Explicitly position popup windows.
Date: Tue, 21 Oct 2008 16:52:27 +0400
Message-ID: <bb6f213e0810210552k1e18ad83l9e06981454818cd2@mail.gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-4-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-5-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-6-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-7-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-8-git-send-email-angavrilov@gmail.com>
	 <18685.49152.25344.398737@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 14:53:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsGk4-0006QX-Vn
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 14:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbYJUMwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 08:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbYJUMwa
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 08:52:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:38739 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbYJUMw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 08:52:29 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1010101ugf.37
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BHFIxR9yDLFJp/nwkg/piqjVpdun06Nnjue4unD75Lk=;
        b=OjNB5Er2FcYO+LMEAYnYmod50vYCeUGfCpG5DJyWVKzrDANX3wW8PlPd+/SJJerHFT
         yNkXXLlL9OEoctPNY8f1Nu9UOCeWyShESWv9TH9SFxalpUtPDdf4/bH/FERWsZHvqQpm
         pBgqoqcKDEPEDnk+1qBYoVxlhkkyJbcBPBUvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WQNI1mr6gd9VBUwXLDBRgRZ1/uvF158heMkLPsLBN/FZyWsi1EG3DsANiGfc07KobD
         hf64GO9UGiJRIQpWvwQIFSjMrQPhENnFG9DEq8GFbI7XQDcDzSd+utFmSmDVyWFz3AFt
         ie3BzvzWxoOBrfw6SzplVkohPb4xLrBgJh95k=
Received: by 10.103.189.15 with SMTP id r15mr4435748mup.135.1224593547055;
        Tue, 21 Oct 2008 05:52:27 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Tue, 21 Oct 2008 05:52:27 -0700 (PDT)
In-Reply-To: <18685.49152.25344.398737@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98785>

On Tue, Oct 21, 2008 at 3:41 PM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>
>> For some reason, on Windows all transient windows are placed
>> in the upper left corner of the screen. Thus, it is necessary
>> to explicitly position the windows using the tk::PlaceWindow
>> function.
>
> Hmmm, this is not part of the official Tk API as far as I can see, and
> having to call tk::PlaceWindow on every window we create is a bit
> gross.  What exactly does it do, and what effect will this change have
> on Linux?  Are you sure there isn't some other way to fix the problem?

It is just a convenient helper function that can explicitly compute
and set the window position in a number of ways. It is used in Tk's
dialog implementations. If you don't like using an unofficial
function, I can pull out the relevant ~8 lines of code as a separate
function in gitk.


http://objectmix.com/tcl/390381-tile-dialog-boxes-not-transient-parent-under-windows.html
http://wiki.tcl.tk/1254

Alexander
