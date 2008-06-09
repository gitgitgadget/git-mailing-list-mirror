From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH] Add git-squash tool and tests
Date: Mon, 09 Jun 2008 13:53:35 -0700
Message-ID: <484D984F.20700@gnu.org>
References: <484D47C9.9050509@gnu.org> <1213043398-30524-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0806092133260.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:54:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5oNy-0008D4-Fs
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbYFIUxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbYFIUxm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:53:42 -0400
Received: from ag-out-0708.google.com ([72.14.246.243]:30570 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYFIUxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:53:40 -0400
Received: by ag-out-0708.google.com with SMTP id 31so5259214agc.10
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=eiT8jbzE4aeFZSoX1VMXEzfWnuezGvG1jz2vrfov9zo=;
        b=LMXtno9PLM00ps/vsMLFDPLak7EDxZnmhUzkM6vd/4wEW+qhtK59OT9jtOS/OH4M3Z
         sNsMp/QpnMwbloGzdaWxM0nZfyp7dZzxh4VN7IsRt1yBnwpeYPCoJk2bGL7J4S7nkKhh
         tpkrffZwcDMi5XydLAA1Ekc2dKSDL7LrqZFyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=bYNYuPP27bwWtzavKHEr9obW7aVi5WkUQpP3Vd1Rq0KTGXdarcEbLdNyYXDUSYScFZ
         8pYrdVaKbikGz72A0sI7KdjQpwiy8cSnRPcC34zwrbz3qL57g0PfPacnPpK0GhC9ShYj
         N7KTjfuo12QZdP8ItuAj3pt7xOBBsX0n6ceVc=
Received: by 10.150.229.16 with SMTP id b16mr6984316ybh.131.1213044819321;
        Mon, 09 Jun 2008 13:53:39 -0700 (PDT)
Received: from scientist-2.local ( [66.78.193.51])
        by mx.google.com with ESMTPS id x48sm14502354pyg.18.2008.06.09.13.53.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 13:53:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <alpine.DEB.1.00.0806092133260.1783@racer>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84427>


> Isn't it possible to do this with something like
> 
> 	$ git reset --hard X^ &&
> 	  git merge --no-ff --squash HEAD@{1}

Yes, that's true!  And very cool.

In turn, ...

> Junio, this could be a backend for the zucchini instruction, by just
>  zucchini <n>  =>  git-squash "HEAD~$(expr $n + 1)"    ;-) 

... zucchini becomes

   git reset --hard HEAD~$(expr $n)
   git merge --no-ff --squash HEAD@{1}

Paolo
