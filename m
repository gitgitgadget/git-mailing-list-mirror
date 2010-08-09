From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: understanding how remote tracking works
Date: Sun, 8 Aug 2010 21:19:00 -0500
Message-ID: <20100809021900.GA10596@burratino>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
 <i3nlq0$8un$1@dough.gmane.org>
 <AANLkTinktpx-rXj1K0BSy0Qwo62SEGFAJWvhKo0nJq=i@mail.gmail.com>
 <AANLkTi=usaZGfOM67acmdAWwvbHe_eHyjmRLGmdTYNaC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: geoffrey.russell@gmail.com, Ralf Ebert <info@ralfebert.de>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 04:20:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiHyp-0000oA-19
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 04:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab0HICUc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 22:20:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33310 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab0HICUa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 22:20:30 -0400
Received: by yxg6 with SMTP id 6so3276096yxg.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 19:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8gb8Uwc9U9XJtBA3GJyLh5owjE7KrDt4H8VqemAGahA=;
        b=bkHB4I3EjJCUnsfSy1jvsqTro1B7wgjddhVu47MVn0upVc0Y7vG2KPMIboaPcxyD41
         Ex2jysUW85Pd8LOVUqvHQ755xdzIAxUQQ7b2LNLec6MSx2s9/wdKhYapUYR50HApnIP9
         ag5YDQZvtiIN3I3GcfJNB8KTX2kaicHENSZYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xHiyL3xPYxP5ts7SCfy29rkU5bbJh61S4b1ndNzan+GYTlYw0bFehCH6DopoJHVH90
         iTKdZPOqBHC8lMAFBHgqKXlW9wcmGMQ77QhMP/ifWNWJuB+zKP520Huaq1JSU2B8JrwQ
         N2Z5deCtgE9FhA5QXAtX6YBezKfe2dmajRQlE=
Received: by 10.151.78.7 with SMTP id f7mr12314635ybl.287.1281320430137;
        Sun, 08 Aug 2010 19:20:30 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id q21sm2259232ybk.15.2010.08.08.19.20.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 19:20:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=usaZGfOM67acmdAWwvbHe_eHyjmRLGmdTYNaC@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152946>

Michael Witten wrote:
> On Sun, Aug 8, 2010 at 20:53, Geoff Russell <geoffrey.russell@gmail.c=
om> wrote:

>> I'm working my way through Jon Loeliger's Git book and it's
>> confusing when the actual behaviour differs from that in the book
>
> This probably results from the git culture's conflation (or should I
> say confusion?) of low-level and high-level representations and
> commands.

I guess I=E2=80=99ll bite.  What does that mean?  We have =E2=80=9Cshow=
-ref=E2=80=9D and
=E2=80=9Cupdate-ref=E2=80=9D precisely as low-level commands that are i=
ndependent
of representation.

Probably the more relevant question: what do you want to do about it?
