From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git merge no longer handles add/add
Date: Mon, 19 Nov 2007 16:29:27 +1300
Message-ID: <46a038f90711181929x4bf0794eue73a5dbac8e2688a@mail.gmail.com>
References: <46a038f90711181918s2743137amc6a827db6d1a6a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 04:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItxKW-0007aD-Vq
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 04:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbXKSD3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 22:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbXKSD33
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 22:29:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:6263 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbXKSD33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 22:29:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so887566ugc
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 19:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=luAqFgPmYUx3S96fsd8L9VAyph95vVLc2tAjQuKHfGo=;
        b=P2nCJRvuYLzlJs/GgABnYfkFJFZIq+hr2wRt3knOu7ohqMYA+h/oinPoB4TvfA+QkKNP7y44qWPQ2wCbVD/7+U0zNMKi7CmHWgWXfaADqFgdZ/ChN0FMGHzRcvUQCBQCr3roCmVVETNuP78YlTq9B60+i77y5ANXptjQfxBAdrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tRjFU1LlrBU8LF7WZUlfX3LaaK5uWgAP9jlxa5cH7nl7czuzNXfizsMan2UlmFBGfws/rH884tXE0nsXB4Ykrq+4yPSX502TrFO/9GxMy1efcGnEAQBko/tYQ9lrGxxp+uRHTccf8oEVgg+vZr/8XetadV0dpuRSZGPgqW7hpJU=
Received: by 10.67.21.11 with SMTP id y11mr1431923ugi.1195442967697;
        Sun, 18 Nov 2007 19:29:27 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Sun, 18 Nov 2007 19:29:27 -0800 (PST)
In-Reply-To: <46a038f90711181918s2743137amc6a827db6d1a6a0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65402>

On Nov 19, 2007 4:18 PM, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Happens with recursive and resolve. Happy to provide a minimal repro
> case, but I think this is fairly obvious...

Steps to repro...

    mkdir repro
    cd repro/
    cp /etc/resolv.conf ./resolv.conf
    git init
    git add resolv.conf
    git commit -m 'a' resolv.conf
    cp resolv.conf resolv-1.conf
    git add resolv-1.conf
    git commit -m 'a1' resolv-1.conf
    echo blabla >> resolv-1.conf
    git commit -m 'a2' resolv-1.conf
    git-branch other HEAD^^
    git checkout other
    cp resolv.conf resolv-1.conf
    git add resolv-1.conf
    git commit -m 'b'
    git checkout master
    git merge other
    ...
   Auto-merged resolv-1.conf
   CONFLICT (add/add): Merge conflict in resolv-1.conf
   Automatic merge failed; fix conflicts and then commit the result.




m
