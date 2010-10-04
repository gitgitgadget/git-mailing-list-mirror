From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid
 warning
Date: Mon, 4 Oct 2010 05:50:08 -0500
Message-ID: <20101004105008.GB4738@burratino>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com>
 <AANLkTim+QH6=XJikOsZs=qt9ZFHjP7gWz0zo9n4vz+gk@mail.gmail.com>
 <20101004103550.GA4738@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@netbsd.org>,
	Steven Drake <sdrake@xnet.co.nz>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 12:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ig0-0005Lw-2D
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 12:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab0JDKxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 06:53:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53861 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261Ab0JDKxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 06:53:23 -0400
Received: by iwn5 with SMTP id 5so6771564iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 03:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FoaavDm4Fnle5prjjted0v18LwGy3YN324Po8QrhjkE=;
        b=w6PvuEZdm583IAkVx0KBrlyJU3Nbkr0XLPGk2gEIYzzJ8HMgdGNNZdm2AJvkK5JYE2
         PhS2RpkV7aUBttdiehzn4lFti2fig+p1wFby6PSpMdqgyx5H5f/BnNb/fh6iFYrl+cba
         wCFkL4GDJ9YpatwqaB+jiUGwzTHyKie+n+t+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=E1V2Mj1VaD+jZswTZ6wluJk4NgNUdHI31TxR1beJQYpBkqrnB1jy7CnvPXNsyrx4TX
         +GmElWPX+8CN5FiVHwjpWWABEyWBT2/h+o5RkeBiajgMTXaNdk/IkB4dKYxn+tl9gL9T
         ayF6pB2vemJuwPTleEZX379igVU4sGks1bSwQ=
Received: by 10.231.166.139 with SMTP id m11mr9970258iby.136.1286189602967;
        Mon, 04 Oct 2010 03:53:22 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n20sm4828683ibe.23.2010.10.04.03.53.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 03:53:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101004103550.GA4738@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158026>

Jonathan Nieder wrote:

> The test harness uses cd -P to ensure $PWD and $(pwd) agree;

As =C3=86var noticed, this sentence as it stands doesn't make much sens=
e.
The idea is rather to make $(pwd -L) and $(pwd -P) agree --- the
former is accessible through $PWD, the latter through getwd() and
/bin/pwd.
