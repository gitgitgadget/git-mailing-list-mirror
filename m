From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sat, 24 Oct 2009 12:05:02 +0200
Message-ID: <20091024100502.GG4615@mx.loc>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
 <20091023202524.GE4615@mx.loc>
 <20091023210648.GA23122@mx.loc>
 <7vocnxajj6.fsf@alter.siamese.dyndns.org>
 <20091024091758.GF4615@mx.loc>
 <m28wf1unop.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, vda.linux@googlemail.com,
	busybox@busybox.net, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Oct 24 12:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1dUH-0002Je-W4
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 12:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbZJXKEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 06:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbZJXKE3
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 06:04:29 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47425 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbZJXKE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 06:04:29 -0400
Received: by bwz27 with SMTP id 27so1300669bwz.21
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=seUMR/+jf+HExyljf09BmfV/AHmxlWmMM4DoedBzY6Y=;
        b=qapuimu1JinETtNRnV6mItlH3Dhc6poeWUixOCj3kXNISzcZsTatmk7XFgly6R04Kx
         vExWZOUaufGI+E3P2CHui9rq3wHX7Tstahjgaxu+ktPJM3+rvND7eiOv5cgb28OtkOPZ
         gFsUjCuuNnsYMn2kT+TMsyf3Cx6dC3MaemyRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qHYUdYyLvvN7AhCF2i8TQO/mw9Jz6lPlCT0sbdRelfvVyjBdtYmtZ+SQeZX+SXveN+
         Qpzl0TO4qVx9efNgIlTUYd+qFYk58Q3CMvl6CMQsSNDQjg1w2CmRgDTKeb815q2HKn+o
         EVhMmjpIFS/w1h8oFCrl6JlpstySMs+U0NQU8=
Received: by 10.204.7.144 with SMTP id d16mr3460815bkd.209.1256378672722;
        Sat, 24 Oct 2009 03:04:32 -0700 (PDT)
Received: from s42.loc (85-127-251-67.dynamic.xdsl-line.inode.at [85.127.251.67])
        by mx.google.com with ESMTPS id 14sm488932bwz.5.2009.10.24.03.04.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 03:04:31 -0700 (PDT)
Received: from cow by s42.loc with local (Exim 4.69)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1N1dUc-00014f-6s; Sat, 24 Oct 2009 12:05:02 +0200
Content-Disposition: inline
In-Reply-To: <m28wf1unop.fsf@whitebox.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131156>

On Sat, Oct 24, 2009 at 11:49:10AM +0200, Andreas Schwab wrote:
>Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>
>> On Fri, Oct 23, 2009 at 02:26:53PM -0700, Junio C Hamano wrote:
>>>Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>>>
>>>> On Fri, Oct 23, 2009 at 10:25:24PM +0200, Bernhard Reutner-Fischer wrote:
>>>>>On Fri, Oct 23, 2009 at 10:15:43PM +0200, Bernhard Reutner-Fischer wrote:
>>>>>>GNU tar-1.22 handles 'o' as no-same-owner only on extract,
>>>>>>on create, 'o' would be --old-archive.
>>>>>
>>>>>FYI this was prompted by:
>>>>>
>>>>>Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
>>>>>
>>>>>diff -rdup git-1.6.5.oorig/templates/Makefile git-1.6.5/templates/Makefile
>>>>>--- git-1.6.5.oorig/templates/Makefile	2009-10-11 03:42:04.000000000 +0200
>>>>>+++ git-1.6.5/templates/Makefile	2009-10-23 21:43:06.000000000 +0200
>>>>>@@ -50,4 +50,4 @@ clean:
>>>>> install: all
>>>>> 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
>>>>> 	(cd blt && $(TAR) cf - .) | \
>>>>>-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
>>>>>+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) x --no-numeric-owner -f -)
>>>>
>>>> argh, sorry! --no-same-owner of course.
>>>
>>>Either way, your change would break non-GNU tar implementations that are
>>>properly POSIX.1, isn't it?
>>
>> I suppose xf - -o would work?
>
>Isn't that the same as 'xfo -'?

Not really (if you do not permute the arguments which we don't in
busybox, for size reasons).
f specifies the file so "fo" acts on file "o".
"xof -" would work for me as well as "xf - -o", it's just that
"xfo -" does not work.
