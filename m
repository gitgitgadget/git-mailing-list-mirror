From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2 2/2] git-am: minor cleanups
Date: Wed, 28 Jan 2009 09:26:48 -0500
Message-ID: <76718490901280626j2caa6ebbgf98c76d8419191c7@mail.gmail.com>
References: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com>
	 <1233113262-17491-2-git-send-email-jaysoffian@gmail.com>
	 <7vd4e8xdva.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sverre@rabbelier.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 15:28:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSBOq-0007mn-DZ
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 15:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbZA1O0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 09:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbZA1O0u
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 09:26:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:8618 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbZA1O0t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 09:26:49 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6971807rvb.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bmlNlCJoTgVOSpwe4n/IYJgrE7j/UWAujcQKftXauAk=;
        b=Q8gCwZ0U2+X1i9WpN4gAD3PY+/GTAimonmaZK4X6MIHaPZG/1yo+U9JxRB35mtm7xL
         rdYRFEgDWdOsWWSWRlNa8bEWTog6aEXIPXjVSW+CU9doI84i0fMaaCWs68Wnd2pJL7GF
         EOIQ0Cj9Gga6YB84l0vTSV+A0F7td8Kl17hb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X4SKhUm7Fs6U22xyPQqc4tS/c5+hScSdAuXKxeu5qJwgDHQ+YHxI+pIjFflBbsciep
         6ODKRiuOeUBlLzO3k94B+4sHJujrymoALeBxZ1Sf/4q/yHp1Xn6YYLbhnOA5M9/EvGMH
         Hj2a3jjf2Y69iNZLOSiNRNZIe8v2KLyLzvYzY=
Received: by 10.140.139.4 with SMTP id m4mr2547163rvd.68.1233152808185; Wed, 
	28 Jan 2009 06:26:48 -0800 (PST)
In-Reply-To: <7vd4e8xdva.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107536>

On Tue, Jan 27, 2009 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> Use "test -t 0" instead of deprecated "tty -s" to detect when stdin is a
>> terminal.
>
> Who deprecated it?

I believe it's IEEE Std 1003.2-1992 / POSIX.2. I found the initial
reference in the BSD/OS X man page[1], but google also found me other
references [2,3]. Also, elsewhere git uses "test -t 0", not "tty -s".

[1] http://developer.apple.com/DOCUMENTATION/Darwin/Reference/ManPages/man1/tty.1.html
    (The -s option is deprecated in favor of the ``test -t 0'' command.)
[2] http://docs.sun.com/app/docs/doc/816-5165/tty-1?a=view
    (Portable applications should use test -t.)
[3] http://opengroup.org/onlinepubs/007908799/xcu/tty.html
    (Portable applications should use test -t 0.)

j.
