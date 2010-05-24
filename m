From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: What's cooking extra
Date: Mon, 24 May 2010 16:12:24 +0400
Message-ID: <20100524121224.GB3005@dpotapov.dyndns.org>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
 <20100519170656.GA30161@pvv.org>
 <20100522130916.GA28452@localhost>
 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
 <20100522222746.GA2694@localhost>
 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
 <20100523115127.GA20443@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon May 24 14:13:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGWWl-00037d-Fu
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 14:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826Ab0EXMMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 08:12:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59418 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab0EXMMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 08:12:30 -0400
Received: by fxm5 with SMTP id 5so2273824fxm.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pd1RX8fzyCcZTGoEoJ0znQDRhVqMO0WQPh3AadhBTG0=;
        b=SsJzOnbJP5VixFZxz/9dNWalLQTgbBEtlzmAiqCDjkqAqP66F5/wvqWUyTfyAlgpNG
         f5KZUqt9cYGCTJmNjWGVyaosf5Sl4UrTIKGqm4SwJaII/nMK5w90uT4/TqxmBBbAcGay
         xDK3DhU0KGHem/whfQ0i5AXM7+va+eP4aD8+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=D2pACuVY95z0i6+1EpM3WlQyv07PS8hakh4XLKEdHTsZMpstsFM0Vle2/OVl8AkJac
         QuQLhumwBH5kX9syJ/WOg1MfzOV54qkmAQrv4n/lF5B478vGxCWM8Y4w8K+Uj6AET2fR
         JDevxil8hrNG8Zdm3XMEXnMZBkIhZGjgcogxY=
Received: by 10.102.237.36 with SMTP id k36mr3853295muh.117.1274703149231;
        Mon, 24 May 2010 05:12:29 -0700 (PDT)
Received: from localhost (ppp85-140-126-0.pppoe.mtu-net.ru [85.140.126.0])
        by mx.google.com with ESMTPS id n7sm14921391mue.15.2010.05.24.05.12.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 05:12:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100523115127.GA20443@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147627>

On Sun, May 23, 2010 at 01:51:27PM +0200, Clemens Buchacher wrote:
> On Sun, May 23, 2010 at 12:36:51PM +0200, Eyvind Bernhardsen wrote:
> > 
> > Actually, since git normalizes to LF, "eol=lf" simply means
> > "convert on input but not on output", which is what
> > "core.autocrlf=input" currently does.  The fact that you didn't
> > know this reflects the poor usability of core.autocrlf, which is
> > one of the things this series is trying to rectify :)
> 
> No, I am aware of autocrlf=input, but apparently I did not
> understand the meaning of eol=lf correctly. So if a file has CRLF
> endings in the repository, and eol=lf, it will _not_ be converted
> to LF in the work tree? Conversely, if it has LF endings in the
> repository, and eol=crlf, it _will_ be converted to CRLF in the
> work tree?

All text files should LF in the repository, if some file does not, it
means the repository is corrupted in respect of handling text files.
So, the situation is not symmetric at all! I don't know how better to
handle this "corruption". I guess, it should be a warning about some
files having different ending that it should have had based on their
attributes.

> 
> I was expecting eol=lf and eol=crlf to be symmetric, which is also
> the reason for my reply to Finn's safe crlf patch.

Finn's patch about _automatic_ text detection when there is no explicit
policy about what ending this file should have.


Dmitry
