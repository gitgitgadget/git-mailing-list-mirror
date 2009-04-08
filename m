From: Elijah Newren <newren@gmail.com>
Subject: Re: need help with git show :1:...
Date: Wed, 8 Apr 2009 11:58:45 -0600
Message-ID: <51419b2c0904081058p7d5a56c3j6aa5cebb0188ad43@mail.gmail.com>
References: <6838.1239212486@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrc4f-00084C-3I
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZDHR6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 13:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbZDHR6s
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 13:58:48 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:40960 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607AbZDHR6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 13:58:47 -0400
Received: by qw-out-2122.google.com with SMTP id 8so251949qwh.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8J1l0pIeZDSF0Q7IIB8izwYNp8HQPS5M9cqN9azv6jo=;
        b=bEQuE6jBTYfsrgv/wfPus5tlAF9cnxC8w1TPeSakWWWmtKx/jJFWAyp09oh96V+jTP
         Q3xq2LQB4FS6cmY7YcJxzp4lFGFgoJY1vs0AROr3oBpsLCrAb7/0YbV1TD6Q1FV83ONY
         ZCi9iwgvx792kf7PRdTJyH8T/48udmAcCyfMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WdEUQhd0TH/8GjD4Wwdok0thlHq1fiYG7jYswkDZGN3axOdWtg3Kl5aVKKAMHVXV4u
         hfP8bbsFrUcndaxVbOFi/Tlc0Pd7TNi63yYjKh/yBfY7Uzo92Flzh6cY3tgv1nsb36xr
         OSEcRzUR8cRDm5R+2Po0SX64TOYkT+zvO7wvQ=
Received: by 10.231.30.198 with SMTP id v6mr425186ibc.26.1239213525868; Wed, 
	08 Apr 2009 10:58:45 -0700 (PDT)
In-Reply-To: <6838.1239212486@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116100>

On Wed, Apr 8, 2009 at 11:41 AM, layer <layer@known.net> wrote:
> I remember this working for me in the not too distant past.
> I'm using git version 1.6.1.3.  Perhaps it was an older version of git
> when it worked for me.
>
> quadra% ls -l src/c/sock.c
> -rw-r--r-- 1 layer fi 57909 Mar  9 13:32 src/c/sock.c
> quadra% git show :2:src/c/sock.c
> fatal: ambiguous argument ':2:src/c/sock.c': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions
> quadra% git show :1:c/sock.c
> fatal: ambiguous argument ':1:c/sock.c': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions
> quadra% git show :1:sock.c
> fatal: ambiguous argument ':1:sock.c': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions
> quadra% git show :1:/src/c/sock.c
> fatal: ambiguous argument ':1:/src/c/sock.c': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions

Does the file have conflicts?  Try
  $ git ls-files -s src/c/sock.c
and report what the output is.

If it doesn't have conflicts, but the file is tracked by git, using
stage 0 should work:
  $ git show :0:src/c/sock.c
