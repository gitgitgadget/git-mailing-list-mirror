From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: clean up trash* directories on SIGINT
Date: Mon, 12 Jul 2010 01:16:08 -0500
Message-ID: <20100712061608.GA6140@burratino>
References: <AANLkTimnrLlprdScYDKHs_lIvFKc3K0n8U5vTzG_df2k@mail.gmail.com>
 <alpine.LFD.2.00.1007112327150.10598@xanadu.home>
 <AANLkTindliEmS2XhH8B1dUyo-v-CzpLQBqZakOaNnARW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 08:17:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYCK5-0003Oi-7g
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 08:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab0GLGQ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 02:16:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46011 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab0GLGQz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 02:16:55 -0400
Received: by iwn7 with SMTP id 7so4306345iwn.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 23:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Y+nZi67zJOSnI9u+LVwmJmuh+CxqITFk9lEAqLzF+t4=;
        b=OgDstD/0D+wdtldoWQHO68bnK87zMmElncHGVsGk8jmslGP/vP3ynxSzRXYvJYbXiF
         dawUIK3JSb44u3fg9LoR3P1+JYRatq/TTqIFlnR8xGcLfMMCtk9PbIe0E81rwFtSh6aF
         neQ+T0bF5WfAGHd3M1QnLZWMvJbx0rPHgyvy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XurqfRVoOiQ9LeK3fgzQe2ZcD6aCWZSpmdTRWN/OQN12vQqB/JJn/cn0aK3H8vVkih
         Kc+/2UPjXtkMR8zxd9YiqeJukudxulIqaW7cuFzfNAEbNbM+AN1JCZv2YV/E36FNcAPr
         G43xC74bbhHWHiJIB3KSqTOfowOG5IK/F6SSo=
Received: by 10.231.173.144 with SMTP id p16mr7031224ibz.108.1278915414183;
        Sun, 11 Jul 2010 23:16:54 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm18114791ibb.8.2010.07.11.23.16.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 23:16:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTindliEmS2XhH8B1dUyo-v-CzpLQBqZakOaNnARW@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150797>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Unless that's due to some unreproducable heisenbug you could get the
> trash directory by running the test with --debug.

So what should I do after noticing a heisenbug?  I guess I can suspend
with ^Z, but I would prefer not to have to train my fingers away from ^=
C.

> These trash directories are explicitly temporary, and
> should be cleaned up as the shell exists.

When tests learned to remove the trash directory in test_done in
v1.6.1-rc1~336^2~1 (Enable parallel tests, 2008-08-08), that was not
the rationale; it was rather to avoid too many trash directories
piling up.  If a test exits by mistake with =E2=80=98exit=E2=80=99 or f=
ails with =E2=80=98-i=E2=80=99,
the one or two scratch directories involved are still kept for
debugging.

So you can see why a person would be reluctant to change this for
aesthetic reasons only.
