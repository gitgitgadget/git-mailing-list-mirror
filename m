From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Thu, 21 Oct 2010 11:01:34 -0500
Message-ID: <20101021160134.GA3732@burratino>
References: <20101020085859.GA13135@do>
 <20101020190709.GB10537@burratino>
 <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com>
 <20101021033042.GA1891@burratino>
 <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, fbriere@fbriere.net, drizzd@aon.at
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 18:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8xdy-0005by-OI
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 18:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074Ab0JUQF0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 12:05:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55079 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab0JUQFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 12:05:25 -0400
Received: by eye27 with SMTP id 27so276150eye.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H345+bXdGsX945q+v0x1RQ3v0pMDTVOIJwZA9dnFgm0=;
        b=rWzRl8/ZQWynfn1ZZ8X1eLmTPZpZ3eBY8x0ixdru11iyUwSD5TsGNEvzVpcHAyNmwX
         LknuJzHiFweZ5+2YnZoPydJhXrzfAs3c7m3GsBR2cOKBjwIGPHmU68ZjgyNrtqMSjwB5
         aX+hW1JjJhsebaJ3i3rGd/SWrhZBbAS289JXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VlS86l+v946EPOgJI3WLwpurhhSmZCu94CpndxosN4OcJHzAagw8Ty0CWl2huEGAxj
         waCKfaOlKY4uTh40aeb2+CGibSA2j/ITB6Jk5VxDNZWHOUIdAFg1N/l1+W0yy4tEhuT5
         LDR7eyKH+un7Qw0RMWOGnN/EekFZtp/vSOxCk=
Received: by 10.213.29.204 with SMTP id r12mr5137291ebc.10.1287677123939;
        Thu, 21 Oct 2010 09:05:23 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x54sm1950675eeh.5.2010.10.21.09.05.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 09:05:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159519>

Nguyen Thai Ngoc Duy wrote:
> On Thu, Oct 21, 2010 at 10:30 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:

>> Speaking of which, it is not clear to me that core.worktree should
>> fall under the forbidden case discussed above. =C2=A0If it does, wha=
t is
>> the point of making it configurable?
>
> I was not the one who introduced core.worktree, so I can't really
> tell. Maybe less keystrokes?

Yeah, it seems you're totally right. :(

So in clarifying the semantics, core.worktree without GIT_DIR should
be forbidden.  But consider this a feature request.  By the time
core.worktree has been read, it is obvious what the GIT_DIR was
supposed to be:

References:

 - v0 (GIT_TOP_DIR):
   http://thread.gmane.org/gmane.comp.version-control.git/38382
 - v1 (GIT_WORK_DIR):
   http://thread.gmane.org/gmane.comp.version-control.git/41902
 - v2 (GIT_WORK_TREE):
   http://thread.gmane.org/gmane.comp.version-control.git/42416
