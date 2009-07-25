From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC 09/10] gitweb: Incremental blame (proof of concept)
Date: Sat, 25 Jul 2009 21:28:22 +0200
Message-ID: <200907252128.25631.jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com> <1248475450-5668-10-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 21:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmvF-0005Bu-6W
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 21:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbZGYT2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 15:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbZGYT2g
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 15:28:36 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:65227 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbZGYT2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 15:28:35 -0400
Received: by bwz28 with SMTP id 28so1950360bwz.37
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IOxXkFkeH6Nz3E1XG2nSycGzQSdHwUNxKl0dniVfyYA=;
        b=Nwuh0w9WfzHv+VokZPUoPSXG6/dR1Gs9y3FAzW61jFofvZaobPbQUybWWSQKSPKyu9
         tifyKVckP5ztngLlgPyOlLInWoYu8XY/OoTGGeWN4fpyJOdyVjNEKUQIOj48gP/0d5xN
         yuJ5JArqlJPpFTAhBLshU5X1LgxfnffGhux4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=w+NC9h87EcmMJe68cKXy6b4N/yJH/W4mikQGvqRscDN+Ms6K6w7SzXnxwC+OQtXU4T
         qeF+A2pzEoBNpoGivuHPbRGSF2tqEGtctRsnXxBJBDZNvRkS3PxCeSGselTZcC/Z10fb
         5GDIlHrc35FguFf6PBerwirHDdVNJmbFEEF34=
Received: by 10.103.251.3 with SMTP id d3mr2180980mus.99.1248550114536;
        Sat, 25 Jul 2009 12:28:34 -0700 (PDT)
Received: from ?192.168.1.13? (abwq254.neoplus.adsl.tpnet.pl [83.8.240.254])
        by mx.google.com with ESMTPS id t10sm19457245muh.30.2009.07.25.12.28.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Jul 2009 12:28:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1248475450-5668-10-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124060>

On Sat, 25 July 2009, Jakub Narebski wrote:

> * set and deal with "no-previous" and "multiple-previous" classes;
> =A0 this was somewhat-ported from 'blame' view in gitweb.perl

Note that it is something that we unfortunately would have to deal with=
,=20
namely playing catch-up with new features in gitweb's 'blame' view,=20
"duplicating" quite a bit of code (well, rewriting Perl code in=20
JavaScript).  But this is, I think, unfortunately unavoidable, unless=20
we move to generating JavaScript code from Perl, e.g. using CGI::Ajax
(something that GWT does with Java and JavaScript).

--=20
Jakub Narebski
Poland
