From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 14/13] wildmatch: fix tests that fail on Windows due to
 path mangling
Date: Tue, 6 Nov 2012 19:47:13 +0700
Message-ID: <CACsJy8DEH53mA4fDyZwbVsbyGcNY8b54Sn1p5-rto6r_h48dkA@mail.gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com> <1350282362-4505-13-git-send-email-pclouds@gmail.com>
 <5096D76F.5090907@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 13:48:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TViZS-0004Oh-JE
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 13:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab2KFMrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 07:47:45 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49936 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab2KFMro (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 07:47:44 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so325206oag.19
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wTjiR25+X0YqtyrqtGdUK3zp/p5XYV97PU0bN+2Gk8k=;
        b=UsOS39QR1I4N5apicu1cZ67a8fiXrgWhPqZsEt4eQx746u/I5Fz0zYQaKeT/rWFynt
         vq6bCG5gmB+F6Wigb8j3BQRBSp0LDPGNWvomZAQ+CYX1PGYMp7cpcLfyBfU6GBKSiwCw
         cRuSeOfzfewaJPbMT1v+PeWxeYdX9OcABH9+sCNBlvRqktrmReE3VR6hlGxVu7sIN1Du
         ay+GTJlKarSxo6VHTtsk/XUSUIjIoEarhdoR3kXaHI5dDpVhuKQaUuN32jb3QvhVPsKf
         BDGnalm0cx2oVN1A/BhC8xmKyba3yGtlffVren3iwN5pG7ru8ijzoHtuSHWfvi4vowM4
         48Xw==
Received: by 10.60.6.227 with SMTP id e3mr703489oea.22.1352206064081; Tue, 06
 Nov 2012 04:47:44 -0800 (PST)
Received: by 10.182.64.82 with HTTP; Tue, 6 Nov 2012 04:47:13 -0800 (PST)
In-Reply-To: <5096D76F.5090907@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209109>

On Mon, Nov 5, 2012 at 4:00 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Patterns beginning with a slash are converted to Windows paths before
> test-wildmatch gets to see them. Use a different first character.

Or we could prepend the paths with something, which is then cut out by
test-wildmatch. Not sure if it's intuitive to look at the tests
though.

>  After this change, there are still 3 failing tests that are in connection
>  with [[:xdigit:]]. Don't know, yet, what's going on there.

the wildmatch tests or fnmatch ones?
-- 
Duy
