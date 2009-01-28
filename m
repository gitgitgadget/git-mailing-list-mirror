From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 01:33:35 +0100
Message-ID: <cb7bb73a0901271633meb3be90k173ec3cf1a6e33de@mail.gmail.com>
References: <1232973937-23875-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200901280120.38985.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 01:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRyOW-0006FG-V1
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 01:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbZA1Adj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 19:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbZA1Adj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 19:33:39 -0500
Received: from ik-out-1112.google.com ([66.249.90.178]:41367 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbZA1Adi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 19:33:38 -0500
Received: by ik-out-1112.google.com with SMTP id c28so1141546ika.5
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 16:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wBghIP6ayJVx6qSK7b+C0xIUDPSVy3K5w/4w+XHCGPw=;
        b=Pk9x44RNmrFClb2xJvLfXQHzAYNPjbwyfn1rhhhHLrkIM6CsO0oh1BYVB0AclFLGo/
         Vk7IFiVjhkHVffh7lXPoj/CQXG71wI44Qd+EbCo6sVtJwdf1wg14YJkUJkovc++mUl6y
         ZQCLpuQjYMT3+i6+vgkkTNmlFzKMNY1Mreuf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jKiBO/YNiD5Ua7nvTjggAW8Oq7Q5Xmi2DlP4KgEl94ioSCrCtYD1zHAuQfxL9E+fDP
         vT8zsMnde3EQFhiy8cVld2gfzjtEe/Lpj32cmvmOqHIJR3c2ZBvxI5mROtGfQkqARMkg
         B4k1aBKoMVXsPUeyX7sSCwkDJK8X8oecVuAwU=
Received: by 10.210.119.16 with SMTP id r16mr1875845ebc.91.1233102815679; Tue, 
	27 Jan 2009 16:33:35 -0800 (PST)
In-Reply-To: <200901280120.38985.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107433>

On Wed, Jan 28, 2009 at 1:20 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>
>> It's sick that $cgi->url() has no way to print the script base url
>> without path_info information (or that, if it has, it's very well
>> hidden).
>
> Actually:
>
> http://localhost/cgi-bin/gitweb/printenv.cgi/path/info?query=a;string=b;c=c;c=a
>
> url(-absolute=>1)  = /cgi-bin/gitweb/printenv.cgi
> url(-relative=>1)  = /cgi-bin/gitweb/printenv.cgi
> url(-full=>1)      = http://localhost/cgi-bin/gitweb/printenv.cgi
> url(-path_info=>1) = http://localhost/cgi-bin/gitweb/printenv.cgi/path/info
> url(-query=>1)     = http://localhost/cgi-bin/gitweb/printenv.cgi?query=a;string=b;c=c;c=a
> url(-base=>1)      = http://localhost
>
> $ENV{'SCRIPT_NAME'} = /cgi-bin/gitweb/printenv.cgi
> $ENV{'PATH_INFO'}   = /path/info

Yeah, but all of these have the script name in it, I was looking for
one without the script name. But more about this in the other reply.

-- 
Giuseppe "Oblomov" Bilotta
