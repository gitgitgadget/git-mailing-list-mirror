From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Possible bug in 1.6.6 with reset --hard and $GIT_WORK_TREE
Date: Tue, 29 Dec 2009 16:12:41 +0800
Message-ID: <be6fef0d0912290012m3d64669fw4315960274baecb9@mail.gmail.com>
References: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Fyn Fynn <fynfynn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 09:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPXCB-0005Qn-Iu
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 09:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbZL2IMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 03:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbZL2IMn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 03:12:43 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:33463 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbZL2IMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 03:12:42 -0500
Received: by iwn1 with SMTP id 1so7742999iwn.33
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 00:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=j/wqmeYqSEQNdxOla7ULgkAasJwf2DqaZ8xwmgQuNa4=;
        b=b8UqHn3c6eewal/wFD7lTh6TzRvazShe5TBbV66uAiTbg834O10/7PUrAiflS2ZLlY
         KnX5rzj0tDRqswAK6icgz9gT1EPis5tSmkmF7BwJ1qO87ZAn3PcygFJ47SN1h2kmPdSV
         yylELU5H8fVWyrAPVycQy6q0q6+WFzttujvpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ftLM/TQjgJQcScXJPnQbhIxKKwohj8/DACEkv8RC9P9vN3OAhNnsrrF3istsj2MuCt
         o+WctvGZf33gQ/E5/QEYDgWgAqHa0DLQez1eC9VL+W/saTPviRb5Qimb5YY1I9XsXWsp
         Cyn1nckdxtQCUzaQm6NuYK/m/gtBrp3k5HDJM=
Received: by 10.231.24.142 with SMTP id v14mr229058ibb.55.1262074361588; Tue, 
	29 Dec 2009 00:12:41 -0800 (PST)
In-Reply-To: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135782>

Hi,

On Tue, Dec 29, 2009 at 2:47 PM, Fyn Fynn <fynfynn@gmail.com> wrote:
> The exact same git reset command that works in 1.6.4, fails to work
> under 1.6.6:
>
> $ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
> /usr/local/git-1.6.6/bin/git reset --hard
> fatal: hard reset requires a work tree
> $ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
> /usr/local/git-1.6.4/bin/git reset --hard
> HEAD is now at 77ec73f...
>
> What gives?

perhaps you should also specify the --exec-path option or
GIT_EXEC_PATH environment variable.

Assuming a full installation in /usr/local/git-1.6.6/ and thus that
the git commands are installed at
/usr/local/git-1.6.6/libexec/git-core/, the reset for 1.6.6 would look
like this:

$ GIT_WORK_TREE=$HOME/rawdata/ \
GIT_DIR=$HOME/rawdata/.git \
GIT_EXEC_PATH=/usr/local/git-1.6.6/libexec/git-core/ \
/usr/local/git-1.6.6/bin/git reset --hard

-- 
Cheers,
Ray Chuan
