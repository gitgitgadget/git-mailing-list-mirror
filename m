From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 14:44:39 +0200
Message-ID: <e5bfff550706130544m40e2f210p2412ef7fde2867a1@mail.gmail.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	 <20070611064203.GG6073@spearce.org>
	 <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	 <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
	 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
	 <20070612135303.GT6073@spearce.org>
	 <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706130411g151b76e3sa2e351aff5dbb35b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 14:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HySDb-00068y-VQ
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 14:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866AbXFMMol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 08:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757625AbXFMMol
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 08:44:41 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:27129 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863AbXFMMok (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 08:44:40 -0400
Received: by nz-out-0506.google.com with SMTP id n1so199530nzf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 05:44:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c09AFoSH/1UH9Byq/R7UEpdkpmFyMP3rzN/bQ+BCdFUFZyVDlGvwSjQ88FOtYZUuJ2zIQwmqPcAJKMzftq98/XA8OcxRRVMaBpZhIJwuntLiwniHCeC8f0rlK5ZqZatoaO/w/kfu68kUJIDUXThTupTkW5EyiOlEsIUEILrvRZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qVGLOLbN7zylEOtJ+ZsJmnJ25Gr/CEJRsds4xsE6k+ro2ArfJU5nQkEWNBpKR3bYapx76ngv6oq+a3N/sNrFC1zVDkf9r5+k4Ad8rv6zXu5vhpUR+ZDF/ObogR2IqbrDM6sG6wiIzCHlXTgeX+moWZhLxSzjGlZmCz7Y9jPleCk=
Received: by 10.114.15.1 with SMTP id 1mr637310wao.1181738679098;
        Wed, 13 Jun 2007 05:44:39 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Wed, 13 Jun 2007 05:44:39 -0700 (PDT)
In-Reply-To: <e5bfff550706130411g151b76e3sa2e351aff5dbb35b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50054>

On 6/13/07, Marco Costalba <mcostalba@gmail.com> wrote:
>
> Some weeks ago I've started to experiment with git-log as a
> replacement for git-rev-list (as suggested by Linus in a thread).
>
> I found some problems and so I stopped

Now I remember why I've quit with git-log: due to a big performance
regression under Windows.

I've made some tests on a git tree copied under Windows:

running:  git rev-list --header --parents --boundary HEAD > tmp.txt

1,38s
1,37s
1,39s

then running: git log --pretty=raw -z --parents --boundary HEAD > tmp.txt

8,87s
8,87s
8,86s
8,86s


So at the end git-log seems 6,4 times slower the git-rev-list !

This would mean the end of the story for me.


Marco
