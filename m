From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 1 Dec 2009 16:50:11 +0100
Message-ID: <40aa078e0912010750m4518f068s9c955042307bf9fe@mail.gmail.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com>
	 <4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com>
	 <4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com>
	 <4B14E934.9090304@viscovery.net> <4B150747.2030900@syntevo.com>
	 <4B151782.8050309@viscovery.net> <4B15391C.5090302@syntevo.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 16:51:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFUzc-0005rq-MF
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 16:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZLAPuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 10:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbZLAPuH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 10:50:07 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:49525 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbZLAPuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 10:50:05 -0500
Received: by fxm5 with SMTP id 5so5041165fxm.28
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 07:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3ExLeIuZsV+rfNBW+HDwhDoCnzFNVcOzjTJXQs1Sw5c=;
        b=GDdxmcOBebnPEGMNeUGtROVDuj4/onJPFEF8cwwhdbG0ZRLoRb98+n0T5euBJ6rdxy
         tU0ji1CXWg4JZSNn7Rocgequsp4/EDZ4jbJ9n5weaw6s/H5sVGq05J8q4TLcp6H7T7yu
         5f38eBUZZFHK+007xYJPydhQNE0TH5Q57p/rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=KHqkBpcW4hPRdwR3zc2rNIBagwbxgH2JZzmztFIEkJJVebs/t69E8pChAKSz0dfUat
         0tmv+uB1z435I7L6Rpa5SJfq1kXmEVdORXY7pPVco7eJxZivSk2P19XDCGZeKnKBkyDC
         15NmSbr/pVzAZ0x5O6TTFWpa6G9fBajMPyeF0=
Received: by 10.216.90.209 with SMTP id e59mr1926248wef.193.1259682611119; 
	Tue, 01 Dec 2009 07:50:11 -0800 (PST)
In-Reply-To: <4B15391C.5090302@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134214>

On Tue, Dec 1, 2009 at 4:41 PM, Thomas Singer <thomas.singer@syntevo.com> wrote:
> Johannes Sixt wrote:
>> Thomas Singer schrieb:
>>> I'm quite surprised, that -- as I
>>> understand you -- msys-Git (or Git at all?) is not able to handle all
>>> characters (aka unicode) at the same time. I expected it would be better
>>> than older tools, e.g. SVN.
>>
>> This has been discussed at length here and in the msysgit mailing list.
>> Git expects that the file system returns file names with the same byte
>> sequence that git used to create a file. On Windows, this works only as
>> long as you do not switch the codepage.
>
> Now you confuse me: is this a problem of Windows, Git using a less capable
> Windows-API call or is there no unicode-capable API call to list file names
> on Windows? I ask myself how Java does it in its internals, finally it
> (also) consists of a C-base, I guess.
>

Git uses the 8-bit file APIs, and Windows doesn't support setting
UTF-8 as the locale. Some work have been done in msysGit to use
_wopen() and friends instead, but AFAIK it's not completed. See the
branch called "work/utf-filenames" in
git://repo.or.cz/git/mingw/4msysgit.git if you are interested in
helping to complete it.

-- 
Erik "kusma" Faye-Lund
