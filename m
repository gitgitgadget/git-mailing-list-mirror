From: Frank Li <lznuaa@gmail.com>
Subject: Re: Delivery Status Notification (Failure)
Date: Tue, 2 Feb 2010 12:30:41 +0800
Message-ID: <1976ea661002012030h23aa415ek30aa6db23cb88d0e@mail.gmail.com>
References: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com>
	 <001636ed7681994278047e4e4a6f@google.com>
	 <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com>
	 <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com>
	 <be6fef0d1002012015q2a10af1cq4c5e5f968039ee45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Laszlo Papp <djszapi@archlinux.us>, git@vger.kernel.org,
	normalperson@yhbt.net
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 05:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcAQJ-0008K7-E3
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 05:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab0BBEbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 23:31:10 -0500
Received: from mail-yw0-f173.google.com ([209.85.211.173]:47749 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab0BBEbI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 23:31:08 -0500
Received: by ywh3 with SMTP id 3so2349288ywh.22
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 20:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Gk0qYKvOHhiIj0MJud3osZoHJd91pTUBqnGCgspD3MQ=;
        b=ChmwqhOLvgnpqpFRDDtEND5dm5zDvAUwQD0iKt6HjJ7phGNWHMedth9mqb4IKgU8ce
         c/Q2+Mxqc6dMuvyux4AoIKe/P/rkqzDjuQChzuw/ffQT2Ayl9p00o6KqlQZ+veWEZ7+k
         Vlntd3j4rsKPy+FiKX66grgvC/IOxB4QhPdLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Eg9uBQ5CLGjZTLFKtVGbrVLMY0xH/wPY8EJJhobHeZUKUXmivR6OBaFrkG7urRslik
         hDSLf/uyeUiAfufBKsDTsHcARR+04nrSPvDHTSq2YDVGTmknxKErcdcS35qeyKHb8ibO
         3KDQJyEMOYIVyR+8XCDHiKqsL9Y6jpWrGsKtM=
Received: by 10.150.30.14 with SMTP id d14mr7790364ybd.97.1265085041180; Mon, 
	01 Feb 2010 20:30:41 -0800 (PST)
In-Reply-To: <be6fef0d1002012015q2a10af1cq4c5e5f968039ee45@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138676>

2010/2/2 Tay Ray Chuan <rctay89@gmail.com>:
> Hi,
>
> On Fri, Jan 29, 2010 at 11:04 PM, Frank Li <lznuaa@gmail.com> wrote:
>> I prefer git-svn can provide environment to launch a external
>> application to input password like open ssh.
>
> how about users who are authenticating over http with basic and
> digest? How does one go about launching an external app for password
> input in those cases?

There are not problem if run git svn clone from console.
But a gui application, such tortoisegit, launch "git svn clone" and
capture git svn clone output.
If passwd needed, git svn clone will read character from console but
GUI application don't know that and wait git svn output.
So there are dead lock till timeout and fail.

The same problem has been happen at ssh.  But OpenSSH provide a
option, environment SSH_ASKPASS, which point to a application. when
passwd need, openssh launch this GUI application,  user can input
passwd at this GUI application.

The basic requirement is git svn can provide a way to prompt a dialog
box to input passwd.

Frank Li
