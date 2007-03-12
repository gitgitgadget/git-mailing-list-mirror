From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 20:36:42 +0700
Message-ID: <fcaeb9bf0703120636r7038a7fat24e571e7c087d13d@mail.gmail.com>
References: <20070311043250.GA21331@moooo.ath.cx>
	 <20070312115350.GA15179@moooo.ath.cx>
	 <20070312121226.GB2268@always.joy.eth.net>
	 <20070312131253.GA16452@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Matthias Lederhofer" <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 14:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQkhm-0002Aa-45
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 14:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965574AbXCLNgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 09:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965582AbXCLNgr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 09:36:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:49319 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965574AbXCLNgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 09:36:46 -0400
Received: by wr-out-0506.google.com with SMTP id i28so975377wra
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 06:36:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GSmtEGOoUtkqmUi1sCOJbf6hiTJUCORp5dAlKLgbb0HB/YpZzSy+g8jEcl7UZNGTXExA4VFBvo+BBd3LDA6veCQCBQDqfDCFz+h/XwT/Qtnm19jGrubB1+KGf7CxnIzpo5M38lNltP1VKBmSj2ttYOtzVzC18dlny2dn30w0Boo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qpKnDr4NbF8p+OF0w9J+izBOjm0AlurRPcSxdGp9M4BG82cfeKbAmsKyuHYQ55bQY3XN5+1VtukIl/PzBkLHtR1OJ4uH9BKVnhk1rOlvn73fDXmkNU+4Dvs8uRMU7hjzH97Q93h3BD8nRTvgPBzqlitRB7XUzHtXruJYniZ8QKE=
Received: by 10.115.76.1 with SMTP id d1mr1496215wal.1173706602735;
        Mon, 12 Mar 2007 06:36:42 -0700 (PDT)
Received: by 10.115.19.15 with HTTP; Mon, 12 Mar 2007 06:36:42 -0700 (PDT)
In-Reply-To: <20070312131253.GA16452@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42028>

On 3/12/07, Matthias Lederhofer <matled@gmx.net> wrote:
> Putting $GIT_WORK_DIR as is into $GIT_DIR/workdir is probably not what
> the user expects because the content of $GIT_DIR/workdir is
> interpreted relative to $GIT_DIR, not the current working directory.
> Example:
>
>     /tmp$ mkdir repository working_directory
>     /tmp$ git --git-dir=repository --work-dir=working_directory init
>
> If git init puts 'working_directory' into $GIT_DIR/workdir it would
> make the associated working directory $GIT_DIR/working_directory =
> /tmp/repository/working_directory and not /tmp/working_directory.
>
> The alternative to use
>
>     /tmp$ git --git-dir=repository --work-dir=../working_directory init
>
> seems quite confusing to me.
>
> If you've any other idea to solve this please tell me.

Let users create $GIT_DIR/workdir themselves. Your way may be less
confusing to you but might be more confusing to me because I _might_
expect a relative workdir setting (for example I move the repository
and the working directory together to another place).

-- 
Duy
