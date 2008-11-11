From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Tue, 11 Nov 2008 14:00:03 +0300
Message-ID: <bb6f213e0811110300maedee6bife5592afb27b48b7@mail.gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-3-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-4-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-5-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-6-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-7-git-send-email-angavrilov@gmail.com>
	 <18708.11537.229423.296701@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 12:01:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzqzq-0008Cx-Ps
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 12:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbYKKLAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 06:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYKKLAF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 06:00:05 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:34453 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbYKKLAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 06:00:04 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3136762wfd.4
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 03:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GoKEEUF3DUSk20oyb7K6Xy5Lu8ha8tfbFWzCAvJ4A40=;
        b=jk1rRFwprwA1GY9DHqSJ3ElwzRbQc/rcmhJQi06OCjgmI4/JpA3E/hF3ZIr5i5Fylu
         /qs0REP8vXjtS9K+Rsi6jb9jRk8R0BLfGiUxWCQtbxOLUzWIrXiezckdzAmLLE5Q4i2H
         uaXZ4/a2HseToN4WvkXtFrPFi+nOeY8BAJLQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tHvYXiCKXertPRawjXC1QhkwkhMLH+Jf5aFKT784qm4oo78lhtkeICrUAD+fl8V3cU
         pQkXMBWqksNC/YmPsxhodgm3wATVe49F5xqL5h/yuzpUiJHmHm90P0ESOFpIw3TI1I94
         mGZkxvsv9FIJGh8QFTGxRNdWWy7kI++0/dJCs=
Received: by 10.143.8.17 with SMTP id l17mr2924930wfi.173.1226401203832;
        Tue, 11 Nov 2008 03:00:03 -0800 (PST)
Received: by 10.142.216.21 with HTTP; Tue, 11 Nov 2008 03:00:03 -0800 (PST)
In-Reply-To: <18708.11537.229423.296701@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100638>

On Fri, Nov 7, 2008 at 2:57 PM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>
>> For some reason, on Windows all transient windows are placed
>> in the upper left corner of the screen. Thus, it is necessary
>> to explicitly position the windows relative to their parent.
>> For simplicity this patch uses the function that is used
>> internally by Tk dialogs.
>
> Is there any reason to call tk::PlaceWindow under Linux or MacOS?
> If not I'd rather add an if statement so we only call it on Windows.

I checked it on MacOS, and there the consequences of wm transient are
even worse that on Windows, so scrap this patch -- I'll redo it to fix
both cases.

Alexander
